class Company
    DB = PG.connect({:host=>"localhost", :port => 5432, :dbname => 'vroom_development'})

    def self.all
        results = DB.exec("SELECT * FROM company;")
        return results.each do |result|
          {
            "id" => result["id"].to_i,
            "name" => result["name"],
            "founded"=> result["founded"].to_i,
            "country" => result["country"],
            "parent_id" => result["parent_id"].to_i
          }
        end
      end
  
    def self.find(id)
      results = DB.exec("SELECT * FROM company WHERE id=#{id};")
      return {
        "id" => result["id"].to_i,
        "name" => result["name"],
        "founded"=> result["founded"].to_i,
        "country" => result["country"],
        "parent_id" => result["parent_id"].to_i
      }
    end
  
    def self.create(opts)
      results = DB.exec(
          <<-SQL
              INSERT INTO company (id, name, founded, country, parent_id)
              VALUES ( '#{opts["name"]}', #{opts["founded"]}, '#{opts["country"]}', #{opts["parent_id"]} )
              RETURNING id, name, founded, country, parent_id;
          SQL
      )
      return {
          "id" => results.first["id"].to_i,
          "name" => results.first["name"],
          "founded" => results.first["founded"].to_i,
          "country" => results.first["country"],
          "parent_id" => results.first["parent_id"].to_i
      }
    end
  
    def self.delete(id)
      results = DB.exec("DELETE FROM company WHERE id=#{id};")
      return { "deleted" => true }
    end
  
    def self.update(id, opts)
      results = DB.exec(
          <<-SQL
              UPDATE people
              SET name='#{opts["name"]}', founded=#{opts["founded"]}, country='#{opts["country"]}', parent_id=#{opts["parent_id"]}
              WHERE id=#{id}
              RETURNING id, name, founded, country, parent_id;
          SQL
      )
      return {
          "id" => results.first["id"].to_i,
          "name" => results.first["name"],
          "founded" => results.first["founded"].to_i,
          "country" => results.first["country"],
          "parent_id" => results.first["parent_id"].to_i
      }
    end
end