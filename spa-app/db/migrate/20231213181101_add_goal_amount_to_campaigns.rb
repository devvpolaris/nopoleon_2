class AddGoalAmountToCampaigns < ActiveRecord::Migration[7.0]
  def change
    add_column :campaigns, :goal_amount, :integer, :default => 0
  end
end
