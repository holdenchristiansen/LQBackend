class Category < ActiveRecord::Base
  after_update :after_update_model
  after_create :after_create_model
  after_destroy :after_destroy_model
	has_many :categories_recipes
	has_many :recipes, through: :categories_recipes, :dependent => :destroy

  private
  
  def after_update_model
    vh = VersionHistory.new
    vh.table_name = self.class.to_s.pluralize
    vh.action = 'UPDATE'
    vh.primary_keys = "id:#{self.id}"
    vh.change_fields = "name:#{self.name}"
    vh.save!
  end

  def after_create_model
    vh = VersionHistory.new
    vh.table_name = self.class.to_s.pluralize
    vh.action = 'CREATE'
    vh.primary_keys = "id:#{self.id}"
    vh.change_fields = "name:#{self.name}"
    vh.save!
  end

  def after_destroy_model
    vh = VersionHistory.new
    vh.table_name = self.class.to_s.pluralize
    vh.action = 'DELETE'
    vh.primary_keys = "id:#{self.id}"
    vh.save!
  end
end
