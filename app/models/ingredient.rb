class Ingredient < ActiveRecord::Base
  after_update :after_update_model
  after_create :after_create_model
  after_destroy :after_destroy_model
  before_create :before_create_model
  self.inheritance_column = nil

	has_many :ingredients_recipes
	has_many :recipes, through: :ingredients_recipes, :dependent => :destroy

  has_attached_file :image_url, styles: { medium: "300x300>", thumb: "150x150>" },
                    :default_url => lambda { |image_url| image_url.instance.set_default_url}
                    # default_url: ActionController::Base.helpers.asset_path('/assets/:style/missing_ingredient.png')
  validates_attachment_content_type :image_url, content_type: /\Aimage\/.*\Z/

  has_attached_file :image_highlight_url, styles: { medium: "300x300>", thumb: "150x150>" },
                    :default_url => lambda { |image_highlight_url| image_highlight_url.instance.set_default_url}
                    # default_url: ActionController::Base.helpers.asset_path('/assets/:style/missing_ingredient.png')
  validates_attachment_content_type :image_highlight_url, content_type: /\Aimage\/.*\Z/

  def set_default_url
    ActionController::Base.helpers.asset_path('thumb/missing_ingredient.png')
  end

  private

  def after_update_model
    vh = VersionHistory.new
    vh.table_name = self.class.to_s.pluralize
    vh.action = 'UPDATE'
    vh.primary_keys = "id:#{self.id}"
    columns = self.class.column_names
    vh.change_fields = ''

    change_any_image = self.image_url_file_name_changed? || self.image_highlight_url_file_name_changed?

    columns.each do |column|
      if ((eval("self.#{column}_changed?") && (column != 'created_at' && column != 'updated_at')) ||
          (change_any_image && column == 'image_url_file_name') ||
          (change_any_image && column == 'image_highlight_url_file_name'))
        vh.change_fields += "#{column}:#{eval("self.#{column}")}**,"
      end
    end
    vh.change_fields = vh.change_fields[0..vh.change_fields.size-4]
    vh.save! unless vh.change_fields.blank?
  end

  def after_create_model
    vh = VersionHistory.new
    vh.table_name = self.class.to_s.pluralize
    vh.action = 'CREATE'
    vh.primary_keys = "id:#{self.id}"
    columns = self.class.column_names
    vh.change_fields = ''
    columns.each do |column|
      vh.change_fields += "#{column}:#{eval("self.#{column}")}**," if (column != 'created_at' && column != 'updated_at')
    end
    vh.change_fields = vh.change_fields[0..vh.change_fields.size-4]
    vh.save!
  end

  def after_destroy_model
    vh = VersionHistory.new
    vh.table_name = self.class.to_s.pluralize
    vh.action = 'DELETE'
    vh.primary_keys = "id:#{self.id}"
    vh.save!
  end

  def before_create_model
    unless self.id.blank?
      self.secondaryname = self.name;
      self.name = Ingredient.where(:id => self.id).pluck(:name)
      self.id = nil
    end
  end

end
