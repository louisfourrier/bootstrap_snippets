## Module that contains all the common methods that can be shared through all class

module CommonMethods
  extend ActiveSupport::Concern
  
  # To reinitialize the slugs for the friendly id gem
  def initialize_slug
    self.slug = nil
    self.save
  end
  
  # Callbacks for the research_name. Research name is a field that try to ease the process of research
  def update_research_name
    res_name = I18n.transliterate(self.name.to_s).to_s.downcase.strip
    self.update(:research_name => res_name)
  end
  
  # Callback for the first letter
  def update_first_letter
    first_letter = self.name.first
    self.update(:first_letter => first_letter)
  end

  module ClassMethods

  # Execute object method on all the class
  def class_method(method_name)
    self.find_each do |a|
      puts a.id.to_s
      a.send(method_name)
    end
  end

  # Execute several object methods on all the class. Separation by |
  def class_methods(methods_name)
    methods_tab = methods_name.to_s.split("|")
    self.find_each do |a|
      puts a.id.to_s
      methods_tab.each do |method|
        puts method
        a.send(method)
      end
    end
  end

  # Class updater for one field. The field is updated with the value of the getter
  def update_one_field(field, getter)
    self.find_each do |a|
      puts a.id.to_s
      value = a.send(getter)
      field = field.to_sym
      a.update(field => value)
    end
  end
  
  end

end