class Assignment < ApplicationRecord
  belongs_to :group
  has_one_attached :file
  has_many :submissions

  validates :title, :description, :due_date, presence: true

  def marks_for_user(user_id)
    submission = submissions.find_by(user_id: user_id)
    submission ? submission.marks[user_id.to_s] : nil
  end
end
