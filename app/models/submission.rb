class Submission < ApplicationRecord
  belongs_to :assignment
  belongs_to :user
  has_one_attached :file

  validates :file, presence: true

  def mark_for_user(user_id)
    marks[user_id.to_s] if marks
  end

  def assign_marks(user_id, mark)
    self.marks ||= {}
    self.marks[user_id.to_s] = mark
    save
  end
end
