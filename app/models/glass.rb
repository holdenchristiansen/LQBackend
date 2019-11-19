class Glass < ActiveRecord::Base
  after_update :after_update_model
  after_create :after_create_model
  after_destroy :after_destroy_model
  before_destroy :check_for_recipes
  belongs_to :recipe
  before_create :randomize_file_name
  before_update :randomize_file_name
  validates :name, uniqueness: true

  attr_accessor :flash_notice

  has_attached_file :image_url, styles: { medium: "300x300>", thumb: "150x150>" },
                    :default_url => lambda { |image_url| image_url.instance.set_default_url}
                    #default_url: ActionController::Base.helpers.asset_path('/assets/:style/missing_glass.png')
  validates_attachment_content_type :image_url, content_type: /\Aimage\/.*\Z/


  def set_default_url
    ActionController::Base.helpers.asset_path('thumb/missing_glass.png')
  end

  private
  
  def check_for_recipes
    if Recipe.where("glass_id = ?", self.id).count > 0
      self.flash_notice = "Cannot delete this Glass because there are recipes using it."
      return false
    else
      self.flash_notice = 'Glass was successfully destroyed.'
    end
  end

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
    vh.save!
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

  def randomize_file_name
    if (image_url_file_name && self.image_url_file_name_changed?)
      extension = File.extname(image_url_file_name).downcase
      self.image_url.instance_write(:file_name, "#{SecureRandom.hex(16)}#{extension}")
    end
  end


end
