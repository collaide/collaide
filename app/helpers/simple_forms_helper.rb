# -*- encoding : utf-8 -*-
module SimpleFormsHelper
  #permet d'introduire facilement un tooltip dans un formulaire
  def tooltip(tip, position = 'tip-top')
    {class: "has-tip #{position}", title: tip, 'data-tooltip' => ''}
  end
end
