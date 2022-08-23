# frozen_string_literal: true

namespace :git_push do
  desc 'TODO'
  task :commit, %i[commit_name skip_ci] => :environment do |_t, args|
    abort 'Error! Name commit not passed!' if args[:commit_name].blank?

    commit_name = args[:skip_ci].present? ? "#{args[:commit_name]}[skip ci]" : args[:commit_name]
    sh 'git add .'
    sh "git commit -m #{commit_name}"
    sh 'git push'
  end
end
