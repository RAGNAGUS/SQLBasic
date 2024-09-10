# การติดตั้ง MariaDB บน Ubuntu Linux

การติดตั้ง MariaDB บน Ubuntu สามารถทำได้ตามขั้นตอนต่อไปนี้:

### 1. อัปเดตระบบ

```cmd
sudo apt update
sudo apt upgrade
```

### 2. ติดตั้ง MariaDB

```cmd
sudo apt install mariadb-server
```

### 3.ตรวจสอบการติดตั้งและสถานะของ MariaDB

```cmd
sudo systemctl start mariadb
sudo systemctl stop mariadb
sudo systemctl restart mariadb
sudo systemctl status mariadb
sudo systemctl enable mariadb
sudo systemctl disable mariadb
```

### 4.ตั้งค่าความปลอดภัย

```cmd
sudo mysql_secure_installation
```

Enter current password for root (enter for none): Enter

Switch to unix_socket authentication [Y/n]: n

Change the root password? [Y/n]: n

Remove anonymous users? [Y/n]: y

Disallow root login remotely? [Y/n]: y

Remove test database and access to it? [Y/n]: y

Reload privilege tables now? [Y/n]: y

### 5. เข้าสู่ระบบ MariaDB

```cmd
sudo mysql -u root -p
sudo mysql -u root
```

### 6. อนุญาตให้ MariaDB/MySQL ยอมรับการเชื่อมต่อจากภายนอก

1. เปิดไฟล์การตั้งค่าของ MariaDB (โดยปกติจะอยู่ที่ `/etc/mysql/mariadb.conf.d/50-server.cnf`) และแก้ไขค่าต่อไปนี้:

```cmd
sudo nano /etc/mysql/mariadb.conf.d/50-server.cnf
```

2. ค้นหาบรรทัดที่มี `bind-address` และแก้ไขจาก `127.0.0.1` เป็น `0.0.0.0` เพื่ออนุญาตให้เชื่อมต่อจากทุกที่:

```cmd
bind-address = 0.0.0.0
```

3. จากนั้นบันทึกไฟล์และออกจากโปรแกรม (`Ctrl + X`, กด `Y`, แล้วกด `Enter`)

4. เปิดพอร์ต 3306 บน Firewall (ถ้าจำเป็น)

```cmd
sudo ufw allow 3306/tcp
```

5. รีสตาร์ท MariaDB

```cmd
sudo systemctl restart mariadb
```

### 7. การสร้าง Database และการสร้างผู้ใช้ พร้อมการกำหนดสิทธิ์

1. เข้าสู่ระบบ MariaDB ในฐานะผู้ใช้ root

```cmd
sudo mysql -u root -p
sudo mysql -u root
```

2. สร้างฐานข้อมูล (Database)

```cmd
CREATE USER 'username'@'localhost' IDENTIFIED BY 'password';
```

3. สร้างผู้ใช้ใหม่ (User) ใช้คำสั่งต่อไปนี้เพื่อสร้างผู้ใช้ใหม่ โดยให้เปลี่ยน `username` เป็นชื่อผู้ใช้ที่ต้องการ และ `password` เป็นรหัสผ่าน

```cmd
CREATE USER 'username'@'localhost' IDENTIFIED BY 'password';
```

4. ให้สิทธิ์ผู้ใช้ในการเข้าถึงฐานข้อมูล

```cmd
GRANT ALL PRIVILEGES ON database_name.* TO 'username'@'localhost';
```

5. ตรวจสอบสิทธิ์ของผู้ใช้

```cmd
SHOW GRANTS FOR 'username'@'hostname';
```

6. รีโหลดสิทธิ์ ใช้คำสั่งนี้เพื่อรีโหลดสิทธิ์ทั้งหมดให้มีผลทันที

```cmd
FLUSH PRIVILEGES;
```

### 8. การตรวจสอบผู้ใช้ทั้งหมด

```cmd
SELECT User, Host FROM mysql.user;
```

### 9. การสร้าง Table ในฐานข้อมูล

1. เลือกฐานข้อมูลที่ต้องการสร้างตาราง

```cmd
USE mydatabase;
```

2. สร้างตาราง (Table)

ใช้คำสั่ง `CREATE TABLE` เพื่อสร้างตารางใหม่ โดยต้องกำหนดชื่อของตารางและโครงสร้างของแต่ละคอลัมน์

ตัวอย่างเช่น สร้างตารางชื่อ `users` ซึ่งมีคอลัมน์ดังนี้:

- `id` (INT) เป็น Primary Key และ Auto Increment
- `username` (VARCHAR) ความยาวสูงสุด 50 ตัวอักษร
- `email` (VARCHAR) ความยาวสูงสุด 100 ตัวอักษร
- `created_at` (TIMESTAMP) ใช้บันทึกวันที่และเวลาที่สร้างข้อมูล

```cmd
CREATE TABLE users (
    id INT NOT NULL AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
);
```

3. ตรวจสอบว่าตารางถูกสร้างสำเร็จ

```cmd
DESCRIBE users;
```

### 10. การส่งไฟล์จาก Windows ไปยัง Linux

สามารถใช้คำสั่ง `scp` ในการอัพโหลดไฟล์จากเครื่อง Windows ไปยังเซิร์ฟเวอร์ Linux Ubuntu เช่น

```cmd
scp /path/to/your-database-file.sql username@server-ip:/path/to/destination

scp exported.sql xver@185.84.160.237:/home/xver
```

### 11. นำเข้าไฟล์ SQL ไปยัง ฐานข้อมูล MariaDB

1. **สร้างฐานข้อมูล** (หากยังไม่ได้สร้างฐานข้อมูล)

```cmd
CREATE DATABASE your_database_name;
```

2. **นำเข้าไฟล์ `.sql`**: ใช้คำสั่งนี้เพื่อ import ไฟล์ `.sql`

```cmd
sudo mariadb -u root -p your_database_name < /path/to/your-database-file.sql

sudo mariadb -u root spire_horizon_online < /home/xver/exported.sql
```



```cmd
sudo nano /etc/mysql/mariadb.conf.d/50-server.cnf
```



```cmd
sudo nano /etc/mysql/mariadb.conf.d/50-server.cnf
```



```cmd
sudo nano /etc/mysql/mariadb.conf.d/50-server.cnf
```



```cmd
sudo nano /etc/mysql/mariadb.conf.d/50-server.cnf
```



```cmd
sudo nano /etc/mysql/mariadb.conf.d/50-server.cnf
```



```cmd
sudo nano /etc/mysql/mariadb.conf.d/50-server.cnf
```



```cmd
sudo nano /etc/mysql/mariadb.conf.d/50-server.cnf
```

