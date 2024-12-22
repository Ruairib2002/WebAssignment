class Submission < ApplicationRecord
  belongs_to :assignment
  belongs_to :user
  has_one_attached :file

  validates :file, presence: true

  def assign_marks(user_id, mark)
    self.marks ||= {}
    self.marks[user_id.to_s] = mark
    save
  end
end
