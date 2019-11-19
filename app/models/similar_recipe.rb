class SimilarRecipe < ActiveRecord::Base
  after_create :after_create_model
  after_destroy :after_destroy_model

	belongs_to :recipe
	belongs_to :reflexive, :class_name => 'Recipe'

	attr_reader :name 
	attr_accessor :name
  def name
    Recipe.find(self.reflexive_id).name
  end

  attr_accessor :attributes
  def attributes
    {:id => self.reflexive_id, :name => Recipe.find(self.reflexive_id).name, :recipe_id => self.recipe_id, :reflexive_id => self.reflexive_id}
  end

  private

  def after_create_model
    vh = VersionHistory.new
    vh.table_name = self.class.to_s.pluralize
    vh.action = 'CREATE'
    vh.primary_keys = "recipe_id:#{self.recipe_id},reflexive_id:#{self.reflexive_id}"
    vh.save!
  end

  def after_destroy_model
    vh = VersionHistory.new
    vh.table_name = self.class.to_s.pluralize
    vh.action = 'DELETE'
    vh.primary_keys = "recipe_id:#{self.recipe_id},reflexive_id:#{self.reflexive_id}"
    vh.save!
  end

end
