class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|
      t.bigint :user_id
      t.bigint :bulletin_id

      t.timestamps
    end
  end
end
