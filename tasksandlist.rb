class Task
  attr_reader :content, :complete
  attr_accessor :id

  def initialize(id, content)
    @id = id
    @content = content
    @complete = false
  end
end

class List
  attr_reader :tasks

  def initialize
    @tasks = []
    convert_file
  end

  def delete(arg)
    @tasks.delete_if {|task| task.id == arg }
    num = arg.to_i - 1
    refresh_list(num)
  end

  def complete(arg)
    @tasks.each do |task|
      if task.id == arg
        task.complete = true
      end
      task.content = "DONE: {#task.content}"
    end
  end

  def add(arg)
    task = arg.join(" ")
    id = @tasks.length + 1
    @tasks << Task.new(id, task)
  end

  private
  def convert_file #not property of List class?
    TodoParser.each_entry('todo.txt') do |entry|
      @tasks << Task.new(entry["id"],entry["description"])
    end
  end

  def refresh_list(num)
    @tasks.each do |task|
      if task.id.to_i > num 
        task.id = ((eval task.id) - 1).to_s 
      end
    end
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

list = List.new
