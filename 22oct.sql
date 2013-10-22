G

GRANT 
SELECT,INSERT,UPDATE,DELETE,INDEX,ALTER,CREATE,DROP,RELOAD,SHUTDOWN,PROCESS,FILE
           ON *.*
           TO admin@localhost IDENTIFIED BY '(admin)'
WITH GRANT OPTION;

------------------------------------------------------------------------------------------

GRANT 
SELECT
           ON *.*
           TO operario@localhost IDENTIFIED BY ('')
WITH GRANT OPTION;

--------------------------------------------------------------------------------------

/************************************************************************************************
*												*
* Permita crear un usuario llamado 'invitado' que pueda realizar operaciones de selección,	*
* inserción, actualización y borrado sobre cualquier tabla de la base de datos . 		*
* Limita sus conexiones por hora a 5. Utiliza la instrucción GRANT				*
*												*
*************************************************************************************************/

GRANT 
SELECT,INSERT,UPDATE,DELETE,INDEX,ALTER,CREATE
           ON *.*
           TO invitado1@localhost IDENTIFIED BY ('')
WITH GRANT OPTION;

---------------------------------------------------------------------------

REVOKE super, grant
ON *.*
FROM admin@localhost

-----------------------------------------------------------------------

delimiter//

CREATE PROCEDURE esimpar
BEGIN
	DECLARE num INT;
	

	
--SELECT num % 2;
	if (SELECT num % 2 ==0)
		print 'es un numero par';
	else
		print 'es un numero impar';
	end if;
END

delimiter ;

-------------------------------------------------------------------------

delimiter//

create procedure call_esimpar
begin
	call vuelta_ciclista.esimpar;
end

delmiter;

-------------------------------------------------------------------------
/*******************************************************************************************
*											   *
* Crea una función denominada 'esimpar' que a partir de un número entero devuelva 1    	   *
* si el número introducido es impar y 0 si no lo es.					   *
*											   *
********************************************************************************************/
create function esimpar (in numero int)
	returns int
	deterministic
begin
	declare impar int;
	if mod(numero, 2)=0 then set impar = false;
	else set impar=true;
	end if;
	return (impar);
end;

--------------------------------------------------------------------

/****************************************************************************************
* Prueba la función anterior desde la consola por ejemplo con SET @x=esimpar(50); 	*
* Después comprueba el valor de @x con SELECT @x; 					*
* Observa que no se ha utilizado CALL para ejecutar la función.				*
*****************************************************************************************/

set @n=esimpar(7)

-------------------------------------------------------------

/**************************************************************************
Crea un procedimiento almacenado denominado muestra_estado que a partir   *
de un número entero devuelva la expresión sobre si es impar o par, 	  *
por ejemplo para 7 y 8 "7 es impar" y "8 es par" respectivamente. 	  *
Utiliza dentro del procedimiento la función 'esimpar'			  *
***************************************************************************/
create procedure muestra_estado (in numero int)
begin
if (esimpar(numero))
  then
     concat (numero, ' es impar');
  else
     concat (numero, ' es par');
end if;
end;

-------------------------------------------------------------------
/********************************************************
*							*
* Prueba el procedimiento anterior utilizando CALL	*
*							*
*********************************************************/

call muestra_estado(@x)
call muestra_estado(75)

---------------------------------------------------------

/****************************************************************************************
*											*
* Crea una función denominada 'f_comprueba' que a partir de un				*
* número entero devuelva 1 si es múltiplo de 2, 2 si es múltiplo de 3, 			*
* 3 si es múltiplo de 4 y 0 si nada de lo anterior. Se recomienda usar un CASE.		*
*											*
*****************************************************************************************/


create function f_comprueba (numero int) returns int
deterministic
begin
case
when (numero%2=0) then returns 1;
when (numero%3=0) then returns 2;
when (numero%4=0) then returns 3;
else return 0;
end case;
end;

-------------------------------------------------------------------


handler;
create procedure insertar_ciclista (in ..... , out mensaje varchar(45))
modifies sql data
begin
	declare continue handler for 1062 set mensaje = 'DNI de ciclista ya insertado';
	set mensaje= 'ciclista insertado con exito';
	insert into ciclistas (....) values (....);
end;

-------------------------------------------------------------------------------

create procedure insertar_ciclista (in .....)
modifies sql data
begin
	begin
		declare clave_duplicada int default 0;
		declare exit handler for 1062 set clave_duplicada = 1;
		insert into ciclistas (....) values ;
	end;
if clave_duplicada = 1 then
	select concat ....
else
	select concat ....
end if;
end;



