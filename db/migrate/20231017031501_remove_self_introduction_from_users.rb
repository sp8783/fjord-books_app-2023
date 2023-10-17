class RemoveSelfIntroductionFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :self_introduction, :string
  end
end
