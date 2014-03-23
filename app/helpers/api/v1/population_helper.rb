module Api::V1::PopulationHelper
  # TODO: number_cols should be some kind of constant
  # not sure how to do that in a Module

  def sum_population_row(population)
    number_cols = %w(0-4 5-9 10-14 15-19 20-24 25-29 30-34
      35-39 40-44 45-49 50-54 55-59 60-64 65-69 70-74
      75-79 80-84 85-89 90-94 95+)
    sum = 0
    number_cols.each do |c|
      sum += population[c] if !population[c].nil?
    end

    return sum
  end

  def age_group_percents(population)
    total_population = sum_population_row(population)
    number_cols = %w(0-4 5-9 10-14 15-19 20-24 25-29 30-34
      35-39 40-44 45-49 50-54 55-59 60-64 65-69 70-74
      75-79 80-84 85-89 90-94 95+)

    percent_vals = { }
    number_cols.each do |c|
      percent_vals[c] = 0 # Set to 0 in case nil
      if !population[c].nil? && population[c] != 0
        percent_vals[c] = ((population[c].to_f / total_population.to_f) * 100.0)
      end
    end

    return percent_vals
  end

  def age_groups_coloured(colours, age_groups)
  coloured_age_group_values = []
    colours.each do |k,v|
      row = {}
      row['value']= age_groups[k]
      row['color'] = v
      coloured_age_group_values << row
    end

  return coloured_age_group_values.to_json.html_safe
  end
end
