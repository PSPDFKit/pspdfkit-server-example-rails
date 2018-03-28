class CreateModels < ActiveRecord::Migration[5.0]
  def change
    create_table :documents do |t|
      t.string :title
      t.string :server_id
      t.integer :owner_id
      t.timestamps
    end

    create_table :users do |t|
      t.string :name
      t.timestamps
    end

    create_table :documents_users do |t|
      t.integer :user_id
      t.integer :document_id
      t.timestamps
    end

  end
end
