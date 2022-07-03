USE adventureworks2019;

SELECT LastName AS Apellido from person 
WHERE LastName LIKE "%s%";

SELECT CONCAT(FirstName," ", LastName) AS Nombre from person
where LastName LIKE "%ez";


SELECT Name from product
WHERE Name LIKE int


