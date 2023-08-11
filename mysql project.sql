CREATE DATABASE Library;
USE Library;

CREATE TABLE Branch
(
  Branch_no INT PRIMARY KEY,
  Manager_Id INT,
  Branch_address VARCHAR(50),
  Contact_no INT
);

INSERT INTO Branch(Branch_no, Manager_Id, Branch_address, Contact_no) VALUES
(1, 001, 'Kozhikode', 987654321),
(2, 002, 'Ernakulam', 987224321),
(3, 003, 'Kannur', 765342189),
(4, 004, 'Wayanad', 876543290),
(5, 005, 'Kasargod', 876523190);

CREATE TABLE Employee
(
  Emp_Id INT PRIMARY KEY,
  Emp_name VARCHAR(30),
  Position VARCHAR(30),
  Salary DECIMAL(10, 2)
);

INSERT INTO Employee(Emp_Id, Emp_name, Position, Salary) VALUES
(001, 'Aneesha', 'Area Manager', 21000.00),
(002, 'Honey', 'Manager', 30000.00),
(003, 'Ayana', 'Clerk', 16000.00),
(004, 'Sarang', 'Assistant', 23000.00),
(005, 'Mohan', 'Director', 29000.00);

CREATE TABLE Customer
(
  Customer_Id INT PRIMARY KEY,
  Customer_name VARCHAR(30),
  Customer_address VARCHAR(50),
  Reg_date DATE
);

INSERT INTO Customer(Customer_Id, Customer_name, Customer_address, Reg_date) VALUES
(1, 'Megha', 'Karnataka', '2022-10-12'),
(2, 'Harsha', 'Kochi', '2022-05-03'),
(3, 'Thanu', 'Angamaly', '2021-10-09'),
(4, 'Jermia', 'Kelakam', '2022-09-09'),
(5, 'Viji', 'Annachal', '2022-12-01');

CREATE TABLE Books
(
  ISBN VARCHAR(50) PRIMARY KEY,
  Book_title VARCHAR(50),
  Category VARCHAR(50),
  Rental_Price DECIMAL(10, 2),
  Status VARCHAR(20),
  Author VARCHAR(50),
  Publisher VARCHAR(50)
);

INSERT INTO Books(ISBN, Book_title, Category, Rental_Price, Status, Author, Publisher) VALUES
('ISBN001', 'Gullivers Travel', 'Fiction', 9.85, 'Available', 'Oliver Twist', 'Modern Library; Onix edition '),
('ISBN002', 'Gullivers Travel', 'Fantasy Fiction', 7.99, 'Available', 'Paulo Coelho', 'yph Publishers'),
('ISBN003', 'Pride and Prejudice', 'Comedy', 9.09, 'Available', 'Jane Austen', 'Classics'),
('ISBN004', 'Wings of fire', 'Autobiography', 9.99, 'Unavailable', 'Dr. A.P.J Abdul Kalam', 'Novel edition'),
('ISBN005', 'Harry potter', 'Fantasy Fiction', 10.99, 'Available', 'J.K Rowling', 'Simon editors');

CREATE TABLE IssueStatus
(
  Issue_Id INT PRIMARY KEY,
  Issued_cust INT,
  Issued_book_name VARCHAR(30),
  Issue_date DATE,
  Isbn_book VARCHAR(30),
  FOREIGN KEY (Issued_cust) REFERENCES Customer(Customer_Id),
  FOREIGN KEY (Isbn_book) REFERENCES Books(ISBN)
);

INSERT INTO IssueStatus(Issue_Id, Issued_cust, Issued_book_name, Issue_date, Isbn_book) VALUES
(1, 1,'Gullivers Travel' , '2023-01-13', 'ISBN001'),
(2, 2, 'Gullivers Travel', '2023-02-14', 'ISBN002'),
(3, 3, 'Pride and Prejudice', '2023-08-22', 'ISBN003'),
(4, 4, 'Wings of fire', '2023-02-01', 'ISBN004'),
(5, 5,  'Harry potter','2023-07-11', 'ISBN005');

CREATE TABLE ReturnStatus
(
  Return_Id INT PRIMARY KEY,
  Return_cust INT,
  Return_book_name VARCHAR(30),
  Return_date DATE,
  Isbn_book2 VARCHAR(30),
  FOREIGN KEY (Return_cust) REFERENCES Customer(Customer_Id),
  FOREIGN KEY (Isbn_book2) REFERENCES Books(ISBN)
);

INSERT INTO ReturnStatus(Return_Id, Return_cust, Return_book_name, Return_date, Isbn_book2) VALUES
(1, 1, 'Gullivers Travel', '2023-07-29', 'ISBN001'),
(2, 2, 'Gullivers Travel', '2023-01-20', 'ISBN002'),
(3, 3,  'Pride and Prejudice', '2023-01-20', 'ISBN003'),
(4, 4,'Wings of Fire', '2023-08-11', 'ISBN004'),
(5, 5, 'Harry potter' , '2023-02-02', 'ISBN005');

SELECT * FROM Branch;
SELECT * FROM Employee;
SELECT * FROM Customer;
SELECT * FROM Books;
SELECT * FROM IssueStatus;
SELECT * FROM ReturnStatus;

/* 1. Retrieve the book title, category, and rental price of all available books. */

SELECT Book_title, Category, Rental_Price FROM Books WHERE Status = 'Available';

/* 2. List the employee names and their respective salaries in descending order of salary. */

SELECT Emp_name, Salary FROM Employee ORDER BY Salary DESC;

/* 3. Retrieve the book titles and the corresponding customers who have issued those books. */

SELECT i.Issued_book_name, c.Customer_name FROM IssueStatus i
JOIN Customer c ON i.Issued_cust = c.Customer_Id;

/* 4. Display the total count of books in each category. */

SELECT Category, COUNT(*) AS Total_count_of_books FROM Books GROUP BY Category;

/* 5. Retrieve the employee names and their positions for the employees whose salaries are above Rs.12,000. */

SELECT Emp_name, Position, Salary FROM Employee WHERE Salary > 50000.00;

/* 6. List the customer names who registered before 2022-01-01 and have not issued any books yet. */

SELECT Customer_name FROM Customer
WHERE Reg_date < '2022-01-01' AND Customer_Id NOT IN (SELECT Issued_cust FROM IssueStatus);

/* 7. Display the branch numbers and the total count of employees in each branch. */

SELECT BRANCH_NO,count(*) AS total_count FROM BRANCH INNER JOIN EMPLOYEE ON BRANCH.MANAGER_ID=EMPLOYEE.EMP_ID GROUP BY BRANCH_NO;


/* 8. Display the names of customers who have issued books in the month of June 2023. */

SELECT CUSTOMER_NAME FROM CUSTOMER INNER JOIN ISSUESTATUS ON 
CUSTOMER.CUSTOMER_ID=ISSUESTATUS.ISSUED_CUST WHERE EXTRACT(YEAR_MONTH FROM ISSUE_DATE)='202012';

/* 9. Retrieve book_title from book table containing 'history'. */

Select Book_title, category from books where category='History';


/* 10. Retrieve the branch numbers along with the count of employees for branches having more than 5 employees. */

Select Branch_no, COUNT(*) AS Total_Count FROM BRANCH JOIN EMPLOYEE  ON BRANCH .MANAGER_ID= EMPLOYEE.EMP_ID
GROUP BY Branch_no HAVING Total_Count > 5;
