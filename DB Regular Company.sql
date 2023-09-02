create schema if not exists company;
use company;

-- restrição atribuída a um domínio
-- create domain D_num as int check(Dnum > 0 and D_num < 21);


create table employee(
	Fname varchar (15) not null,
	Minit char,
	Lname varchar (15) not null,
	Ssn char(9) not null,
	Bdate date,
	Address varchar(90),
	Sex char,
	Salary decimal(10,2),
	Super_ssn char(9),
	Dno int not null,
    constraint chk_salary_employee check (Salary > 2000.0),
    constraint pk_employee primary key (Ssn)
);

alter table employee
	add constraint fk_employee
    foreign key (Super_ssn) references employee (Ssn)
    on delete set null
    on update cascade; -- atualiza as entidades relacionadas


desc employee;

create table department(
	Dname varchar(15) not null,
    Dnumber int not null,
    Mgr_ssn char(9),
    Mgr_start_date date,
    Dept_create_date date,
    constraint chk_date_dept check (Dept_create_date <= Mgr_start_date),
    constraint pk_dpt primary key(Dnumber),
    constraint unique_name_dept unique(Dname),
    foreign key (Mgr_ssn) references employee(Ssn)
);

-- 'def', 'company_constraints', 'department_ibfk_1', 'company_constraints', 'department', 'FOREIGN KEY', 'YES'
-- modificar uma constrain: drop and add
alter table department drop constraint department_ibfk_1;
alter table department 
		add constraint fk_dept foreign key (Mgr_ssn) references employee (Ssn)
        on update cascade;

create table dept_locations(
	Dnumber int not null,
    Dlocation varchar(15) not null,
    constraint pk_dept_locations primary key (Dnumber, Dlocation),
    constraint fk_dept_location foreign key (Dnumber) references department (Dnumber)
);

alter table dept_locations drop constraint fk_dept_location;
alter table dept_locations
	add constraint fk_dept_locations foreign key (Dnumber) references department (Dnumber)
    on delete cascade
    on update cascade;

create table project(
	Pname varchar(15) not null,
	Pnumber int not null,
	Plocation varchar(15),
    Dnumber int not null,
    primary key (Pnumber),
    constraint unique_project unique (Pname),
    constraint fk_project foreign key (Dnumber) references Department (Dnumber)
);

create table work_on(
	Essn char(9) not null,
    Pno int not null,
    Hours decimal(3,1) not null,
    primary key (Essn, Pno),
    constraint fk_work_on_employee foreign key (Essn) references employee (Ssn),
    constraint fk_work_on_project foreign key (Pno) references project (Pnumber)
);

create table dependent(
	Essn char(9) not null,
    Dependent_name varchar(15) not null,
    Sex char, -- F ou M
    Bdate date,
    Relationship varchar(8),
    Age int not null,
    constraint chk_age_dependent check (Age < 22),
    primary key (Essn, Dependent_name),
    constraint fk_dependent foreign key (Essn) references employee (Ssn)    
);

show tables;


select * from information_schema.table_constraints
	where constraint_schema = 'company_constraints';

    ------------------------------------------------------------------------------------------

    -- inserção de dados no bd company

use company_constraints;
show tables;

select * from dept_locations;

drop table dependent;

create table dependent(
	Essn char(9) not null,
    Dependent_name varchar(15) not null,
    Sex char, -- F ou M
    Bdate date,
    Relationship varchar(8),
    primary key (Essn, Dependent_name),
    constraint fk_dependent foreign key (Essn) references employee (Ssn)
    );

insert into employee values ('John', 'B', 'Smith', '123456789', '1965-01-09', '731-Fondren-Houston-TX', 'M', 30000, null, 5);

insert into employee values ('Franklin', 'T', 'Wong', 333445555,  '1955-12-08', '638-Voss-Houston-TX', 'M', 40000, 123456789, 5),
							('Alicia', 'J', 'Zelaya', 999887777, '1968-01-19', '3321-Castle-Spring-TX', 'F', 25000, 333445555, 4),
							('Jennifer', 'S', 'Wallace', 987654321, '1941-06-20', '291-Berry-Bellaire-TM', 'F', 43000, null, 4),
							('Raeesh', 'K', 'Narayan', 666884444, '1962-09-15', '975-Fire-Oak-Mumble-TX', 'M', 38000, 987654321, 5),
							('Joyce', 'A', 'English', 455453453, '1972-07-31', '5631-Rice-Houston-TM', 'F', 25000, 987654321, 5),
							('Ahnad', 'V', 'Jabbar', 987987987, '1969-03-29', '980-Dallas-Houston-TX', 'M', 25000, 123456789, 4),
							('James', 'E', 'Borg', 888665555, '1937-11-10', '450-Stone-Houston-TX', 'M', 55000, 333445555, 1);

