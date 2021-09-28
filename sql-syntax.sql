/* -------------------------------------------------- */
/*
Data Definition Language : DDL
    - CREATE (DATABASE, TABLE, VIEW, USER)
    - ALTER (CHANGE, ADD, DROP)
    - DROP (DATABASE, TABLE, VIEW, USER)
*/

/* สร้าง Database ชื่อ cpe */
CREATE DATABASE cpe;

/* สร้าง Table ชื่อ Advisor */
CREATE TABLE Advisor(
    ADVISOR_ID CHAR(5) NOT NULL,
    FNAME VARCHAR(30) NOT NULL,
    LNAME VARCHAR(30) NOT NULL,
    /* กำหนด PRIMARY KEY */
    PRIMARY KEY(ADVISOR_ID)
);

/* สร้าง Table ชื่อ Student โดยมี FK อ้างอิงไปยัง Table Advisor */
CREATE TABLE Student(
    STUDENT_ID CHAR(9) NOT NULL,
    FNAME VARCHAR(30) NOT NULL,
    LNAME VARCHAR(30) NOT NULL,
    DOB DATE NOT NULL,
    /* FLOAT(ความกว้างของตัวเลข, จำนวนทศนิยม) */
    GPA FLOAT(3, 2) NOT NULL,
    TEL VARCHAR(10) NOT NULL,
    ADVISOR_ID CHAR(5) NOT NULL,
    PRIMARY KEY(STUDENT_ID),
    /* การสร้าง Foreign Key */
    FOREIGN KEY(ADVISOR_ID) REFERENCES Advisor(ADVISOR_ID)
    /* ป้องกันไม่ให้ลบหากยังมี Foreign Key ที่อ้างอิงข้อมูลอยู่ */
    ON DELETE RESTRICT
    /* เมื่อข้อมูลเปลี่ยนแปลง Foreign Key ที่อ้างอิงข้อมูลไป จะเปลี่ยนแปลงด้วย */
    ON UPDATE CASCADE
);

/* ดูโครงสร้างของ Table */
DESCRIBE Advisor;
/* ดูข้อมูลว่ามี Database และ Table อะไรบ้าง */
SHOW DATABASES;
SHOW TABLES;

/* เปลี่ยนแปลง Attributes ใน Table */
ALTER TABLE Student
CHANGE FNAME FIRST_NAME VARCHAR(35) NOT NULL,
CHANGE LNAME LAST_NAME VARCHAR(35) NOT NULL;

/* เพิ่ม Attributes ลงไปใน Table */
ALTER TABLE Student
ADD EMAIL VARCHAR(50) NULL

/* ลบ Attributes ออกจาก Table */
ALTER TABLE Student
DROP EMAIL;

/* ลบ Database และ Table */
DROP TABLE Student;
DROP DATABASE cpe;

/* -------------------------------------------------- */


/* -------------------------------------------------- */
/*
Data Data Manipulation Language : DML
    - SELECT
    - INSERT
    - UPDATE
    - DELETE
*/

แสดงข้อมูลที่อยู่ใน Table โดยต้องกำหนด Attributes ที่จะนำมาแสดง
และต้องใช้เสมอ FROM เพื่อบอกว่าจะดึงข้อมูลมาจาก Table ไหน
 */
SELECT staff.staffNO, staff.fName, staff.lName, staff.salary
FROM staff;

/* แสดงข้อมูลทุกคอลัมที่อยู่ใน Table นั้น โดยเติม * หลังจาก SELECT */
SELECT *
FROM staff;

/* สามารถใช้การคำนวณทางคณิตศาสตร์มาใช้กับการแสดงผลข้อมูลใน Table ได้ */
SELECT staff.salary+500 /* ทุกข้อมูลที่อยู่ใน Attributes salary จะมีค่าเพิ่มขึ้น 500 */
FROM staff;

/* สามารถใช้ฟังก์ชั่นทางคณิตศาสตร์ได้ในการแสดงผลของข้อมูลได้ */
/* AS Summary ก็การกำหนดชื่อ Attributes ของข้อมูลที่คำนวณแล้ว*/
/* แสดงผลรวมของข้อมูลทั้งหมดใน Attributes salary */
SELECT SUM(staff.salary) AS Summary 
FROM staff;

/* แสดงค่าสูงสุดของข้อมูลทั้งหมดใน Attributes salary */
SELECT MAX(staff.salary) AS Maximum 
FROM staff;

