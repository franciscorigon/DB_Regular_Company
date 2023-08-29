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

create table dept_locations(
	Dnumber int not null,
    Dlocation varchar(15) not null,
    constraint pk_dept_locations primary key (Dnumber, Dlocation),
    constraint fk_dept_location foreign key (Dnumber) references department (Dnumber)
);

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