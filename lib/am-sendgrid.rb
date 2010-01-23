require 'actionmailer'
require 'smtp_api_header'

module ActionMailer
  class Base

    def sendgrid_header
      @sendgrid_header ||= SmtpApiHeader.new
    end

    def create_mail_with_sendgrid_header
      headers["X-SMTPAPI"] = sendgrid_header.asJSON if sendgrid_header
      create_mail_without_sendgrid_header
    end

    alias_method_chain :create_mail, :sendgrid_header

    def sendgrid_filter_setting(*args)
      sendgrid_header.addFilterSetting *args
    end

    def sendgrid_category(category)
      sendgrid_header.setCategory category
    end
  end

end