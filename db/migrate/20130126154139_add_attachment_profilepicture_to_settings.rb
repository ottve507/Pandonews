class AddAttachmentProfilepictureToSettings < ActiveRecord::Migration
  def self.up
    change_table :settings do |t|
      t.attachment :profilepicture
    end
  end

  def self.down
    drop_attached_file :settings, :profilepicture
  end
end
