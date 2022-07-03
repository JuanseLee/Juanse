/*
CheckPoint III
CAMADA 6 - 0921
GRUPO 8
INTEGRANTES: Harry Montenegro,   Luis Miguel Orviz,    Gabriel Marquez,    Juan Lozano

Enunciado
La institución hotelera LA APROBACIÓN, nos pidió una tercera reunión. Para este hito, se nos solicita presentar una serie de reportes sobre
los datos almacenados en la base de datos que hemos construido. En base a lo solicitado, vamos a trabajar en la producción de los siguientes reportes
*/

USE la_aprobacion;

/*
1. Listar los servicios básicos de la habitación número 25.
*/

SELECT habitacion_numero AS 'Número de habitación', servicio_basico.nombre AS 'Servicios básicos de la habitación 25'
FROM habitacion_x_servicio_basico
INNER JOIN servicio_basico ON habitacion_x_servicio_basico.servicio_basico_id = servicio_basico.id
INNER JOIN habitacion ON habitacion_x_servicio_basico.habitacion_numero = habitacion.numero
WHERE habitacion_numero = 25;
/* Esta consulta de SQL retorna 4 filas de registros */

/*
2. Listar absolutamente todos los servicios básicos y la cantidad de habitaciones en las que están instalados. Mostrar sólo el nombre del servicio básico y cantidad.
*/

SELECT servicio_basico.nombre AS 'Nombre de Servicio Básico', COUNT(*) AS "Cantidad de habitaciones"
FROM habitacion_x_servicio_basico
JOIN servicio_basico ON habitacion_x_servicio_basico.servicio_basico_id = servicio_basico.id
JOIN habitacion ON habitacion_x_servicio_basico.habitacion_numero = habitacion.numero
GROUP BY servicio_basico_id;
/* Esta consulta de SQL retorna 10 filas de registros */

/*
3. Listar todos los huéspedes que tengan tres o más check-in. Mostrar el número
de huésped, apellido y nombre separado por un espacio dentro de una misma columna denominada "Cliente" y, la cantidad de check-in que posee.*/

SELECT huesped_id, CONCAT(nombre, ' ', apellido) AS "Cliente", COUNT(*) AS "Cantidad de Check-ins"
FROM checkin
JOIN huesped ON checkin.id = huesped.id
GROUP BY huesped_id
HAVING `Cantidad de Check-ins`>=3
ORDER BY huesped_id ASC;
/* Esta consulta de SQL retorna 8 filas de registros */

/*
4. Listar todos los huéspedes que no tengan un check-in. Mostrar el número de
huésped, apellido y nombre en mayúsculas dentro de una misma columna
denominada "huésped sin check-in".
*/

SELECT huesped.id AS 'Número de huésped', UPPER(CONCAT(nombre, ' ', apellido)) AS "Huésped sin check-in"
FROM checkin
RIGHT JOIN huesped ON huesped_id = huesped.id
WHERE huesped_id IS NULL;
/* Esta consulta de SQL retorna 16 filas de registros */

/*
5. Listar todos los huéspedes que tengan al menos un check-in que corresponda a
la habitación de clase 'Classic'. Se debe mostrar el número de huésped, apellido,
nombre, número de habitación y la clase.
*/

SELECT huesped.id AS 'Número de huésped', huesped.apellido AS 'Apellido', huesped.nombre AS 'Nombre', habitacion.numero AS 'Número de habitación', clase.nombre AS 'Clase'
FROM checkin
JOIN huesped ON huesped_id = huesped.id
JOIN habitacion ON habitacion_numero = habitacion.numero
JOIN clase ON habitacion.clase_id = clase.id
WHERE clase.nombre = "Classic";
/* Esta consulta de SQL retorna 47 filas de registros */

/*
6. Listar los huéspedes que tengan una o más reservas y que en la segunda letra de
su apellido contenga una "u". Se debe mostrar el número de huésped, apellido,
nombre, nombre del servicio.*/

SELECT huesped_id AS "número de huésped", apellido, h.nombre, se.nombre AS "nombre del servicio" FROM reserva r
INNER JOIN servicio_extra se 
ON servicio_extra_id = se.id
INNER JOIN huesped h 
ON huesped_id = h.id
WHERE h.nombre LIKE "_u%";

