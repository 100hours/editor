class Notifier < ActionMailer::Base
  def requested_document_start(document)
    @document = document
    mail(to: document.requester,
         from: "no-reply@100hours.tv",
         subject: "[100hours.tv] David started writing for you")
  end
end
