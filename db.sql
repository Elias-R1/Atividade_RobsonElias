CREATE DATABASE restaurante_db;
USE restaurante_db;

CREATE TABLE locations (
    id INT PRIMARY KEY,
    locations INT NOT NULL,
    hourvalues DECIMAL(4,1) NOT NULL
);

CREATE TABLE clients (
    id INT PRIMARY KEY,
    names VARCHAR(50) NOT NULL,
    emails VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE products (
    id INT PRIMARY KEY,
    names VARCHAR(50) NOT NULL,
    prices DECIMAL(10,2) NOT NULL
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

CREATE TABLE productsche (
    sid INT NOT NULL,
    pid INT NOT NULL,
    quantities INT NOT NULL,
    PRIMARY KEY (sid, pid),
    FOREIGN KEY (sid) REFERENCES orders(id),
    FOREIGN KEY (pid) REFERENCES products(id)
);
