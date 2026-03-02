#!/usr/bin/env ruby

module HerokuImport
  class Db < Thor
    method_option :keep,   type: :boolean, default: false
    method_option :host,   type: :string,  default: "localhost"
    method_option :user,   type: :string,  default: `whoami`.strip
    method_option :dbname, type: :string
    method_option :dump,   type: :string,  default: "latest.dump"

    desc "clone", "clone a remote heroku database to the local environment"
    def clone
      require 'bundler'
      ::Bundler.with_unbundled_env {
        app = "democratictravelers"
        dump = options[:dump]

        puts "Cloning production database to local environment. This might take a few minutes\n"

        puts "(1/4) capturing production database snapshot..."
        system("heroku", "pg:backups:capture", "--app", app)

        puts "(2/4) downloading snapshot..."
        url = `heroku pg:backups:url --app #{app}`.strip.tr('"', '')
        system("curl", "-o", dump, url)

        puts "(3/4) restoring snapshot..."
        db = options[:dbname] || dbname
        system("pg_restore", "--verbose", "--clean", "--no-acl", "--no-owner",
               "-h", options[:host], "-U", options[:user], "-d", db, dump)

        if options[:keep]
          puts "(4/4) skipping cleanup..."
        else
          puts "(4/4) cleaning up..."
          File.delete(dump) if File.exist?(dump)
        end

        puts "Done!"
      }
    end

    no_tasks do
      def dbname
        YAML.load_file('config/database.yml')["development"]["database"]
      end
    end
  end
end
