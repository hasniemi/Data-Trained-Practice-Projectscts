# DSML # MYSQL-project

You are going to build a project based on Library Management System. It keeps
track all information about books in the library, their cost, status and total
number of books available in the library.
Create a database named library and create following TABLES in the database:
1. Branch
2. Employee
3. Customer
4. IssueStatus
5. ReturnStatus
6. Books


Attributes for the tables:

1. Branch
âˆ™Branch_no - Set as PRIMARY KEY
âˆ™Manager_Id
âˆ™Branch_address
âˆ™Contact_no

3. Employee
âˆ™Emp_Id â€“ Set as PRIMARY KEY
âˆ™Emp_name
âˆ™Position
âˆ™Salary
âˆ™Branch_no - Set as FOREIGN KEY and it should refer branch_no in
EMPLOYEE table

5. Customer
âˆ™Customer_Id - Set as PRIMARY KEY
âˆ™Customer_name
âˆ™Customer_address
âˆ™Reg_date

4.IssueStatus
âˆ™Issue_Id - Set as PRIMARY KEY
âˆ™Issued_cust â€“ Set as FOREIGN KEY and it refer customer_id in
CUSTOMER table
âˆ™Issued_book_name
âˆ™Issue_date
âˆ™Isbn_book â€“ Set as FOREIGN KEY and it should refer isbn in
BOOKS table

7. ReturnStatus
âˆ™Return_Id - Set as PRIMARY KEY
âˆ™Return_cust
âˆ™Return_book_name
âˆ™Return_date
âˆ™Isbn_book2 - Set as FOREIGN KEY and it should refer isbn in
BOOKS table

9. Books
âˆ™ISBN - Set as PRIMARY KEY
âˆ™Book_title
âˆ™Category
âˆ™Rental_Price
âˆ™Status [Give yes if book available and no if book not available] âˆ™
Author
âˆ™Publisher

Write the queries for the following:

1. Retrieve the book title, category, and rental price of all available
books.
2. List the employee names and their respective salaries in descending
order of salary.
3. Retrieve the book titles and the corresponding customers who have
issued those books.
4. Display the total count of books in each category.
5. Retrieve the employee names and their positions for the employees
whose salaries are above Rs.50,000.
6. List the customer names who registered before 2022-01-01 and have
not issued any books yet.
7. Display the branch numbers and the total count of employees in each
branch.
8. Display the names of customers who have issued books in the month
of June 2023.
9. Retrieve book_title from book table containing history.
10.Retrieve the branch numbers along with the count of employees for branches
   having more than 5 employees.
- MYSQL
