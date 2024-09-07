-- ANALYTICAL QUERY

-- Soal 1 - Ranking popularitas model mobil berdasarkan jumlah bid
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



-- Soal 2 - Membandingkan harga mobil berdasarkan harga rata2 per kota
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



-- Soal 3 - Membandingkan tgl bid user dengan bid selanjutnya
WITH ranked_bid AS (
    SELECT 
        b.bid_id,
        b.user_id,
        b.bid_amount,
        b.bid_date,
        c.model,
        b.ad_id,
        LAG(b.bid_date) OVER (PARTITION BY b.user_id, c.model ORDER BY b.bid_date) AS previous_bid_date,
        LAG(b.bid_amount) OVER (PARTITION BY b.user_id, c.model ORDER BY b.bid_date) AS previous_bid_amount
    FROM 
        bids b
    JOIN 
        ads a 
        ON b.ad_id = a.ad_id
    JOIN 
        cars c 
        ON a.car_id = c.car_id
)
SELECT 
    model,
	user_id,
	previous_bid_date AS first_bid_date,
	bid_date AS next_bid_date,
    previous_bid_amount AS first_bid_price,
	bid_amount AS next_bid_price
FROM 
    ranked_bid
WHERE 
    previous_bid_date IS NOT NULL
ORDER BY 
    user_id, bid_date;



-- Soal 4 - Membandingkan persentase perbedaan rata2 mobil berdasarkan modelnya 
-- dan rata-rata harga bid yang ditawarkan oleh customer pada 6 bulan terakhir
WITH avg_prices AS (
    SELECT
        model,
        AVG(price) AS avg_price
    FROM
        cars
    GROUP BY
        model
),
avg_bid_6month AS (
    SELECT
        c.model,
        AVG(b.bid_amount) AS avg_bid_6month
    FROM 
        ads a
    JOIN 
        cars c 
        ON a.car_id = c.car_id
    JOIN 
        bids b 
        ON a.ad_id = b.ad_id
    WHERE
        b.bid_date >= CURRENT_DATE - INTERVAL '6 months'
    GROUP BY
        c.model
),
price_vs_bid AS (
    SELECT
        ap.model,
        ap.avg_price,
        COALESCE(ab.avg_bid_6month, 0) AS avg_bid_6month,
        COALESCE(ab.avg_bid_6month, 0) - ap.avg_price AS difference,
        CASE
            WHEN ap.avg_price = 0 THEN 0
            ELSE (COALESCE(ab.avg_bid_6month, 0) - ap.avg_price) * 100.0 / ap.avg_price
        END AS difference_percent
    FROM
        avg_prices ap
    LEFT JOIN
        avg_bid_6month ab
    ON
        ap.model = ab.model
)
SELECT
    model,
    ROUND(avg_price) AS avg_price,
    ROUND(avg_bid_6month) AS avg_bid_6month,
    ROUND(difference) AS difference,
    difference_percent
FROM
    price_vs_bid
ORDER BY
    model;



-- Soal 5 - Membuar window function rata2 bid sebuah merk 
-- dan model mobil selama 6 bulan terakhir
WITH bid_details AS (
    SELECT
        b.bid_amount,
        c.brand,
        c.model,
        DATE_TRUNC('month', a.date_post) AS month_start
    FROM
        bids b
    JOIN
        ads a ON b.ad_id = a.ad_id
    JOIN
        cars c ON a.car_id = c.car_id
    WHERE
        a.date_post >= DATE_TRUNC('month', CURRENT_DATE) - INTERVAL '6 months'
),
ranked_bids AS (
    SELECT
        brand,
        model,
        month_start,
        bid_amount,
        ROW_NUMBER() OVER (PARTITION BY brand, model, month_start ORDER BY month_start DESC) AS rn
    FROM
        bid_details
),
monthly_avg AS (
    SELECT
        brand,
        model,
        month_start,
        AVG(bid_amount) OVER (PARTITION BY brand, model, month_start) AS avg_bid_amount
    FROM
        ranked_bids
)

SELECT
    brand,
    model,
    ROUND(AVG(CASE WHEN month_start = DATE_TRUNC('month', CURRENT_DATE) - INTERVAL '5 month' THEN avg_bid_amount END)) AS m_min_6,
	ROUND(AVG(CASE WHEN month_start = DATE_TRUNC('month', CURRENT_DATE) - INTERVAL '4 month' THEN avg_bid_amount END)) AS m_min_5,
	ROUND(AVG(CASE WHEN month_start = DATE_TRUNC('month', CURRENT_DATE) - INTERVAL '3 month' THEN avg_bid_amount END)) AS m_min_4,
	ROUND(AVG(CASE WHEN month_start = DATE_TRUNC('month', CURRENT_DATE) - INTERVAL '2 month' THEN avg_bid_amount END)) AS m_min_3,
	ROUND(AVG(CASE WHEN month_start = DATE_TRUNC('month', CURRENT_DATE) - INTERVAL '1 month' THEN avg_bid_amount END)) AS m_min_2,
	ROUND(AVG(CASE WHEN month_start = DATE_TRUNC('month', CURRENT_DATE) - INTERVAL '0 month' THEN avg_bid_amount END)) AS m_min_1    
FROM
    monthly_avg
-- WHERE
-- 	model = 'Daihatsu Xenia'
GROUP BY
    brand, model
ORDER BY
    brand, model;

