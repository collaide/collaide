# -*- encoding : utf-8 -*-
module SimpleFormsHelper
  #permet d'introduire facilement un tooltip dans un formulaire
  #=f.input :annotation, label_html: tooltip('salut')
  def tooltip(tip, position = 'tip-top')
    {class: "has-tip #{position}", title: tip, 'data-tooltip' => true}
  end
end
