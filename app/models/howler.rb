class Howler < ActiveRecord::Base
  after_initialize :default_values
  before_validation :make_url_token, if: :new_record?
  attr_accessible :charges, :notes

  validates_presence_of :url, :charges
  validates_uniqueness_of :url
  validates_numericality_of :charges, greater_than_or_equal_to: 1, if: :new_record?

  def played?
    !played_at.nil?
  end

  private
    def default_values
      self.charges ||= 1
    end

    def make_url_token
      self.url = SecureRandom.hex(32)
    end
end
