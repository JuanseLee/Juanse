SELECT artista.id, nombre, apellido 
FROM artista
INNER JOIN artista_x_pelicula
ON artista.id = artista_x_pelicula.artista_id
group by artista.nombre; 

