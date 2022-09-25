class Renamezip_codeToZipCode < ActiveRecord::Migration[7.0]
  def change
    rename_column :warehouses, :zip_code, :zip_code
  end
end
