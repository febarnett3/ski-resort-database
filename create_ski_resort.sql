-- Create the database
CREATE DATABASE ski_resort;
USE ski_resort;

-- Inventory table
CREATE TABLE inventory (
    inventory_id INT NOT NULL AUTO_INCREMENT,
    item_name VARCHAR(50) NOT NULL,
    brand VARCHAR(50) NOT NULL,
    model VARCHAR(100) NOT NULL,
    current_condition ENUM('good','fair','new','poor') NOT NULL,
    rental_price DECIMAL(10,2) NOT NULL,
    length_cm INT,
    boot_size INT,
    PRIMARY KEY (inventory_id)
);

-- Pass types
CREATE TABLE pass_type (
    pass_type_id INT NOT NULL AUTO_INCREMENT,
    pass_name VARCHAR(45) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    duration_days INT NOT NULL,
    PRIMARY KEY (pass_type_id)
);

-- Memberships
CREATE TABLE membership (
    membership_id INT NOT NULL AUTO_INCREMENT,
    join_date DATE,
    PRIMARY KEY (membership_id)
);

-- Customers
CREATE TABLE customer (
    customer_id INT NOT NULL AUTO_INCREMENT,
    membership_id INT,
    first_name VARCHAR(45) NOT NULL,
    last_name VARCHAR(45) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone_number VARCHAR(15) NOT NULL,
    address VARCHAR(255) NOT NULL,
    PRIMARY KEY (customer_id),
    FOREIGN KEY (membership_id) REFERENCES membership(membership_id)
);

-- Credit cards
CREATE TABLE credit_card (
    credit_card_id INT NOT NULL AUTO_INCREMENT,
    customer_id INT NOT NULL,
    credit_card_number VARCHAR(16) NOT NULL UNIQUE,
    expiry_date DATE NOT NULL,
    holder_first_name VARCHAR(45) NOT NULL,
    holder_last_name VARCHAR(45) NOT NULL,
    cvc_code VARCHAR(4) NOT NULL,
    PRIMARY KEY (credit_card_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

-- Staff table (NEW)
CREATE TABLE staff (
    staff_id INT NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(45) NOT NULL,
    last_name VARCHAR(45) NOT NULL,
    role VARCHAR(50),
    email VARCHAR(100),
    PRIMARY KEY (staff_id)
);

-- Rentals
CREATE TABLE rental (
    rental_id INT NOT NULL AUTO_INCREMENT,
    customer_id INT,
    staff_id INT,  -- NEW
    checkout DATE NOT NULL,
    checkin DATE,
    PRIMARY KEY (rental_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);

-- Ski passes
CREATE TABLE ski_pass (
    pass_id INT NOT NULL AUTO_INCREMENT,
    customer_id INT NOT NULL,
    pass_type_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    staff_id INT,  -- NEW
    PRIMARY KEY (pass_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (pass_type_id) REFERENCES pass_type(pass_type_id),
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);

-- Join table for rentals and inventory
CREATE TABLE rental_has_inventory (
    rental_id INT NOT NULL,
    inventory_id INT NOT NULL,
    PRIMARY KEY (rental_id, inventory_id),
    FOREIGN KEY (rental_id) REFERENCES rental(rental_id),
    FOREIGN KEY (inventory_id) REFERENCES inventory(inventory_id)
);

-- Events (NEW)
CREATE TABLE event (
    event_id INT NOT NULL AUTO_INCREMENT,
    event_name VARCHAR(100),
    event_date DATE,
    location VARCHAR(100),
    PRIMARY KEY (event_id)
);

-- Customer-event link (NEW)
CREATE TABLE customer_event (
    customer_id INT,
    event_id INT,
    PRIMARY KEY (customer_id, event_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (event_id) REFERENCES event(event_id)
);

-- Rental feedback (NEW)
CREATE TABLE rental_feedback (
    feedback_id INT NOT NULL AUTO_INCREMENT,
    rental_id INT,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comments TEXT,
    feedback_date DATE,
    PRIMARY KEY (feedback_id),
    FOREIGN KEY (rental_id) REFERENCES rental(rental_id)
);
