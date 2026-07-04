class CreateTasks < ActiveRecord::Migration[8.1]
  def change
    create_table :tasks do |t|
      t.string :title
      t.string :description
      t.references :team, null: false, foreign_key: { on_delete: :cascade }
      t.references :author, null: false, foreign_key: { to_table: :users }
      t.references :assignee, null: true, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
