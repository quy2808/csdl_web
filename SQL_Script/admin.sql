USE vanchuyen;
CREATE TABLE admin (
  username CHAR(20) NOT NULL,
  password CHAR(20) NOT NULL,
  PRIMARY KEY (username)
);
INSERT INTO admin(username, password) VALUES ('quy123', '123456');