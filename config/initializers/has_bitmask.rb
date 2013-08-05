class <<ActiveRecord::Base
   def has_bit_mask (name, array)
    define_method "#{name}=" do |values|
      self.bit_mask = (values & array).map { |r| 2**array.index(r) }.inject(0, :+)
    end
     define_method "#{name}" do
       array.reject { |value|((bit_mask || 0) & 2**array.index(value)).zero?}
     end

     define_method "has_#{name}?" do |value|
       eval("#{name}").each do |r|
         return true if r == value
       end
       false
     end

     #TODO: ajouter les méthodes de types rights<<(value) et rights>>(value)
   end
end