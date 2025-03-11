create table Students (
  zid  integer, -- unique, not null
  name text,
  primary key (zid)
);

create table Courses (
  code  char(8), -- e.g. 'COMP3311'
  term  char(4), -- e.g. '25T1'
  title text not null,
  uoc   integer check (uoc > 0),
  offerer integer,
  primary key (code,term),
  foreign key (offerer)
    references Schools(id)
); 

create table Schools (
  id    integer,
  name  text, -- e.g. 'CSE'
  web   text,
  primary key (id)
);

"Enrols" != Enrols == enrols

create table Enrols (
  student integer,
  c_code  char(8),
  c_term  char(4),
  primary key (student,c_code,c_term),
  foreign key (student)
    references Students(zid),
  foreign key (c_code,c_term)
    references Courses(code,term)
);


