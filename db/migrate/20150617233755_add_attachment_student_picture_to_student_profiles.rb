class AddAttachmentStudentPictureToStudentProfiles < ActiveRecord::Migration
  def self.up
    change_table :student_profiles do |t|
      t.attachment :student_picture
    end
  end

  def self.down
    remove_attachment :student_profiles, :student_picture
  end
end
