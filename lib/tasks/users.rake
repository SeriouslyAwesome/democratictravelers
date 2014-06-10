namespace :users do
  desc 'Generate UUIDs for all users that don\'t already have one.'
  task :generate_uuids => :environment do
    User.all.each do |user|
      user.update_attribute(:uuid, SecureRandom.hex(8)) if user.uuid.blank?
      user.update_attribute(:username, user.uuid) if user.username.blank?
    end
  end
end
