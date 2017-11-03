# Create default avatar for user using their initials via avatarly
class CreateUserAvatarJob < ApplicationJob
  queue_as :default

  def perform(user)
    # create the user's avatar using their name using avatarly
    img = Avatarly.generate_avatar(user.email)
    # puts "Finished generating avatar using avartarly"

    name = Tempfile.new('avatar')

    File.open(name, 'wb') do |f|
      puts "WRITE_IMAGE_TO_FILE #{name}"
      f.write img
    end
    # attach avatar to user
    user.avatar.attach(io: File.open(name), filename: "avatar.png", content_type: "image/png")
  end
end
