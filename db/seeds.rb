Parish.create!(name: 'Castel')
Parish.create!(name: 'Forest')
Parish.create!(name: 'St Andrew')
Parish.create!(name: 'St Martin')
Parish.create!(name: 'St Peter Port')
Parish.create!(name: 'St Pierre du Bois')
Parish.create!(name: 'St Sampson')
Parish.create!(name: 'St Saviour')
Parish.create!(name: 'Torteval')
Parish.create!(name: 'Vale')

test_user = User.create!(email: 'test@data.gg', password: 'password', password_confirmation: 'password',
  forename: 'Test', surname: 'User', is_admin: true)