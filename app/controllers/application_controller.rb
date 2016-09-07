class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :current_company

  private

    def current_company
      @current_company ||= if company_code = params[:company_code]
        Company.find_by(code: company_code)
      else
        current_user.try(:company)
      end
    end

end
