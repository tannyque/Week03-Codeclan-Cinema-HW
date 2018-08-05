require_relative( 'models/customer')
require_relative( 'models/film')
require_relative( 'models/ticket')

require( 'pry-byebug' )

Ticket.delete_all()
Film.delete_all()
Customer.delete_all()

film1 = Film.new({ 'title' => 'Blade Runner', 'price' => 5 })
film1.save()
film2 = Film.new({ 'title' => 'The Matrix', 'price' => 7})
film2.save()
film3 = Film.new({ 'title' => 'The Silence of the Lambs', 'price' => 6})
film3.save()
film4 = Film.new({ 'title' => 'Toy Story', 'price' => 10})
film4.save()

customer1 = Customer.new({ 'name' => 'Roger Ebert', 'funds' => 15})
customer1.save()
customer2 = Customer.new({ 'name' => 'Ridley Scott', 'funds' => 20})
customer2.save()
customer3 = Customer.new({ 'name' => 'Alfred Hitchcock', 'funds' => 30})
customer3.save()
customer4 = Customer.new({ 'name' => 'Stanley Kubrick', 'funds' => 50})
customer4.save()

ticket1 = Ticket.new({ 'customer_id' => customer1.id, 'film_id' => film1.id})
ticket1.save()
ticket2 = Ticket.new({ 'customer_id' => customer2.id, 'film_id' => film2.id})
ticket2.save()
ticket3 = Ticket.new({ 'customer_id' => customer3.id, 'film_id' => film3.id})
ticket3.save()
ticket4 = Ticket.new({ 'customer_id' => customer4.id, 'film_id' => film4.id})
ticket4.save()
ticket5 = Ticket.new({ 'customer_id' => customer4.id, 'film_id' => film1.id})
ticket5.save()

# customer1.buy_ticket(film2)
binding.pry
nil
