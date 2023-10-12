require "fileutils"

desc "Create the default structure for one day of AOC"
task :scaffold_day, [:day_number] => [:create_example_and_input, :create_shared_file, :create_part_files]

task :make_directory_if_not_there do |t, args|
  Dir.mkdir args.day_number unless Dir.exist? args.day_number
end

task :change_to_correct_directory => [:make_directory_if_not_there] do |t, args|
  Dir.chdir args.day_number
end

task :create_example_and_input => [:change_to_correct_directory] do
  ["example", "input"].each do |file|
    puts "create\t#{file}"
    FileUtils.touch file
  end
end

task :create_shared_file => [:change_to_correct_directory] do |t, args|
  shared_file_contents = <<~RUBY
    # frozen_string_literal: true
    require_relative '../common'
    require 'pry-rescue'

    DAY = "#{args.day_number}"

    module Shared

    end
  RUBY
  puts "create\tshared.rb"
  File.write("shared.rb", shared_file_contents)
end

task :create_part_files => [:change_to_correct_directory] do
  { "PartA" => "part-a.rb", "PartB" => "part-b.rb" }.each do |klass, file|
    contents = <<~RUBY
      #!/usr/bin/env ruby
      # frozen_string_literal: true
      require_relative './shared'

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
    FileUtils.chmod 'u+x', file
  end
end
