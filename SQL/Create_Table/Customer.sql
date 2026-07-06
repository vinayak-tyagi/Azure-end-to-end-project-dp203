CREATE TABLE dbo.customers (
    customer_id INT PRIMARY KEY,
    country VARCHAR(100),
    age INT,
    gender VARCHAR(50),
    membership_tier VARCHAR(50),
    registration_date DATE,
    total_orders INT,
    total_spend_usd DECIMAL(10, 2),
    avg_order_value_usd DECIMAL(10, 2),
    days_since_last_purchase INT,
    preferred_category VARCHAR(100),
    preferred_device VARCHAR(50),
    preferred_payment_method VARCHAR(50),
    acquisition_channel VARCHAR(100),
    reviews_given INT,
    avg_review_score DECIMAL(3, 2),
    returns_made INT,
    wishlist_items INT,
    newsletter_subscribed INT, -- Use BOOLEAN if your database supports it
    churned INT -- Use BOOLEAN if your database supports it
);
