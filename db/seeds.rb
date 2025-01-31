# Ensure the roles exist
Role.find_or_create_by!(role_name: 'admin')
Role.find_or_create_by!(role_name: 'teacher')
Role.find_or_create_by!(role_name: 'student')

# Create a default admin user
User.find_or_create_by!(email: 'admin@example.com') do |user|
  user.password = 'password'
  user.password_confirmation = 'password'
  user.role = Role.find_by(role_name: 'admin')
  user.full_name = 'Admin User'
end

# Create a default teacher user
User.find_or_create_by!(email: 'teacher@example.com') do |user|
  user.password = 'password'
  user.password_confirmation = 'password'
  user.role = Role.find_by(role_name: 'teacher')
  user.full_name = 'Teacher User'
end

# Create a default student user
User.find_or_create_by!(email: 'student@example.com') do |user|
  user.password = 'password'
  user.password_confirmation = 'password'
  user.role = Role.find_by(role_name: 'student')
  user.full_name = 'Student User'
end

Place.create([
  { name: "Dublin", latitude: 53.3498, longitude: -6.2603 },
  { name: "Cork", latitude: 51.8985, longitude: -8.4756 },
  { name: "Galway", latitude: 53.2707, longitude: -9.0568 },
  { name: "Limerick", latitude: 52.6680, longitude: -8.6267 },
  { name: "Kilkenny", latitude: 52.6584, longitude: -7.2475 },
  { name: "Waterford", latitude: 52.2580, longitude: -7.1101 },

  { name: "Belfast", latitude: 54.5973, longitude: -5.9301 },
  { name: "Derry", latitude: 54.9960, longitude: -7.3190 },
  { name: "Armagh", latitude: 54.3500, longitude: -6.6531 },
  { name: "Lisburn", latitude: 54.5128, longitude: -6.0615 },
  { name: "Newry", latitude: 54.1796, longitude: -6.3433 },
  { name: "Antrim", latitude: 54.7039, longitude: -6.2153 },
  { name: "Ballymena", latitude: 54.8716, longitude: -6.2763 },
  { name: "Bangor", latitude: 54.6637, longitude: -5.6662 },
  { name: "Portadown", latitude: 54.4708, longitude: -6.4533 },
  { name: "Cookstown", latitude: 54.6467, longitude: -6.7408 },
  { name: "Enniskillen", latitude: 54.3444, longitude: -7.6400 },
  { name: "Carrickfergus", latitude: 54.7133, longitude: -5.1053 },
  { name: "Newtownards", latitude: 54.5757, longitude: -5.6841 }
])

puts "Roles and Users created successfully"
puts "Places seeded successfully"
