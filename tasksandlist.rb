class Task
  attr_reader :id,:content, :complete

  @@unique_id == 0

  def initialize(id, content, complete)
    @unique_id = @@unique_id
    @id = id
    @content = content
    @complete = false
  end
end

class List
  attr_reader :tasks

  def initialize
    @tasks = []
  end

  def convert_file #not property of List
    TodoParser.each_entry('todo.txt') do |entry|
      @tasks << Task.new(entry["id"],entry["description"])
    end
  end

  def delete(arg)
    @tasks.delete_if {|task| task.id == arg }
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
    task = arg.join
    Task.new()

  end

  # def to_s
  #   @tasks.each do |task|
  #     puts "#{task.id}:  #{task.content}\n"
  #   end
  # end
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
a.delete("2")
p a
