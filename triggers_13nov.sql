/****************************************************************************************
*																					Generar las restricciones:															*
* -Fecha de la etapa entre la fecha de inicio y de fin de la edición correspondiente	*
* -Número de etapa de cada edición entre 20 y 25										*
*																	*
*****************************************************************************************/

DELIMITER //

CREATE TRIGGER fecha_inicio BEFORE INSERT ON edicion
  if new.fecha > Ediciones.Fecha_Inicio and new.fecha < Ediciones.Fecha_fin
	begin
    INSERT INTO Etapas values (new.fecha);
	end if
    UPDATE Ciclistas_Equipos SET DNI = new.DNI WHERE Ciclistas.DNI = Ciclistas_Equipos.Id_Ciclista;
  END
//

DELIMITER ;



/********************************************************************************
*																				*
*  Añadir un campo derivado que sea la letra del DNI a la tabla CICLISTAS 		*
* y que se inserte/actualice al insertarse/actualizarse cada registro en tabla	*
*																				*
*********************************************************************************/

DELIMITER //

CREATE TRIGGER n_DNI BEFORE INSERT ON ciclistas
  FOR EACH ROW BEGIN
    INSERT INTO Ciclistas SET DNI = NEW.DNI;
     
    UPDATE Ciclistas_Equipos SET DNI = new.DNI WHERE Ciclistas.DNI = Ciclistas_Equipos.Id_Ciclista;
  END
//

DELIMITER ;

/****************************************************************************************
*																						*
*Crear una tabla (CONTROL_DATOS_CICLISTAS) para control de inserciones/actualizaciones	*		
* en tabla CICLISTAS: usuario que realiza la inserción/actualización, fecha y hora,		*
* DNI del ciclista, marca que indica si se ha realizado una inserción 					*
* o una actualización (I/U)																*
*																						*
*****************************************************************************************/

CREATE TABLE CONTROL_DATOS_CICLISTAS(
n_DNI int not null,
user varchar(20) NOT NULL,
tipo_accion enum (I, U) NOT NULL,
fecha date not null,
hora time not null)
ENGINE=INNODB;

DELIMITER //

CREATE TRIGGER n_DNI BEFORE INSERT ON ciclistas
 begin
    INSERT INTO CONTROL_DATOS_CICLISTAS values ('new.DNI', user(), 'I', current_date, current_time);
     
  END
//

DELIMITER ;

CREATE TRIGGER n_DNI BEFORE update ON ciclistas
 begin

    INSERT INTO CONTROL_DATOS_CICLISTAS values ('new.DNI', user(), 'U', current_date, current_time);

  END
//

DELIMITER ;
