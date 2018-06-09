DELIMITER $$
DROP TRIGGER IF EXISTS ejercicio2 $$
CREATE TRIGGER insert_operacio AFTER INSERT ON operacio
FOR EACH ROW
BEGIN
  IF NEW.quantitat>3000 THEN
    INSERT INTO `alertes`(`num_compte`, `id_operacio`, `motiu`, `data_alerta`) VALUES (NEW.num_compte_desti,NEW.id_operacio,'Ingres molt elevat!',NOW());
  END IF;
END $$
DELIMITER ;
