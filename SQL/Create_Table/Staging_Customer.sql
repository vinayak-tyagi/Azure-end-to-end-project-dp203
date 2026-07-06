CREATE TABLE dbo.staging_customers (
    customer_id VARCHAR(50),
    country VARCHAR(50),
    age VARCHAR(50),
    gender VARCHAR(50),
    membership_tier VARCHAR(50),
    registration_date VARCHAR(50),
    total_orders VARCHAR(50),
    total_spend_usd VARCHAR(50),
    avg_order_value_usd VARCHAR(50),
    days_since_last_purchase VARCHAR(50),
    preferred_category VARCHAR(50),
    preferred_device VARCHAR(50),
    preferred_payment_method VARCHAR(50),
    acquisition_channel VARCHAR(50)),
    reviews_given VARCHAR(50),
    avg_review_score VARCHAR(50),
    returns_made VARCHAR(50),
    wishlist_items VARCHAR(50),
    newsletter_subscribed VARCHAR(5), -- Use BOOLEAN if your database supports it
    churned VARCHAR(5) -- Use BOOLEAN if your database supports it
);
