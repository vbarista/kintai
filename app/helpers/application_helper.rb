module ApplicationHelper
  def admin_user?
    current_user.try(:admin?)
  end

  def reader_user?
    current_user.try(:reader?) || admin_user?
  end
end
