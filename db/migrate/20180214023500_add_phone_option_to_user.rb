class AddPhoneOptionToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :phone_option, :boolean
  end
end
