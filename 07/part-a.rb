require "./shared"

class PartA
  def self.run
    input = Common::InputReader.real
    self.scan_input input
    puts self.sum_of_sizes_under_100_001
  end

  def self.scan_input(input)
    input.each do |line|
      case line
      when /^\$\scd\s(?<name>.+)$/
        folder_name = $~[:name]
        case folder_name
        when "/" # if name is '/', create Root
          @current_folder = @root = Shared::Root.new
        when ".." # if name is '..', move to parent folder
          @current_folder = @current_folder.parent
        else # else, change context to specified folder
          @current_folder = @current_folder.child folder_name
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
        Shared::Folder.new(folder_name, @current_folder)
      else
        raise "This line,\n'#{line}'\nis not recognized."
      end
    end
  end

  def self.sum_of_sizes_under_100_001
    @sizes_under_100_001 = []
    self.find_if_size_is_under_100_001 @root
    @sizes_under_100_001.push @root.size if @root.size_under_100_001?
    @sizes_under_100_001.sum
  end

  def self.find_if_size_is_under_100_001(element)
    element.children.each do |child|
      next unless child.is_a? Shared::Folder
      self.find_if_size_is_under_100_001 child
      @sizes_under_100_001.push child.size if child.size_under_100_001?
    end
  end
end

PartA.run
