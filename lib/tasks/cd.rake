namespace :cd do
  desc "Submit a new change to the CD changelog and commit to git, kicking off the CD process"
  task :commit, [:message] => :environment do |task,args|
    git_binary = `which git`.strip
    unless File.executable?(git_binary)
      puts "Could not find a git binary.  Are you sure git is installed?"
    end

    changelog = File.expand_path(File.join(File.dirname(__FILE__), "../../continuous_deployment.changelog.markdown"))
    git_user = `#{git_binary} config --global user.name`.strip
    git_email = `#{git_binary} config --global user.email`.strip
    user = "Unknown"
    if git_user || git_email
      user = "#{git_user} <#{git_email}>"
    end
    File.open(changelog, 'a+') do |file|
      file.write("* #{Time.now} [#{user}] - #{args.message}")
    end

    git_message = "[Continuous Deployment] - Automated build kicked off with message: #{args.message}"
    `#{git_binary} add #{changelog}`
    `#{git_binary} commit -m "#{git_message}"`
    `#{git_binary} push`
  end
end