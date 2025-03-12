CREATE DATABASE restaurante_db;
USE restaurante_db;

CREATE TABLE locations (
    id INT PRIMARY KEY,
    table_number INT NOT NULL,
    hourvalues DECIMAL(4,1) NOT NULL
);

CREATE TABLE clients (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    price DECIMAL(10,2) NOT NULL
);

CREATE TABLE orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    tid INT NOT NULL,
    clid INT NOT NULL,
    dates DATE NOT NULL,
    status ENUM('reserved', 'canceled', 'open', 'payment', 'closed') NOT NULL,
    FOREIGN KEY (tid) REFERENCES locations(id),
    FOREIGN KEY (clid) REFERENCES clients(id)
);

CREATE TABLE order_items (
    sid INT NOT NULL,
    pid INT NOT NULL,
    quantity INT NOT NULL,
    PRIMARY KEY (sid, pid),
    FOREIGN KEY (sid) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (pid) REFERENCES products(id) ON DELETE CASCADE
);
