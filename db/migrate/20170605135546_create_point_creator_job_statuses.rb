class CreatePointCreatorJobStatuses < ActiveRecord::Migration[5.1]
  def change
    create_table :point_creator_job_statuses do |t|
      t.string :job
      t.boolean :done, default: false, null: false
      t.string :message
      t.belongs_to :point, nullable: true
      t.timestamps
    end
  end
end
