module UserHelper
  def get_roster_status(status)
    return Roster::STATUSES[:unedited] if status.blank?
    Roster::STATUSES[status]
  end
  
  def get_roster_by_previous(user)
    prev_time = Time.now - 1.month
    prev_year = prev_time.year.to_s
    prev_month = prev_time.month.to_s.rjust(2, '0')
    
    user.rosters.where(year: prev_year, month: prev_month).first
  end
end
