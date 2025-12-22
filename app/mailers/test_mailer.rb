class TestMailer < ApplicationMailer
  def test_email(to)
    mail(
      to: to,
      subject: "SMTP Test Email",
      body: "This is a test email from Chatwoot SMTP configuration."
    )
  end
end
