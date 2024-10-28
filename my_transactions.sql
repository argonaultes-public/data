CREATE TABLE my_transactions (
    num INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    label TEXT,
    amount FLOAT,
    quantity INT,
    transaction_date DATE
);