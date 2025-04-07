-- COMP3311 Prac 03 Exercise
-- Schema for simple company database

create table Employees (
	tfn         char(11) PRIMARY KEY,
	givenName   varchar(30) NOT NULL,
	familyName  varchar(30) NOT NULL,
	hoursPweek  float,
	CHECK (hoursPweek >= 0 AND hoursPweek <= 168),
	CHECK (tfn SIMILAR TO '\d{3}-\d{3}-\d{3}'),
	CHECK (LENGTH(givenName) <= 30)

);

create table Departments (
	id          char(3) PRIMARY KEY,
	name        varchar(100),
	manager     char(11) REFERENCES Employees (id),
	CHECK (id SIMILAR TO '\d{3}')

);

create table DeptMissions (
	department  char(3) REFERENCES Departments (id),
	keyword     varchar(20)
);

create table WorksFor (
	employee    char(11) REFERENCES Employees (tfn),
	department  char(3) REFERENCES Departments (id),
	percentage  float,
	CHECK (percentage > 0)
);
