class CreateUserTeams < ActiveRecord::Migration[8.1]
  def change
    create_table :user_teams, primary_key: [ :user_id, :team_id ] do |t|
      t.references :user, null: false, foreign_key: true
      t.references :team, null: false, foreign_key: true
      t.integer :role, default: 3

      t.timestamps
    end
  end
end
