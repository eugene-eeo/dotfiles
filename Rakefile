namespace :pip do
  desc "Update outdated python packages"
  task :update do
    output = `pip list --outdated`
    output.split(/\n/).each do |line|
      line.strip!
      return if line.empty?
      if line.include? 'Current' and line.include? 'Latest'
        system("pip install --upgrade #{line.split.first}")
      end
    end
  end

  desc "Upgrade python and pip"
  task :upgrade do
    system('brew update')
    system('brew upgrade python')
    system('pip install --upgrade pip')
  end

  desc "Setup python environment"
  task :setup do
    ['flask', 'gevent', 'pymongo'].each do |package|
      system("pip install #{package}")
    end
  end
end


namespace :brew do
  desc "Upgrade homebrew"
  task :update do
    ['update', 'upgrade', 'cleanup'].each do |command|
      system("brew #{command}")
    end
  end
end


namespace :db do
  desc "Start MongoDB"
  task :mongodb do
    system('mongod --dbpath ~/mongodump')
  end

  desc "Start Redis"
  task :redis do
    system('redis-server')
  end
end
