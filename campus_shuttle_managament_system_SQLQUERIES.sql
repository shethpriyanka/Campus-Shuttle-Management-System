-- DOWN SCRIPT 

-- Dropping foreign key constraints for student id from feedback table if exists
If exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME = 'fk_rating_student_id') 
    ALTER TABLE ratings drop constraint fk_rating_student_id

DROP TABLE if exists ratings

-- -- Dropping foreign key contraints for student id and employee id  from booking table
If exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME = 'fk_booking_employee_id') 
    ALTER TABLE bookings drop constraint fk_booking_employee_id

If exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME = 'fk_booking_student_id') 
    ALTER TABLE bookings drop constraint fk_booking_student_id

DROP TABLE if EXISTS bookings

-- Dropping foreign key constraints for employee id and vehicle id from students table
If exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME = 'fk_student_employee_id') 
    ALTER TABLE students drop constraint fk_student_employee_id

If exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME = 'fk_student_vehicle_id') 
    ALTER TABLE students drop constraint fk_student_vehicle_id

DROP TABLE if exists students

--  Dropping foreign key constraints for vehicle id from employees table if exists 
If exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME = 'fk_employee_vehicle_id') 
    ALTER TABLE employees drop constraint fk_employee_vehicle_id

DROP TABLE if exists employees

DROP TABLE if exists vehicle

DROP DATABASE if exists sucsms;
GO

-- UP SCRIPT

CREATE DATABASE sucsms     -- creating database for our project called syracuse university campus shuttle management system
GO

-- using the database syracuse university campus shuttle management system sucsms
use sucsms
GO

-- creating table vehicle
CREATE TABLE vehicle(
vehicle_id int identity not null,
vehicle_number varchar(10) not null,
license_number varchar(8) not null,
car_model varchar(100) not null,
CONSTRAINT pk_vehicle_id PRIMARY KEY(vehicle_id)
)

-- creating table employees
CREATE TABLE employees(
employee_id int identity not null,
employee_firstname varchar(50) not null,
employee_lastname varchar(50) not null,
employee_email varchar(50) not null,
employee_contact_number varchar(10) not null,
employee_address varchar(50) not null,
employee_vehicle_id int not null,
constraint pk_employees_employee_id PRIMARY KEY(employee_id),
constraint uk_employees_employee_email UNIQUE (employee_email),
constraint uk_employees_employee_contact UNIQUE (employee_contact_number)
)

-- Altering employees table to add foreign key constraints for vehicle id 
ALTER TABLE employees add CONSTRAINT fk_employee_vehicle_id FOREIGN KEY(employee_vehicle_id) REFERENCES vehicle(vehicle_id)

-- creating table students

CREATE TABLE students (
    student_id int identity not null,
    student_suid char(8) not null,
    student_firstname varchar(50) not null,
    student_lastname varchar(50) not null,
    student_email varchar(50) not null,
    student_phonenumber char(10) not null,
    student_age int not null,
    student_home_address varchar(100) not null,
    student_vehicle_id int not null,
    student_employee_id int not null,
    CONSTRAINT pk_students_student_id primary key (student_id),
    CONSTRAINT u_student_suid unique (student_suid),
    CONSTRAINT u_student_email unique(student_email)
)

-- Altering students table to add foreign key constraints for booking id, employee id and vehicle id 
ALTER TABLE students add CONSTRAINT fk_student_vehicle_id FOREIGN KEY(student_vehicle_id) REFERENCES vehicle(vehicle_id)
ALTER TABLE students add CONSTRAINT fk_student_employee_id FOREIGN KEY(student_employee_id) REFERENCES employees(employee_id)


-- creating table bookings
CREATE TABLE bookings (
    booking_id int identity not null,
    booking_time datetime not null,
    pick_up_location varchar(100) not null,
    drop_off_location varchar(100) not null,
    booking_status varchar(50) not null,
    estimated_arrival_time datetime not null,
    booking_student_id int not null,
    booking_employee_id int not null,
    CONSTRAINT pk_booking_id PRIMARY KEY(booking_id)
)

