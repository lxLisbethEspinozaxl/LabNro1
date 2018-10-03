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