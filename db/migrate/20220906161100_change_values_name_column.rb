class ChangeValuesNameColumn < ActiveRecord::Migration[6.1]
  def change
    User.all.find_each do |user|
      user.name = user.email.split('@').first.downcase
      user.save!
    end
  end
end
