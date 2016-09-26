module UserHelper
  def get_roster_status(status)
    return Roster::STATUSES[:unedited] if status.blank?
    Roster::STATUSES[status]
  end
end
