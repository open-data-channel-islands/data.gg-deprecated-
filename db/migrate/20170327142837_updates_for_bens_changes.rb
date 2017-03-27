class UpdatesForBensChanges < ActiveRecord::Migration[5.0]
  def change

    prison_pop = DataCategory.find_by(name: 'Prison Population')
    prison_pop.update!(source_url: 'https://www.gov.gg/prison')


  end
end