insert into dependent values (333445555, 'Alice', 'F', '1986-04-05', 'Daughter'),
							(333445555, 'Theodore', 'M', '1983-10-25', 'Son'),
							(333445555, 'Joy', 'F', '1958-05-03', 'Spouse'),
							(987654321, 'Abner', 'M', '1942-02-28', 'Spouse'),
							(123456789, 'Michael', 'M', '1988-01-04', 'Son'),
							(123456789, 'Alice', 'F', '1988-12-30', 'Daughter'),
							(123456789, 'Elizabeth', 'F', '1967-05-05', 'Spouse');
                            
insert into department values ('Research', 5, 333445555, '1988-05-22', '1986-05-22'),
							('Administration', 4, 987654321, '1995-01-01', '1994-01-01'),
                            ('Headquarters', 1, 888665555, '1981-06-19', '1980-06-19');
                            
insert into dept_locations values (1, 'Houston'),
								  (4, 'Stafford'),
                                  (5, 'Bellaire'),
                                  (5, 'Sugarland'),
                                  (5, 'Houston');

insert into project values ('ProductX', 1, 'Belaire', 5),
						   ('ProductY', 2, 'Sugarland', 5),
						   ('ProductZ', 3, 'Houston', 5),
						   ('Computerization', 10, 'Stafford', 4),
						   ('Reorganization', 20, 'Houston', 1),
						   ('Newbenefits', 30, 'Stafford', 4);

insert into work_on values (123456789, 1, 32.5),
						(123456789, 2, 7.5),
						(888665555, 3, 40.0),
						(455453453, 1, 20.0),
						(455453453, 2, 20.0),
						(333445555, 2, 10.0),
						(333445555, 3, 10.0),
						(333445555, 10, 10.0),
						(333445555, 20, 10.0),
						(999887777, 30, 30.0),
						(999887777, 10, 10.0),
						(987987987, 10, 35.0),
						(987987987, 30, 5.0),
						(987654321, 30, 20.0),
						(987654321, 20, 15.0),
						(888665555, 20, 0.0);


-------------------------------------


select * from employee;

-- gerente e seu departamento
select Ssn, Fname, Dname from employee e, department d where (e.Ssn = d.Mgr_ssn);

-- recuperando dependentes dos empregados
select Fname, Dependent_name, Relationship from employee, dependent where Essn = Ssn;

--
select Fname, Bdate, Address from employee
	where Fname = 'John' and Minit = 'B' and Lname = 'Smith';
    
-- recuperando um departamento específico
select * from department where Dname = 'Research';

--
select Fname, Lname, Address from employee, department
	where Dname = 'Research' and Dnumber = Dno;
    
--
desc work_on;
select Pname, Essn, Fname, Hours from project, work_on, employee 
	where Pnumber = Pno and Essn = Ssn;

---------------------------------------------

select * from department;
select * from dept_locations;

-- Cláusula ambígua: --
-- select * from department, dept_locations
-- 		where Dnumber = Dnumber;

-- Resolução: através do alias ou AS Statement --
select Dname, l.Dlocation as Department_location
		from department as d, dept_locations as l
        where d.Dnumber = l.Dnumber;

select concat(Fname, ' ', Lname) as Employee from employee;

-------------------------------------------------

--
--
-- Expressões e alias
--
--
-- Recolhendo valor do INSS
SELECT Fname, Lname, Salary, ROUND(Salary*0.011,2) AS INSS from employee;
--
--
-- Definir um aumento salarial para os gerentes que trabalham no projeto associado ao ProdutoX
SELECT * 
	FROM employee e, work_on AS w, project as p
    WHERE (e.Ssn = w.Essn and w.Pno = p.Pnumber and p.Pname='ProductX');
    
SELECT CONCAT(Fname, ' ', Lname) AS Complete_name, Salary, round(Salary*1.1,2) as increased_salary
	FROM employee e, work_on AS w, project as p
    WHERE (e.Ssn = w.Essn and w.Pno = p.Pnumber and p.Pname='ProductX');


