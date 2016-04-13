class DisinfectUsers
  def initialize(old_version_number:, new_version_number:)
    @users = User.where(site_version: old_version_number)
    @old_version_number = old_version_number
    @new_version_number = new_version_number
  end

  def call
    @users.each do |user|
      user.site_version = @new_version_number
      user.save!
    end

    @users.map(&:id)
  end
end
