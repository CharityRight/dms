ROM::SQL.migration do
  change do
    create_table :projects do
      primary_key :id
      column :active, :boolean, default: true, index: true
      column :name, :text, null: false, index:true
      column :description, :text
      column :code, :text, null: false, index:true
      column :cause_id, :integer, null: false, index:true
    end
  end
end
