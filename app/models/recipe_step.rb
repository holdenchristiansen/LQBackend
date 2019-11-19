class RecipeStep < ActiveRecord::Base
  after_update :after_update_model
  after_create :after_create_model
  after_destroy :after_destroy_model
  belongs_to :recipe

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
  end

  def after_create_model
    vh = VersionHistory.new
    vh.table_name = self.class.to_s.pluralize
    vh.action = 'CREATE'
    vh.primary_keys = "id:#{self.id}"
    columns = self.class.column_names
    vh.change_fields = ''
    columns.each do |column|
      vh.change_fields += "#{column}:#{eval("self.#{column}")}**," if eval("self.#{column}_changed?") if (column != 'created_at' && column != 'updated_at')
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
end
