class ObserverHelpers
  def self.current_user
    @@current_user
  end

  def self.current_user=(user)
    @@current_user = user
  end
end