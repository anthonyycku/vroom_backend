class Company < ApplicationRecord
  if(ENV['DATABASE_URL'])
    uri = URI.parse(ENV['DATABASE_URL'])
    DB = PG.connect(uri.hostname, uri.port, nil, nil, uri.path[1..-1], uri.user, uri.password)
  else
    DB = PG.connect(host: "localhost", port: 5432, dbname: 'vroom_development')
  end

  def self.all
    results = DB.exec(
    <<-SQL    
    SELECT * FROM company
    ORDER BY id ASC;
    SQL
    )
    return results.map do |result|
      {
        "id" => result["id"].to_i,
        "name" => result["name"],
        "description" => result["description"],
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
    "description" => result["description"],
    "country" => result["country"],
    "parent_id" => result["parent_id"].to_i,
    "image" => result["image"],
    "children" => childrenArray

  }
end

def self.create(opts)
  results = DB.exec(
      <<-SQL
          INSERT INTO company (name, country, description, image, parent_id)
          VALUES ('#{opts["name"]}',
          '#{opts["country"]}',
          '#{opts["description"]}',
          '#{opts["image"]}',
          #{opts["parent_id"]})
          RETURNING id, name, country, parent_id, description, image;
      SQL
  )
  return {
      "id" => results.first["id"].to_i,
      "name" => results.first["name"],
      "description" => results.first["description"],
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
          UPDATE company
          SET name='#{opts["name"]}',
          description='#{opts["description"]}',
          country='#{opts["country"]}', image='#{opts["image"]}',
          parent_id=#{opts["parent_id"]}
          WHERE id=#{id}
          RETURNING id, name, description, image, country, parent_id;
      SQL
  )
  results.first["parent_id"] = 0 if results.first["parent_id"] == nil
  return {
      "id" => results.first["id"].to_i,
      "name" => results.first["name"],
      "description" => results.first["description"],
      "image" => results.first["image"],
      "country" => results.first["country"],
      "parent_id" => results.first["parent_id"].to_i
  }
end

def self.filterCountry()
  results = DB.exec(
    <<-SQL
    SELECT * FROM company
    ORDER BY  country ASC
    SQL
  )
  return results.map do |result|
    {
      "id" => result["id"].to_i,
      "name" => result["name"],
      "description" => result["description"],
      "country" => result["country"],
      "parent_id" => result["parent_id"].to_i,
      "image" => result["image"],
  }
  end
end

def self.filterCountryDesc()
  results = DB.exec(
    <<-SQL
    SELECT * FROM company
    
    ORDER BY  country DESC
    SQL
  )
  return results.map do |result|
    {
      "id" => result["id"].to_i,
      "name" => result["name"],
      "description" => result["description"],
      "country" => result["country"],
      "parent_id" => result["parent_id"].to_i,
      "image" => result["image"],
  }
  end
end

def self.alphabeticalASC()
  results = DB.exec(
    <<-SQL
    SELECT  * FROM company
    
    ORDER BY  name ASC
    SQL
  )
  return results.map do |result|
    {
      "id" => result["id"].to_i,
      "name" => result["name"],
      "description" => result["description"],
      "country" => result["country"],
      "parent_id" => result["parent_id"].to_i,
      "image" => result["image"],
  }
  end
end

def self.alphabeticalDesc()
  results = DB.exec(
    <<-SQL
    SELECT  * FROM company
    
    ORDER BY  name DESC
    SQL
  )
  return results.map do |result|
    {
      "id" => result["id"].to_i,
      "name" => result["name"],
      "description" => result["description"],
      "country" => result["country"],
      "parent_id" => result["parent_id"].to_i,
      "image" => result["image"],
  }
  end
end

def self.countcarsASC() 
results = DB.exec(
  <<-SQL
  SELECT COUNT(car.id) as count, company.id, company.name, company.country, company.image FROM car
  LEFT JOIN company ON company.id=car.company_id
  GROUP BY company.id, company.name, company.country, company.image
  ORDER BY COUNT ASC
  SQL
)

return results.map do |result|
  {
    "id" => result["id"],
    "name" => result["name"],
    "country" => result["country"],
    "image" => result["image"],
    "count" => result["count"]
  }
end
end

def self.countcarsDESC
results = DB.exec(
  <<-SQL
  SELECT COUNT(car.id) as count, company.id, company.name, company.country, company.image FROM car
  LEFT JOIN company ON company.id=car.company_id
  GROUP BY company.id, company.name, company.country, company.image
  ORDER BY COUNT DESC
  SQL
)
return results.map do |result|
  {
    "id" => result["id"],
    "name" => result["name"],
    "country" => result["country"],
    "image" => result["image"],
    "count" => result["count"]
  }
end
end

end
