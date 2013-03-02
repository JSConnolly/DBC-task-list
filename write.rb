def save_as(file_name)
  File.open(file_name, 'w').do |file|
    @list.tasks.each |task| do
      "#{task.id}. #{task.content}"
    end
  end
end
