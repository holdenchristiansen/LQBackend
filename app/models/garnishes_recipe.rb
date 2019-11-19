class GarnishesRecipe < ActiveRecord::Base
  after_create :after_create_model
  after_destroy :after_destroy_model
  belongs_to :garnish
  belongs_to :recipe

  private

  def after_create_model
    vh = VersionHistory.new
    vh.table_name = self.class.to_s.pluralize
    vh.action = 'CREATE'
    columns = self.class.column_names
    vh.primary_keys = ''
    columns.each do |column|
      vh.primary_keys += "#{column}:#{eval("self.#{column}")}," if (column != 'created_at' && column != 'updated_at')
    end
    vh.primary_keys = vh.primary_keys[0..vh.primary_keys.size-2]
    vh.save!
  end

  def after_destroy_model
    vh = VersionHistory.new
    vh.table_name = self.class.to_s.pluralize
    vh.action = 'DELETE'
    columns = self.class.column_names
    vh.primary_keys = ''
    columns.each do |column|
      vh.primary_keys += "#{column}:#{eval("self.#{column}")}," if (column != 'created_at' && column != 'updated_at')
    end
    vh.primary_keys = vh.primary_keys[0..vh.primary_keys.size-2]
    vh.save!
  end
end
