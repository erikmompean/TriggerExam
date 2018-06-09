DELIMITER $$
  DROP PROCEDURE IF EXISTS ejercicio1 $$
  CREATE PROCEDURE ejercicio1 (IN pais VARCHAR(20), OUT numero INTEGER)
  BEGIN
  DECLARE file_name VARCHAR(100);
  SET file_name = CONCAT("C:/Users/Erik/Desktop/pais_", pais, ".txt");

  IF EXISTS (SELECT * FROM client WHERE client.pais = pais) then
    SET @aux = CONCAT ("SELECT nom, cognom FROM client WHERE client.pais='",pais,"' INTO OUTFILE '",file_name,"' FIELDS TERMINATED BY ',' LINES TERMINATED BY ';'" );
    PREPARE stmt1 FROM @aux;
    EXECUTE stmt1;
    DEALLOCATE PREPARE stmt1;
    -- SET @aux = CONCAT ("SELECT COUNT(*) FROM client WHERE client.pais='",pais,"' INTO ", numero);
    -- PREPARE stmt2 FROM @aux;
    -- EXECUTE stmt2;
    -- SELECT numero;
    -- DEALLOCATE PREPARE stmt2;

  ELSE
    SELECT CONCAT('El banc no te cap pais ', pais, ' en aquests moments');
  END IF;
  END $$
DELIMITER ;

--
-- DELIMITER $$
--   DROP PROCEDURE IF EXISTS ejercicio1 $$
--   CREATE PROCEDURE ejercicio1 (IN pais VARCHAR(20), OUT numero INTEGER)
--   BEGIN
--   DECLARE file_name VARCHAR(100);
--   SET file_name = CONCAT("C:/Users/Erik/Desktop/pais_", pais, ".txt");
--
--   IF EXISTS (SELECT * FROM client WHERE client.pais = pais) then
--     SET @aux = CONCAT ("SELECT nom, cognom FROM client WHERE client.pais='",pais,"' INTO OUTFILE '",file_name,"' FIELDS TERMINATED BY ',' LINES TERMINATED BY ';'" );
--   ELSE
--     SELECT CONCAT('El banc no te cap pais ', pais, ' en aquests moments');
--   END IF;
--   END $$
-- DELIMITER ;
