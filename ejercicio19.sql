-- Create a user data_analyst
use mysql;
CREATE USER data_analyst IDENTIFIED BY 'gatitos123';

-- Grant permissions only to SELECT, UPDATE and DELETE to all sakila tables to it.
GRANT SELECT, UPDATE, DELETE ON sakila.* TO 'data_analyst'@'%';

-- Login with this user and try to create a table. Show the result of that operation.
-- ERROR 1142 (42000): CREATE command denied to user 'data_analyst'@'localhost' for table 'lol'

-- Try to update a title of a film. Write the update script.
use sakila;
UPDATE films
SET title = 'Lion King'
WHERE film_id = 1;

-- With root or any admin user revoke the UPDATE permission. Write the command
use mysql;
REVOKE UPDATE ON sakila.* FROM data_analyst;

-- Login again with data_analyst and try again the update done in step 4. Show the result.
-- ERROR 1142 (42000): UPDATE command denied to user 'data_analyst'@'localhost' for table 'films'


