*************************************************************************************
*																					 *
*      Vista que ofrezca la clasificación general de la última edición disputada	 *
*																					 *
**************************************************************************************/
use VUELTA_CICLISTA;
DROP VIEW if EXISTS c_general;

create view c_generalEdiciones_Ciclistas as 
	(select Id_Ciclista, sum(Tiempo) from Ediciones_Ciclistas 
	where id_ciclista in 
			(select id_ciclista from ciclista)
	order by sum(Tiempo)
);

/****************************************************************************************
*																						*
*     Vista que permita visualizar los componentes de cada equipo para la última		*
*     edición disputada																	*
*																						*
*****************************************************************************************/

DROP VIEW IF EXISTS comp_equipos;
create view comp_equipos as
	( select * from Ciclistas_Equipos
			where Ciclistas_Equipos.Id_Equipo in 
				(select id_Equipo, max(anno_edicion from Ediciones_Equipos group by id_equipo)
	);
