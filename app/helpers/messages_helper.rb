# -*- encoding : utf-8 -*-
module MessagesHelper
  # Crée automatiquement le lien vers l'instance qui a envoyé le message (groupe, user, etc..)
  def link_to_message_sender(receipt)
    case receipt.receiver_type
      when 'User'
        sender = User.find(receipt.receiver_id)
        link_to(sender.name_to_show, sender)
      when 'jensairien'
        #dooo
      else
        false
    end
  end
end
