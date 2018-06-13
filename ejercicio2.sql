
-- Trigger principal
DELIMITER $$
DROP TRIGGER IF EXISTS insert_operacio $$
CREATE TRIGGER insert_operacio AFTER INSERT ON operacio
FOR EACH ROW
BEGIN
  IF NEW.quantitat>3000 THEN
    INSERT INTO `alertes`(`num_compte`, `id_operacio`, `motiu`, `data_alerta`) VALUES (NEW.num_compte_desti,NEW.id_operacio,'Ingres molt elevat!',NOW());
  ELSEIF NEW.quantitat=0 THEN
    INSERT INTO `alertes`(`num_compte`, `id_operacio`, `motiu`, `data_alerta`) VALUES (NEW.num_compte_desti,NEW.id_operacio,'Operacio no valida',NOW());
    CALL eliminar_operacio(NEW.id_operacio);
    -- DELETE FROM operacio WHERE operacio.id_operacio=NEW.id_operacio;
  ELSEIF NEW.quantitat<3000 THEN
    INSERT INTO `alertes`(`num_compte`, `id_operacio`, `motiu`, `data_alerta`) VALUES (NEW.num_compte_desti,NEW.id_operacio,'Nou Ingres!',NOW());
  END IF;
END $$
DELIMITER ;

-- Funcio per eliminar una operacio
DELIMITER $$
  DROP PROCEDURE IF EXISTS eliminar_operacio $$
  CREATE PROCEDURE eliminar_operacio (IN id INT)
  BEGIN
  IF EXISTS (SELECT * FROM operacio WHERE operacio.id_operacio = id) then
    DELETE FROM operacio WHERE operacio.id_operacio=id;
    -- SET @aux = CONCAT ("DELETE FROM operacio WHERE operacio.id_operacio=",id,";" );
    -- PREPARE stmt1 FROM @aux;
    -- EXECUTE stmt1;
    -- DEALLOCATE PREPARE stmt1;
  END IF;
  END $$
DELIMITER ;

-- Trigger 2
DELIMITER $$
DROP TRIGGER IF EXISTS delete_operacio $$
CREATE TRIGGER delete_operacio BEFORE DELETE ON operacio
FOR EACH ROW
BEGIN
  INSERT INTO `alertes`(`num_compte`, `id_operacio`, `motiu`, `data_alerta`) VALUES (OLD.num_compte_desti,OLD.id_operacio,'Operacio esborrada',NOW());
END $$
DELIMITER ;
