require 'rubygems'
require 'test/unit'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'am-sendgrid'

ActionMailer::Base.template_root = File.join(File.dirname(__FILE__))
ActionMailer::Base.delivery_method = :test

