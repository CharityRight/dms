ROM::SQL.migration do
  change do
    add_column :projects, :eligible_for_zakat, :boolean, default: false, index: true
    add_column :projects, :longitude, :text
    add_column :projects, :location, :text
    add_column :projects, :latitude, :text
    add_column :projects, :target_total, :integer, null: false
  end
end
