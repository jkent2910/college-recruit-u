class AddFinancialAidLinkToCollege < ActiveRecord::Migration
  def change
    add_column :colleges, :financial_aid_link, :string
  end
end
