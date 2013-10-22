
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

set @n=esimpar(7)

-------------------------------------------------------------

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

call muestra_estado(@x)
call muestra_estado(75)

---------------------------------------------------------

create function f_comprueba (numero int) returns int
deterministic
begin
case
