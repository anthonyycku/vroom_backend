class Car
  if(ENV['DATABASE_URL'])
      uri = URI.parse(ENV['DATABASE_URL'])
      DB = PG.connect(uri.hostname, uri.port, nil, nil, uri.path[1..-1], uri.user, uri.password)
    else
      DB = PG.connect(host: "localhost", port: 5432, dbname: 'vroom_development')
    end

  def self.all
      results = DB.exec(
      <<-SQL    
      SELECT * FROM car;
      SQL
      )
      return results.map do |result|
        {

          "id" => result["id"].to_i,
          "model" => result["model"],
          "price" => result["price"].to_i,
          "type" => result["type"],
          "rating"=> result["rating"].to_i,
          "image" => result["image"],
          "company_id" => result["company_id"].to_i
        }
      end
    end

  def self.find(id)
    results = DB.exec(
        <<-SQL
        SELECT car.* FROM car
        LEFT JOIN company
        ON car.company_id = company.id
        WHERE company.id = #{id}
        SQL
    )
    return results.map do |result|
        {
            "id" => result["id"].to_i,
            "model" => result["model"],
            "price" => result["price"].to_i,
            "rating"=> result["rating"].to_i,
            "type" => result["type"],
            "image" => result["image"],
            "company_id" => result["company_id"].to_i
      }
      end
  end

  def self.create(opts)
    results = DB.exec(
        <<-SQL
            INSERT INTO car (model, price, rating, type, image, company_id)
            VALUES ('#{opts["model"]}', #{opts["price"]}, #{opts["rating"]}, '#{opts["type"]}','#{opts["image"]}', #{opts["company_id"]})
            RETURNING id, model, rating, type, image, price, company_id;
        SQL
    )
    result = results.first
    return {
      "id" => result["id"].to_i,
      "model" => result["model"],
      "price" => result["price"].to_i,
      "rating"=> result["rating"].to_i,
      "type" => result["type"],
      "image" => result["image"],
      "company_id" => result["company_id"].to_i
    }
  end

  def self.delete(id)
    results = DB.exec("DELETE FROM car WHERE id=#{id};")
    return { "deleted" => true }
  end

  def self.update(id, opts)
    results = DB.exec(
        <<-SQL
            UPDATE car
            SET model='#{opts["model"]}', rating=#{opts["rating"]}, image='#{opts["image"]}',
            price=#{opts["price"]}, company_id=#{opts["company_id"]}, type='#{opts["type"]}'
            WHERE id=#{id}
            RETURNING id, model, price, type, rating, image, company_id
        SQL
    )
    result = results.first
    return {
      "id" => result["id"].to_i,
      "model" => result["model"],
      "price" => result["price"].to_i,
      "type" => result["type"],
      "rating"=> result["rating"].to_i,
      "image" => result["image"],
      "company_id" => result["company_id"].to_i
    }
  end
end