-- Altering booking table to add foreign key contraints for student id and employee id 
ALTER TABLE bookings add CONSTRAINT fk_booking_student_id FOREIGN KEY(booking_student_id) REFERENCES students(student_id)
ALTER TABLE bookings add CONSTRAINT fk_booking_employee_id FOREIGN KEY(booking_employee_id) REFERENCES employees(employee_id)

-- Creating table ratings 
create table ratings(
rating_id int IDENTITY not null,
rating int not null,
feedback char(100) not null,
rating_student_id int not null,
CONSTRAINT pk_rating_id PRIMARY KEY(rating_id)
)


-- Altering ratings table to add foreign key constraints for student id 
Alter TABLE ratings add CONSTRAINT fk_rating_student_id FOREIGN KEY(rating_student_id) REFERENCES students(student_id)

-- insert into vehicle table
INSERT into vehicle(vehicle_number, license_number, car_model) values ('A1' ,'W12345', 'Toyota Mini Van')
INSERT into vehicle(vehicle_number, license_number, car_model) values ('B1','X09869', 'Kia Mini Van')
INSERT into vehicle(vehicle_number, license_number, car_model) values ('C1', 'Y73718', 'Nissan Mini Van')
INSERT into vehicle(vehicle_number, license_number, car_model) values ('D1' , 'Z34298', 'Toyota Sienna Mini Van')
INSERT into vehicle(vehicle_number, license_number, car_model) values ('E1' , 'U29338', 'Nissan Mini Van')
INSERT into vehicle(vehicle_number, license_number, car_model) values ('F1' , 'R19222', 'Kia Mini Van')
INSERT into vehicle(vehicle_number, license_number, car_model) values ('G1' , 'E23923', 'Ford Mini Van')
INSERT into vehicle(vehicle_number, license_number, car_model) values ('H1' , 'W31011', 'Chevrolet Mini Van')
INSERT into vehicle(vehicle_number, license_number, car_model) values ('I1' , 'X24249', 'Honda Mini Van')

-- insert into employees table
insert into employees(employee_firstname, employee_lastname, employee_email, employee_contact_number, employee_address,employee_vehicle_id) VALUES
('Valtterii', 'Bottas', 'v.bottas@syr.edu', '3151231234', '103 Ackerman Ave',5),
('Lance', 'Stroll', 'l.stroll@syr.edu', '3152233224', '101 Trinity Pl',3),
('Daniel', 'Ricciardo' , 'd.ricciardo@syr.edu', '3159876509', '220 Clarendon St',4),
('Nikita', 'Mazepin', 'n.mazepin@syr.edu', '3156673421', '350 Westcott St',4),
('Connie', 'Roy',     'connieroy@syr.edu', '315821813', '292 Ostrom Ave',2),
('Juliet', 'Huber', 'juliethuber@syr.edu', '315322422', '712 Sunshine Ave',6),
('Nora', 'Taylor', 'norataylor@syr.edu', '315312323', '110 South beach Ave',7),
('Willie', 'Miller', 'williemiller@syr.edu', '315154213', '181 Maryland Ave',8),
('Flora', 'Daniels', 'floradaniels@syr.edu', '315144421', '131 redfield Ave',9),
('Kanie' , 'Garner', 'kaniegarner@syr.edu', '315221343', '113 livingston Ave',3),
('patrick', 'Glover', 'patrickglover@syr.edu', '315332424', '242 Euclid Ave',4),
('Ann', 'keller', 'annkelle@syr.edu', '315323213', '410 Sumner Ave',1)

