class List < ActiveRecord::Base
	after_update :after_update_model
	after_create :after_create_model
	after_destroy :after_destroy_model
	has_many :lists_recipes
	has_many :recipes, through: :lists_recipes, :dependent => :destroy

  has_attached_file :image_url, styles: { medium: "300x300>", thumb: "150x150>" },
                    :default_url => lambda { |image_url| image_url.instance.set_default_url}
                    # default_url: ActionController::Base.helpers.asset_path('/assets/:style/missing_ingredient.png')
  validates_attachment_content_type :image_url, content_type: /\Aimage\/.*\Z/




  def set_default_url
    ActionController::Base.helpers.asset_path('thumb/missing_ingredient.png')
  end


  attr_reader :recipe_tokens
  def recipe_tokens=(ids)
    self.recipe_ids = ids.split(",")
  end


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
