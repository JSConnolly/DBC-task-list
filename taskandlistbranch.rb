class Task
  attr_reader :id,:content, :complete

  def initialize(id, content)
    @id = id
    @content = content
  end
end

class List
  attr_reader :tasks

  def initialize
    @tasks = []
  end

  def convert_file #not property of List
    TodoParser.each_entry('todo.txt') do |entry|
      @tasks << Task.new(entry["id"],entry["description"])# {|idtag, id, contenttag, content|  }
    end
  end

  def all_items
    p @tasks
  end

  def delete(arg)
    # will delete line # (arg) in the list
  end

  def complete(arg)
    # will mark line # (arg) in the list as complete
  end
end

class TodoParser
  def self.each_entry(path)
    File.open(path, "r").each_line do |line|
      yield parse_line(line)
    end
  end
 
  private
  def self.parse_line(line)
    match = line.chomp.match(/^(?<id>\d+)\.\s+(?<description>.+)$/)
    Hash[match.names.zip(match.captures)]
  end
end

a = List.new
a.convert_file
p a.tasks


