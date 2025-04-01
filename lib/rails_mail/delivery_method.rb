module RailsMail
  class DeliveryMethod
    def initialize(options = {})
    end

    def deliver!(mail)
      RailsMail::Email.create!(
        from: mail.from&.first,
        to: mail.to,
        cc: mail.cc,
        bcc: mail.bcc,
        subject: mail.subject,
        text_part: extract_mail_body_by_type(mail, "text/plain"),
        html_part: extract_mail_body_by_type(mail, "text/html"),
        content_type: mail.content_type,
        attachments: mail.attachments.map { |a| { filename: a.filename, content_type: a.content_type.split(";").first } }
      )
    rescue => e
      Rails.logger.error("Failed to deliver email: #{e.message}")
      raise e
    end

    private

    def extract_mail_body_by_type(mail, mime_type)
      if mail.multipart?
        part = mail.parts.find { |p| p.content_type.start_with?(mime_type) }
        part ? part.body.as_json : nil
      elsif mail.content_type.start_with?(mime_type)
        mail.body.as_json
      end
    end
  end
end
