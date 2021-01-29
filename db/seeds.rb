# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

companies = [
    {"name"=>"Volkswagen", "country"=>"Germany"},
    {"name"=>"BMW", "country"=>"Germany"},
    {"name"=>"Audi", "country"=>"Germany", "parent_id"=>1},
    {"name"=>"Bentley", "country"=>"England", "parent_id"=>1},
    {"name"=>"Porsche", "country"=>"Germany", "parent_id"=>1},
    {"name"=>"Mercedes", "country"=>"Germany"},
    {"name"=>"Toyota", "country"=>"Japan"},
    {"name"=>"Lexus", "country"=>"Japan", "parent_id"=>7},
    {"name"=>"Honda", "country"=>"Japan"},
    {"name"=>"Acura", "country"=>"Japan", "parent_id"=>9},
    {"name"=>"Tesla", "country"=>"USA"}
]

companies.each do |result|
    Company.create("name"=> result["name"], "country"=> result["country"], "description"=> result["description"],"image"=> result["description"],"parent_id"=> result["parent_id"])

end

# Company.create("name"=>"hi", "country"=>"GA", "description"=>"hello","image"=>"hello.jpg","parent_id"=>"1")