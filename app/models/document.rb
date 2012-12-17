class Document < ActiveRecord::Base
  attr_accessible :body, :title, :requester, :word_count

  default_scope order("updated_at DESC")

  def to_pusher
    {
      id:         self.id.to_s,
      title:      self.title,
      body:       self.body,
      updated_at: self.updated_at
    }
  end
end
