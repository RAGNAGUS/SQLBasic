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
#เริ่มการทำงาน
sudo systemctl start mariadb
#หยุดการทำงาน
sudo systemctl stop mariadb
#รีสตาร์ท
sudo systemctl restart mariadb
#เช็คสถานะ
sudo systemctl status mariadb
#ตั้งให้เริ่มตอนบูตเครื่อง
sudo systemctl enable mariadb
#ยกเลิกการตั้งค่าเริ่มตอนบูตเครื่อง
sudo systemctl disable mariadb
```

