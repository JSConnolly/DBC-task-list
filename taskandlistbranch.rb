class Task
  attr_reader :id,:content, :complete?

  def initialize
    @id = 0
    @content = content
    @complete? = false
  end
end

class List
  attr_reader :tasks

  def initialize
    @tasks = []
  end

  def self.from_file(file)
    list = List.new
    

end
