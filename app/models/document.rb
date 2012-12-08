class Document < ActiveRecord::Base
  attr_accessible :body, :title

  default_scope order("updated_at DESC")
end
