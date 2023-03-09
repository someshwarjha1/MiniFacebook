class AddImageProcessingToActiveStorageAttachments < ActiveRecord::Migration[6.1]
  def change
    add_column :active_storage_attachments, :image_processing, :boolean
  end
end
