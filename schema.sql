DROP TABLE IF EXISTS recipes;

DROP TABLE IF EXISTS comments;

CREATE TABLE recipes (
  recipe_id INTEGER,
  recipe VARCHAR(100)
);

CREATE TABLE comments (
  comment_id INTEGER,
  comment VARCHAR(255)
);
