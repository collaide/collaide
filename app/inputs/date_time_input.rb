# -*- encoding : utf-8 -*-
class DateTimeInput < SimpleForm::Inputs::StringInput
  def input
    "<div class=\"hide\">#{super}</div><input type=\"text\" class=\"datepicker-form\"/>".html_safe
  end
end
