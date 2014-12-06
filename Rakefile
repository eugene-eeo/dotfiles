namespace :pip do
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

  task :upgrade do
    system('brew update')
    system('brew upgrade python')
  end

  task :setup do
    ['flask', 'gevent', 'pymongo'].each do |package|
      system("pip install #{package}")
    end
  end
end
