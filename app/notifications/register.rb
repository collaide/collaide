class Register
  def self.perform(class_name, method_name, values, ids)
    ids.each do |an_id|
       Notif.create(
           class_name: class_name,
           method_name: method_name,
           values: values.to_json,
           id: an_id
       )
    end
  end
end