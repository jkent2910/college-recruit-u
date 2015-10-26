require "googleauth"
require "google/api_client"
require "google_drive"

namespace :cru do

  desc "Updates colleges table from Google spreadsheet"
  task update_colleges: :environment do
    spreadsheet_name = "colleges_production"

    ENV["GOOGLE_APPLICATION_CREDENTIALS"] = Rails.root.join("config", "google_college_credentials.json").to_path
    ENV["SSL_CERT_FILE"] = $LOAD_PATH.grep(/google-api-client/).first + "/cacerts.pem"

    credentials = Google::Auth.get_application_default
    credentials.scope = ["https://www.googleapis.com/auth/drive", "https://spreadsheets.google.com/feeds/"]
    credentials.fetch_access_token!
    access_token = credentials.access_token

    drive_session = GoogleDrive.login_with_oauth(access_token)

    spreadsheet = drive_session.spreadsheet_by_title(spreadsheet_name)
    raise "Spreadsheet #{spreadsheet_name} not found" unless spreadsheet

    spreadsheet_dir = drive_session.file_by_id(spreadsheet.parents.first.id)
    photos_dir = spreadsheet_dir.file_by_title("photos")
    logos_dir = spreadsheet_dir.file_by_title("logos")

    worksheet = spreadsheet.worksheets.first

    attrs = worksheet.rows.first.map(&:to_sym)

    worksheet.rows.drop(1).each do |row|
      college_attrs = attrs.zip(row).to_h
      college = College.find_or_initialize_by(id: college_attrs[:id])
      if college.persisted?
        puts "Updating #{college.name}"
      else
        puts "Adding #{college_attrs[:name]}"
      end
      college.update!(college_attrs.reject {|k, _| k == :logo })

      logo_name = college_attrs[:logo]
      logo = logo(logos_dir, logo_name)
      add_or_remove_logo(logo, college) unless has_logo?(logo, college)

      spreadsheet_photos = photos_for_id(photos_dir, college.id)
      spreadsheet_photos.each do |photo|
        add_photo(photo, college) unless has_photo?(photo, college)
      end

      college.photos.each do |photo|
        photo.destroy unless spreadsheet_has_photo?(photo, spreadsheet_photos)
      end
    end
  end

  def logo(logos_dir, name)
    logos_dir.file_by_title(name)
  end

  def photos_for_id(photos_dir, college_id)
    dir = photos_dir.file_by_title(college_id.to_s)
    return [] if dir.nil?
    dir.contents
  end

  def has_logo?(logo, college)
    return false if logo.nil?
    college.logo_file_name == logo.original_filename && college.logo_file_size == logo.file_size
  end

  def has_photo?(photo, college)
    college.photos.any? { |p| p.photo_file_name == photo.original_filename && p.photo_file_size == photo.file_size }
  end

  def spreadsheet_has_photo?(photo, spreadsheet_photos)
    spreadsheet_photos.any? { |p| p.original_filename == photo.photo_file_name && p.file_size == photo.photo_file_size }
  end

  def add_or_remove_logo(logo, college)
    if logo.nil?
      college.logo = nil
    else
      tf = Tempfile.new('college-logo')
      begin
        logo.download_to_file(tf.path)
        college.logo = tf
        college.logo_file_name = logo.original_filename
      ensure
        tf.close
        tf.unlink
      end
    end
    college.save!
  end

  def add_photo(photo, college)
    tf = Tempfile.new('college-photo')
    begin
      photo.download_to_file(tf.path)
      cp = college.photos.create(name: photo.title)
      cp.photo = tf
      cp.photo_file_name = photo.original_filename
      cp.save!
    ensure
      tf.close
      tf.unlink
    end
  end
end
