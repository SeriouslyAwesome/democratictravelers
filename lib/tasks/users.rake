namespace :users do
  desc 'Generate UUIDs for all users that don\'t already have one.'
  task :generate_uuids => :environment do
    User.all.each do |user|
      user.update_attribute(:uuid, SecureRandom.hex(8)) if user.uuid.blank?
      user.update_attribute(:username, user.uuid) if user.username.blank?
    end
  end

  desc 'Delete guest users who have been active for 14 days.'
  task :clean_out_inactive_guests => :environment do
    puts 'Removing guests who haven\'t signed in for two weeks...'

    User.guests.inactive.find_each do |u|
      puts "Deleting #{u.email}..."
      u.destroy
      puts "...done."
    end

    puts 'Cleanup complete!'
  end
end
