House.delete_all
Student.delete_all

ravenclaw = House.create( name: 'Ravenclaw' )
hufflepuff = House.create( name: 'Hufflepuff' )
slytherin = House.create( name: 'Slytherin' )
gryffindor = House.create( name: 'Gryffindor' )

require 'faker'

20.times do |x|
  x = Student.create( name: Faker::Name.first_name, house_id: rand(4) + 1)
end

harry = Student.create( name: 'Harry Potter', house_id: 4)
ron = Student.create( name: 'Ron Weasley', house_id: 4)
hermoine = Student.create( name: 'Hermoine Grainger', house_id: 4)