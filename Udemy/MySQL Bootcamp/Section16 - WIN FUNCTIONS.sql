-- CREATE TABLE employees (
--     emp_no INT PRIMARY KEY AUTO_INCREMENT,
--     department VARCHAR(20),
--     salary INT
-- );
 
-- INSERT INTO employees (department, salary) VALUES
-- ('engineering', 80000),
-- ('engineering', 69000),
-- ('engineering', 70000),
-- ('engineering', 103000),
-- ('engineering', 67000),
-- ('engineering', 89000),
-- ('engineering', 91000),
-- ('sales', 59000),
-- ('sales', 70000),
-- ('sales', 159000),
-- ('sales', 72000),
-- ('sales', 60000),
-- ('sales', 61000),
-- ('sales', 61000),
-- ('customer service', 38000),
-- ('customer service', 45000),
-- ('customer service', 61000),
-- ('customer service', 40000),
-- ('customer service', 31000),
-- ('customer service', 56000),
-- ('customer service', 55000);


SELECT department, AVG(salary)
FROM employees
GROUP BY department;

SELECT department,
AVG(salary) OVER() #Calculte and give on the side of each row
FROM employees;


SELECT department,
AVG(salary) OVER() AS total_avg,
AVG(salary) OVER(PARTITION BY department) AS department_avg #Calculte by... and give on the side of each row
FROM employees;

-- ORDER BY INSIDE OVER

SELECT department,salary,
SUM(salary) OVER(PARTITION BY department ORDER BY salary)
FROM employees;

-- RANK() 
# ranking columns of salary by the greatest to the lowest
SELECT emp_no,department, salary,
RANK() OVER(ORDER BY salary DESC) AS overall_rank
FROM employees;

SELECT emp_no,department, salary,
RANK() OVER(PARTITION BY department ORDER BY salary DESC) AS overall_rank
FROM employees;

-- ROW_NUMBER() AND DENSE_RANK()

SELECT 
    emp_no, 
    department, 
    salary,
    ROW_NUMBER() OVER(ORDER BY salary DESC) as overall_num,
    ROW_NUMBER() OVER(PARTITION BY department ORDER BY SALARY DESC) as dept_row_number,
    
    RANK() OVER(PARTITION BY department ORDER BY SALARY DESC) as dept_salary_rank,
    
    RANK() OVER(ORDER BY salary DESC) as overall_rank,
    DENSE_RANK() OVER(ORDER BY salary DESC) as overall_dense_rank
    
FROM employees ORDER BY overall_rank;


