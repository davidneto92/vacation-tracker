class AddNpsSiteToParks < ActiveRecord::Migration[5.1]
  def change
    add_column :parks, :nps_url, :string
  end
end
