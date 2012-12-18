class Howler < ActiveRecord::Base
  attr_accessor :recipient_addresses
  attr_accessible :charges, :notes, :recipient_addresses

  after_initialize :default_values
  before_validation :make_url_token, if: :new_record?
  before_validation :merge_recipient_list

  validates_presence_of :url, :charges
  validates_uniqueness_of :url
  validates_numericality_of :charges, greater_than_or_equal_to: 1, if: :new_record?

  serialize :recipient_list

  def played?
    !played_at.nil?
  end

  def new_recipients
    return [] unless recipient_list
    recipient_list.
      reject { |recipient, sent| sent }.
      map { |recipient, sent| recipient }
  end

  def default_values
    self.charges ||= 1
    self.recipient_addresses = recipient_list.keys.join(", ") if recipient_list
  end

  def make_url_token
    self.url = SecureRandom.hex(32)
  end

  def merge_recipient_list
    self.recipient_list ||= {}
    self.recipient_list = make_recipient_list(recipient_addresses).merge recipient_list
  end

  def make_recipient_list(addresses)
    Hash[ addresses.split(/\s*,\s*/).collect { |address| [address, nil] } ]
  end
end
