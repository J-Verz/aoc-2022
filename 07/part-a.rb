require "./shared"

class PartA
  def self.run
    input = Common::InputReader.real
    self.scan_input input
    puts self.find_sizes_under_100_001
  end

  def self.scan_input(input)
    @folders = {}
    input.each do |line|
      case line
      when /^\$\scd\s(?<name>.+)$/
        folder_name = $~[:name]
        case folder_name
        when "/" # if name is '/', create Root
          @current_folder = @folders[folder_name] = Shared::Root.new
        when ".." # if name is '..', move to parent folder
          @current_folder = @current_folder.parent
        else # else, change context to specified folder
          @current_folder = @folders[folder_name]
        end
      when /^\$\sls$/
        # listing folder inputs, read to create content.
        # Doesn't have to do anything
      when /^(?<size>\d+)\s(?<name>.+)$/
        file_size = $~[:size].to_i
        file_name = $~[:name]
        @current_folder.add_child Shared::File.new(file_name, file_size)
      when /^dir\s(?<name>.+)$/
        folder_name = $~[:name]
        @folders[folder_name] = Shared::Folder.new(folder_name, @current_folder)
      else
        raise "This line,\n'#{line}'\nis not recognized."
      end
    end
  end

  def self.find_sizes_under_100_001
    puts @folders.filter_map {|name, folder| "#{name}\t#{folder.size}" if folder.size <= 100000 }
    binding.pry
    @folders.filter_map {|name, folder| folder.size if folder.size <= 100000 }.sum
  end
end

PartA.run
