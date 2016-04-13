require 'spec_helper'

RSpec.describe LimitedInfection do
  let!(:student) { create(:student) }
  let!(:classroom) { create(:classroom, :with_5_students) }

  it 'implements exact infection by setting a range to 0' do
    num_infected_users = User.where(site_version: 2).count
    expect(num_infected_users).to eq(0)
    LimitedInfection.new(target: 7, range: 0, new_version_number: 2).call
    num_infected_users = User.where(site_version: 2).count
    expect(num_infected_users).to eq(7)
  end

  it 'will infect a number of users close to the target if they are within range' do
    num_infected_users = User.where(site_version: 2).count
    expect(num_infected_users).to eq(0)
    LimitedInfection.new(target: 10, range: 2, new_version_number: 2).call
    num_infected_users = User.where(site_version: 2).count
    expect(num_infected_users).to eq(8)
  end

  it 'wont infect if nothing within range' do
    num_infected_users = User.where(site_version: 2).count
    expect(num_infected_users).to eq(0)
    LimitedInfection.new(target: 4, range: 1, new_version_number: 2).call
    num_infected_users = User.where(site_version: 2).count
    expect(num_infected_users).to eq(0)
  end
end
