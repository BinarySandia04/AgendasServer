class Assigment < ApplicationRecord
  belongs_to :task
  belongs_to :user

  def self.create_auto(task)
    task.group.users.each do |user|
      assigment = Assigment.new()

      assigment.is_done = false
      assigment.user = user
      assigment.task = task

      assigment.save()
    end
  end

  def self.notify_users(task, sender, title, desc)
    task.group.users.each do |user|
      unless sender.id == user.id
        Notification.create(user, title, desc)
      end
    end
  end

  def self.add_exisiting(user, group)
    unless group.nil?
      group.tasks.each do |task|
        assigment = Assigment.new()

        assigment.user = user
        assigment.task = task

        assigment.save()
      end
    end
  end
end
