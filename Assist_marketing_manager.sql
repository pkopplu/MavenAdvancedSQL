use mavenfuzzyfactory;

SELECT 
    utm_source,
    utm_campaign,
    http_referer,
    COUNT(DISTINCT website_session_id) AS sessions
FROM
    website_sessions
WHERE
    created_at < '2012-04-12'
GROUP BY utm_source , utm_campaign , http_referer
ORDER BY sessions desc;

-- asignment 2
SELECT 
    COUNT(distinct w.website_session_id) AS sessions,
    COUNT(distinct o.order_id) AS orders,
    COUNT(distinct o.order_id) * 100.0 / COUNT(distinct w.website_session_id) AS session_to_order_conv_rate
FROM
    website_sessions w
        LEFT JOIN
    orders o ON w.website_session_id = o.website_session_id
WHERE
    w.utm_source = 'gsearch'
        AND w.utm_campaign = 'nonbrand'
        and w.created_at <'2012-04-14';
/* assignment-3*/
SELECT 
    MIN(DATE(created_at)) AS week_start_date,
    COUNT(website_session_id) AS numer_of_sessions
FROM
    website_sessions
WHERE
    created_at < '2012-05-10'
        AND utm_source = 'gsearch'
        AND utm_campaign = 'nonbrand'
GROUP BY WEEK(created_at) , YEAR(created_at);
-- assignment 4
SELECT 
    device_type,
    COUNT(DISTINCT w.website_session_id) AS sessions,
    COUNT(DISTINCT o.order_id) AS orders,
    COUNT(DISTINCT o.order_id) / COUNT(DISTINCT w.website_session_id) AS conversion_rate
FROM
    website_sessions w
        LEFT JOIN
    orders o ON w.website_session_id = o.website_session_id
WHERE
    w.created_at < '2012-05-11'
        AND w.utm_source = 'gsearch'
        AND w.utm_campaign = 'nonbrand'
GROUP BY device_type;
select * from website_sessions;
-- assignment 5
SELECT 
    MIN(DATE(created_at)) AS start_of_week,
    COUNT(CASE
        WHEN device_type = 'mobile' THEN device_type
        ELSE NULL
    END) AS mob_sessions,
    COUNT(CASE
        WHEN device_type = 'desktop' THEN device_type
        ELSE NULL
    END) AS desktop_sessions
FROM
    website_sessions
    where created_at >= '2012-04-15' and created_at <'2012-06-09'
        AND utm_source = 'gsearch'
        AND utm_campaign = 'nonbrand'
GROUP BY week(created_at) , YEAR(created_at)
