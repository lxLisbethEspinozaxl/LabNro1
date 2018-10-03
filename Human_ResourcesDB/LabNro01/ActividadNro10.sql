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