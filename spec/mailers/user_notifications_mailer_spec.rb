# -*- encoding : utf-8 -*-
require "spec_helper"

describe UserNotificationsMailer do
  describe "document_created" do
    let(:mail) { UserNotificationsMailer.document_created }

    it "renders the headers" do
      mail.subject.should eq("Document created")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
