class ContactMailer < ActionMailer::Base
  def message(contact)
    recipients APP_CONFIG['email_recipient']
    from "#{contact.name} <#{contact.email}>"
    subject "Website Inquiry"
    sent_on Time.now
    body :contact => contact
  end
end
