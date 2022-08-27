class AddAdminToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :admin, :boolean, default: false

    User.find_by(email: ENV.fetch('ADMIN_EMAIL', nil))&.update(admin: true)
  end
end
