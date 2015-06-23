class AddAttachmentPhotoToStudentProfiles < ActiveRecord::Migration
  def self.up
    change_table :student_profiles do |t|
      t.attachment :photo
    end
  end

  def self.down
    remove_attachment :student_profiles, :photo
  end
end
