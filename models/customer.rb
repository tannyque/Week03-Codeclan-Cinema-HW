require_relative( '../db/sql_runner' )

class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize(options)
    @id = options['id'].to_i() if options['id']
    @name = options['name']
    @funds = options['funds']
  end

  def save()
    sql = "INSERT INTO customers (name, funds) VALUES ($1, $2) RETURNING ID"
    values = [@name, @funds]
    customer = SqlRunner.run(sql, values).first()
    @id = customer['id'].to_i()
  end

  def self.all()
    sql = "SELECT * FROM customers"
    customers_array = SqlRunner.run(sql)
    result = customers_array.map { |customer| Customer.new(customer) }
  end

  def update()
    sql = "UPDATE customers SET (name, funds) = ($1, $2) WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM customers WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

  # def films()
  #   sql = "SELECT films.* FROM films INNER JOIN tickets
  #   ON films.id = tickets.film_id WHERE customer_id = $1"
  #   values = [@id]
  #   film_data = SqlRunner.run(sql, values)
  #   return Film.map_items(film_data)
  # end
  #
  # def self.map_items(data)
  #   result = data.map{|customer| Customer.new(data)}
  #   return result
  # end

  def films()
    sql = "SELECT films.* FROM films INNER JOIN tickets
    ON films.id = tickets.film_id WHERE customer_id = $1"
    values = [@id]
    films_list = SqlRunner.run(sql, values)
    return films_list.map { |film| Film.new(film) }
  end

end
