require "googleauth"
require "google/api_client"
require "google_drive"

namespace :cru do

  desc "Updates colleges table from Google spreadsheet"
  task update_colleges: :environment do
    spreadsheet_name = "CRU_College_Info"

    ENV["GOOGLE_APPLICATION_CREDENTIALS"] = Rails.root.join("config", "google_college_credentials.json").to_path
    ENV["SSL_CERT_FILE"] = $LOAD_PATH.grep(/google-api-client/).first + "/cacerts.pem"

    credentials = Google::Auth.get_application_default
    credentials.scope = ["https://www.googleapis.com/auth/drive", "https://spreadsheets.google.com/feeds/"]
    credentials.fetch_access_token!
    access_token = credentials.access_token

    drive_session = GoogleDrive.login_with_oauth(access_token)
    spreadsheet = drive_session.spreadsheet_by_title(spreadsheet_name)
    spreadsheet_dir = drive_session.file_by_id(spreadsheet.parents.first.id)
    photos_dir = spreadsheet_dir.file_by_title("photos")
    logos_dir = spreadsheet_dir.file_by_title("logos")

    raise "Spreadsheet #{spreadsheet_name} not found" unless spreadsheet

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
      add_logo(logo, college) unless has_logo?(logo, college)

      spreadsheet_photos = photos_for_id(photos_dir, college.id)
      spreadsheet_photos.each do |photo|
        add_photo(photo, college) unless has_photo?(photo, college)
      end
    end
  end

  def logo(logos_dir, name)
    logos_dir.file_by_title(name)
  end

  def photos_for_id(photos_dir, college_id)
    dir = photos_dir.file_by_title(college_id.to_s)
    dir.contents
  end

  def has_logo?(logo, college)
    college.logo_file_name == logo.original_filename && college.logo_file_size == logo.file_size
  end

  def has_photo?(photo, college)
    college.photos.any? { |p| p.photo_file_name == photo.original_filename && p.photo_file_size == photo.file_size }
  end

  def add_logo(logo, college)
    tf = Tempfile.new('college-logo')
    begin
      logo.download_to_file(tf.path)
      college.logo = tf
      college.logo_file_name = logo.original_filename
      college.save!
    ensure
      tf.close
      tf.unlink
    end
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
