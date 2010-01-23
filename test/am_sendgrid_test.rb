require 'helper'

class TestMailer < ActionMailer::Base
  def category_message
    sendgrid_category "a_category"
    recipients "foo@example.com"
  end
  def filter_message
    sendgrid_filter_setting "filter", "enabled", 1
    recipients "foo@example.com"
  end
end

class SendGridTest < Test::Unit::TestCase

  def sendgrid_options
    mail = ActionMailer::Base.deliveries[0]
    sendgrid_options = JSON.parse(mail["X-SMTPAPI"].to_s)
  end
  
  def test_sendgrid_category
    TestMailer.deliver_category_message
    assert_equal "a_category", sendgrid_options["category"]
  end

  def test_sendgrid_filter_settings
    TestMailer.deliver_filter_message
    assert_equal sendgrid_options["filters"]["filter"]["settings"]["enabled"], 1
  end

  def teardown
    ActionMailer::Base.deliveries.clear
  end
end
