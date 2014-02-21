class GroupMailer < ActionMailer::Base
  include Resque::Mailer

  default from: "from@example.com"

  def new_invitation

  end
end
