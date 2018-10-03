/*Actividad Nro01*/
SELECT last_name, job_id, salary AS Sal FROM employees; 
go
SELECT * FROM jobs;
go
SELECT employee_id, last_name, salary*12 'ANNUAL SALARY' FROM employees; 
go
/*Actividad Nro02*/
go
SP_HELP departments;
go
SELECT emp.employee_id,
emp.last_name,
emp.job_id,
emp.hire_date AS StartDate
FROM employees AS emp;
go
SELECT DISTINCT job_id FROM employees;
go
/*Actividad Nro03*/
go
SELECT emp.employee_id AS 'Emp N',
emp.last_name AS employee,
emp.job_id AS jobs,
emp.hire_date AS 'Fecha de contratación'
FROM employees AS emp;
go
SELECT CONCAT(emp.last_name,',',emp.job_id) AS 'Empleado y Puesto'
FROM employees AS emp;
go
SELECT CONCAT(emp.employee_id,',',
emp.first_name,',',
emp.last_name,',',
emp.email,',',
emp.phone_number,',',
emp.hire_date,',',
emp.job_id,',',
emp.salary,',',
emp.commission_pct,',',
emp.manager_id,',',
emp.department_id) AS 'Los empleados'
FROM employees AS emp;
go
/*Actividad Nro04*/
go
select last_name,salary from employees where salary > 12000;
go
select last_name,department_id from employees where employee_id > 176;
go
select last_name,job_id,salary as Sal from employees where salary > 5000 and salary < 12000;
go
select last_name,job_id,hire_date from employees where 
last_name = 'Matos' or last_name = 'Taylor' order by hire_date asc;
go
select last_name,department_id from employees where 
department_id = 20 or department_id = 50 order by last_name asc;
go
select last_name 'Empleado', salary 'Salario Mensual' from employees where 
salary > 5000 and salary < 12000 and (department_id = 20 or department_id = 50);
go
select last_name,hire_date from employees where hire_date between '19940101' and '19941231';
go
select last_name,job_id from employees where manager_id is null;
go
select last_name,salary,commission_pct from employees order by salary desc,commission_pct desc;
go
declare @salario as decimal(9,2); set @salario = 12000; select last_name, salary from employees where salary > @salario;
go
declare @gerente as int;
set @gerente = 103;
select employee_id,last_name,salary,department_id from employees where manager_id = @gerente order by last_name;
set @gerente = 201;
select employee_id,last_name,salary,department_id from employees where manager_id = @gerente order by salary;
set @gerente = 124;
select employee_id,last_name,salary,department_id from employees where manager_id = @gerente order by employee_id;
go
select last_name from employees where SUBSTRING(last_name,3,1) = 'a';
go
select last_name from employees where SUBSTRING(last_name,3,1) = 'a' or SUBSTRING(last_name,3,1) = 'e';
go
select last_name,job_id,salary from employees where 
(job_id = 'SA_REP' or job_id = 'ST_CLERK') and (salary = 2500 or salary = 3500 or salary = 7000);
go
select last_name 'Empleado', salary 'Salario Mensual', commission_pct from employees where 
salary > 5000 and salary < 12000 and (department_id = 20 or department_id = 50) and commission_pct = 0.20;
go
/*Actividad Nro05*/
go
SELECT CONVERT (date, SYSDATETIME())
,CONVERT (date, SYSDATETIMEOFFSET())
,CONVERT (date, SYSUTCDATETIME())
,CONVERT (date, CURRENT_TIMESTAMP)
,CONVERT (date, GETDATE())
,CONVERT (date, GETUTCDATE());
go
SELECT employee_id, last_name, salary, salary*0.155 as newsalary FROM employees;
go
SELECT employee_id,last_name,salary,salary*0.155 as newsalary,salary-(salary*0.155) as incremento FROM employees
go
select UPPER(last_name) 'Apellido', (LOWER(first_name)) 'Longitud' from employees
where last_name like 'A%'
or last_name like 'J%'
or last_name like 'M%' order by last_name asc;
go
/*Nueva Funcion Extra*/
GO
  -- Drop la función si existe
  IF OBJECT_ID('dbo.InitCap') IS NOT NULL
	DROP FUNCTION dbo.InitCap;
  GO
 
 -- Implementando la función de Oracle INITCAP en SQL Server
 CREATE FUNCTION dbo.InitCap (@inStr VARCHAR(8000))
  RETURNS VARCHAR(8000)
  AS
  BEGIN
    DECLARE @outStr VARCHAR(8000) = LOWER(@inStr),
		 @char CHAR(1),	
		 @alphanum BIT = 0,
		 @len INT = LEN(@inStr),
                 @pos INT = 1;		  
    -- Iterar entre todos los caracteres en la cadena de entrada
    WHILE @pos <= @len BEGIN
      -- Obtener el siguiente caracter
      SET @char = SUBSTRING(@inStr, @pos, 1);
      -- Si la posición del caracter es la 1ª, o el caracter previo no es alfanumérico
      -- convierte el caracter actual a mayúscula
      IF @pos = 1 OR @alphanum = 0
        SET @outStr = STUFF(@outStr, @pos, 1, UPPER(@char));
      SET @pos = @pos + 1;
      -- Define si el caracter actual es  non-alfanumérico
      IF ASCII(@char) <= 47 OR (ASCII(@char) BETWEEN 58 AND 64) OR
	  (ASCII(@char) BETWEEN 91 AND 96) OR (ASCII(@char) BETWEEN 123 AND 126)
	  SET @alphanum = 0;
      ELSE
	  SET @alphanum = 1; 
    END
   RETURN @outStr;		   
  END
 GO
