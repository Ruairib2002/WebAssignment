class Assignment < ApplicationRecord
  belongs_to :group
  has_many_attached :files

  validates :title, presence: true
  validates :due_date, presence: true

  def past_deadline?
    due_date < Time.current
  end

  def marks_for_user(user_id)
    marks[user_id.to_s] if marks
  end

  def assign_marks(user_id, mark)
    self.marks ||= {}
    self.marks[user_id.to_s] = mark
    save
  end
end
