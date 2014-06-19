# -*- encoding : utf-8 -*-
class ApplicationMailer < ActionMailer::Base
  include Resque::Mailer
  default from: 'no-reply@collaide.com'
  layout 'mailer_layout'
  #helper SanitizeHelper
end