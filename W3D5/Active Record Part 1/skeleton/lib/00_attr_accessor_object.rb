class AttrAccessorObject
  def self.my_attr_accessor(*names)                             # unpacks args (each arg will be name of method)
    # [ :method_name1, :method_name2 ]
    # implement a ::my_attr_accessor macro, which should do exactly the same 
    # thing as the real attr_accessor: it should define setter/getter methods.
    names.each do |name|                                        # loop through each symbol in names arr
      define_method("#{name}") do                 
        self.instance_variable_get("@#{name}")                  # method will return the instance variable that matches the symbol :name
      end
      define_method("#{name}=") do  |val_to_set|
        self.instance_variable_set("@#{name}", val_to_set)               
      end
    end
  end


  # my_attr_accessor :attr1   # ?<- is this equivalent to what we're trying to do?
  # def initialize(attr1)
  #   @attr1 = attr1
  # end
  # def attr1=(val_to_set)
  #   @attr1 = val_to_set
  # end
end