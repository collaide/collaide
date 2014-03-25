# -*- encoding : utf-8 -*-
class MessagesController < ApplicationController

  before_filter :get_mailbox, :get_box, :get_actor

  def index
    redirect_to conversations_path(:box => @box)
  end

  # GET /messages/1
  # GET /messages/1.xml
  def show
    if @message = Message.find_by_id(params[:id]) and @conversation = @message.conversation
      if @conversation.is_participant?(@actor)
        redirect_to conversation_path(@conversation, :box => @box, :anchor => "message_" + @message.id.to_s)
        return
      end
    end
    redirect_to conversations_path(:box => @box)
  end

  # GET /messages/new
  # GET /messages/new.xml
  def new
    if params[:receiver].present?
      @recipient = Actor.find_by_slug(params[:receiver])
      return if @recipient.nil?
      @recipient = nil if Actor.normalize(@recipient)==Actor.normalize(current_subject)
    end
  end

  # GET /messages/1/edit
  def edit

  end

  # POST /messages
  # POST /messages.xml
  def create
    @recipients =
        if params[:_recipients].present?
          @recipients = params[:_recipients].split(',').map{ |r| Actor.find(r) }
        else
          []
        end

    @receipt = @actor.send_message(@recipients, params[:body], params[:subject])
    if (@receipt.errors.blank?)
      @conversation = @receipt.conversation
      flash[:success]= t('mailboxer.sent')
      redirect_to conversation_path(@conversation, :box => :sentbox)
    else
      render :action => :new
    end
  end

  # PUT /messages/1
  # PUT /messages/1.xml
  def update

  end

  # DELETE /messages/1
  # DELETE /messages/1.xml
  def destroy

  end

  private

  def get_mailbox
    @mailbox = current_subject.mailbox
  end

  def get_actor
    @actor = Actor.normalize(current_subject)
  end

  def get_box
    if params[:box].blank? or !["inbox","sentbox","trash"].include?params[:box]
      @box = "inbox"
      return
    end
    @box = params[:box]
  end

end
#class MessagesController < ApplicationController
#  #load_and_authorize_resource
#
#  add_breadcrumb I18n.t("messages.index.breadcrumb"), :messages_path
#  add_breadcrumb I18n.t("messages.new.h1_title"), :new_message_path, :only => %w(new create)
#
#
#  def index()
#    #user = User.find(2)
#    #user.send_message(current_user, 'contenu du messag2e')
#    #current_user.send_message(current_user, "Salut Yves, je t'envoie ce mail car j'ai un soucis")
#    @conversations = current_user.mailbox.inbox.page(params[:page]).per(@per)
#
#    respond_to do |format|
#      format.html # index.html.erb
#      format.json {
#        render json: @conversation
#      }
#    end
#  end
#
#  def sentbox
#    add_breadcrumb I18n.t("messages.sentbox.breadcrumb"), :sentbox_messages_path
#    @conversations = current_user.mailbox.sentbox.page(params[:page]).per(@per)
#  end
#
#  def trash
#    add_breadcrumb I18n.t("messages.trash.breadcrumb"), :trash_messages_path
#    @conversations = current_user.mailbox.trash.page(params[:page]).per(@per)
#  end
#
#  def all
#    add_breadcrumb I18n.t("messages.all.breadcrumb"), :all_messages_path
#    @conversations = current_user.mailbox.conversations.page(params[:page]).per(@per)
#  end
#
#  def newParticipant
#
#  end
#
##Cette methode sert juste à traiter la réponse, elle n'aura pas de vue
#  def reply
#    c = Mailboxer::Conversation.find(params[:conversation])
#    unless c
#      redirect_to :messages, alert: t('messages.reply.no_conversation') and return
#    end
#    if params[:reply].empty?
#      redirect_to message_path(c.id), alert: t('messages.reply.empty_message') and return
#    end
#
#    current_user.reply_to_conversation(c, params[:reply])
#
#    redirect_to message_path(c.id), notice: t('messages.reply.succed')
#  end
#
#  def show
#    @conversation = Mailboxer::Conversation.find(params[:id])
#    @receipts = @conversation.receipts_for current_user
#    p @receipts
#    add_breadcrumb @conversation.subject
#  end
#
#  def new
#    @message = UserMessage.new
#    pre_full_message(@message)
#  end
#
#  def create
#    @message = UserMessage.new(message_params)
#    respond_to do |format|
#      if @message.valid?
#        receipts = current_user.send_message(@message.users.to_a, @message.body, @message.subject)
#        if receipts.valid?
#          logger.debug(receipts.save.inspect)
#          format.html { redirect_to message_path(receipts.conversation.id), notice: t('messages.new.forms.success') }
#          format.json { render json: :messages, status: :created, location: @message }
#        else
#          logger.debug(receipts.errors)
#          format.html { render action: 'new' }
#          format.json { render json: @message.errors, status: :unprocessable_entity }
#        end
#      else
#        format.html { render action: 'new' }
#        format.json { render json: @message.errors, status: :unprocessable_entity }
#      end
#    end
#  end
#
#  def destroy
#  end
#
#  def edit
#  end
#
#  def update
#  end
#
#  private
#  def pre_full_message(message)
#    unless params[:id_book].nil?
#      sale_book = Advertisement::SaleBook.find(params[:id_book])
#      message.users<<sale_book.user
#      message.subject=t('sale_books.buy.subject', book: sale_book.book.title)
#      message.body=t('sale_books.buy.textarea', book: sale_book.book.title)
#    end
#    message
#  end
#  def message_params
#    p = params.require(:user_message)
#    {user_ids: p[:user_ids], subject: p[:subject], body: p[:body]}
#  end
#end
