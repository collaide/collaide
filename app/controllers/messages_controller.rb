# -*- encoding : utf-8 -*-
class MessagesController < ApplicationController
  add_breadcrumb I18n.t("messages.index.breadcrumb"),  :messages_path
  add_breadcrumb I18n.t("messages.new.h1_title"), :new_message_path, :only => %w(new create)

  def index(page=1)
    user = User.find(2)
    #user.send_message(current_user, 'contenu du messag2e')
    #current_user.send_message(current_user, "Salut Yves, je t'envoie ce mail car j'ai un soucis")
    #logger.info('subject'.inspect)

    #@conversations = current_user.mailbox.inbox

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
    @conversations = current_user.mailbox.inbox.page(page).per(9)

    respond_to do |format|
      format.html # index.html.erb
      format.json {
        render json: @conversation
      }
    end

  end

  #Cette methode sert juste à traiter la réponse, elle n'aura pas de vue
  def reply
    c = Conversation.find(params[:conversation])
    unless c
      redirect_to :messages, alert: t('messages.reply.no_conversation') and return
    end
    if params[:reply].empty?
      redirect_to messages_path(:anchor => c.id), alert: t('messages.reply.empty_message') and return
    end

    current_user.reply_to_conversation(c, params[:reply])

    redirect_to messages_path(:anchor => c.id), notice: t('messages.reply.succed')
  end

  def show
    @conversation = Conversation.find(params[:id])
    @receipts = @conversation.receipts_for current_user
  end

  def new
    @conversations = getConversations
    @message = MessageSending.new
    #current_user.send_message(current_user, '@message.body', '@message.subject')
  end

  def create
    #@conversations = getConversations
    @message = MessageSending.new(params[:message_sending])
    respond_to do |format|
      if @message.valid?
        current_user.send_message(@message.users, @message.body, @message.subject)
        format.html { redirect_to :messages, notice: t('messages.new.forms.success') }
        format.json { render json: :messages, status: :created, location: @message }
      else
        format.html { render action: 'new' }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
  end

  def edit
  end

  def update
  end

  private
  def getConversations(page=1)
    #@conversations = current_user.mailbox.inbox

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
    current_user.mailbox.inbox.page(page).per(9)
  end

end
