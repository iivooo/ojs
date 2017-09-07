# CryptSubmit Prototype in Open Journal Systems 2.x

Requirements:
LAMPP stack with:

    1. PHP support (4.2.x and max. 5.3.x)
    2. MySQL (3.23 or later) or PostgreSQL (7.1 or later)
    3. Apache (1.3.2x or later) or Apache 2 (2.0.4x or later)
    
Then do the following steps:

    1. Clone this repo into the apaches document directory
    Change config.TEMPLATE.inc.php to config.inc.php
    2. Open the site in the browser and follow the installation steps.
        -> keep english as language, database: must be user with name and password e.g. in xampp(bug)
    3. Add the sql-statements in: dbscripts/ojsInstallationAfter.sql into the database (e.g. with phpmyadmin)
    (Adjust the use statement to the database name you choosed)
    4. Now you are ready to go.
    
Please note that the users, roles and site settings are provided from the sql 
you insert.
    
