# db/seeds.rb

# Ensure the roles exist
Role.find_or_create_by!(role_name: 'admin')
Role.find_or_create_by!(role_name: 'teacher')
Role.find_or_create_by!(role_name: 'student')

# Add any other necessary data here
# Example: If you want to create default users with specific roles:

# Create a default admin user
User.find_or_create_by!(email: 'admin@example.com') do |user|
  user.password = 'password'
  user.password_confirmation = 'password'
  user.role = Role.find_by(role_name: 'admin')  # Correct column name for role
  user.full_name = 'Admin User'
end

# Create a default teacher user
User.find_or_create_by!(email: 'teacher@example.com') do |user|
  user.password = 'password'
  user.password_confirmation = 'password'
  user.role = Role.find_by(role_name: 'teacher')  # Correct column name for role
  user.full_name = 'Teacher User'
end

# Create a default student user
User.find_or_create_by!(email: 'student@example.com') do |user|
  user.password = 'password'
  user.password_confirmation = 'password'
  user.role = Role.find_by(role_name: 'student')  # Correct column name for role
  user.full_name = 'Student User'
end
