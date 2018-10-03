/*
Plantilla de script posterior a la implementación							
--------------------------------------------------------------------------------------
 Este archivo contiene instrucciones de SQL que se anexarán al script de compilación.		
 Use la sintaxis de SQLCMD para incluir un archivo en el script posterior a la implementación.			
 Ejemplo:      :r .\miArchivo.sql								
 Use la sintaxis de SQLCMD para hacer referencia a una variable en el script posterior a la implementación.		
 Ejemplo:      :setvar TableName miTabla							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/

USE Human_ResourcesDB;

/*

ACTIVIDAD 9 - SUBCONSULTAS

EJERCICIO 1

El departamento de Recursos Humanos requiere una consulta que pregunte al usuario por el Apellido
del empleado, Luego la consulta deberá mostrar los Apellidos y Fecha de Contratación de todos los
empleados del mismo departamento excluyendo o con excepción del empleado el cual ha sido
proporcionado su apellido reporte que muestre las direcciones de todos los departamentos.
*/

--para el desarrollo se cambio apellido por id de empleado

DECLARE @depid INT;
DECLARE @empid INT;

--leyendo id de empleado
SET @empid = 110

--obteniendo id de departamento de empleado
SET @depid = (SELECT emp.department_id
			FROM employees as emp
			WHERE emp.employee_id=@empid);

--todos los empleados del mismo departamento excluyendo al empleado ingresado anteriormente
SELECT emp.employee_id,
		emp.last_name,
		emp.hire_date,
		emp.department_id
FROM employees AS emp 
WHERE emp.department_id = @depid 
AND emp.employee_id != @empid;




/*
EJERCICIO 2

Crear un reporte que muestre el N° del Empleado, Apellidos y Salarios de todos los empleados que
tienen un salario superior al promedio de salarios de todos los empleados. Ordenar los resultados por
el Salario de forma ascendente.*/


--Se considera "N° de empleado" como "id de empleado"
--Obteniendo promedio de salario

DECLARE @prom DECIMAL (8,2); -- Variable de promedio
SET @prom = (SELECT AVG(salary) FROM employees);


--Todos los empleados con sueldo superior al promedio
SELECT emp.employee_id,
		emp.last_name,
		emp.salary
		FROM employees AS emp
WHERE emp.salary > @prom;



/*
EJERCICIO 3

Realizar un reporte que muestre el N° de Empleado y Apellidos de todos los empleados quienes trabajan en el departamento de cualquier 
empleado que su apellido contenga la letra ‘u’
*/

--Se considera "N° de empleado" como "id de empleado"
--Obtener los id de departamentos de los empleados que contengan "u" en su apellido
SELECT DISTINCT department_id
FROM employees
WHERE last_name LIKE '%u%'


--Obtener todos los empleados que laboren en alguno de los departamentos hallados anteriormente
SELECT emp.employee_id,
		emp.last_name,
		emp.department_id
		FROM employees AS emp
JOIN (SELECT DISTINCT department_id
		FROM employees
		WHERE last_name LIKE '%u%') AS depid
		ON emp.department_id=depid.department_id



/*
EJERCICIO 4

El departamento de Recursos Humanos requiere un reporte que muestre los Apellidos, N° de
Departamento y Puestos de los empleados cuya locación de departamento es 1700.
*/


SELECT emp.last_name,
		emp.department_id,
		dep.location_id
		FROM employees as emp
JOIN departments as dep
	ON emp.department_id=dep.department_id
	WHERE dep.location_id=1700;


/*
EJERCICIO 5

Modificar la consulta anterior de forma que el usuario pueda introducir el N° de locación*/


DECLARE @locid INT;
SET @locid = 1700;
SELECT emp.last_name,
		emp.department_id,
		dep.location_id
		FROM employees as emp
JOIN departments as dep
		ON emp.department_id=dep.department_id
		WHERE dep.location_id=@locid;


/*
EJERCICIO 6

Crear un reporte para el departamento de Recursos Humanos que muestre los Apellidos y Salarios de 
todos los empleados cuyo Administrador apellide ‘King’.*/

--conseguir id de empleado que lleven como apellido KING
SELECT employee_id,
		last_name
		FROM employees
		WHERE last_name='KING';

--conseguir id de departamentos que coincidan con el manager_id con employee_id

SELECT dep.department_id
			FROM departments AS dep
JOIN (SELECT employee_id,
			last_name
			FROM employees
			WHERE last_name='KING') as manking
ON dep.manager_id=manking.employee_id

--Obtener los apellidos y salarios de empleados que tengan como id de departamneto el/los id de departamento hallados anteriormente
SELECT emp.last_name,
		emp.salary
		FROM employees AS emp
JOIN (SELECT dep.department_id
		FROM departments AS dep
JOIN (SELECT employee_id,
		last_name
		FROM employees
		WHERE last_name='KING') AS manking
	ON dep.manager_id = manking.employee_id) AS depking
ON emp.department_id=depking.department_id;

/*
EJERCICIO 7

Crear un reporte para el departamento de Recursos Humanos que muestre el N° de Departamento, Apellidos, Puestos de todos los empleados en el departamento ‘Executive’.*/

SELECT * from employees where department_id=90;
SELECT * from jobs;
SELECT * from departments where department_name='executive';

--consiguiendo empleados con nombre de puesto
SELECT emp.department_id,
	emp.last_name,
	jobs.job_title
	FROM employees AS emp
JOIN jobs
ON emp.job_id=jobs.job_id;

--Conseguir a los empleado con departamento Executive
SELECT empnomjob.department_id,
	empnomjob.last_name,
	empnomjob.job_title
	FROM departments
JOIN (SELECT emp.department_id,
	emp.last_name,
	jobs.job_title
	FROM employees AS emp
JOIN jobs
	ON emp.job_id=jobs.job_id) AS empnomjob
	ON empnomjob.department_id=departments.department_id
WHERE department_name='executive';