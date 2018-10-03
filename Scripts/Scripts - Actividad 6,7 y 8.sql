--ACTIVIDAD 6

select 'Sueldos Son~ados'=(last_name + 'gana' + Cast(salary as varchar(18)) + 'pero quisiera' + Cast((salary * 3) as varchar(18)))
from dbo.employees
go

select last_name, hire_date as Revision from employees
where hire_date between '2003-06-17' and '2005-09-21';
go

select e.last_name, e.hire_date, DateName(WEEKDAY, jh.START_DATE)as 'Dia'
from employees as e inner join job_history as jh on
e.employee_id=jh.employee_id
go


select last_name as 'Apellidos', 'Comision'='Sin Comision' from dbo.employees where 
commission_pct != 0 UNION select last_name as 'Apellidos', 'Comision'= Cast((salary * commission_pct) 
as varchar(20)) from dbo.employees where commission_pct >0



select e.last_name as 'Apellidos', j.job_title, case when j.job_id = 'AD PRES' THEN 'A' 
when j.job_id = 'ST_MAN' THEN 'B' when j.job_id = 'IT_PROG' THEN 'C' when j.job_id = 'SA REP' 
THEN 'D' else '0' END as 'Grados' from dbo.employees as e inner join dbo.jobs 
as j on e.job_id=j.job_id 


--ACTIVIDAD 7


 select round (max(salary),0) as "Maximo", round (min(salary),0) as
 "Minimo", round(sum(salary),0)as "Sumatoria",round (avg(salary),0)as "Promedio" from employees;



select count (*) from employees group by job_id;



select count (distinct manager_id) as "Numero de Administradores" from employees;



select (max(salary)-min(salary)) as "Diferencia" from employees;



select salman.minimo, salman.manager_id from(select min(salary)as 'Minimo',manager_id from employees
where salary>6000 group by manager_id) as salman order by salman.minimo;




