#!/usr/bin/env ruby

module HerokuImport
  class Db < Thor
    method_option :keep,   :type => :boolean, :default => false
    method_option :remote, :type => :string,  :default => "heroku"
    method_option :host,   :type => :string,  :default => "localhost"
    method_option :user,   :type => :string,  :default => `whoami`.strip
    method_option :dbname, :type => :string
    method_option :dump,   :type => :string,  :default => "latest.dump"

    desc "clone", "clone a remote heroku database to the local environment"
    def clone
      Bundler.with_clean_env {
        puts "Cloning production database to local environment. This might take a few minutes\n"
        puts "(1/4) capturing production database snapshot..."
        puts `heroku pg:backups capture --remote #{options[:remote]} --app democratictravelers`
        puts "(2/4) downloading snapshot..."
        puts `curl -o #{options[:dump]} \`heroku pg:backups public-url --remote #{options[:remote]} --app democratictravelers\``
        puts "(3/4) restoring snapshot..."
        puts `pg_restore --verbose --clean --no-acl --no-owner -h #{options[:host]} -U #{options[:user]} -d #{options[:dbname] || dbname} #{options[:dump]}`
        if options[:keep]
          puts "(4/4) skipping cleaning..."
        else
          puts "(4/4) cleaning up..."
          puts `rm #{options[:dump]}`
        end
      }
    end

    no_tasks do
      def dbname
        YAML.load_file('config/database.yml')["development"]["database"]
      end
    end
  end
end