-- insert into students table
INSERT into students(student_suid, student_firstname, student_lastname, student_email, student_phonenumber, student_age, student_home_address, student_vehicle_id, student_employee_id) values
 ('33683456', 'Himanshu', 'Patel', 'himanshupatel@syr.edu', '3453454344', 24, '183 Trinity pl', 1 , 3 ),
 ('71831831', 'Tina', 'Chopra',    'tinachopra@syr.edu', '6724214726', 22, '33 Ostrum Ave',  4, 2),
 ('78237484', 'Rahul', 'Gupta',    'rahulgupta@syr.edu', '8763526271', 28, '20 Madison street',  5, 1 ),
 ('74817481', 'Karan', 'Wahi',    'karunWahi@syr.edu',   '9828989238', 26, '11 Dewit street',  7, 4 ),
 ('54351243', 'Rose', 'Franco',    'rosefranco@syr.edu',   '3155832955', 35, '14 Avondale street',  6, 5 ),
 ('23663244', 'Trey', 'Mcdonald',    'trymcdonald@syr.edu',   '3154384924',35, '18 Comstock street',  8, 6 ),
 ('46646323', 'Matt', 'Wagner',    'mattwagner@syr.edu',   '6082489248', 29, '22 Concord pl',  9, 8 ),
 ('67424466', 'John', 'Hogan',    'johnhogan@syr.edu',   '1489849284', 30, '221 Victoria Pl',  5, 7 ),
 ('84834843', 'Ellie', 'Kemp',    'elliekemp@syr.edu',   '1489424192', 22, '521 Euclid Avenue',  4, 9 ),
 ('54235465', 'Wade', 'Jacobs',    'wadejacob@syr.edu',   '5929248244', 23, '44 Clarendon street',  3, 10 ),
 ('75673365', 'Ishaan', 'Lee',    'ishaanlee@syr.edu',   '8294812942', 21, '75 Lancaster Avenue',  2, 11 ),
 ('65865865', 'Mohit', 'Haas',    'mohithaas@syr.edu',   '4819241294', 25, '32 Judson street',  1, 12 ),
 ('54465655', 'Rohit', 'Shetty',    'rohitshetty@syr.edu',   '2149124912', 25, '64 Allen street',  7, 11 ),
 ('56425435', 'Sdyney', 'Vaz',    'sydneyvaz@syr.edu',   '4219412492', 24, '64 Dorset rd',  8, 9 ),
 ('86856345', 'Lara', 'Scott',    'larascott@syr.edu',   '4291849849', 27, '34 Oakwood Ave',  7, 8 ),
 ('91892891', 'Sasha', 'fox',    'sashafox@syr.edu',   '1289128393', 29, '129 Sunsrise street',  5, 10 ),
 ('29181928', 'Raj', 'Patel',    'rajpatel@syr.edu',   '4291849849', 23, '533 Sky street',  4, 8 ),
 ('42198491', 'Diana', 'Frenandes',    'dianafernandes@syr.edu',   '9238133113', 22, '381 Ernie street',  3, 4 ),
 ('12489114', 'Elita', 'Frank',    'elitafrank@syr.edu',   '9838281828', 24, '1231 Deli street',  2, 1 ),
 ('12491484', 'Vruti', 'West',    'vrutishah@syr.edu',   '4284828281', 25, '142 Comstock street',  7, 5 ),
 ('34843242', 'Shivani', 'Stanley',    'shivanistanley@syr.edu',   '9864567546', 26, '323 Trinity street',  8, 5 ),
 ('23823233', 'Prachi', 'Carey',    'prachicarey@syr.edu',   '8675757578', 27, '129 Westcott strret',  9, 6 ),
 ('12312383', 'Nidhi', 'Hooper',    'nidhihopper@syr.edu',   '6565745367', 28, '291 Southbeech strret',  3, 7 ),
 ('32932213', 'Diksha', 'Mcneil',    'dikshamcneil@syr.edu',   '8643563456', 21, '293  Columbus street',  4, 8 ),
 ('32932193', 'Manali', 'Glenn',    'manaligleen@syr.edu',    '3834342222', 22, '1312 Columbus street',  5, 3 ),
 ('23829383', 'shruti', 'Barnett',    'shrutibarnett@syr.edu',   '8754567567', 23, '1383 Shine street',  6, 2 ),
 ('21389393', 'Tom', 'Ford',    'tomford@syr.edu',   '7646754567', 24, '233 ABC street',  7, 1 ),
 ('34923849', 'Riya', 'Shah',    'riyashah@syr.edu',   '8765678964', 20, '323 XYZ street',  8, 4 ),
 ('23492349', 'Kanika', 'Arya',    'kanikaarya@syr.edu',   '7645678976', 19, '1238 Derie street',  9, 5 ),
 ('12389239', 'Kunj', 'Patel',    'Kunjpatel@syr.edu',   '8756745678', 18, '2329 Sadler street',  9, 6 ),
 ('23938932', 'Tarun', 'talreja',    'taruntalreja@syr.edu',   '8756757824', 25, '423 Ernie street',  3, 7 ),
 ('21892138', 'Soham', 'pednse',    'sohampednse@syr.edu',   '9876545676', 22, '2348 Comstock street',  2, 8 ),
 ('23892138', 'Derrick', 'Josh',    'derrickjosh@syr.edu',   '8923423244', 21, '238 Comstock street',  4, 9 ),
 ('48324244', 'Jadyn', 'Fox',    'jadynfox@syr.edu',   '4883848383', 22, '234 Comstock street',  5, 4 ),
 ('33688456', 'Brad', 'Pitt', 'bpitt@syr.edu', '3453454389', 24, '175 Trinity pl', 1 , 3 ),
 ('71551831', 'Tom', 'Cruise',    'tomcruise@syr.edu', '6724464726', 22, '39 Ostrum Ave',  4, 2),
 ('78246484', 'Sonam', 'Gupta',    'sonamgupta@syr.edu', '8764626271', 28, '27 Madison street',  5, 1 ),
 ('74467481', 'Kriti', 'Sanon',    'ksanon@syr.edu',   '9879989238', 26, '46 Dewit street',  7, 4 ),
 ('54347243', 'Rachel', 'Zane',    'rachelzane@syr.edu',   '3157932955', 35, '79 Avondale street',  6, 5 ),
 ('23625244', 'Tom', 'Hanks',    'tomhanks@syr.edu',   '3464384924',35, '46 Comstock strret',  8, 6 ),
 ('46679323', 'Jack', 'Nicholsan',    'jnicholsan@syr.edu',   '6082469248', 29, '77 Concord pl',  9, 8 ),
 ('67446466', 'Jon', 'Snow',    'jonsnow@syr.edu',   '1489841384', 30, '22 Victoria Pl',  5, 7 ),
 ('84863843', 'Ella', 'Anne',    'ellaanne@syr.edu',   '1489424692', 22, '51 Euclid Avenue',  4, 9 ),
 ('54215465', 'Kade', 'Spade',    'kadespade@syr.edu',   '5929468244', 23, '454 Clarendon strret',  3, 10 ),
 ('75646365', 'Martin', 'Snape',    'martinspade@syr.edu',   '8294879942', 21, '77 Lancaster Avenue',  2, 11 ),
 ('65813865', 'Mohit', 'Thakker',    'mohitthakker@syr.edu',   '4819213294', 25, '36 Judson strret',  1, 12 ),
 ('54446655', 'Meet', 'Bhanushali',    'meet@syr.edu',   '2469124912', 25, '66 Allen strret',  7, 11 ),
 ('56413435', 'Ebrahim', 'Hirani',    'ebrahimhirani@syr.edu',   '4219415492', 24, '644 Dorset rd',  8, 9 )
 

