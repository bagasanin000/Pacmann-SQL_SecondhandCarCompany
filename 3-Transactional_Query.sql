-- TRANSACTIONAL QUERY

-- Soal 1 - Mencari mobil keluaran 2015 ke atas
SELECT 
	car_id,
	brand,
	model,
	year,
	price
FROM 
	cars
WHERE 
	year >= 2015;

-- Soal 2 - Menambahkan satu data bid produk baru
INSERT INTO 
	bids
VALUES
	('B-051', 44, 8, 155550000, '2024-05-11', true);

SELECT * 
FROM 
	bids
ORDER BY
	bid_id DESC
LIMIT 5;

-- Soal 3 - Melihat semua mobil yg dijual salah satu akun dari yg paling baru
WITH car_ads AS (
SELECT 
	a.user_id,
	a.car_id,
	c.brand,
	c.model,
	c.year,
	c.price,
	a.date_post
FROM ads as a
JOIN cars as c
ON a.car_id = c.car_id
)

SELECT 
	u.user_id,
	u.name,
	ca.car_id,
	ca.brand,
	ca.model,
	ca.year,
	ca.price,
	ca.date_post
FROM car_ads as ca
JOIN users as u
ON ca.user_id = u.user_id
WHERE 
	u.name = 'Zelda Suryono';

-- Soal 4 - Mencari mobil bekas termurah berdasarkan keyword
SELECT 
	*
FROM 
	cars
WHERE 
	model LIKE '%Yaris%';

-- Soal 5 - Mencari mobil bekas yang terdekat berdasarkan sebuah id kota
-- euclidean function
CREATE FUNCTION euclidean_distance(
    lat1 FLOAT, lon1 FLOAT, 
    lat2 FLOAT, lon2 FLOAT
) RETURNS FLOAT AS $$
DECLARE
    -- Define the conversion factor for latitude and longitude to distance in meters
    lat_conv FLOAT := 111320.0; -- Approximate conversion factor for latitude in meters
    lon_conv FLOAT := 40008000.0 / 360.0 * COS(RADIANS((lat1 + lat2) / 2)); -- Approximate conversion factor for longitude in meters
BEGIN
    -- Calculate the difference in latitudes and longitudes
    RETURN SQRT(
        POWER((lat2 - lat1) * lat_conv, 2) + 
        POWER((lon2 - lon1) * lon_conv, 2)
    );
END;
$$ LANGUAGE plpgsql;

-- querynya
WITH current_city AS (
	SELECT 
		latitude, 
		longitude,
		location_id
	FROM 
		locations 
	WHERE
		location_id='3173'
)
SELECT 
	c.car_id,
	c.brand,
	c.model,
	c.year,
	c.price,
	euclidean_distance(cc.latitude, cc.longitude, l.latitude, l.longitude)
FROM 
	ads a
JOIN
	locations l
	ON a.location_id = l.location_id	
JOIN
	cars c
	ON a.car_id = c.car_id
JOIN 
	current_city cc
	ON a.location_id = cc.location_id;