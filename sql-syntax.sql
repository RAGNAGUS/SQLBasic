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
/*
Data Data Manipulation Language : DML
    - SELECT
    - INSERT
    - UPDATE
    - DELETE
*/
/*
Data Control Language : DCL
    - GRANT
    - REVOKE
*/