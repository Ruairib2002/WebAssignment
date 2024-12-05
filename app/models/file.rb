class File < ApplicationRecord

  self.primary_key = 'file_id'


  belongs_to :user, foreign_key: 'uploaded_by', optional: true

  validates :file_name, presence: true
  validates :file_path, presence: true
  belongs_to :group
  has_one_attached :file_attachment

end
