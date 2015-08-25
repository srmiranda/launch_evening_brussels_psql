require 'pg'
require 'pry'

def db_connection
  begin
    connection = PG.connect(dbname: "brussels_sprouts_recipes")
    yield(connection)
  ensure
    connection.close
  end
end

TITLES = [
  "Roasted Brussels Sprouts",
  "Fresh Brussels Sprouts Soup",
  "Brussels Sprouts with Toasted Breadcrumbs, Parmesan, and Lemon",
  "Cheesy Maple Roasted Brussels Sprouts and Broccoli with Dried Cherries",
  "Hot Cheesy Roasted Brussels Sprout Dip",
  "Pomegranate Roasted Brussels Sprouts with Red Grapes and Farro",
  "Roasted Brussels Sprout and Red Potato Salad",
  "Smoky Buttered Brussels Sprouts",
  "Sweet and Spicy Roasted Brussels Sprouts",
  "Smoky Buttered Brussels Sprouts",
  "Brussels Sprouts and Egg Salad with Hazelnuts"]

  COMMENTS = [
   {0 => "Best dish ever!"},
   {1 => "Too salty!"},
   {2 => "My kids loved them!"},
   {3 => "Easy to make!"},
   {4 => "Not my favorite."},
   {5 => "I've had better."},
   {6 => "Make me puke!"},
   {7 => "Not bad."},
   {8 => "Best brussels ever!"},
   {9 => "Too spicy!"},
   {10 => "The best so far!"},
   {8 => "Great leftovers!"},
   {2 => "I'll definitely make this again!"},
   {4 => "Try it with some bacon!"}
  ]

#WRITE CODE TO SEED YOUR DATABASE AND TABLES HERE

db_connection do |conn|
  TITLES.each_with_index do |index, item|
    conn.exec_params("INSERT INTO recipes (recipe, recipe_id) VALUES ($1, $2)", [index, item])
  end
  COMMENTS.each do |hash|
    hash.each do |key, value|
      conn.exec_params("INSERT INTO comments (comment_id, comment) VALUES ($1, $2)", [key, value])
    end
  end
end

db_connection do |conn|
  conn.exec("
  SELECT recipes.recipe_id, recipes.recipe, comments.comment_id, comments.comment
  FROM recipes
  JOIN comments ON recipes.recipe_id = comments.comment_id
  ORDER BY recipes.recipe_id ASC")
end


# QUESTIONS:
# How many recipes are there in total?
select count(recipe) from recipes;

# How many comments are there in total?
select count(comment) from comments;

# How would you find out how many comments each of the recipes have?
select count(*) from comments where comment_id = 4;

# What is the name of the recipe that is associated with a specific comment?
select recipes.recipe
from recipes
inner join comments
on recipes.recipe_id = comments.comment_id
where comments.comment = ('Too spicy!');

# Add a new recipe titled Brussels Sprouts with Goat Cheese. Add two comments to it.
insert into recipes (recipe, recipe_id) values ('Brussels Sprouts with Goat Cheese', 11);
insert into comments (comment, comment_id) values ('Who likes goat cheese?', 11);
insert into comments (comment, comment_id) values ('I love goat cheese!', 11);
