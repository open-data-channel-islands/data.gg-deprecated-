xml.instruct!

xml.objects(type: 'array') {
  @population.each do |pop|
    xml.object {
      xml.tag! 'Date-Taken', pop['Date Taken']
      xml.Year(pop['Year'], type: 'integer')
      xml.Sex(pop['Sex'])
      xml.Range(pop['0-4'], type: 'integer', name: '0-4')
      xml.Range(pop['5-9'], type: 'integer', name: '5-9')
      xml.Range(pop['10-14'], type: 'integer', name: '10-14')
      xml.Range(pop['15-19'], type: 'integer', name: '15-19')
      xml.Range(pop['20-24'], type: 'integer', name: '20-24')
      xml.Range(pop['25-29'], type: 'integer', name: '25-29')
      xml.Range(pop['30-34'], type: 'integer', name: '30-34')
      xml.Range(pop['35-39'], type: 'integer', name: '35-39')
      xml.Range(pop['40-44'], type: 'integer', name: '40-44')
      xml.Range(pop['45-49'], type: 'integer', name: '45-49')
      xml.Range(pop['50-54'], type: 'integer', name: '50-54')
      xml.Range(pop['55-59'], type: 'integer', name: '55-59')
      xml.Range(pop['60-64'], type: 'integer', name: '60-64')
      xml.Range(pop['65-69'], type: 'integer', name: '65-69')
      xml.Range(pop['70-74'], type: 'integer', name: '70-74')
      xml.Range(pop['75-79'], type: 'integer', name: '75-79')
      xml.Range(pop['80-84'], type: 'integer', name: '80-84')
      xml.Range(pop['85-89'], type: 'integer', name: '85-89')
      xml.Range(pop['90-94'], type: 'integer', name: '90-94')
      xml.Range(pop['95+'], type: 'integer', name: '95+')
    }
  end
}