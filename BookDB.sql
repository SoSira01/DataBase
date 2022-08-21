SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=1;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
drop SCHEMA book;
CREATE SCHEMA IF NOT EXISTS book DEFAULT CHARACTER SET utf8 ;
USE book ;

CREATE TABLE IF NOT EXISTS `book`.`category` (
  CategoryId INT NOT NULL auto_increment,
  CategoryName VARCHAR(100) NOT NULL,
  Duration INT NOT NULL,
  CategoryDescription VARCHAR(500) NULL,
  PRIMARY KEY (`CategoryId`),
  UNIQUE INDEX CategoryName_UNIQUE (`CategoryName` ASC) VISIBLE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `book`.`booking` (
  BookingId INT NOT NULL auto_increment,
  BookingName VARCHAR(100) NOT NULL,
  StartTime DATETIME NOT NULL,
  Email VARCHAR(45) NULL,
  Note VARCHAR(500) NULL,
  Category_CategoryId INT NOT NULL,
  PRIMARY KEY (`BookingId`),
  INDEX fk_booking_Category_idx (`Category_CategoryId` ASC) VISIBLE,
  CONSTRAINT fk_booking_Category
    FOREIGN KEY (`Category_CategoryId`)
    REFERENCES `book`.`category` (`CategoryId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

drop table user;
CREATE TABLE IF NOT EXISTS `book`.`user` (
  `userId` INT NOT NULL auto_increment,
  `name` VARCHAR(100) NOT NULL,
  `email` VARCHAR(50) NOT NULL,
  `password` VARCHAR(90) NOT NULL,
  `role` enum('admin','lecturer','student') default 'student',
  `createdOn` datetime default now(),
  `updatedOn` datetime on update current_timestamp default current_timestamp,
  PRIMARY KEY (`userId`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `book`.`eventcategoryowner` (
  `eventCategoryId` INT NOT NULL,
  `userId` INT NOT NULL,
  PRIMARY KEY (`eventCategoryId`, `userId`),
  INDEX `fk_category_has_user_user1_idx` (`userId` ASC) VISIBLE,
  INDEX `fk_category_has_user_category1_idx` (`eventCategoryId` ASC) VISIBLE,
  CONSTRAINT `fk_category_has_user_category1`
    FOREIGN KEY (`eventCategoryId`)
    REFERENCES `book`.`category` (`CategoryId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_category_has_user_user1`
    FOREIGN KEY (`userId`)
    REFERENCES `book`.`user` (`userId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET time_zone = '+7:00';
SELECT current_timestamp;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
 desc user;
insert into category value(1,'Project Management Clinic','30','ตารางนัดหมายนี้ใช้สำหรับนัดหมาย project management clinic ในวิชา INT221 integrated project I ให้นักศึกษาเตรียมเอกสารที่เกี่ยวข้องเพื่อแสดงระหว่างขอคำปรึกษา'),
     (2,'DevOps/Infra Clinic','30','Use this event category for DevOps/Infra clinic'),
     (3,'Database Clinic','15','ตารางนัดหมายนี้ใช้สำหรับนัดหมาย database clinic ในวิชา INT221 integrated project I'),
     (4,'CLient-side Clinic','30','ตารางนัดหมายนี้ใช้สําหรับนัดหมาย client-side clinic ในวิชา INT221 integrated project I'),
     (5,'Server-side Clinic','30',null);
     
Insert into user (name,email,role,password) Values
('OASIP ADMIN','oasip.admin@kmutt.ac.th','admin','$argon2i$v=19$m=65586,t=4,p=2$l+I8prWqIp4$DbfD98/mMhN/NO3u8imVIw'),
('Olarn Rojanapornpun','olarn.roj@kmutt.ac.th','lecturer','$argon2i$v=19$m=65586,t=4,p=2$s0Dg2fXIIcM$s1AmWux/8aDDLCwV3yi2lA'),
('Pichet Limvachiranan','pichet.limv@kmutt.ac.th','lecturer','$argon2i$v=19$m=65586,t=4,p=2$jLzsZVCvZz0$dV94A9w+Ojp6b2dabEqvHg'),
('Umaporn Supasitthimethee','umaporn.sup@kmutt.ac.th','lecturer','$argon2i$v=19$m=65586,t=4,p=2$FgzRo5aw6r4$3dm/rfm11escgg3dUuVqNw'),
('Siam Yamsaengsung','siam.yam@kmutt.ac.th','lecturer','$argon2i$v=19$m=65586,t=4,p=2$ubPNZOX9fkk$L9KXbLpeH1+DoN/TM/7WGA'),
('Sunisa Sathapornvajana','sunisa.sat@kmutt.ac.th','lecturer','$argon2i$v=19$m=65586,t=4,p=2$9AlPsF4LX4Q$iRsBAjpcbWEQhANzMjgrjw'),
('Somchai Jaidee','somchai.jai@kmutt.ac.th','student','$argon2i$v=19$m=65586,t=4,p=2$lMjh7UCI/vA$n9mqDgqTTGVHgQdz3E7DlA'),
('Komkrid Rakdee','komkrid.rak@mail.kmutt.ac.th','student','$argon2i$v=19$m=65586,t=4,p=2$FCpdEzbi6+w$37fBJkdZBsuff81fj/Vf3w'),
('สมเกียรติ ขยันเรียน','somkiat.kay@kmutt.ac.th','student','$argon2i$v=19$m=65586,t=4,p=2$z2tQpTHjXPA$OhPMQ/ASiWmAayf/46559w');
 insert into eventcategoryowner value(1,2),(2,5),(2,2),(3,6),(4,4),(5,3),(5,2);


commit;
