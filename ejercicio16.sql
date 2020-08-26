create database if not exists clase16;
use clase16;

CREATE TABLE if not exists `employees` (
  `employeeNumber` int(11) NOT NULL,
  `lastName` varchar(50) NOT NULL,
  `firstName` varchar(50) NOT NULL,
  `extension` varchar(10) NOT NULL,
  `email` varchar(100) NOT NULL,
  `officeCode` varchar(10) NOT NULL,
  `reportsTo` int(11) DEFAULT NULL,
  `jobTitle` varchar(50) NOT NULL,
  PRIMARY KEY (`employeeNumber`)
);

insert  into `employees`(`employeeNumber`,`lastName`,`firstName`,`extension`,`email`,`officeCode`,`reportsTo`,`jobTitle`) values 
(1002,'Murphy','Diane','x5800','dmurphy@classicmodelcars.com','1',NULL,'President'),
(1056,'Patterson','Mary','x4611','mpatterso@classicmodelcars.com','1',1002,'VP Sales'),
(1076,'Firrelli','Jeff','x9273','jfirrelli@classicmodelcars.com','1',1002,'VP Marketing');

-- Insert a new employee to , but with an null email. Explain what happens.
insert  into `employees`(`employeeNumber`,`lastName`,`firstName`,`extension`,`email`,`officeCode`,`reportsTo`,`jobTitle`) values 
(1000,'Franco','Bustos','x5800',NULL,'1',1000,'President')
-- Salta un error indicando que email no puede ser nulo, esto se debe a un contraint al crear la base indicando esto.

-- Run the first the query
UPDATE employees SET employeeNumber = employeeNumber - 20

-- What did happen? Explain. El id de todos los empleados disminuye en 20. Esto puede ocasionar problemas si otra tabla tuviese de fk la id de los empleados.
-- Ademas de que disminuye en orden, por lo que puede duplicar id en algun momento y saltar error.
SELECT * FROM employees e 

-- Then run this other
UPDATE employees SET employeeNumber = employeeNumber + 20
-- Explain this case also. Como explique antes, en este caso se duplica el id 1056 en un momento y salta el error.

-- Add a age column to the table employee where and it can only accept values from 16 up to 70 years old.
ALTER TABLE employees 
   ADD age INT CHECK (age >= 16 and age <= 70);

-- Describe the referential integrity between tables film, actor and film_actor in sakila db.
-- Estan referenciadas a traves de fk, film_actor tiene fk de film y de actor en sus columnas, gracias a esto las une

-- 5- Create a new column called lastUpdate to table employee and use trigger(s) to keep the date-time updated on inserts and updates operations.
ALTER TABLE employees 
   ADD lastUpdate timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
  
CREATE TRIGGER lupd_aupdate
AFTER UPDATE ON employees FOR EACH ROW 
BEGIN
   	UPDATE employees 
   	SET lastUpdate = CURRENT_TIMESTAMP
   	WHERE employeeNumber = now.employeeNumber; 
END;
DROP DATABASE clase16;

use sakila

CREATE DEFINER=`user`@`%` TRIGGER `ins_film` AFTER INSERT ON `film` FOR EACH ROW BEGIN
    INSERT INTO film_text (film_id, title, description)
        VALUES (new.film_id, new.title, new.description);
  END
-- Despues de crear una pelicula en film, inserta en film_text una nueva fila con id, titulo y descripcion igual al creado en film 

CREATE DEFINER=`user`@`%` TRIGGER `upd_film` AFTER UPDATE ON `film` FOR EACH ROW BEGIN
    IF (old.title != new.title) OR (old.description != new.description) OR (old.film_id != new.film_id)
    THEN
        UPDATE film_text
            SET title=new.title,
                description=new.description,
                film_id=new.film_id
        WHERE film_id=old.film_id;
    END IF;
  END
  
-- Al actualizarse una pelicula, si su titulo, descripcion o id cambio, cambia tambien en film_text
  
CREATE DEFINER=`user`@`%` TRIGGER `del_film` AFTER DELETE ON `film` FOR EACH ROW BEGIN
    DELETE FROM film_text WHERE film_id = old.film_id;
  END
  
-- Al borrarse una pelicula en film, tambien se borra en film_text

