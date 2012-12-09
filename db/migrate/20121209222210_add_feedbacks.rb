class AddFeedbacks < ActiveRecord::Migration
  def up
    create_table :feedbacks do |f|
      f.string :email, :subject
      f.text :body
      f.timestamps
    end
  end

  def down
    drop_table :feedbacks
  end
end
