Once our Gem environment knows to put ActiveRecord into the picture, 
we need to tell ActiveRecord where the database is located that it will be working with.

We do this by running ActiveRecord::Base.establish_connection. Once establish_connection is run, 
    ActiveRecord::Base keeps it stored as a class variable at ActiveRecord::Base.connection.

    ActiveRecord::Base.establish_connection(
        :adapter => "sqlite3",
        :database => "db/students.sqlite"
      )

      <<<Create a table>>>

      But our database is empty. Let's create a table to hold students.

      Let's create our table using SQL:
      
      sql = <<-SQL
        CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY,
        name TEXT
        )
      SQL
       
      # Remember, the previous step has to run first so that `connection` is set!
      ActiveRecord::Base.connection.execute(sql)

      <<<Link a Student "model" to the database table students>>>
    "The last step is to tell your Ruby class to make use of ActiveRecord's" built-in ORM methods. 
    With Active Record and other ORMs, this is managed through Class Inheritance. 
    We simply make our class (Student) a subclass of ActiveRecord::Base.

    [[[class Student < ActiveRecord::Base
    end]]]

    Our Student class is now our gateway for talking to the students table in the database. 
    The Student class has gained a whole bunch of new methods via its inheritance relationship to ActiveRecord.

    <<<.column_names>>>
Retrieve a list of all the columns in the table:

Student.column_names
#=> [:id, :name]

    <<<.create>>>
Create a new Student entry in the database:

Student.create(name: 'Jon')
# INSERT INTO students (name) VALUES ('Jon')
.find
Retrieve a Student from the database by id:

Student.find(1)
    <<<.find_by>>>
Find by any attribute, such as name:

Student.find_by(name: 'Jon')
# SELECT * FROM students WHERE (name = 'Jon') LIMIT 1

    <<<attr_accessors>>>
"You can get or set attributes of an instance of Student once you've retrieved it:"

student = Student.find_by(name: 'Jon')
student.name
#=> 'Jon'
 
student.name = 'Steve'
 
student.name
#=> 'Steve'

    <<<"#save">>>

And then save those changes to the database:

student = Student.find_by(name: 'Jon')
student.name = 'Steve'
student.save
Note that our Student class doesn't have any methods defined for #name either. Nor does it make use of Ruby's built-in attr_accessor method.

class Student < ActiveRecord::Base
end