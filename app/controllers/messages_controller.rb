# -*- encoding : utf-8 -*-
class MessagesController < ApplicationController
  load_and_authorize_resource

  add_breadcrumb I18n.t("messages.index.breadcrumb"), :messages_path
  add_breadcrumb I18n.t("messages.new.h1_title"), :new_message_path, :only => %w(new create)


  def index()
    #user = User.find(2)
    #user.send_message(current_user, 'contenu du messag2e')
    #current_user.send_message(current_user, "Salut Yves, je t'envoie ce mail car j'ai un soucis")
    @conversations = current_user.mailbox.inbox.page(params[:page]).per(@per)

    respond_to do |format|
      format.html # index.html.erb
      format.json {
        render json: @conversation
      }
    end
  end

  def sentbox
    add_breadcrumb I18n.t("messages.sentbox.breadcrumb"), :sentbox_messages_path
    @conversations = current_user.mailbox.sentbox.page(params[:page]).per(@per)
  end

  def trash
    add_breadcrumb I18n.t("messages.trash.breadcrumb"), :trash_messages_path
    @conversations = current_user.mailbox.trash.page(params[:page]).per(@per)
  end

  def all
    add_breadcrumb I18n.t("messages.all.breadcrumb"), :all_messages_path
    @conversations = current_user.mailbox.conversations.page(params[:page]).per(@per)
  end

  def newParticipant

  end

#Cette methode sert juste à traiter la réponse, elle n'aura pas de vue
  def reply
    c = Conversation.find(params[:conversation])
    unless c
      redirect_to :messages, alert: t('messages.reply.no_conversation') and return
    end
    if params[:reply].empty?
      redirect_to message_path(c.id), alert: t('messages.reply.empty_message') and return
    end

    current_user.reply_to_conversation(c, params[:reply])

    redirect_to message_path(c.id), notice: t('messages.reply.succed')
  end

  def show
    @conversation = Conversation.find(params[:id])
    @receipts = @conversation.receipts_for current_user
    add_breadcrumb @conversation.subject_to_show
  end

  def new
    @message = UserMessage.new
    #current_user.send_message(current_user, '@message.body', '@message.subject')
  end

  def create
    @message = UserMessage.new(params[:user_message])
    respond_to do |format|
      if @message.valid?
        receipts = current_user.send_message(@message.users, @message.body, @message.subject)
        format.html { redirect_to message_path(receipts.conversation.id), notice: t('messages.new.forms.success') }
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

end
