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
go
select 'Sueldos Soñados'=(last_name + 'gana' + Cast(salary as varchar(18)) + 'pero quisiera' + Cast((salary * 3) as varchar(18)))
from employees
go
select last_name, hire_date as Revision from employees
where hire_date between '2003-06-17' and '2005-09-21';
go
select e.last_name, e.hire_date, DateName(WEEKDAY, jh.START_DATE)as 'Dia'
from employees as e inner join job_history as jh on
e.employee_id=jh.employee_id
go