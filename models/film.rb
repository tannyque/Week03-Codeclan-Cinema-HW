require_relative( '../db/sql_runner' )

class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize(options)
    @id = options['id'].to_i() if options['id']
    @title = options['title']
    @price = options['price']
  end

  def save()
    sql = "INSERT INTO films (title, price) VALUES ($1, $2) RETURNING ID"
    values = [@title, @price]
    film = SqlRunner.run(sql, values).first()
    @id = film['id'].to_i()
  end

  def self.all()
    sql = "SELECT * FROM films"
    films_array = SqlRunner.run(sql)
    result = films_array.map { |film| Film.new(film) }
  end

  def update()
    sql = "UPDATE films SET (title, price) = ($1, $2) WHERE id = $3"
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM films WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

  # def customers()
  #   sql = "SELECT customers.* FROM customers INNER JOIN tickets
  #   ON customers.id = tickets.customer_id WHERE film_id = $1"
  #   values = [@id]
  #   customer_data = SqlRunner.run(sql, values)
  #   return Customer.map_items(customer_data)
  # end
  #
  # def self.map_items(data)
  #   result = data.map{|film| Film.new(film)}
  #   return result
  # end

  def customers()
    sql = "SELECT customers.* FROM customers INNER JOIN tickets
    ON customers.id = tickets.customer_id WHERE film_id = $1"
    values = [@id]
    customers_list = SqlRunner.run(sql, values)
    return customers_list.map { |customer| Customer.new(customer) }
  end

  def customer_count()
    sql = "SELECT * FROM tickets WHERE film_id = $1"
    values = [@id]
    SqlRunner.run(sql, values).count
    #result = SqlRunner.run(sql, values)
    #return result = [0]['count'].to_i()
  end

end