-- insert into bookings table
INSERT INTO bookings ( booking_time, pick_up_location,drop_off_location,booking_status,estimated_arrival_time, booking_student_id,booking_employee_id) VALUES
('2022-12-01 04:00:00', '111 trinity place', '1033 Ackerman Ave','dispatched', '2022-12-01 05:00:00',    1,2),
('2022-12-01 05:00:00', 'College Place', '230 Lancaster Ave','cancelled',     '2022-12-01  05:15:00' ,    3,4),
('2022-12-01 06:00:00', '111 Trinity place','college place','received',     '2022-12-01   06:20:00'  ,  5,2),
('2022-12-01 07:00:00', '198 Concord pl','Barnes','arrived',     '2022-12-01 07:40:00',      4,8),
('2022-12-01 07:00:00', '291 Allen St','Hinds hall','arrived',        '2022-12-01 07:50:00',       5,4),
('2022-12-01 07:00:00', '532 Roosevelt Ave','Ernie dining hall','arrived',     '2022-12-01 07:30:00',     6,5),
('2022-12-01 08:00:00', '143 Summer Ave','Sadler dining hall','completed',     '2022-12-01 08:20:00',      7,6),
('2022-12-01 08:00:00','14 Buckingham Ave','Bird library','completed',         '2022-12-01 08:30:00',     8,7),
('2022-12-02 08:00:00','131 Circle Rd','Marshal Street','no_call_no_show',     '2022-12-01 08:40:00',     9,1),
('2022-12-02 08:00:00','146 Ostrom pl','Unuversity ave','no_call_no_show',     '2022-12-02 08:55:00',   3,2),
('2022-12-02 09:00:00','154 Comstock Ave','Thornden park','arrived',     '2022-12-02 09:10:00',      9,4),
('2022-12-02 09:00:00','College Place', '729 Westcott Street','no_call_no_show',  '2022-12-02 09:15:00',   7,3),
('2022-12-02 09:00:00','College Place', '230 Lancaster Ave','cancelled',     '2022-12-02 09:40:00',       3,4),
('2022-12-02 09:00:00', 'College Place', '408 Westcott St','arriving',    '2022-12-02 09:16:00',     4,5),
('2022-12-02 09:00:00','College Place', '103 Euclid Ave','completed',      '2022-12-02 09:20:00',      7,6),
('2022-12-02 09:00:00','College Place', '132 Euclid Ave','no_call_no_show',   '2022-12-02 09:23:00',      13,7),
('2022-12-02 09:00:00','College Place', '123 Euclid Ave','dispatched',     '2022-12-02 09:25:00',     14,8),
('2022-12-02 09:00:00','College Place', '123 Euclid Ave','pending',    '2022-12-02 09:28:00',      15,1),
('2022-12-02 09:00:00','Bird Library', '1238 Westcott Ave','completed',     '2022-12-02 09:30:00',      16,4),
('2022-12-02 09:00:00','Bird Library', '90 southbeech Place','completed',  '2022-12-02 09:35:00',    6,5),
('2022-12-02 09:00:00','Bird Library', '11 livingston Place','dispatched',   '2022-12-02 09:40:00',   7,6),
('2022-12-02 09:00:00','Bird Library', '12 redfield Place','no_call_no_show', '2022-12-02 09:45:00',   10,7),
('2022-12-02 09:00:00','Bird Library', '13 lancaster Place','completed',   '2022-12-02 09:50:00',    11,8),
('2022-12-02 09:00:00','University Ave', '14 ackerman Place','completed',   '2022-12-02 09:55:00',   12,9),
('2022-12-03 10:00:00','University Ave', '15 ackerman Place','no_call_no_show',  '2022-12-03 09:52:00',    13,5),
('2022-12-04 10:00:00','Univeristy Ave','16 trinity place','dispatched',   '2022-12-04 10:05:00',    15,1),
('2022-12-04 10:00:00','Univeristy Ave','77 Lancaster Avenue','arriving',   '2022-12-04 10:10:00',    16,2),
('2022-12-04 10:00:00','Univeristy Ave','16 trinity place','arrived',   '2022-12-04 10:10:00',    17,3),
('2022-12-04 10:00:00','Univeristy Ave','66 Allen strret','cancelled',   '2022-12-04 10:10:00',    18,4),
('2022-12-04 10:00:00','Univeristy Ave','293  Columbus street','dispatched',   '2022-12-04 10:15:00',    19,5),
('2022-12-04 10:00:00','Univeristy Ave','46 Comstock strret','dispatched',   '2022-12-04 10:20:00',    20,6),
('2022-12-04 10:00:00','Univeristy Ave','16 trinity place','pending',   '2022-12-04 10:25:00',    21,7),
('2022-12-04 10:00:00','Univeristy Ave','129 Westcott strret','dispatched',   '2022-12-04 10:30:00',    22,8),
('2022-12-04 10:00:00','Univeristy Ave','22 Victoria Pl','pending',   '2022-12-04 10:30:00',    23,9),
('2022-12-04 10:00:00','Univeristy Ave','454 Clarendon strret','dispatched',   '2022-12-04 10:40:00',    24,10),
('2022-12-04 10:00:00','Univeristy Ave','16 trinity place','dispatched',   '2022-12-04 10:45:00',    25,11),
('2022-12-04 10:00:00','Univeristy Ave','34 Oakwood Ave','dispatched',   '2022-12-04 10:50:00',    26,12),
('2022-12-04 10:00:00','Univeristy Ave','161 trinity place','received',   '2022-12-04 10:55:00',    27,12),
('2022-12-04 10:00:00','Univeristy Ave','291 Southbeech strret','dispatched',   '2022-12-04 10:56:00',    28,11),
('2022-12-04 10:00:00','Univeristy Ave','129 Sunsrise street','received',   '2022-12-04 10:57:00',    29,9)

