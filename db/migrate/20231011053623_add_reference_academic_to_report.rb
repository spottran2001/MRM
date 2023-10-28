class AddReferenceAcademicToReport < ActiveRecord::Migration[7.0]
  def change
    add_reference :reports, :academic, index: true
  end
end
