class HowlerObserver < ActiveRecord::Observer
  def after_save(howler)
    howler.new_recipients.each do |recipient|
      Notifier.new_howler(recipient, howler).deliver
      howler.recipient_list[ recipient] = true
    end
  end
end
