
/* ============================= */
/* Base SAS Data Analysis Project */
/* ============================= */

/* 1. Create dataset */
data sales_data;
input ID Name $ Age Region $ Sales;
datalines;
1 John 34 North 500
2 Mary 29 South 700
3 Peter 45 East 800
4 Alice 38 West 650
5 John 34 North 500
6 David . South 400
7 Sarah 31 East 900
8 Michael 40 West 0
9 James 28 North 300
10 Linda 36 South 750
;
run;

/* 2. Clean data */
data clean_sales;
set sales_data;

if ID = 5 then delete; /* remove duplicate */

if Age = . then Age = 0;

/* derive performance category */
if Sales >= 700 then Performance = "High";
else if Sales >= 500 then Performance = "Medium";
else Performance = "Low";
run;

/* 3. Summary statistics */
proc means data=clean_sales mean min max;
var Sales Age;
run;

/* 4. Frequency tables */
proc freq data=clean_sales;
tables Region Performance;
run;

/* 5. SQL aggregation */
proc sql;
select Region,
       count(*) as Total_Records,
       avg(Sales) as Avg_Sales
from clean_sales
group by Region;
quit;
