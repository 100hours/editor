class DocumentObserver < ActiveRecord::Observer
  def after_create(document)
    Notifier.requested_document_start(document).deliver unless document.requester.blank?
  end
end
