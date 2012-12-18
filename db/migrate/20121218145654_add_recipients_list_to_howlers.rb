class AddRecipientsListToHowlers < ActiveRecord::Migration
  def change
    add_column :howlers, :recipient_list, :text
  end
end
