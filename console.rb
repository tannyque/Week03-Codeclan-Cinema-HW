require_relative( 'models/customer')
require_relative( 'models/film')
require_relative( 'models/ticket')

require( 'pry-byebug' )

# Ticket.delete_all()
# Film.delete_all()
# Customer.delete_all()

film1 = Film.new({ 'title' => 'Blade Runner', 'price' => 10 })
film1.save()

binding.pry
nil
