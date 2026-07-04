class CreateUserTeams < ActiveRecord::Migration[8.1]
  def change
    create_table :user_teams, primary_key: [ :user_id, :team_id ] do |t|
      t.references :user, null: false, foreign_key: { on_delete: :cascade }
      t.references :team, null: false, foreign_key: { on_delete: :cascade }

      t.integer :role, default: 1

      t.timestamps
    end
  end
end
