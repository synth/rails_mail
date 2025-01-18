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
        body: mail.body.to_s,
        content_type: mail.content_type,
        attachments: mail.attachments.map { |a| { filename: a.filename, content_type: a.content_type.split(";").first } }
      )
    rescue => e
      Rails.logger.error("Failed to deliver email: #{e.message}")
      raise e
    end
  end
end
