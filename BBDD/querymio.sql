SELECT count(*) as "Total Clientes"
FROM clientes;

SELECT Ciudad, count(ClienteID) 
FROM clientes
group by Ciudad;

SELECT SUM(Transporte) as "Total Transporte"
FROM facturas;


SELECT EnvioVia as "Empresa Envio" , SUM(Transporte) as "Total Transporte" 
FROM facturas
group by EnvioVia;

SELECT count(FacturaID), ClienteID
FROM facturas
group by ClienteID order by count(FacturaID) desc;

SELECT count(PaisEnvio) as "Cantidad Envios" , PaisEnvio
FROM facturas
group by PaisEnvio order by count(PaisEnvio) limit 1;

SELECT count(FacturaID) as "Total de Facturas" , ClienteID
FROM facturas
group by ClienteID order by count(FacturaID) desc limit 5;

SELECT sum(empleadoID) as "Numero de empleado" 

