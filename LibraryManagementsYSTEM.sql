
DROP DATABASE LIBRARY;
CREATE DATABASE LIBRARY;
USE LIBRARY; 

DROP TABLE BRANCH;

CREATE TABLE BRANCH(
BRANCH_NO INT PRIMARY KEY ,
MANAGER_ID VARCHAR (30),
BRANCH_ADDRESS TEXT,
CONTACT_NO VARCHAR(30));


CREATE PROCEDURE INSERT_BRANCH(IN BRANCH_NO VARCHAR(20),IN BRANCH_ADDRESS TEXT,IN MANAGER_ID VARCHAR(20),IN CONTACT_NO VARCHAR(20))
INSERT INTO BRANCH (BRANCH_NO,BRANCH_ADDRESS,MANAGER_ID,CONTACT_NO)VALUE(BRANCH_NO,BRANCH_ADDRESS,MANAGER_ID,CONTACT_NO);

CALL INSERT_BRANCH('11','MUVATTUPUZHA','26789923','704456782');
CALL INSERT_BRANCH('12','THODUPUZHA','28091451','9780895641');
CALL INSERT_BRANCH('13','ERNAKULAM','29874301','8089406750');
CALL INSERT_BRANCH('15','CHERTHALA','24509862','7356452031');
CALL INSERT_BRANCH('16','THRISSUR','30673013','7788364690');

SELECT * FROM BRANCH;

DROP TABLE EMPLOYEE;
CREATE TABLE EMPLOYEE(
EMP_ID INT PRIMARY KEY ,
EMP_NAME VARCHAR (20),
POSITION VARCHAR(20),
SALARY FLOAT,
MANAGER_ID INT,
FOREIGN KEY (MANAGER_ID) REFERENCES EMPLOYEE(EMP_ID)
ON DELETE CASCADE);

DROP PROCEDURE INSERT_EMPLOYEE;
CREATE PROCEDURE INSERT_EMPLOYEE(IN EMP_ID VARCHAR(20),IN EMP_NAME VARCHAR(20),IN POSITION VARCHAR(20),IN SALARY FLOAT,MANAGER_ID INT)
INSERT INTO EMPLOYEE(EMP_ID,EMP_NME ,POSITION,SALARY,MANAGER_ID)VALUES(EMP_ID,EMP_NAME,POSITION,SALARY,MANAGER_ID);

CALL INSERT_EMPLOYEE('11006753','SAM','8','30000','1269');
CALL INSERT_EMPLOYEE('11007652','AMAL','9','54000','1298');
CALL INSERT_EMPLOYEE('11006766','MINNU','5','50000','1278');
CALL INSERT_EMPLOYEE('11006562','CHINNU','7','12000','1256');
CALL INSERT_EMPLOYEE('11004532','ILIN','2','25000','1234');

SELECT * FROM EMPLOYEE;

CREATE TABLE CUSTOMER(
CUSTOMER_ID INT PRIMARY KEY ,
CUSTOMER_NAME VARCHAR(20),
CUSTOMER_ADDRESS TEXT,
REG_DATE DATETIME DEFAULT NOW());

DROP PROCEDURE INSERT_CUSTOMER;

CREATE PROCEDURE INSERT_CUSTOMER(IN CUSTOMER_ID VARCHAR(20),IN CUSTOMER_NAME VARCHAR(15),
IN CUSTOMER_ADDRESS TEXT,IN REG_DATE DATETIME)
INSERT INTO CUSTOMER(CUSTOMER_ID,CUSTOMER_NAME,CUSTOMER_ADDRESS,REG_DATE)
VALUES(CUSTOMER_ID,CUSTOMER_NAME,CUSTOMER_ADDRESS,REG_DATE);

