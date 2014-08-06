class CustomFailure < Devise::FailureApp
  def redirect_url
    if request.env['HTTP_REFERER']
      request.env['HTTP_REFERER']
    else
      root_path
    end
  end

  # You need to override respond to eliminate recall
  def respond
    redirect
  end
end