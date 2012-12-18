class Notifier < ActionMailer::Base
  def requested_document_start(document)
    @document = document
    mail(to: document.requester,
         from: "no-reply@100hours.tv",
         subject: "[100hours.tv] David started writing for you")
  end

  def new_howler(recipient, howler)
    @howler = howler
    mail(to: recipient,
         from: "no-reply@100hours.tv",
         subject: "[100hours.tv] You have been granted a 'howler'")
  end
end
