# frozen_string_literal: true

module AuthConcern
  def sign_in(user)
    session[:user_id] = user.id
  end

  def auth_user(auth)
    email = auth.info.email.downcase
    name = auth.info.name

    user = User.find_or_initialize_by(email: email)

    user.name = name
    user.save
    user
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
