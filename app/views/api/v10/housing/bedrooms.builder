xml.instruct!

xml.objects(type: 'array') {
  @bedrooms.each do |row|
    xml.object {
      xml.Year(row['Year'], type: 'integer')
      xml.Market(row['Market'])
      xml.Count(row['1'], type: 'integer', name: '1')
      xml.Count(row['2'], type: 'integer', name: '2')
      xml.Count(row['3'], type: 'integer', name: '3')
      xml.Count(row['4'], type: 'integer', name: '4')
      xml.Count(row['Over 4'], type: 'integer', name: 'Over 4')
      xml.Count(row['Unknown'], type: 'integer', name: 'Unknown')
    }
  end
}