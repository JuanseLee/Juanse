-- 1. Listar las canciones que poseen la letra Z en su título.
select * from cancion where titulo like '%z%';

-- 2. Listar las canciones que poseen como segundo caracter la letra ‘a’ y como último, la letra ‘s’.
select * from cancion where titulo like '_a%s';

-- 3. Mostrar la playlist que tiene más canciones, renombrando las columnas poniendo mayúsculas en la primera letra, los tildes correspondientes y agregar los espacios entre palabras.
select idCancion AS 'ID Canción', titulo AS 'Título', duracion AS 'Duración', cantreproduccion AS 'Cantidad de Reproducciones', cantlikes AS 'Cantidad de Likes', idAlbum AS 'ID Álbum' from playlist order by cantcanciones desc limit 1;

-- 4. Listar los 10 usuarios más jóvenes, salteando los primeros 5 resultados.
Select * from usuario order by fecha_nac desc limit 10 offset 5;

-- 5. Listar las 5 canciones con más reproducciones, ordenadas descendentemente.
select titulo, cantreproduccion from cancion order by cantreproduccion desc limit 5;

-- 6. Generar un reporte de todos los albumes ordenados alfabéticamente.
select titulo from album order by titulo asc;

-- 7. Listar a todos los albumes que no tengan imagen, ordenados alfabéticamente.
SELECT titulo, imagen FROM album where imagen is null order by titulo asc;

-- 8. Insertar un usuario nuevo, con los siguientes datos, tener en cuenta las relaciones.
insert into usuario (idUsuario, nombreusuario, nyap, fecha_nac, sexo, CP, password, Pais_idPais) 
values ('20','nuevousuariodespotify@gmail.com','Elmer Gomez','1991/11/15','M','B4129ATF','S4321m','2');

-- 9. Eliminar todas las canciones de género "pop".
delete from generoxcancion where IdGenero = 9;

-- 10. Editar todos los artistas que no tengan una imagen cargada y cargamos el texto de ‘Imagen faltante’ en la columna de imagen.
update artista
set imagen = 'Imagen faltante'
where imagen is null

-- 9. Listar las 5 canciones de mayor duración
--select titulo as cancion, duracion from cancion order by duracion desc limit 5;