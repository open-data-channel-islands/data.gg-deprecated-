class ConvertEffectiveDateToInt < ActiveRecord::Migration
  def change
    # Change to be 20130101 instead, this way we can do
    # comparisons and get the latest entry, for example
    change_column :timetables, :effective_date, :integer
  end
end
