class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :job_title
      t.string :headquarters
      t.text :description
      t.text :apply
      t.string :name
      t.string :url
      t.string :email
      t.boolean :highlight

      t.timestamps null: false
    end
  end
end
