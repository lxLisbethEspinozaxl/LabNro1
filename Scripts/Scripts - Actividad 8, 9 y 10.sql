/*


LAB N1:ACTIVIDAD 8 - EJERCICIO 7 


*/

USE Human_Resources;


-----------------------------------------Scripts de Consultas-------------------------------------------

--LABORATORIO 1

--------------------------------------------------------------------------------------------------------


/*ACTIVIDAD 8 - ENLACES

EJERCICIO 7

El departamento de Recursos Humanos requiere un reporte de todo el personal que fue contratado
despu´es del empleado apellidado ‘Davies’. Crear un reporte que muestre el apellidos y
fecha de contrataci´on de todo los empleados contratado despu´es de ‘Davies’.*/


SELECT e.first_name, e.last_name, e.hire_date
FROM employees e
JOIN employees davies
ON (davies.last_name = 'Davies')
WHERE davies.hire_date < e.hire_date;



/*
EJERCICIO 8

El departamento de Recursos Humanos requiere de un reporte que el apellido del empleado, fecha de
contratación del empleado, apellido del administrador, fecha de contratación del administrador. Para
todos aquellos empleados que fueron contratados antes que sus Administradores.*/

SELECT e.last_name 'EMPLEADO', e.hire_date 'FECHA CONTRATACION' , j.last_name 'ADMINISTRADOR',
j.hire_date 'FECHA CONTRATACION ADMINISTRADOR'
from employees e
join employees j
on e.manager_id=j.employee_id
and e.hire_date < j.hire_date
order by e.hire_date;


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


/*
EJERCICIO 8

Modificar la consulta del ítem 4.3 para que adicionalmente se muestro solo a los empleados que tengan
un salario mayor al promedio de todos los salarios de los empleados.*/











/*ACTIVIDAD 10 - CONJUNTOS

EJERCICIO 1

El departamento de Recursos Humanos requiere un reporte de todos los departamentos que no
contengan un empleado con el puesto ‘ST_CLERK’. Utilizar el operador MINUS para esta solicitud.
*/


select department_id from employees
where job_id = 'ST CLERK';



/*
EJERCICIO 2

El departamento de Recursos Humanos requiere adicionalmente una lista de todos los países que no
tengan un departamento de la empresa localizado en ellos, mostrar el código del país y el nombre.
Utilizar el operador MINUS para realizar esta operación.*/


select country_id, country_name from countries
minus



/*
EJERCICIO 3

 Se necesita una lista de puestos de los departamentos 10, 50 y 20, en ese orden, mostrar el código del
puesto y código del departamento. Utilizar el operador UNION ALL*/


select distinct job_id, department_id from employees
where (department_id=10)
union
select distinct job_id, department_id from employees
where (department_id=50)
union
select distinct job_id, department_id from employees
where (department_id=20);



/*
EJERCICIO 4

Crear un reporte que muestre que liste los códigos de los empleados y los puestos de todos aquellos
empleados que tienen el mismo puesto que en el momento en el que fueron contratados por la empresa,
cambiaron de puestos y luego volvieron al puesto anterior. Utilizar el operador INTERSECT.*/



select employee_id, job_id from employees
intersect
select distinct employee_id, job_id from job_history;



/*
EJERCICIO 5

El departamento de Recursos Humanos requiere un reporte que muestre lo siguiente:

 Apellidos y códigos de departamentos de todos los registros de la tabla empleados sin importar si
pertenecen a uno o ningún departamento.
 Código de departamentos y nombres de departamentos de la tabla DEPATAMENTOS inclusive si
no existiese ningún empleado en ese departamento

Ambos requerimientos se deben mostrar en un mismo resultado. Utilizar el operador UNION ALL.*/

select last_name, department_id, null from employees union select null, department_id, department_name from departments;

