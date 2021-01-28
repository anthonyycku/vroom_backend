class Company
    DB = PG.connect({:host=>"localhost", :port => 5432, :dbname => 'vroom_development'})

    def self.all
        results = DB.exec(
        <<-SQL    
        SELECT * FROM company;
        SQL
        )
        return results.map do |result|
          {
            "id" => result["id"].to_i,
            "name" => result["name"],
            "founded"=> result["founded"],
            "country" => result["country"],
            "parent_id" => result["parent_id"].to_i,
            "image" => result["image"]
          }
        end
      end
  
    def self.find(id)
      results = DB.exec(
          <<-SQL
          SELECT
          parent.*,
          child.name as "childName",
          child.id as "childID",
          child.image as "childImage"
          FROM company as parent
          LEFT JOIN company as child 
          ON parent.id=child.parent_id
          WHERE parent.id=#{id}
          SQL
      )
    if results.first["childID"].to_i > 0
        childrenArray = results.map do |result|
            {
            "childID" => result["childID"].to_i,
            "childName" => result["childName"],
            "childImage" => result["childImage"]
            }
        end
    end
      result = results.first
      return {
        "id" => result["id"].to_i,
        "name" => result["name"],
        "founded"=> result["founded"],
        "country" => result["country"],
        "parent_id" => result["parent_id"].to_i,
        "image" => result["image"],
        "children" => childrenArray

      }
    end
  
    def self.create(opts)
      results = DB.exec(
          <<-SQL
              INSERT INTO company (name, founded, country, parent_id)
              VALUES ( '#{opts["name"]}', #{opts["founded"]}, '#{opts["country"]}', #{opts["parent_id"]} )
              RETURNING id, name, founded, country, parent_id;
          SQL
      )
      return {
          "id" => results.first["id"].to_i,
          "name" => results.first["name"],
          "founded" => results.first["founded"],
          "country" => results.first["country"],
          "parent_id" => results.first["parent_id"].to_i,
          "image" => result["image"]
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
          "founded" => results.first["founded"],
          "country" => results.first["country"],
          "parent_id" => results.first["parent_id"].to_i
      }
    end
end