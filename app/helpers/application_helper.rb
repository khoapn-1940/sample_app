module ApplicationHelper
  def full_title page_title
    base_title = I18n.t "application.applicationtittle"
    if page_title.blank?
      base_title
    else
      page_title + base_title
    end
  end

  def find_followed
    current_user.active_relationships.find_by(followed_id: @user.id)
  end
end
