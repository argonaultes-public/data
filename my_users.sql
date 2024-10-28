CREATE TYPE street_categories AS ENUM ('avenue','boulevard', 'alley', 'hem');

CREATE TYPE address AS (
    num INT,
    street_category street_categories,
    postal_code INT,
    city VARCHAR(30)
);

CREATE TYPE customer AS (
    firstname TEXT,
    lastname TEXT,
    birthday DATE
);

CREATE TABLE my_users (
    id SERIAL PRIMARY KEY,
    email TEXT,
    customer customer,
    postal_adress address
);