select dbo.InitCap(FIRST_NAME) as
 'name', len(first_name) as
 'Length' from employees where
 upper(SUBSTRING(first_name, 1, 1)) = upper('&Inicial') 
 order by first_name;
 go
/*Nueva Funcion extra*/ 
GO
CREATE FUNCTION MONTHS_BETWEEN (@date1 DATETIME, @date2 DATETIME) 
RETURNS FLOAT AS
   BEGIN
     DECLARE @months FLOAT = DATEDIFF(month, @date2, @date1);
     -- Both dates does not point to the same day of month
     IF DAY(@date1) <> DAY(@date2) AND
        -- Both dates does not point to the last day of month
        (MONTH(@date1) = MONTH(@date1 + 1) OR MONTH(@date2) = MONTH(@date2 + 1))
     BEGIN
        -- Correct to include full months only and calculate fraction
        IF DAY(@date1) < DAY(@date2)
          SET @months = @months + CONVERT(FLOAT, 31 - DAY(@date2) + DAY(@date1)) / 31 - 1;
        ELSE    
          SET @months = @months + CONVERT(FLOAT, DAY(@date1) - DAY(@date2)) / 31;
      	END
     RETURN @months; 
   END;
GO
go
SELECT last_name, ROUND(dbo.MONTHS_BETWEEN(SYSDATETIME(), HIRE_DATE),0) 'MONTHS_WORK'
from employees order by dbo.MONTHS_BETWEEN(HIRE_DATE, SYSDATETIME());
go
/*Funcion extra*/
CREATE FUNCTION LPAD
(
@string VARCHAR(MAX),
@length INT,
@pad CHAR
)
RETURNS VARCHAR(MAX)
AS
BEGIN
RETURN REPLICATE(@pad, @length - LEN(@string)) + @string;
END
GO
SELECT dbo.LPAD(salary, 15, '$') VALUE
FROM employees;
go
/**/
GO

CREATE FUNCTION dbo.trunc (@input datetime)
	RETURNS datetime
AS 
BEGIN
	DECLARE @fecha datetime,
		@fechastring varchar(10)
	SET @fechastring = CONVERT(varchar(10),@input, 103)
	SET @fecha = CONVERT(datetime, @fechastring, 103)
	RETURN @fecha 
END
GO
select last_name, dbo.trunc((((CONVERT (date, SYSDATETIME())  - hire_date)/7),0) as TENURE from employees where 
department_id=90 ORDER BY hire_date DESC;

go



