#1
SELECT 
s.names
FROM 
Students s
JOIN 
packages p USING (id)
JOIN
Friends f using (id)
JOIN 
Packages p2 on f.friend_id = p2.id 
where 
p.salary < p2.salary 
order by p2.salary ;

#2 
SELECT 
product_name
FROM 
Sales 
JOIN 
product USING (product_id)
GROUP BY 
product_id 
HAVING 
min(sale_date) >= date('2019-01-01') AND max(sale_date) <=date('2019-03-31')
;

#3 
With employeeRank as (
SELECT 
e.*,
DENSE_RANK() OVER (PARTITION BY e.departmentID ORDER BY e.salary DESC)
AS RNK
FROM 
Employee e 
)
SELECT 
d.name as Department,
e.name as Employee,
e.salary as salary
from employeeRank
JOIN Department d 
on departmentid = d.id 
where e.rnk <= 3 
;

-- # 4design a database for youtube 
-- # write a SQL query to find the Top 3 Youtube Channels by video views. 
-- # Write a DML query to subscribe to channel handle jayzern

CREATE TABLE Videos(
    videoid INTEGER PRIMARY KEY,
    title VARCHAR(100),
    desciption TEXT , 
    thumbnail BLOB,
    views INTEGER,
    likes INTEGER,
    channelID VARCHAR (50),
    FOREIGN KEY(channelID) REFERENCES (channelID)
);

CREATE TABLE Channels (
    channelID VARCHAR (50)PRIMARY KEY,
    subscribers INTEGER,
    dateJoined DATE,
);

CREATE TABLE Subscribers(
    channelID VARCHAR(50), 
    subscribedTo VARCHAR(50),
    FOREIGN KEY (channelId) REFERENCES Channels (channelID),
    FOREIGN KEY (subscribedTo) REFERENCES Channels (channelID),
    PRIMARY KEY (channelID, subscribedTo)
);

#Find the top3 youtube channels by views
SELECT 
c.channelID,
SUM(v.views) as totalviews
FROM 
Channels c
JOIN 
Videos v 
on c.channelID = v.channelID
GROUP BY  c.channelID
ORDER BY totalViews DESC
LIMIT 3
;

#Write a DML query to subscribe to jayzern
BEGIN TRANSACTION;
UPDATE Channels 
SET subscribers = subscribers +1 
WHERE channelID = "jayzern"

INSERT Subscribers 
VALUES ("you","jayzern")

COMMIT;

##################################################

-- Given the reviews table, write a query to retrieve the average star rating for each product, grouped by month. The output should display the month as a numerical value, product ID, and average star rating rounded to two decimal places. Sort the output first by month and then by product ID.
SELECT 
EXTRACT(MONTH FROM submit_date) as mth, 
product_id,
round(avg(stars),2) as avg_stars 
FROM reviews
group by mth,product_id
order by mth, product_id

-- #submit_date datetime format 06/08/2022 00:00:00 

--Given a table of Facebook posts, for each user who posted at least twice in 2021, write a query to find the number of days between each user’s first post of the year and last post of the year in the year 2021. Output the user and number of the days between each user's first and last post.
WITH user_post_dates AS (
    SELECT 
        user_id, 
        MIN(post_date) AS first_post_date, 
        MAX(post_date) AS last_post_date
    FROM 
        posts
    WHERE 
        EXTRACT(YEAR FROM post_date) = 2021
    GROUP BY 
        user_id
    HAVING 
        COUNT(*) >= 2
)

SELECT 
    user_id, 
    EXTRACT(DAY FROM (last_post_date - first_post_date)) AS days_between_first_last
FROM 
    user_post_dates;

--with () create table,  


def maximum_product_of_three(nums):
    products = []
    n = len(nums)
    for i in range(n):
        for j in range(i + 1, n):
            for k in range(j + 1, n):
                products.append(nums[i] * nums[j] * nums[k])
    products.sort()
    return products[-1]

# Examples
A = [1, 3, 4, 5]
B = [-4, -2, 3, 5]
print(maximum_product_of_three(A))  # Output: 60
# print(maximum_product_of_three(B))  # Output: 40