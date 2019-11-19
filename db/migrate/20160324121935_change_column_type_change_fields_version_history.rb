class ChangeColumnTypeChangeFieldsVersionHistory < ActiveRecord::Migration
  def change
  	change_column :version_histories, :change_fields, :text
  end
end