CALL INSERT_CUSTOMER('101','MERY','PQRS ,KOCHI','20-05-2011');
CALL INSERT_CUSTOMER('141','JABI','MNOP ,TVM','15-06-2015');
CALL INSERT_CUSTOMER('131','SEMI','ABCD ,CALICUT','10-07-2021');
CALL INSERT_CUSTOMER('121','RIYA','EFGH ,EKM','22-01-2019');
CALL INSERT_CUSTOMER('111','SHEMI','IJKL ,IDUKKI',NOW());

SELECT * FROM CUSTOMER;

CREATE TABLE IssueStatus (
  Issue_Id INT PRIMARY KEY,
  Issued_cust INT,
  Issued_book_name VARCHAR(255),
  Issue_date DATE,
  Isbn_book INT,
  FOREIGN KEY (Issued_cust) REFERENCES Customer(Customer_Id),
  FOREIGN KEY (Isbn_book) REFERENCES Books(ISBN)
);

delimiter $$

CREATE PROCEDURE INSERT_ISSUE_STATUS(IN ISSUED_CUST INT,IN Isbn_book INT)
BEGIN
DECLARE BOOK_NAME TEXT;
SELECT BOOK_TITLE INTO BOOK_NAME FROM BOOKES WHERE ISBN=isbn_book ;
INSERT INTO ISSUESTATUS(ISSUED_CUST,ISSUED_BOOK_NAME,ISSUE_DATE,ISBN_BOOK)
VALUES(ISSUED_CUST,BOOK_NAME,NOW(),isbn_book);
end $$
delimiter ;

CALL INSERT_ISSUED_STATUS('KKK','ABCD','20-09-2020');
CALL INSERT_ISSUED_STATUS('KKK','ABCD','20-09-2020');
CALL INSERT_ISSUED_STATUS('KKK','ABCD','20-09-2020');
CALL INSERT_ISSUED_STATUS('KKK','ABCD','20-09-2020');
CALL INSERT_ISSUED_STATUS('KKK','ABCD','20-09-2020');

DELIMITER $$
CREATE TRIGGER BEFORE_INSERT_ISSUE_STATUS
BEFORE INSERT ON ISSUESTATUS
FOR EACH ROW
BEGIN
DECLARE ERRMSG VARCHAR(20);
DECLARE STATUS1 VARCHAR(4);
SELECT STATUS INTO STATUS1 FROM BOOKS WHERE ISBN=NEW.ISBN_BOOK;
SET ERRMSG=CONCAT(NEW.ISBN_BOOK,'IS NOT AVAILABLE');
IF STSTUS1='NO' THEN SIGNAL SQLSTATE'45000'
SET MESSAGE_TEXT=ERRMSG;
END IF;
END $$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER after_insert_issue_status
after INSERT ON IssueStatus
FOR EACH ROW
BEGIN
update books set status='no' where isbn=new.Isbn_book;
END $$
DELIMITER ;

SELECT *FROM IssueStatus;


CREATE TABLE ReturnStatus (
  Return_Id INT PRIMARY KEY,
  Return_cust INT,
  Return_book_name VARCHAR(100),
  Return_date DATE,
  Isbn_book2 VARCHAR(20),
  FOREIGN KEY (Return_cust) REFERENCES Customer(Customer_Id),
  FOREIGN KEY (Isbn_book2) REFERENCES Books(ISBN)
);

DELIMITER $$
DROP PROCEDURE INSERT_CUSTOMER;
CREATE PROCEDURE INSERT_RETURN_STATUS(IN RETURN_ID INT,IN RETURN_CUST INT,IN ISBN_BOOKS INT)
BEGIN
DECLARE BOOK_NAME TEXT;
SELECT BOOK_LITLE INTO BOOK_NAME FROM BOOKS WHERE ISBN=ISBN_BOOK2;
INSERT INTO RETURNSTATUS(RETURN_ID,RETURN_CUST,RETURN_BOOK_NAME,RETURN_DATE,ISBN_BOOK2)
VALUES(RETURN_ID,RETURN_CUST,RETURN_BOOK_NAME,NOW(),ISBN_BOOK2);
END $$
DELIMITER ;

