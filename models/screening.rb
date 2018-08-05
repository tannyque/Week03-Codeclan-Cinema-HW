require_relative( '../db/sql_runner' )

class Screening

  attr_reader :id
  attr_accessor :show_time, :film_id

  def initialize(options)
    @id = options['id'].to_i() if options['id']
    @show_time = options['show_time']
    @film_id = options['film_id']
  end

  def save()
    sql = "INSERT INTO screenings (show_time, film_id) VALUES ($1, $2) RETURNING ID"
    values = [@show_time, @film_id]
    screening = SqlRunner.run(sql, values).first
    @id = screening['id'].to_i()
  end

  def self.all()
    sql = "SELECT * FROM screenings"
    screenings_array = SqlRunner.run(sql)
    result = screenings_array.map { |screening| Screening.new(screening) }
  end

  def update()
    sql = "UPDATE screenings SET (show_time, film_id) = ($1, $2) WHERE id = $3"
    values = [@show_time, @film_id, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM screenings WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM screenings"
    SqlRunner.run(sql)
  end

end
