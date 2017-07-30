require 'irb/ext/save-history'
IRB.conf[:SAVE_HISTORY] = 200
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb-history"

unless ENV['DISABLE_PRY']
  # Use pry everywhere
  if defined?(::Bundler)
    global_gemset = ENV['GEM_PATH'].split(':').grep(/ruby.*@global/).first
    if global_gemset
      all_global_gem_paths = Dir.glob("#{global_gemset}/gems/*")
      all_global_gem_paths.each do |p|
        gem_path = "#{p}/lib"
        $LOAD_PATH << gem_path
      end
    end
  end
  require 'rubygems'
  require 'pry'
  if Kernel.const_defined?("Rails")
    require 'rails/console/app'
    extend Rails::ConsoleMethods
  end
  Pry.start

  exit
end
