class RootController < ApplicationController
  def main
  end

  def service
    classrooms = Classroom.all
    render json: classrooms.as_json(:include =>
                                    {:students =>
                                     { :except => [:created_at, :updated_at] },
                                    :teacher => { :except => [:created_at, :updated_at] }},
                                    :except => [:created_at, :updated_at])
  end

  def infect
    target = params["target"].to_i
    range = params["range"].to_i
    render json: LimitedInfection.new(target: target, range: range, new_version_number: 2).call
  end

  def reset
    render json: DisinfectUsers.new(old_version_number: 2, new_version_number: 1).call
  end
end
