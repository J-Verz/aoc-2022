require "fileutils"

desc "Create the default structure for one day of AOC"
task :scaffold_day, :day_number do |t, args|
  Dir.chdir args.day_number
  Rake::Task[:create_example_and_input].invoke
  Rake::Task[:create_shared_file].invoke
  Rake::Task[:create_part_files].invoke
end

task :create_example_and_input do
  ["example", "input"].each do |file|
    puts "create\t#{file}"
    FileUtils.touch file
  end
end

task :create_shared_file do
  shared_file_contents = <<~RUBY
    require '../common'
    require 'pry-rescue'

    module Shared

    end
  RUBY
  puts "create\tshared.rb"
  File.write("shared.rb", shared_file_contents)
end

task :create_part_files do
  { "PartA" => "part-a", "PartB" => "part-b" }.each do |klass, file|
    contents = <<~RUBY
      require './shared'

      class #{klass}
        def self.run
          input = Common::InputReader.example

        end

        private
      end

      if __FILE__ == $0
        #{klass}.run
      end
    RUBY
    puts "create\t#{file}"
    File.write(file, contents)
  end
end
