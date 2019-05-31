class AddIdApplicantsInfo < ActiveRecord::Migration[5.1]
  def change
    add_column :applicants_info, :id, :integer
  end
end