CALL insert_return_status('1','KKKK','ABCD','18-11-2020','3')
CALL insert_return_status('2','KKKK','ABCD','20-06-2023','2')
CALL insert_return_status('3','RRRR','WWWW','26-04-2019','1')
CALL insert_return_status('4','SSSS','XXXX','17-09-2021','4')
call insert_return_status('5','QQQQ','YYYY','21-01-2022','5')

DELIMITER $$
CREATE TRIGGER after_insert_return_status
after INSERT ON ReturnStatus
FOR EACH ROW
BEGIN
 update books set status='yes' where isbn=new.Isbn_book2;
END $$
DELIMITER ;

SELECT * FROM ReturnStatus;


CREATE TABLE Books (
  ISBN VARCHAR(20) PRIMARY KEY,
  Book_title VARCHAR(100),
  Category VARCHAR(50),
  Rental_Price DECIMAL(10, 2),
  Status VARCHAR(3),
  Author VARCHAR(50),
  Publisher VARCHAR(50)
);

CREATE PROCEDURE INSERT_BOOKS(IN BOOK_TITLE VARCHAR(60),IN CATEGORY VARCHAR(60),IN RENTAL_PRICE FLOAT,IN STATUS VARCHAR(6),
IN AUTHOR VARCHAR(60),IN PUBLISHER VARCHAR(60))
INSERT INTO BOOKS(BOOK_LITLE,CATEGORY,RENTAL_PRICE,STATUS,AUTHOR,PULISHER)
VALUES(BOOK_TITLE,CATEGORY,RENTAL_PRICE,STATUS,AUTHOER,PUBLISHER);

call insert_books('Book1','category1',150,'yes','Author1','Publisher1');
Call insert_books('Book2','category2',150,'yes','Author2','Publisher2');
call insert_books('Book3','category3',100,'yes','Author3','Publisher3');
call insert_books('Book4','category4',100,'yes','Author4','Publisher4');
call insert_books('Book5','category5',200,'yes','Author5','Publisher5');

SELECT * FROM Books;


SELECT Book_title, Category, Rental_Price
FROM Books
WHERE Status = 'yes';

SELECT Emp_name, Salary
FROM Employee
ORDER BY Salary DESC;

-- 3. Retrieve the book titles and the corresponding customers who have issued those books.
SELECT b.Book_title, c.Customer_name
FROM IssueStatus i
JOIN Books b ON i.Isbn_book = b.ISBN
JOIN Customer c ON i.Issued_cust = c.Customer_Id;

-- 4. Display the total count of books in each category.
SELECT Category, COUNT(*) AS Total_Count
FROM Books
GROUP BY Category;

-- 5. Retrieve the employee names and their positions for the employees whose salaries are above Rs. 50,000.
SELECT Emp_name, Position
FROM Employee
WHERE Salary > 50000;

-- 6. List the customer names who registered before 2022-01-01 and have not issued any books yet.
SELECT Customer_name
FROM Customer
WHERE Reg_date < '2022-01-01'
AND Customer_Id NOT IN (SELECT DISTINCT Issued_cust FROM IssueStatus);

-- 7. Display the branch numbers and the total count of employees in each branch.
SELECT Branch_no, COUNT(*) AS Total_Employees
FROM Employee
GROUP BY Branch_no;

-- 8. Display the names of customers who have issued books in the month of June 2023.
SELECT DISTINCT c.Customer_name
FROM Customer c
JOIN IssueStatus i ON c.Customer_Id = i.Issued_cust
WHERE YEAR(i.Issue_date) = 2023 AND MONTH(i.Issue_date) = 6;

-- 9. Retrieve book_title from the book table containing the word "history".
SELECT Book_title
FROM Books
WHERE Category LIKE '%history%';

-- 10. Retrieve the branch numbers along with the count of employees for branches having more than 5 employees.
SELECT Branch_no, COUNT(*) AS Total_Employees
FROM Employee
GROUP BY Branch_no
HAVING COUNT(*) > 5;