/* Esta consulta de SQL retorna 15 filas de registros */

/*
7. Listar absolutamente todos los países y la cantidad de huéspedes que tengan.
*/

SELECT p.nombre AS "Nombre del Pais", count(h.id) FROM huesped h
INNER JOIN pais p 
ON pais_id = p.id
GROUP BY p.nombre;

/* Esta consulta de SQL retorna 4 filas de registros */

/*
8. Calcular el importe total y la cantidad de reservas realizadas en el mes de marzo
por cada huésped. Mostrar el apellido del huésped, importe total y cantidad de
reservas.
*/

SELECT h.apellido, sum(r.importe) AS importeTotal, COUNT(r.id) AS cantidadReservas FROM reserva r
INNER JOIN huesped h ON h.id = r.huesped_id
WHERE MONTH(fecha) = 3
GROUP BY h.apellido;

/* Esta consulta de SQL retorna 9 filas de registros */

/*
9. Calcular el importe total recaudado por mes (fecha de entrada) para la
habitación número 22. Mostrar el número de habitación, nombre de la
decoración, clase, nombre del mes y el importe total.
*/

SELECT ch.habitacion_numero, de.nombre AS nombreDecoracion, cl.nombre AS nombreClase, MONTHNAME(ch.fecha_entrada) AS mes ,SUM(ch.importe) AS importeTotal FROM checkin ch
INNER JOIN habitacion h ON h.numero = ch.habitacion_numero
INNER JOIN decoracion de ON de.id = h.decoracion_id
INNER JOIN clase cl ON cl.id = h.clase_id
WHERE ch.habitacion_numero  = 22 AND MONTH(ch.fecha_entrada) = '5'
GROUP BY mes;

/* Esta consulta de SQL retorna 1 filas de registros */

/*
10. Determinar la recaudación total por país para las habitaciones número 5, 10 y
22. Mostrar nombre del país, número de habitación y el total recaudado.
*/

SELECT p.nombre, habitacion_numero AS "Número de Habitación", SUM(importe) AS "Total Recaudo" FROM checkin ch
INNER JOIN habitacion hab
ON habitacion_numero = hab.numero
INNER JOIN huesped h
ON huesped_id = h.id
INNER JOIN pais p 
ON pais_id = p.id
WHERE ch.habitacion_numero IN(5,10,22)
GROUP BY p.nombre, ch.habitacion_numero;

/* Esta consulta de SQL retorna 8 filas de registros */

/*
11. Calcular la recaudación total de cada forma de pago para las reservas. Mostrar la
forma de pago y el total.
*/

SELECT fp.nombre as formaPago, sum(r.importe) AS recaudacionTotal FROM reserva r
INNER JOIN forma_pago fp ON r.forma_pago_id = fp.id
GROUP BY fp.nombre;

/* Esta consulta de SQL retorna 4 filas de registros */

/*
12. Listar los empleados del sector 'administración' que su país de origen sea
'Argentina'. Mostrar el número de legajo, apellido, la primera inicial del primer
nombre y un punto, nombre de su país de origen y el nombre del sector.
*/

SELECT 	e.legajo, e.apellido, concat(LEFT(e.nombre,1),".") AS Abreviatura_Nombre, p.nombre AS Pais, s.nombre AS sector
FROM empleado e
INNER JOIN sector s ON e.sector_id = s.id
INNER JOIN pais p ON p.id = e.pais_id
WHERE s.nombre LIKE "%Administracion%" AND p.nombre LIKE "%Argentina%";

/* Esta consulta de SQL retorna 3 filas de registros */

/*
13. Listar todos los servicios básicos que tienen las habitaciones (desde la 20 hasta
la 24) y su clase. Mostrar número de habitación, clase y el nombre de los
servicios básicos. Ordenar por número de habitación y servicio.
*/

SELECT h.numero AS "Numero de habitación", cl.nombre AS "Clase", s.nombre AS "Servicio Básico"
FROM Servicio_basico s
INNER JOIN habitacion_x_servicio_basico hxsb ON s.id = hxsb.servicio_basico_id
INNER JOIN habitacion h ON hxsb.habitacion_numero = h.numero
INNER JOIN  clase cl ON h.clase_id = cl.id
WHERE h.numero IN (20, 21, 22, 23, 24)
ORDER BY h.numero ASC, s.nombre ASC;