/* แสดงค่าที่ต่ำสุดของข้อมูลทั้งหมดใน Attributes salary */
SELECT MIN(staff.salary) AS Minimum 
FROM staff;

/* แสดงจำนวนของข้อมูลที่อยู่ใน Attributes salary */
SELECT COUNT(*) AS Total
FROM staff;

/* 
แสดงข้อมูลทั้งหมดที่อยู่ใน pos โดยจะแสดงผลแบบไม่ซ้ำกัน
ตัวอย่างเช่น
        หัวหน้าแผนก
        พนักงาน
        พนักงาน
        ผู้จัดการ
        พนักงาน
    จะแสดงเป็น
        หัวหน้าแผนก
        พนักงาน
        ผู้จัดการ
*/
SELECT distinct(pos)
FROM staff;

/* แสดงข้อมูลโดยคัดกรองข้อมูลตามเงื่อนไข */
/* แสดงข้อมูลของพนักงานทั้งหมดที่ gender เป็น "ช" และเป็นผู้จัดการ */
SELECT *
FROM staff
WHERE gender = 'ช' And pos = 'ผู้จัดการ';

/* แสดงข้อมูลของพนักงานทั้งหมดที่มี salary เกิน 20,000*/
SELECT *
FROM staff
WHERE salary >= 20000;

/* แสดงจำนวนพนักงานทั้งหมดที่มี salary เกิน 20,000*/
SELECT COUNT(*) AS Total
FROM staff
WHERE salary >= 20000;

/* แสดงข้อมูลเฉพาะช่วง */
/* แสดงข้อมูลพนักงานทั้งหมดที่มี salary ระหว่าง 10,000 - 20,000 */
SELECT * 
FROM staff
WHERE salary BETWEEN 10000 AND 20000;

/* แสดงข้อมูลที่เจาะจง */
/* แสดงข้อมูลพนักงานทั้งหมดที่มี salary ตามที่กำหนด (9000, 10000, 20000) */
SELECT *
FROM staff
WHERE salary IN ('9000', '10000', '20000');

/* แสดงข้อมูลทุก Attribute ที่มี Attributes comment ไม่เป็นค่าว่าง */
SELECT *
FROM viewing
WHERE COMMENT IS NOT NULL;
/* แสดงข้อมูลทุก Attribute ที่มี Attributes comment เป็นค่าว่าง */
SELECT *
FROM viewing
WHERE COMMENT IS NULL;

/* แสดงข้อมูลพนักงานทั้งหมดที่มีชื่อขึ้นต้นด้วย "ส" */
SELECT *
FROM staff
WHERE staff.fName LIKE 'ส%'

/* แสดงข้อมูลพนักงานทั้งหมดที่มีชื่อขึ้นลงท้ายด้วยด้วยคำว่า "ดา" */
SELECT *
FROM staff
WHERE staff.fName LIKE '%ดา'

/* แสดงข้อมูลพนักงานทั้งหมดที่มี "ร" อยู่ภายในชื่อ */
SELECT *
FROM staff
WHERE staff.fName LIKE '%ร%'

/* แสดงข้อมูลพนักงานทั้งหมดที่มีตัวอักษร 5 ตัว */
SELECT *
FROM staff
WHERE staff.fName LIKE '_____'

/* แสดงข้อมูลพนักงานทั้งหมดโดยเรียงจากค่ามากไปน้อย */
SELECT *
FROM staff
ORDER BY staff.salary DESC

/* แสดงข้อมูลพนักงานทั้งหมดโดยเรียงจากค่าน้อยไปมาก */
SELECT *
FROM staff
ORDER BY staff.salary ASC

/* แสดงข้อมูลพนักงานทั้งหมดโดยเรียงจากค่ามากไปน้อยของ salary ก่อน
แล้วค่อยเรียงจากค่าน้อยไปมากของ staffNo */
SELECT * 
FROM staff
ORDER BY staff.salary DESC, staff.staffNO ASC;

/* แสดงข้อมูลของพนักงานทั้งหมดโดยเรียงจากค่ามากไปน้อย 3 ลำดับแรก */
SELECT *
FROM staff
ORDER BY staff.salary DESC
/* LIMIT(เริ่มต้นที่ Record ที่เท่าไหร่, จำนวนข้อมูลที่นำมาแสดง) */
LIMIT 0,3

