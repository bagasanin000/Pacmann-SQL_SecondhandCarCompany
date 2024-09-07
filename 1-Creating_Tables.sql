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