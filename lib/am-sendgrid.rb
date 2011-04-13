require 'action_mailer'
require 'smtp_api_header'

module ActionMailer
  class Base

    def sendgrid_header
      @sendgrid_header ||= SmtpApiHeader.new
    end

    def mail_with_sendgrid_header(headers={}, &block)
      headers["X-SMTPAPI"] = sendgrid_header.asJSON if sendgrid_header
      mail_without_sendgrid_header(headers, &block)
    end

    alias_method_chain :mail, :sendgrid_header

    def sendgrid_filter_setting(*args)
      sendgrid_header.addFilterSetting *args
    end

    def sendgrid_category(category)
      sendgrid_header.setCategory category
    end
  end

end