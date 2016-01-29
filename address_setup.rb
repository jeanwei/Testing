require 'sqlite3'

$db = SQLite3::Database.new "address_book.db"

module Address_bookDB
	def self.setup
		$db.execute(
			<<-SQL
				CREATE TABLE contacts (
				id INTEGER PRIMARY KEY AUTOINCREMENT,
				first_name VARCHAR(64) NOT NULL,
				last_name VARCHAR(64) NOT NULL,
				company VARCHAR(64) NOT NULL,
				phone_number VARCHAR(64) NOT NULL,
				email VARCHAR(64) NOT NULL,
				created_at DATETIME NOT NULL,
				updated_at DATETIME NOT NULL
				);

				CREATE TABLE groups (
				id INTEGER PRIMARY KEY AUTOINCREMENT,
				name VARCHAR(64) NOT NULL
				created_at DATETIME NOT NULL,
				updated_at DATETIME NOT NULL
				);
			SQL
		)
	end

	def self.seed
		# Add a few records to your database when you start
		$db.execute(
			<<-SQL
				INSERT INTO students
					(first_name, last_name, gender, dob, created_at, updated_at)
				VALUES
					('Brick', 'Thornton', 'male', '1991-10-01', DATETIME('now'), DATETIME('now')),
					('Harry', 'Potter', 'male', '1991-01-01', DATETIME('now'), DATETIME('now')),
					('Hermoine', 'Granger', 'female', '1991-01-20', DATETIME('now'), DATETIME('now'));

				-- Create two more students who are at least as cool as this one.

			SQL
		)
	end

	def self.add(firstname, lastname, gender, date)
		$db.execute(
			<<-SQL	
				INSERT INTO students
					(first_name, last_name, gender, dob, created_at, updated_at)
				VALUES
					("#{firstname}", "#{lastname}" , "#{gender}", "#{date}", DATETIME('now'), DATETIME('now'));
			SQL
		)
	end

	def self.delete(id)
		$db.execute(
			<<-SQL	
				DELETE FROM students WHERE id = "#{id}";
			SQL
		)
	end

	def self.list
		$db.execute(
			<<-SQL
			SELECT first_name, last_name FROM students;
			SQL
		)
	end

	def self.list_firstname(firstname)
		$db.execute(
			<<-SQL
			SELECT first_name, last_name FROM students WHERE first_name = "#{firstname}";
			SQL
		)
	end

	def self.list_attribute(key, value)
		$db.execute(
			<<-SQL
			SELECT * FROM students WHERE "#{key}" = "#{value}";
			SQL
		)
	end

	def self.birthday_baby
		$db.execute(
			<<-SQL
				SELECT first_name, last_name FROM 
				(SELECT *, strftime('%m', dob) as birth_month FROM students 
					WHERE birth_month = strftime('%m', 'now'));
				
			SQL
		)
	end

	def self.list_birthday
		$db.execute(
			<<-SQL
				SELECT * FROM students ORDER BY dob ASC;
			SQL
		)

	end


end