/* แบ่งกลุ่มของข้อมูลที่อยู่ใน Attributes */
SELECT staff.pos
FROM staff
GROUP BY staff.pos

/* แบ่งกลุ่มของข้อมูลที่อยู่ใน Attributes และจำนวนของข้อมูลที่อยู่ในแต่ละกลุ่ม
และจัดเรียงจากมากไปน้อย และแสดงเฉพาะข้อมูลในกลุ่มที่มีจำนวนมากกว่า 1 */
SELECT staff.pos, COUNT(*) AS Total
FROM staff
GROUP BY staff.pos
ORDER BY Total DESC
HAVING Total > 1;

/* การ Join กันของข้อมูลให้สัมพันธ์กัน */
SELECT staff.staffNO, staff.fName, staff.lName, staff.branchNo, branch.province
FROM staff, branch
WHERE staff.branch = branch.branchNo

/* การ Insert ข้อมูล */
INSERT INTO staff(staff.staffNO, staff.fName, staff.lName)
VALUES ('621103004','ก้องสิทธา','นิ่มกิ่ง');

/* หาก Insert ข้อมูลโดยที่ไม่กำหนดว่าจะต้องเพิ่มข้อมูลอะไรบ้าง
จำเป็นจะต้องเพิ่มข้อมูลให้ครบตาม Attributes ที่มีทั้งหมด */
INSERT INTO staff
VALUES ('621103004','ก้องสิทธา','นิ่มกิ่ง');

/* การ Update ข้อมูลที่อยู่ใน Record */
๊/* เปลี่ยนแปลงข้อมูลของพนักงานรหัส S0010 โดยจะกำหนดให้
ตำแหน่งเป็น IT และเงินเดือนมีค่าเป็น 60000 */
UPDATE staff
SET staff.pos = 'IT', staff.salary = '60000'
/* ข้อควรระวัง */
/* หากไม่มี WHERE ที่จะเจาะจงตำแหน่งของข้อมูลที่จะเปลี่ยนแปลง
คำสั่งด้านบนจะทำการทับข้อมูลทั้ง Table โดย pos จะถูกแทนที่ด้วย IT
และ salary จะถูกแทนที่ทั้งหมดด้วย 60000 ทำให้ข้อมูลเสียหายได้ */ 
WHERE staff.staffNo = 'S0010';

/* การ Delete ข้อมูลที่อยู่ใน Record */
/* ลบข้อมูลของพนักงานรหัส S0010 */
DELETE
FROM staff
/* ข้อควรระวังเช่นเดียวกันกับการ Update หากไม่มีการกำหนด WHERE
คำสั่งจะทำการลบข้อมูลทั้งหมดที่อยู่ใน staff */
WHERE staff.staffNo = 'S0010'

/* การสร้าง View (จำลองข้อมูลขึ้นมาโดยการคัดลอก Table
และสามารถเลือกได้ว่าจะคัดลอกเฉพาะ Attribute ไหน)*/
/* สร้าง view ที่ชื่อ staff_view โดยการคัดลอกข้อมูลเฉพาะ
พนักงานที่มี salary มากกว่า 10000*/
CREATE VIEW staff_view
AS SELECT staff.staffNO, staff.fName, staff.lName, staff.salary
FROM staff
WHERE staff.salary > 10000

/* ลบ View */
DROP VIEW staff_view;

/* -------------------------------------------------- */


/* -------------------------------------------------- */
/*
Data Control Language : DCL
    - GRANT
    - REVOKE
*/
/* 

/* การสร้าง User */
CREATE USER test@localhost
INDENTIFIED BY '12345';

/* กำหนดความสามารถให้กับ User */
/* กำหนดความสามารถในการ SELECT และ INSERT ให้กับ User test */
GRANT SELECT, INSERT
ON lab8.staff
TO test@localhost;

/* เพิกถอนความสามารถในการ SELECT และ INSERT ให้กับ User test */
REVOKE SELECT, INSERT
ON lab8.staff
FROM test@localhost;

/* เพิกถอนความสามารถทั้งหมดของ User test */
REVOKE ALL
ON lab8.*
FROM test@localhost;

/* แสดงผลว่า User test ได้รับความสามารถอะไรบ้าง */
SHOW GRANT FOR test@localhost;

/* ลบ User ออกจากระบบ */
DROP USER test@localhost;

/* -------------------------------------------------- */