--
--
-- recuperando todos os gerentes que trabalham em Stafford
SELECT Dname as Department_name, concat(Fname, ' ', Lname) as Manager from department d, dept_locations l, employee e
	WHERE d.Dnumber = l.Dnumber and Dlocation = 'Stafford' and Mgr_ssn = e.Ssn;


-- recuperando todos os gerentes, departamentos e seus nomes
SELECT Dname as Department_name, concat(Fname, ' ', Lname) as Manager, Dlocation from department d, dept_locations l, employee e
	WHERE d.Dnumber = l.Dnumber and Mgr_ssn = e.Ssn;
    
--
--
-- like e between
-- 
--
select * from employee;
	
select Fname as First_name, Lname as Last_name, Address from emplyoee
	where (Address like '%Houston%');
    
select * from department where Dname = 'Research' or Dname = 'Administration';

select * from employee;

-------------------------------------------------

-- union, except, intersect
--
--
create database teste;
use teste;

create table R(
	A char(2)
);
create table S(
	A char(2)
);

insert into R(A) values ('a1'),('a2'),('a2'),('a3');
insert into S(A) values ('a1'),('a1'),('a2'),('a3'),('a4'),('a5');

select * from R;
select * from S;

-- except -> not in
select * from S where A not in (select A from R);

-- union -> 
(select distinct R.A from R)
	UNION
    (select distinct S.A from S);

-- union -> 
(select R.A from R)	UNION (select S.A from S);

-- intersect
select distinct R.A from R where R.A in (select S.A from S);

-------------------------------------------------

    -- cláusulas com exists e unique
    
    
    --
    -- Quais employees possuem dependents?
    --
    SELECT e.Fname, e.Lname FROM employee AS e
		WHERE EXISTS (SELECT * FROM dependent as d
					  WHERE e.Ssn = d.Essn AND Relationship = 'Son');
                      
	-- sem dependentes?
    SELECT e.Fname, e.Lname FROM employee AS e
		WHERE NOT EXISTS (SELECT * FROM dependent as d
					  WHERE e.Ssn = d.Essn);

	-- 
	SELECT e.Fname, e.Lname FROM employee AS e, department d
		WHERE (e.Ssn = d.Mgr_ssn) AND EXISTS (SELECT * FROM dependent AS d WHERE e.Ssn = d.Essn);
        
	-- dois ou mais dependentes?
    SELECT Fname, Lname FROM employee
		WHERE(SELECT COUNT(*) FROM dependent WHERE Ssn = Essn) >= 2;
        
	-- qual projeto o funcionário trabalha?
	SELECT DISTINCT Essn, Pno FROM work_on WHERE Pno IN (1,2,3);

-------------------------------------------------

	-- ORDENAÇÃO
    --
    --
	
    -- nome do departamento e gerente em ordem alfabetica 
    SELECT distinct d.Dname, Fname, Lname
		from department as d, employee e, work_on w, project p
		where (d.Dnumber = e.Dno AND e.Ssn = d.Mgr_ssn AND w.Pno = p.Pnumber)
        order by e.Fname;
        
	-- recuperar todos empregados e seus projeos em andamento
    SELECT DISTINCT d.Dname, e.Fname, e.Lname, p.Pname as Project_Name
		FROM department as d, employee e, work_on w, project p
        WHERE (d.Dnumber = e.Dno and eSsn = w.Essn and w.Pno = p.Pnumber)
        ORDER BY d.Dname desc, e.Fname asc, e.Lname asc;

		-------------------------------------------------

		-- funções e cláusulas de agrupamento
--
--

-- 
select count(*) as counter from employee, department
	where Dno = Dnumber and Dname = 'Research';
    
select count(*) as counter, round(avg(Salary), 2) from employee
	group by Dno;

select count(*) as Number_of_employees, round(avg(Salary), 2) as Salary_avg from employee
	group by Dno;
    
    SELECT Pnumber, Pname, count(*) as Employees
		FROM project, work_on
        WHERE Pnumber = PNO
        GROUP BY Pnumber, Pname;
        
SELECT COUNT(DISTINCT Salary) from employee;

SELECT sum(Salary) as total_salry, max(Salary) as Max_salary, min(Salary) as min_salry, round(avg(Salary),2) as AVG_slary from employee;

-------------------------------------------------

