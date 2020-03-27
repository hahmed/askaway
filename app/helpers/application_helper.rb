module ApplicationHelper
  def emojify(content)
    h(content).to_str.gsub(/:([\w+-]+):/) do |match|
      if emoji = Emoji.find_by_alias($1)
        %(<img alt="#$1" src="#{image_path("emoji/#{emoji.image_filename}")}" style="vertical-align:middle" width="20" height="20" />)
      else
        match
      end
    end.html_safe if content.present?
  end

  def user_avatar(user, klass: nil)
    if user&.avatar&.attached?
      image_tag current_user.avatar.variant(resize: "28x28"), class: klass
    else
      Emoji.find_by_alias("cat").raw
    end
  end
end
