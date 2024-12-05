class Assignment < ApplicationRecord
  belongs_to :group
  has_many_attached :files

  validates :title, presence: true
  validates :due_date, presence: true

  def past_deadline?
    due_date < Time.current
  end
end
