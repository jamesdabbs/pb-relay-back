namespace :git do
  desc "Dump data to git repo"
  task :dump => :environment do
    path = Rails.configuration.container.queries.repo_path
    puts "Dumping repo to #{path}"
    Rails.logger.level = :debug
    Git::Writer.new(path: path, delete: true).run
  end
end
