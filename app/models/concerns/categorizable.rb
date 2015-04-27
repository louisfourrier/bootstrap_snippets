module Categorizable
  extend ActiveSupport::Concern

  # Module that is added to all the class that are categorizable
  # Associations polymorhpic for the models
  included do
    attr_writer :categories_list
    has_many :categorizings, as: :categorizable, dependent: :destroy
    has_many :categories, through: :categorizings
    
    after_save :save_categories_list
  end
  
  # Virtual attributes. Getter for the Autocomplete associations form
  def categories_list
    # tags.map(&:name).join(", ")
    @categories_list || self.categories.to_json
  end
  
  # Callback that handle the process of saving the associations
  def save_categories_list
    categories = self.categories_list.split(',')
    categories_id = []
    
    categories.each do |id|
      category = Category.find_by_id(id.to_i)
      if category
      categories_id << category.id
      end
    end
    
    puts "Les categories_id " +  categories_id.to_s
    self.category_ids = categories_id.uniq

  end

  # Place to put class methods relative to the categoriable behaviour
  module ClassMethods
  end
  
  
  

end