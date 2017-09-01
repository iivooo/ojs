
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
  origin_timestamp bigint(20) DEFAULT 0,
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
  origin_timestamp bigint(20) DEFAULT 0
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
  origin_timestamp bigint(20) DEFAULT 0
);

ALTER TABLE articles (
ADD origin_sha256 varchar(80),
  originstamp_status int(2),
  origin_timestamp bigint(20) DEFAULT 0;
  )


INSERT INTO `users` (`user_id`, `username`, `password`, `salutation`, `first_name`, `middle_name`, `last_name`, `suffix`, `gender`, `initials`, `email`, `url`, `phone`, `fax`, `mailing_address`, `billing_address`, `country`, `locales`, `date_last_email`, `date_registered`, `date_validated`, `date_last_login`, `must_change_password`, `auth_id`, `auth_str`, `disabled`, `disabled_reason`, `inline_help`) VALUES
(2, 'author', '$2y$10$NWPqsTb0KFse0iHo2/uGC.iwd7qlXCJNB.vBQ/RXP5shEjU9H7V/S', '', 'au', '', 'thor', NULL, '', '', 'au@thor.de', '', '', '', '', NULL, '', '', NULL, '2017-03-21 14:16:33', NULL, '2017-08-29 20:13:28', 0, NULL, NULL, 0, NULL, 0),
(3, 'reviewer', '$2y$10$p6mWxYRvsRqiozXJ.jWAwegeBNKj0ZuHVTCeNbik.XQPLzle5I9Ca', '', 're', '', 'viewer', NULL, '', '', 'reviewer@test.de', '', '', '', '', NULL, '', '', NULL, '2017-05-29 21:20:24', NULL, '2017-08-23 20:23:29', 0, NULL, NULL, 0, NULL, 0),
(4, 'sectioneditor', '$2y$10$27sISu9GWsLDBQ1gQB8M9uF/AUiVYhMo1Ij2NBb07zNwpqws6Qxt6', '', 'section', '', 'editor', NULL, '', '', 'secedit@test.de', '', '', '', '', NULL, '', '', NULL, '2017-05-29 21:21:10', NULL, '2017-08-30 15:50:23', 0, NULL, NULL, 0, NULL, 0),
(5, 'editor', '$2y$10$5V8eTDhymqyin.1Eaa83ueeCtVS6l93TzgaJaCazafWwLSPDzxOZe', '', 'edit', '', 'or', NULL, '', '', 'editor@test.de', '', '', '', '', NULL, '', '', NULL, '2017-05-29 21:25:38', NULL, '2017-06-14 08:25:26', 0, NULL, NULL, 0, NULL, 0);
COMMIT;


