require 'set'
class TotalInfection
  def initialize(user_id:, new_version_number:)
    @new_version_number = new_version_number
    @stack_to_infect = [user_id]
    @already_infected = Set.new
    @already_seen = Set.new
  end

  def call
    while @stack_to_infect.any?
      user_id = @stack_to_infect.shift
      infect_user(user_id)
    end
  end

  private

  def infect_user(user_id)
    user = User.find(user_id)
    connected_users = user.students + user.teachers
    connected_users.each do |connected_user|
      next if @already_infected.include?(connected_user.id)
      @stack_to_infect << connected_user.id
    end
    user.site_version = @new_version_number
    user.save!
    @already_infected << user.id
  end
end
