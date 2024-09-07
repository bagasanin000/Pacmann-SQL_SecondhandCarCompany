# #LearnDataWithPacmann - SQL: Creating and Designing Relational Database of Secondhand Car Sales Company

**Tools: PostgreSQL and pgAdmin4 (and Python).**
## Project Requirements
The general description of this project is that anyone can offer their products (secondhand cars) in the form of advertisements and potential buyers can search based on several categories. Here are the features and limitations of this project:
- Each user can offer more than one secondhand car.
- Before selling their car, users must complete their personal data first, such as name, contact and location domicile.
- Users offer their car through advertisements that will be displayed on the website.
- This advertisement contains the title, detailed information about the product being offered, as well as the seller's contact.
- Some information that must be written in the advertisement, such as car brands, model, body type, transmission, year of its manufacture, and other descriptions if needed.
- Each user can search for cars on offer based on the seller's user location, car brand, and car body type.
- If a potential buyer is interested in a car, they can bid on the product price if the seller allows the bargaining feature.
- Purchase transaction is done outside the application, so it is not in the project's scope.

## Designing the Database
### 1. Mission Statement
To create a relational database for a website that facilitates the sale of secondhand cars by allowing users to post advertisements and prospective buyers to search for vehicles based on various criteria. The database will store user details, vehicle information, and bidding activities.
### 2. Creating Table Structures
![image](https://github.com/user-attachments/assets/7cb23658-733e-42fd-9843-a41cfb14570f)

### 3. Determine Table Relationship
- **Users to Locations:** Many-to-One (One user lives in one location).
- **Ads to Users:** Many-to-One (One ad placed by one user).
- **Ads to Cars:** Many-to-One (One ad related to one car).
- **Ads to Locations:** Many-to-One (One ad located in one location).
- **Bids to Ads:** Many-to-One (One bid associated with one ad).
- **Bids to Users:** Many-to-One (One bid placed by one user).

![image](https://github.com/user-attachments/assets/1512ed75-ae42-426f-9ffd-03e1f2a409b7)

### 4. Determine Business Rules
![image](https://github.com/user-attachments/assets/7b345490-3101-4f04-a0d3-8b71e6903870)

## Syntax DDL
```
-- Create Locations table
CREATE TABLE Locations (
    location_id SERIAL NOT NULL,
    city_name VARCHAR(255) NOT NULL,
    longitude DECIMAL(9,6) NOT NULL,
    latitude DECIMAL(9,6) NOT NULL,
	PRIMARY KEY (location_id)
);

-- Create Users table
CREATE TABLE Users (
    user_id SERIAL NOT NULL,
    name VARCHAR(255) NOT NULL,
    phone VARCHAR(255) NOT NULL,
    address VARCHAR(255) NOT NULL,
    location_id INT NOT NULL,
	PRIMARY KEY (user_id),
    CONSTRAINT fk_location_id
		FOREIGN KEY (location_id) 
		REFERENCES Locations(location_id)
);


-- Create Cars table
CREATE TABLE Cars (
    car_id SERIAL NOT NULL,
    brand VARCHAR(255) NOT NULL,
    model VARCHAR(255) NOT NULL,
    body_type VARCHAR(255) NOT NULL,
    transmission VARCHAR(255) NOT NULL,
    year INT NOT NULL,
    description TEXT,
    price DECIMAL(12, 0) NOT NULL,
	PRIMARY KEY (car_id)
);

-- Create Ads table
CREATE TABLE Ads (
    ad_id SERIAL NOT NULL,
    title VARCHAR(255) NOT NULL,
	date_post DATE NOT NULL,
    car_id INT,
    user_id INT,
    location_id INT,
	PRIMARY KEY (ad_id),
	CONSTRAINT fk_car_id
    	FOREIGN KEY (car_id)
		REFERENCES Cars(car_id),
	CONSTRAINT fk_user_id
    	FOREIGN KEY (user_id)
		REFERENCES Users(user_id),
	CONSTRAINT fk_location_id
		FOREIGN KEY (location_id)
		REFERENCES Locations(location_id)
);

-- Create Bids table
CREATE TABLE Bids (
    bid_id VARCHAR(255) NOT NULL,
    ad_id INT,
    user_id INT,
    bid_amount DECIMAL(12, 0) NOT NULL,
    bid_date DATE NOT NULL,
    bid_status BOOLEAN NOT NULL,
	PRIMARY KEY (bid_id),
	CONSTRAINT fk_ad_id
    	FOREIGN KEY (ad_id)
		REFERENCES Ads(ad_id),
    CONSTRAINT fk_user_id
		FOREIGN KEY (user_id)
		REFERENCES Users(user_id)
);
```

## Create Dummy Dataset
Dummy dataset created using Python and some its additional libraries. You can access the code from file `2-CREATE_DUMMY_DATA.ipynb` above. Then, you can import it via Query Tools using code below.
```
- Import locations dummy data
COPY
 locations(
  location_id,
  city_name,
  latitude,
  longitude
 )
FROM
 'dummy\cities_table.csv'
DELIMITER ','
CSV
HEADER;

-- Import users dummy data
COPY
 users(
  user_id,
  name,
  phone,
  address,
  location_id
 )
FROM
 'dummy\users_table.csv'
DELIMITER ','
CSV
HEADER;

-- Import cars dummy data
COPY
 cars(
  car_id,
  brand,
  model,
  body_type,
  year,
  price,
  transmission,
  description
 )
FROM
 'dummy\cars_table.csv'
DELIMITER ','
CSV
HEADER;

-- Import ads dummy data
COPY
 ads(
  ad_id,
  title,
  date_post,
  car_id,
  user_id,
  location_id
 )
FROM
 'dummy\ads_table.csv'
DELIMITER ','
CSV
HEADER;

-- Import bids dummy data
COPY
 bids(
  bid_id,
  ad_id,
  user_id,
  bid_amount,
  bid_date,
  bid_status
 )
FROM
 'dummy\bids_table.csv'
DELIMITER ','
CSV
HEADER;
```

## Example Query
1. Find the cheapest car by searching for "Yaris" as the keyword.
```
SELECT 
 c.car_id, 
 c.brand,
 c.model,
 c.price,
 a.title,
 a.date_post,
 u.name,
 l.city_name
FROM 
 cars c
JOIN 
 ads a
 ON c.car_id = a.car_id
JOIN 
 users u
 ON a.user_id = u.user_id
JOIN 
 locations l
 ON a.location_id = l.location_id
WHERE 
 c.model ILIKE '%Yaris%'
ORDER BY 
 c.price ASC;
```

2. Comparing the car's price with the average price per city.
```
WITH ad_car AS (
 SELECT
  a.car_id,
  l.city_name
 FROM
  ads a
 JOIN 
  locations l
 ON 
  a.location_id = l.location_id
)

SELECT 
 ac.city_name,
 c.brand,
 c.model,
 c.year,
 c.price,
 ROUND(AVG(c.price) OVER (PARTITION BY ac.city_name)) AS avg_car_city 
FROM 
 ad_car ac
JOIN
 cars c
ON 
 ac.car_id = c.car_id
ORDER BY
 avg_car_city DESC;
```

3. Sort all car models based on their popularity, referring to the number of bids received.
```
WITH ad_bid AS(
 SELECT
  a.car_id,
  b.bid_status
 FROM
  ads a
 JOIN 
  bids b
 ON 
  a.ad_id = b.ad_id
)

SELECT 
 c.model,
 COUNT(c.car_id) AS count_product,
 COUNT(ab.bid_status) AS count_bid
FROM 
 cars c
JOIN
 ad_bid ab
ON 
 c.car_id = ab.car_id
WHERE 
 bid_status = true
GROUP BY
 1
ORDER BY
 3 DESC
LIMIT
 5;
```
