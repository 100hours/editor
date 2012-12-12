class Document < ActiveRecord::Base
  attr_accessible :body, :title, :requester

  default_scope order("updated_at DESC")
end