-- inserting into ratings table
insert into ratings(rating, feedback, rating_student_id) VALUES
(10, 'Excellent service', 2),
(5, 'the vehicle came late', 7),
(8, 'Quick and fast ', 6),
(7, 'Too slow to come to the destination', 8),
(6, 'Average service', 9),
(4, 'Bad Driver', 3),
(0, 'vehicle didnt show up', 1),
(1, 'the time taken for vehicle to come was more', 5),
(2, 'Time taken was extremely more', 6),
(10, 'Best service', 4)

-- quering the database 
-- using with and joins as well as aggregate functions to obtain the average of different kids of bookings
WITH ref
AS (SELECT s.student_id as id,s.student_firstname as firstname, s.student_lastname as lastname, 
b.booking_status as status, count(*) as counfof
FROM students s
JOIN employees e ON s.student_employee_id = e.employee_id
JOIN bookings b ON b.booking_employee_id = e.employee_id
group by b.booking_status,s.student_id,s.student_firstname,s.student_lastname,b.booking_status)
 
SELECT distinct status, AVG(cast(counfof as DECIMAL(10,2))) as average
FROM ref
GROUP BY status
ORDER BY average DESC

-- Displaying  top 5 pickup locations using windows function
SELECT distinct pick_up_location, COUNT(*) OVER (PARTITION by pick_up_location) as total
FROM bookings
order by total DESC

