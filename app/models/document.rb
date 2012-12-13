class Document < ActiveRecord::Base
  attr_accessible :body, :title, :requester

  default_scope order("updated_at DESC")

  def to_pusher
    {
      id:         self.id,
      title:      self.title,
      body:       self.body,
      updated_at: self.updated_at
    }
  end
end
