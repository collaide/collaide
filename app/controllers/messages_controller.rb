# -*- encoding : utf-8 -*-
class MessagesController < ApplicationController
  def index
    @messages = current_user.mailbox.inbox

    ##alfa wants to retrieve all his conversations
    #alfa.mailbox.conversations
    #
    ##A wants to retrieve his inbox
    #alfa.mailbox.inbox
    #
    ##A wants to retrieve his sent conversations
    #alfa.mailbox.sentbox
    #
    ##alfa wants to retrieve his trashed conversations
    #alfa.mailbox.trash
  end

  def new
    @message = Message.new
    #current_user.send_message(current_user, '@message.body', '@message.subject')
  end

  def create
    @message = Message.new(params[:message])

    if @message.valid?
      ##On ajoute tous les user receveur dans un array
      #receivers = Array.new
      #@message.users.each do |u|
      #  receivers << u.id
      #end
      current_user.send_message(@message.users, @message.body, @message.subject)
      format.html { redirect_to @message, notice: t('messages.new.forms.succes') }
      format.json { render json: @message, status: :created, location: @message }
    else
      format.html { render action: "new" }
      format.json { render json: @message.errors, status: :unprocessable_entity }
    end
end

def destroy
end

def edit
end

def update
end

def show
end

end