/* Esta consulta de SQL retorna 28 filas de registros */

/*
14. Listar las decoraciones que no están aplicadas en ninguna habitación.
*/

SELECT d.nombre FROM decoracion d
LEFT JOIN habitacion h ON d.id = h.decoracion_id
WHERE h.decoracion_id IS NULL;

/* Esta consulta de SQL retorna 2 filas de registros */

/*
15. Listar todos los empleados categorizándolos por edad. Las categorías son:
'junior' (hasta 35 años), 'semi-senior' (entre 36 a 40 años) y 'senior' (más de 40).
Mostrar el apellido, nombre, edad, categoría y ordenar por edad.
*/

SELECT apellido, nombre, TIMESTAMPDIFF(year,fecha_nacimiento, "2022-04-11") AS Edad,
    CASE 
		WHEN  TIMESTAMPDIFF(year,fecha_nacimiento, "2022-04-11") <= 35 THEN "Junior"
		WHEN  TIMESTAMPDIFF(year,fecha_nacimiento, "2022-04-11") BETWEEN 36 AND 40 THEN "Semi-Senior"
		ELSE "Senior"
	END AS "Categoria"
FROM empleado
ORDER BY Edad DESC;

/* Esta consulta de SQL retorna 25 filas de registros */

/*
16. Calcular la cantidad y el promedio de cada forma de pago para los check-in.
Mostrar la forma de pago, cantidad y el promedio formateado con dos
decimales.
*/

SELECT nombre, COUNT(*) AS `Número de pagos`, ROUND(AVG(importe), 2)  AS `Importe promedio` FROM checkin 
JOIN forma_pago ON forma_pago_id = forma_pago.id
GROUP BY nombre;
/* Esta consulta de SQL retorna 4 filas de registros */

/*17. Calcular la edad de los empleados de Argentina. Mostrar el apellido, nombre y la
edad del empleado.
*/

SELECT apellido, empleado.nombre, FLOOR(DATEDIFF(CURDATE(), fecha_nacimiento)/365) AS edad FROM empleado
JOIN pais ON pais_id = pais.id
WHERE pais.nombre = "Argentina";
/* Esta consulta de SQL retorna 17 filas de registros */


/*
18. Calcular el importe total para los check-in realizados por el huésped 'Mercado
Joel'. Mostrar apellido, nombre, importe total y el país de origen.
*/

SELECT huesped.apellido, huesped.nombre, SUM(importe) AS `Importe total`, pais.nombre AS `País de origen` FROM checkin 
JOIN huesped ON huesped_id = huesped.id
JOIN pais ON huesped.pais_id = pais.id
WHERE huesped.nombre = 'Joel'
AND huesped.apellido = 'Mercado';
/* Esta consulta de SQL retorna 1 filas de registros */

/*
19. Listar la forma de pago empleada por cada servicio extra. Se debe mostrar el
nombre del servicio extra, nombre de la forma de pago y calcular la cantidad y
total recaudado.
*/

SELECT servicio_extra.nombre AS "Servicio extra", forma_pago.nombre AS "Forma de pago", COUNT(*) AS "Cantidad", SUM(importe) AS "Total importe" 
FROM reserva 
JOIN servicio_extra ON servicio_extra_id = servicio_extra.id
JOIN forma_pago ON forma_pago_id = forma_pago.id
GROUP BY servicio_extra.nombre;
/* Esta consulta de SQL retorna 4 filas de registros */

/*
20. Listar la forma de pago empleada para el servicio extra 'Sauna' y los huéspedes
correspondientes. Se debe mostrar el nombre del servicio extra, nombre de la
forma de pago, número del cliente e importe total.
*/

SELECT servicio_extra.nombre AS "Servicio extra", forma_pago.nombre AS "Forma de pago", huesped.nombre, SUM(importe) AS "Total importe" 
FROM reserva 
JOIN servicio_extra ON servicio_extra_id = servicio_extra.id
JOIN forma_pago ON forma_pago_id = forma_pago.id
JOIN huesped ON reserva.huesped_id = huesped.id
GROUP BY huesped.nombre
HAVING servicio_extra.nombre = "Sauna";

/* Esta consulta de SQL retorna  8 filas de registros */