class Assigment < ApplicationRecord
  belongs_to :task
  belongs_to :user

  def self.create_auto(task)
    task.group.users.each do |user|
      assigment = Assigment.new()

      assigment.user = user
      assigment.task = task

      assigment.save()
    end
  end

  def self.add_exisiting(user, group)
    group.tasks.each do |task|
      assigment = Assigment.new()

      assigment.user = user
      assigment.task = task

      assigment.save()
    end
  end
end
