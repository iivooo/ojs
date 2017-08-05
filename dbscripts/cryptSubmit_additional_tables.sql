
  CREATE TABLE article_comments_timestamping_cryptSubmit (
  ID int NOT NULL AUTO_INCREMENT,
  --auto_increment must be primary key
  PRIMARY KEY (ID),
  user_id bigint(20),
  FOREIGN KEY (user_id) REFERENCES users(user_id) ON UPDATE CASCADE, --first create column, then add constraint
  ip varchar(50),
  username varchar(20),
  first_name varchar(20),
  middle_name varchar(20),
  last_name varchar(20),
  phone varchar(30),
  billing_address varchar(100),
  country varchar(20),
  article_id bigint(20),

  FOREIGN KEY (article_id) REFERENCES articles(article_id) ON UPDATE CASCADE,
  original_comments text,
  comment_title varchar(255),
  comment_id bigint(20),
  FOREIGN KEY (comment_id) REFERENCES article_comments(comment_id) ON UPDATE CASCADE,
  comment_timestamp int(10),
  originstamp_status int(2),
  origin_timestamp int(10),
  origin_sha256 varchar(100)
);

  CREATE TABLE download_log (
  ID int NOT NULL AUTO_INCREMENT,
  --auto_increment must be primary key
  PRIMARY KEY (ID),
  user_id bigint(20),
  FOREIGN KEY (user_id) REFERENCES users(user_id) ON UPDATE CASCADE,
  --first create column, then add constraint
  ip varchar(50),
  username varchar(20),
  first_name varchar(20),
  middle_name varchar(20),
  last_name varchar(20),
  phone varchar(30),
  billing_address varchar(100),
  country varchar(20),
  article_id bigint(20),

  FOREIGN KEY (article_id) REFERENCES articles(article_id) ON UPDATE CASCADE,
  article_hash varchar(100),
  download_timestamp int(10),
  originstamp_status int(2),
  origin_timestamp int(10)
);

 CREATE TABLE login_log (
            `index` int NOT NULL AUTO_INCREMENT,
  --auto_increment must be primary key
  PRIMARY KEY (`index`),
  user_id bigint(20),
  FOREIGN KEY (user_id) REFERENCES users(user_id) ON UPDATE CASCADE,
  --first create column, then add constraint
  ip varchar(50),
  username varchar(20),
  first_name varchar(20),
  middle_name varchar(20),
  last_name varchar(20),
  phone varchar(30),
  billing_address varchar(100),
  country varchar(20),
  origin_sha256 varchar(80),
  originstamp_status int(2),
  origin_timestamp int(10)
);


