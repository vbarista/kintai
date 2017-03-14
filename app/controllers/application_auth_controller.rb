
class ApplicationAuthController < ApplicationController
  before_action :authenticate_user!

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end

  private

  def check_current_company!
    return if current_user.admin?
    raise CanCan::AccessDenied unless current_company == current_user.company
  end

  def check_admin!
    raise CanCan::AccessDenied unless current_user.admin?
  end

  def check_reader!
    raise CanCan::AccessDenied unless current_user.reader? || current_user.admin?
  end

end
