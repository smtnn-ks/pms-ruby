class CreateTaskChangelogs < ActiveRecord::Migration[8.1]
  def change
    create_table :task_changelogs do |t|
      t.references :task, null: false, foreign_key: { on_delete: :cascade }
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
