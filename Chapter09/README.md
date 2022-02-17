# Chapter 9: Advanced Continuous Delivery

All the instructions assumes that you have Java 8+ and Docker installed on your system.

## Code Samples

### Code Sample 1: Initial Flyway migration

The [sample1](sample1) includes a Calculator project together with the initial Flyway migration.

The initial migration SQL is defined in `src/main/resources/db/migration/V1__Create_calculation_table.sql`. You can have a look at that file and then apply the migration.

	$ ./gradlew flywayMigrate -i

The command should automatically detect the migration script and update the database schema. You can now run the Calculator application.

	$ ./gradlew bootRun

We can now make a call to our service.

	$ curl localhost:8080/sum?a=1\&b=2
	3

This should result in creating an entry in the database. You can check it by browsing the database at: http://localhost:8080/h2-console (use JDBC URL: `jdbc:h2:/tmp/calculator`).

### Code Sample 2: Backwards-compatible Flyway migration

The [sample2](sample2) includes a Calculator project together with the backwards-compatible Flyway migration.

The migration adds a new column `CREATED_AT` to the `CALCULATION` table. The migration is defined in `src/main/resources/db/migration/V2__Add_created_at_column.sql`. To apply the migration, run the following command.

	$ ./gradlew flywayMigrate -i

Then, run again the application.

	$ ./gradlew bootRun

Make a new call to the service.

	$ curl localhost:8080/sum?a=2\&b=3
	5

Observe the new entry in the database.

### Code Sample 3: Non-backwards-compatible Flyway migration

The [sample3](sample3) includes a Calculator project together with the non-backwards-compatible Flyway migration (which renames of the table column).

Renaming the column will be done in a few steps:
 1. Adding a new column in the database
 2. Changing the code to use both columns
 3. Merging the data
 4. Removing the old column from the code
 5. Dropping the old column from the database

The first steps are already included, you can check they work fine by executing the `src/main/resources/db/migration/V3__Add_sum_column.sql` migration and starting the service.

	$ ./gradlew flywayMigrate -i
	$ ./gradlew bootRun

Make a new call to the service and observe the entries in the database. Note that all the changes we did so far are backwards-compatible.

Let's create the data merging migration (`src/main/resources/db/migration/V4__Copy_result_into_sum_column.sql`), which will copy the old column data to the new one.

	update CALCULATION
	set CALCULATION.sum = CALCULATION.result
	where CALCULATION.sum is null;

Execute the migration.

	$ ./gradlew flywayMigrate -i

The next step is to remove the old column from the code. You can remove all mentions of `result` from the `Calculation.java` class. Then, start the service and observe the data in the database.

	$ ./gradlew bootRun

Finally, we can drop the old column from the database. Create `src/main/resources/db/migration/V5__Drop_result_column.sql` with the following content.

	alter table CALCULATION
	drop column RESULT;

After running the migration and starting the service, observe again the database.

	$ ./gradlew flywayMigrate -i
	$ ./gradlew bootRun

## Exercise solutions

### Exercise 1: Flyway to make non-backwards-compatible change in MySQL

The [exercise1](exercise1) directory contains the initial Flyway migration.

Start the MySQL docker container with the following command.

	$ docker run -p 3306:3306 -e MYSQL_ROOT_PASSWORD=abc123 -d mysql

Install MySQL client CLI (`mysql-client`) and the `flyway` command tool. Note that you can use the related client Docker images instead.

Create a sample database `test`.

	$ mysql -h 127.0.0.1 -u root -p'abc123' -P 3306
	mysql> create database test;
	mysql> use test;

Run the initial migration which creates the `users` table.

	$ flyway -user=root -password=abc123 -url=jdbc:mysql://127.0.0.1:3306/test -locations=filesystem:. migrate

Insert some data with the MySQL client.

	mysql> INSERT INTO USERS(ID, EMAIL, PASSWORD) VALUES(1, 'rafal@leszko.com','ala123');
	mysql> INSERT INTO USERS(ID, EMAIL, PASSWORD) VALUES(2, 'maria@leszko.com','123456');
	mysql> INSERT INTO USERS(ID, EMAIL, PASSWORD) VALUES(3, 'roza@leszko.com','password');

Create the migration `V2__Create_hashed_password_column.sql` to create a new column.

	alter table USERS
	add HASHED_PASSWORD varchar(100);

Apply the migration.

	$ flyway -user=root -password=abc123 -url=jdbc:mysql://127.0.0.1:3306/test -locations=filesystem:. migrate

Create a migration to copy the data from `PASSWORD` into `HASHED_PASSWORD`. Let's name it `V3__Copy_password_into_hashed_password.sql`.

	update USERS
	set USERS.HASHED_PASSWORD = MD5(USERS.PASSWORD);

Apply the migration.

	$ flyway -user=root -password=abc123 -url=jdbc:mysql://127.0.0.1:3306/test -locations=filesystem:. migrate

Check using MySQL client that the data was copied.

Create a migration to drop the `PASSWORD` column. Let's name it `V4__Drop_password_column.sql`.

	alter table USERS
	drop column PASSWORD;

Apply the migration and check the results with the MySQL client.

	$ flyway -user=root -password=abc123 -url=jdbc:mysql://127.0.0.1:3306/test -locations=filesystem:. migrate
	mysql> select * from USERS;
	+----+------------------+----------------------------------+
	| ID | EMAIL            | HASHED_PASSWORD                  |
	+----+------------------+----------------------------------+
	|  1 | rafal@leszko.com | 77da6e74372583260cc783e8bdbe5b37 |
	|  2 | maria@leszko.com | e10adc3949ba59abbe56e057f20f883e |
	|  3 | roza@leszko.com  | 5f4dcc3b5aa765d61d8327deb882cf99 |
	+----+------------------+----------------------------------+

### Exercise 2: Create Jenkins shared library to build and unit test Gradle projects

The [exercise2](exercise2) directory contains the code for the Jenkins shared library.

To use it, you need to copy it into a separate repository and point it in Jenkins.