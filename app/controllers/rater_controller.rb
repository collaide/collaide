# -*- encoding : utf-8 -*-
class RaterController < ApplicationController:w
  def create
    if current_user.present?
      obj = eval "#{params[:klass]}.find(#{params[:id]})"
      if params[:dimension].present?
        obj.rate params[:score].to_i, current_user, "#{params[:dimension]}"
        obj.save.inspect
      else
        obj.rate params[:score].to_i, current_user
      end
      render :json => true
    else
      render :json => false
    end
  end
end
