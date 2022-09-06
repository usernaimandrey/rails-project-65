# frozen_string_literal: true

module AuthConcern
  def sign_in(user)
    session[:user_id] = user.id
  end

  def get_user_attributes(auth)
    email = auth.info.email.downcase
    name = auth.info.email.split('@').first.downcase
    { email: email, name: name }
  end

  def sign_out
    session.delete(:user_id)
    session.clear
  end

  def signed_in?
    session[:user_id].present? && current_user.present?
  end

  def admin_signed_in?
    current_user&.admin?
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
end
