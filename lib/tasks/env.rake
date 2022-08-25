# frozen_string_literal: true

namespace :env do
  desc 'TODO'
  task prepare: :environment do
    print "#{'#' * 5} Task Run! #{'#' * 5}\n"

    abort 'Error! .env file already exists!' if File.exist?('.env')

    file = File.new('./.env.example', 'r:UTF-8')
    env = File.new('./.env', 'a:UTF-8')
    content = file.readlines
    content.each do |l|
      env.print(l)
    end
    env.close
    gitignore = File.new('./.gitignore', 'r+:UTF-8')
    content_gitignore = gitignore.readlines
    gitignore.print(".env\n") unless content_gitignore.include?(".env\n")
    gitignore.close

    print ".env file was generated and and added .gitignore\n"
    print "#{'#' * 5} Task Done! #{'#' * 5}\n"
  end
end
