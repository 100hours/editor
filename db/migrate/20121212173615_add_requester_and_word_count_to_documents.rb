class AddRequesterAndWordCountToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :requester, :string
    add_column :documents, :word_count, :integer
  end
end
