class UserGroup < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :group
end
