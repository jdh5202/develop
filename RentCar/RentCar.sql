create table RentCar (
	
	no number primary key,
	name varchar2(20),
	category number,
	price number,
	usepeople number,
	company varchar(50),
    img varchar2(50),
	info varchar2(3000)


);

select * from RentCar;

insert into rentcar values (1, '베이론', 2,  250000, 4, '부가티', 'car1.jpg' , '부가티 베이론입니다.');
insert into rentcar values (2, '어큐라 NSX', 2,  600000, 4, '혼다 ', 'car2.jpg' , '혼다 어큐라 NSX입니다.');
insert into rentcar values (3, 'G80', 3,  70000, 7, '제네시스', 'car3.jpg' , '제네시스 G80입니다.');
insert into rentcar values (4, '스쿠프', 2,  25000, 4, '현대', 'car4.jpg' , '현대 스쿠프입니다.');
insert into rentcar values (5, '토륨', 2,  300000, 4, '콘셉트', 'car5.jpg' , '콘셉트 토륨입니다.');
insert into rentcar values (6, '스파크', 1,  60000, 4, '쉐보레', 'car6.jpg' , '쉐보레 스파크입니다.');
insert into rentcar values (7, 'i30', 3,  30000, 4, '현대', 'car7.jpg' , '현대 i30입니다.');
insert into rentcar values (8, '아이오닉', 2,  24000, 4, '현대', 'car8.jpg' , '현대 아이오닉입니다.');
insert into rentcar values (9, '아이오닉', 2,  27000, 4, '현대', 'car9.jpg' , '현대 아이오닉입니다.');
insert into rentcar values (10, '아비스타', 2,  500000, 4, '콘셉트', 'car10.jpg' , '콘셉트 아비스타입니다.');
insert into rentcar values (11, '코나', 3,  60000, 4, '현대', 'car11.jpg' , '현대 코나입니다.');
insert into rentcar values (12, '308', 2,  200000, 5, '푸조', 'car12.jpg' , '푸조 308입니다.');
insert into rentcar values (13, '콜벳c6', 2,  200000, 4, '쉐보레', 'car13.jpg' , '쉐보레 콜벳c6입니다.');
insert into rentcar values (14, 'lfa', 2,  200000, 4, '렉서스', 'car14.jpg' , '렉서스 lfa입니다.');
insert into rentcar values (15, '모닝', 1,  23000, 4, '기아', 'car15.jpg' , '기아 모닝입니다.');
insert into rentcar values (16, '쏘나타', 2,  50000, 4, '현대', 'car16.jpg' , '현대 쏘나타입니다.');
insert into rentcar values (17, '그렌져', 2,  40000, 4, '현대', 'car17.jpg' , '현대 그렌져입니다.');
insert into rentcar values (18, 'G80', 2,  55000, 4, '제네시스', 'car18.jpg' , '제네시스 G80입니다.');
select * from rentcar;






create table carreserve(

   reserveno  number primary key,
   no number not null,
   id varchar2(50) not null,
   qty number not null,
   dday number not null,
   rday varchar2(50) not null,
   userin number not null,
   usewifi number not null,
   useseat number not null,
   usenavi number not null
	

);

-- 시퀀스 생성

create sequence reserve_seq 
	start with 1
	increment by 1
	nomaxvalue 
    nocycle
    nocache;

CREATE SEQUENCE BOARD_SEQ START WITH 1
                          INCREMENT BY 1
                          MAXVALUE 9999999999999999999999
                          NOMINVALUE
                          NOORDER
                          NOCYCLE
                          NOCACHE;
                          
                          
-- 또다른 maxvalue 무한설정

CREATE SEQUENCE  BOARD_SEQ
			START WITH 1
			INCREMENT by 1
			NOMAXVALUE
			nocache;

			
drop table board;
create table board(

	num number primary key,
	writer varchar2 (20),
    email varchar2(50),
    subject varchar2(50),
    password varchar2(10),
    reg_date  Date,
	ref number,
    re_step number,
    re_level  number,
	readcount number,
    content  varchar2(3000)
	
);	


ALTER TABLE SYSTEM.board ADD (
  PRIMARY KEY
  (num)
  ENABLE VALIDATE);

  

drop table Member ;



CREATE TABLE MEMBER
(
  ID     VARCHAR2(120),
  PASS1  VARCHAR2(120),
  EMAIL  VARCHAR2(150),
  TEL    VARCHAR2(120),
  AGE    VARCHAR2(110),
  INFO   VARCHAR2(500)
);


ALTER TABLE MEMBER ADD (
  CONSTRAINT MEMBER_PK
  PRIMARY KEY
  (ID)
  ENABLE VALIDATE);

INSERT INTO member VALUES('admin', 'feg103' , 'jdh5202@naver.com' ,'010-4903-3911' ,'20' , 'administration account')

commit;
