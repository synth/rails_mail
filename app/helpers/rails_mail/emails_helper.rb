module RailsMail
  module EmailsHelper
    def prepare_email_html(raw_html)
      doc = Nokogiri::HTML::DocumentFragment.parse(raw_html)
      doc.css('a[href]').each do |a|
        a.set_attribute('target', '_blank')
        a.set_attribute('data-turbo', 'false')
      end
      sanitize(doc.to_html,
        tags: ActionView::Base.sanitized_allowed_tags + ['table', 'tbody', 'tr', 'td'],
        attributes: ActionView::Base.sanitized_allowed_attributes + ['style', 'target', 'data-turbo'])
    end
  end
end
