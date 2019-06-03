class CreateRecruitmentSites < ActiveRecord::Migration[5.1]
  def change
    create_table :recruitment_site do |t|
      t.timestamps

      t.string :site_name, null: false
      t.string :url , null: false
      t.integer :scraping_type, default: nil
      t.integer :order_key, default: nil
      t.integer :del_flg, default: '0'

    end
  end
end
