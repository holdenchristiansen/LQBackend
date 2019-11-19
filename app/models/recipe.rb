class Recipe < ActiveRecord::Base
  after_update :after_update_model
  after_create :after_create_model
  after_destroy :after_destroy_model
  before_create :before_create_model

  has_many :categories_recipes
  has_many :categories, through: :categories_recipes, :dependent => :destroy
  has_many :lists_recipes
  has_many :lists, through: :lists_recipes, :dependent => :destroy

  has_many :recipe_steps, -> { order(stepindex: :asc) } , :dependent => :destroy
  has_one :glass
  has_many :ingredients_recipes
  has_many :ingredients, through: :ingredients_recipes, :dependent => :destroy
  has_many :garnishes_recipes
  has_many :garnishes, through: :garnishes_recipes, :dependent => :destroy


  has_many :similar_recipes
  has_many :reflexives, :through => :similar_recipes, :source => :recipe, :dependent => :destroy

  accepts_nested_attributes_for :recipe_steps, :reject_if => lambda { |a| a[:steptitle].blank? }, :allow_destroy => true


  attr_reader :ingredient_tokens
  def ingredient_tokens=(ids)
    self.ingredient_ids = ids.split(",")
  end

  attr_reader :category_tokens
  def category_tokens=(ids)
    self.category_ids = ids.split(",")
  end

  attr_reader :garnish_tokens
  def garnish_tokens=(ids)
    self.garnish_ids = ids.split(",")
  end

  attr_reader :similar_recipe_tokens
  def similar_recipe_tokens=(ids)
    #Similar recipes displaying
    @similar_recipes_display = ids.split(",").map { |i| i.to_i }
    unless self.id.blank?
      #Get the recipes to destroy
      #This line:
      #(@similar_recipes_display.size == 0 ? [-1] : @similar_recipes_display ))
      #is for avoid empty array because cause problems in query
      destroy_similar_recipes = 
        SimilarRecipe.where("recipe_id = ? AND reflexive_id not in (?)", 
          self.id, 
          (@similar_recipes_display.size == 0 ? [-1] : @similar_recipes_display ))
      
      #Destroy Recipes
      destroy_similar_recipes.destroy_all
    end
    
    #Add new recipes
    current_similar_recipes = SimilarRecipe.where(:recipe_id => self.id).pluck(:reflexive_id)
    added_similar_recipes = @similar_recipes_display - current_similar_recipes
    @similar_r = []
    added_similar_recipes.each do |id|
      @similar_r << SimilarRecipe.new(:recipe_id=>self.id, :reflexive_id=>id)
    end
  end

  def similar_recipe_tokens
    self.similar_recipes.map{|object| {:id=>object.reflexive_id, :name=> object.name};}
  end

  private

  def after_update_model
    vh = VersionHistory.new
    vh.table_name = self.class.to_s.pluralize
    vh.action = 'UPDATE'
    vh.primary_keys = "id:#{self.id}"
    columns = self.class.column_names
    vh.change_fields = ''
    columns.each do |column|
      vh.change_fields += "#{column}:#{eval("self.#{column}")}**," if eval("self.#{column}_changed?") if (column != 'created_at' && column != 'updated_at')
    end
    vh.change_fields = vh.change_fields[0..vh.change_fields.size-4]
    vh.save! unless vh.change_fields.blank?
    save_similar_recipes
  end

  def after_create_model
    vh = VersionHistory.new
    vh.table_name = self.class.to_s.pluralize
    vh.action = 'CREATE'
    vh.primary_keys = "id:#{self.id}"
    columns = self.class.column_names
    vh.change_fields = ''
    columns.each do |column|
      vh.change_fields += "#{column} : #{eval("self.#{column}")}**," if eval("self.#{column}_changed?") if (column != 'created_at' && column != 'updated_at')
    end
    vh.change_fields = vh.change_fields[0..vh.change_fields.size-4]
    vh.save!
    save_similar_recipes
  end

  def save_similar_recipes
    unless @similar_r.blank?
      @similar_r.each do |similar|
        similar.recipe_id = self.id
        similar.save!
      end
    end
  end

  def after_destroy_model
    vh = VersionHistory.new
    vh.table_name = self.class.to_s.pluralize
    vh.action = 'DELETE'
    vh.primary_keys = "id:#{self.id}"
    vh.save!
    save_similar_recipes
  end

  def before_create_model
    if !self.drinkid
      self.drinkid = Recipe.maximum("drinkid") + 1
    end
  end

end
