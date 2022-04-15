# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'contact@graphn.eu'
  layout 'mailer'
end
