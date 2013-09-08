module ApplicationHelper
  
  def validate(record)
    if !verify_recaptcha
      record.errors[:base] << "This person is evil"
      redirect_to sessions_path
    else
      redirect_to logout_path
    end
  end

end
