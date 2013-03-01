require_relative 'list'

class TaskMaster
  def initialize(ARGV)
    @command = ARGV[0]
    run(@commands)
  end

  def run(command)
    case @command.downcase
    when "list"
      list.all_items
    when "delete"
      list.delete(ARGV[1])
    when "complete"
      list.complete(ARGV[1])
    when "add"
      ARGV.each do |arg|
        # turn arguments after [0] to strings and combine them
      end
      #list.add(result from above)
    else
      puts "I can't do that, Dave"
    end
  end
  
  
end


TaskMaster.new(ARGV)
