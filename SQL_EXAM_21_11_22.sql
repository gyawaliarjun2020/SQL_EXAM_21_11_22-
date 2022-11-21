create table Physician (employee_id int(20) Primary Key Not null, 
name varchar(50), position varchar(50));

insert into Physician values (1, 'John Dorian', 'Staff Internist'),
(2, 'Elliot Reid ', 'Attending Physician'),
(3, 'Christopher Turk', 'Surgical Attending Physician'),
(4, 'Percival Cox', 'Senior Attending Physician'),
(5, 'Bob Kelso', 'Head Chief of Medicine'),
(6, 'Todd Quinlan', 'Surgical Attending Physician'),
(7, 'John Wen', 'Surgical Attending Physician'),
(8, 'Keith Dudemeister', 'MD Resident'),
(9, 'Molly Clock', 'Attending Psychiatrist');

create table Department ( department_id int (20) Primary key not null, 
name varchar(50), head int (20), foreign key (head) references physician (employee_id));

insert into Department values
 (1, 'General Medicine', 4),
(2, 'Surgery', 7),
(3, 'Psychiatry', 9);

  Create table Affiliated_with( physician int,foreign key(physician) 
  references physician(employee_id), department int ,foreign key(department) 
  references department(department_id),primaryaffiliation varchar(10) );

insert into Affiliated_with(physician,department,primaryaffiliation) values
(1, 1 ,'t'),
(2 ,1 ,'t'),
(3, 1, 'f'),
(3, 2 ,'t'),
(4 ,1, 't'),
(5 ,1 ,'t'),
(6 ,2 ,'t'),
(7 ,1 ,'t'),
(7, 2, 't'),
(8 ,1 ,'t'),
(9 ,3 ,'t');

create table patient(patient_id int(30) primary key, name varchar(30), address varchar(30),
 phone int(30), insurance_id int(20), physician_id int,foreign key(physician_id) 
 references Physician(employee_id));

insert into patient(patient_id , name, address, phone ,insurance_id ,physician_id ) values
(100000001, 'John Smith',  '42 Foobar Lane' ,555-0256 ,68476213 ,1),
(100000002, 'Grace Ritchie' ,'37 Snafu Drive' ,555-0512 ,36546321 ,2),
(100000003, 'Random J. Patient' ,'101 Omgbbq Street' ,555-1204 ,65465421 ,2),
(100000004 ,'Dennis Doe' ,'1100 Foobaz Avenue' ,555-2048 ,68421879 ,3);

Create table Appointment(appointment_id int(30) primary key, 
patient int ,foreign key (patient_id) references Patient(patient_id),
start_date_time  Date, end_date_time Date);


insert into appointment values 
(13216584,100000001,1,'2008-04-24 10:00','2008-04-24 11:00'),
(26548913,100000002,2,'2008-04-24 10:00','2008-04-24 11:00'),
(36549879,100000001,1,'2008-04-25 10:00','2008-04-25 11:00'),
(46846589,100000004,4,'2008-04-25 10:00','2008-04-25 11:00'),
(59871321,100000004,null,'2008-04-26 10:00','2008-04-26 11:00'),
(69879231,100000003,2,'2008-04-26 11:00','2008-04-26 12:00'),
(76983231,100000001,3,'2008-04-26 12:00','2008-04-26 13:00'),
(86213939,100000004,9,'2008-04-27 10:00','2008-04-27 11:00'),
(93216548,100000002,2,'2008-04-27 10:00','2008-04-27 11:00');


/* 2 */
SELECT t.name AS "Patient",
       t.address AS "Address",
       p.name AS "Physician"
FROM patient t
JOIN physician p ON t.pcp=p.employeeid;


/* 3 */
SELECT p.name "Patient",
       count(t.patient) "Appointment for No. of Physicians"
FROM appointment t
JOIN patient p ON t.patient=p.ssn
GROUP BY p.name
HAVING count(t.patient)>=1;

/* 4 */
SELECT t.name AS "Name of the patient",
       p.name AS "Name of the physician",
       a.start_dt_time
FROM patient t
JOIN appointment a ON a.patient=t.ssn
JOIN physician p ON a.physician=p.employeeid
WHERE start_dt_time='2008-04-25 10:00:00';


/* 5 */


/* 6 */
SELECT pt.name AS "Patient",
       p.name AS "Primary care Physician"
FROM patient pt
JOIN physician p ON pt.pcp=p.employeeid
WHERE pt.pcp NOT IN
    (SELECT head
     FROM department);


/* 7 */
SELECT d.name AS "Department",
       p.name AS "Physician"
FROM department d,
     physician p
WHERE d.head=p.employeeid;

/* 8 */
SELECT count(DISTINCT patient) AS "No. of patients taken at least one appointment"
FROM appointment;

/* 9 */
SELECT p.name AS "Physician",
       d.name AS "Department"
FROM physician p,
     department d,
     affiliated_with a
WHERE p.employeeid=a.physician
  AND a.department=d.departmentid;

/* 10 */
SELECT p.name AS "Physician",
       p.position,
       d.name AS "Department"
FROM physician p
JOIN affiliated_with a ON a.physician=p.employeeid
JOIN department d ON a.department=d.departmentid
WHERE primar