-- Trigger to restrict students to rate only between 1 and 10 
drop trigger rating_value
GO
CREATE TRIGGER RATING_VALUE 
ON ratings
AFTER INSERT
AS
IF EXISTS(select 1 from inserted where rating not between 1 and 10) 
BEGIN  
   RAISERROR('You can rate only from 1 to 10',10,1)
    ROLLBACK TRANSACTION;
    RETURN
 END; 

GO

-- checking trigger execution
insert into ratings(rating, feedback, rating_student_id) VALUES (110, 'Excellent service', 2)


-- calculating the Estimated arrival time for students by calculating the difference between the booking time and estimated arrival time
SELECT DATEDIFF(MINUTE, CAST(booking_time as time) ,
cast(estimated_arrival_time as time)) as Estimated_arrival_time ,
s.student_id, s.student_firstname +' ' + s.student_lastname as student_fullname,
b.booking_time, b.pick_up_location, b.drop_off_location
from bookings as b
join students as s on s.student_id = b.booking_student_id


-- creating a procedure for searching students details by feeding student id
DROP PROCEDURE  IF exists p_student_details
GO
CREATE PROCEDURE p_student_details(
    @student_suid INT
)AS 
BEGIN
SELECT 
    student_suid,
    student_firstname + ' ' + student_lastname as Student_name,
    student_email,
    student_phonenumber,
    student_age,
    student_home_address,
    b.pick_up_location as pick_up_location,
    b.drop_off_location as drop_off_location
FROM students s
INNER JOIN bookings b ON b.booking_student_id = s.student_id
Where student_suid = @student_suid
END

-- executing procedure 
exec p_student_details '33683456'
GO


-- calculating the total ratings per person and the average rating per student
with ratings_value as (select s.student_firstname + ' ' + s.student_lastname as student_name, s.student_email as email,
    count(rating) over (PARTITION by s.student_id) as total_rating,
    min(rating) over (PARTITION by s.student_id) as min_rating_value,
    avg(cast(rating as decimal)) over (PARTITION by s.student_id) as avg_rating
    from students as s
    join ratings as r on s.student_id = r.rating_student_id
    group by s.student_id, s.student_firstname + ' ' + s.student_lastname, s.student_email , r.rating
)
select distinct student_name, email, total_rating, min_rating_value, avg_rating from ratings_value 
