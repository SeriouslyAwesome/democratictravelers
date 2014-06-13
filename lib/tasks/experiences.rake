namespace :experiences do
  desc "Cache current vote count for each experience."
  task :cache_votes => :environment do
    Experience.find_with_reputation(:votes, :all).each do |exp|
      exp.votes_cache = exp.votes.to_i
      exp.save!
    end
  end
end
