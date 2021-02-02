class Car
    DB = PG.connect({:host=>"localhost", :port => 5432, :dbname => 'vroom_development'})

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
            "rating"=> result["rating"].to_i,
            "image" => result["image"],
            "description" => result["description"],
            "company_id" => result["company_id"].to_i
          }
        end
      end
  
    def self.find(id)
      results = DB.exec(
          <<-SQL
          SELECT car.* FROM company 
          LEFT JOIN car 
          ON car.company_id=company.id
          SELECT * FROM car 
          WHERE id=#{id}
          SQL
      )
      result = results.first
      return {
        "id" => result["id"].to_i,
            "model" => result["model"],
            "rating"=> result["rating"].to_i,
            "image" => result["image"],
            "description" => result["description"],
            "company_id" => result["company_id"].to_i
      }
    end
  
    def self.create(opts)
      results = DB.exec(
          <<-SQL
              INSERT INTO car (name, model, rating, image, description, company_id)
              VALUES ( '#{opts["name"]}', '#{opts["model"]}', #{opts["rating"]}, '#{opts["image"]}', '#{opts["description]}', #{opts["company_id"]}, )
              RETURNING id, name, model, rating, image, description, company_id;
          SQL
      )
      result = results.first
      return {
        "id" => result["id"].to_i,
        "model" => result["model"],
        "rating"=> result["rating"].to_i,
        "image" => result["image"],
        "description" => result["description"],
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
              SET name='#{opts["name"]}', model='#{opts["model"]}', rating=#{opts["rating"]}, image='#{opts["image"]}',
              description='#{opts["description"]}', company_id='#{opts["image"]}'
              WHERE id=#{id}
              RETURNING id, name, model, rating, image, description, company_id;
          SQL
      )
      result = results.first
      return {
        "id" => result["id"].to_i,
        "model" => result["model"],
        "rating"=> result["rating"].to_i,
        "image" => result["image"],
        "description" => result["description"],
        "company_id" => result["company_id"].to_i
      }
    end
end