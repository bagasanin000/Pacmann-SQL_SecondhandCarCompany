-- Import locations dummy data
COPY
	locations(
		location_id,
		city_name,
		latitude,
		longitude
	)
FROM
	'D:\# DATA\Courses\Pacmann Academy - DE 2024\2 PostgreSQL and Relational Database\# final project\dummy\cities_table.csv'
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
	'D:\# DATA\Courses\Pacmann Academy - DE 2024\2 PostgreSQL and Relational Database\# final project\dummy\users_table.csv'
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
	'D:\# DATA\Courses\Pacmann Academy - DE 2024\2 PostgreSQL and Relational Database\# final project\dummy\cars_table.csv'
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
	'D:\# DATA\Courses\Pacmann Academy - DE 2024\2 PostgreSQL and Relational Database\# final project\dummy\ads_table.csv'
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
	'D:\# DATA\Courses\Pacmann Academy - DE 2024\2 PostgreSQL and Relational Database\# final project\dummy\bids_table.csv'
DELIMITER ','
CSV
HEADER;
