class Upload < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
  validates :file, presence: true
  validates :user_id, presence: true
  before_create :update_upload_type
  default_scope { order('created_at DESC') }
  scope :ambient_content, ->{ where(:ambient_content => true).order("created_at DESC") }
  scope :last_updated, ->{ select('id, updated_at').unscope(:order).order("updated_at DESC").limit(1) }

  mount_uploader :file, FileUploader

  private

  def update_upload_type
    if file.present?
      self.upload_type = file.file.content_type
    end
  end
end
