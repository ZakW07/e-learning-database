-- 2.1 Implementing the Database:

-- //INDEPENDANT TABLES//

CREATE TABLE Category (
    categoryID INT AUTO_INCREMENT NOT NULL,
    categoryName VARCHAR(20) NOT NULL,
    description TEXT,
    PRIMARY KEY (categoryID)
);

CREATE TABLE Provider (
    providerID INT AUTO_INCREMENT NOT NULL,
    providerName VARCHAR(50) NOT NULL,
    PRIMARY KEY (providerID)
);

CREATE TABLE User (
    userID INT AUTO_INCREMENT NOT NULL,
    firstName VARCHAR(20) NOT NULL,
    lastName VARCHAR(20) NOT NULL,
    email VARCHAR(254) NOT NULL,
    learningPreferences TEXT,
    PRIMARY KEY (userID)
);

CREATE TABLE Instructor (
    instructorID INT AUTO_INCREMENT NOT NULL,
    firstName VARCHAR(20) NOT NULL,
    lastName VARCHAR(20) NOT NULL,
    bio TEXT NOT NULL,
    expertise VARCHAR(100) NOT NULL,
    PRIMARY KEY (instructorID)
);

-- //////////////////////////////////
-- //TABLES CONTAINING FOREIGN KEYS//

CREATE TABLE Course (
    courseID INT AUTO_INCREMENT NOT NULL,
    title VARCHAR(100) NOT NULL,
    duration INT,
    level INT,
    price DECIMAL(5,2),
    providerID INT NOT NULL,
    PRIMARY KEY (courseID),
    FOREIGN KEY (providerID) REFERENCES Provider(providerID)
);

CREATE TABLE Review (
    reviewID INT AUTO_INCREMENT NOT NULL,
    rating INT NOT NULL CHECK (rating >= 1 AND rating <= 10),
    feedback TEXT,
    completionStatus VARCHAR(20),
    userID INT NOT NULL,
    courseID INT NOT NULL,
    PRIMARY KEY (reviewID),
    FOREIGN KEY (userID) REFERENCES User(userID),
    FOREIGN KEY (courseID) REFERENCES Course(courseID)
);

-- //////////////////////////////////
-- //LINKING TABLES//

CREATE TABLE CourseCategory (
    courseID INT NOT NULL,
    categoryID INT NOT NULL,
    PRIMARY KEY (courseID,categoryID),
    FOREIGN KEY (courseID) REFERENCES Course(courseID),
    FOREIGN KEY (categoryID) REFERENCES Category(categoryID)
);

CREATE TABLE CourseInstructor (
    courseID INT NOT NULL,
    instructorID INT NOT NULL,
    PRIMARY KEY (courseID,instructorID),
    FOREIGN KEY (courseID) REFERENCES Course(courseID),
    FOREIGN KEY (instructorID) REFERENCES Instructor(instructorID)
);

-- //////////////////////////////////
-- //POPULATING THE DATABASE//

INSERT INTO Provider (providerName) VALUES
("Codecademy"), ("Coursera"), ("Udemy"), ("Heriot-Watt University"), ("Codedex"), ("edX");

INSERT INTO Category (categoryName, description) VALUES
("Computer Science", "Software Development, lots of math and Design"),
("Business", "Course is about finance and entrepreneurship"),
("Graphics Design", "Course is about designing UI and UX"),
("Cyber Security", "Couse is about privacy, networks and ethical hacking"),
("Web Design", "Course is about designing and developing web pages"),
("Machine Learning", "Course is about AI models and real-life solutions");

INSERT INTO Instructor (firstName, lastName, bio, expertise) VALUES
("Jimmy", "John", "Very qualified software developer", "Java, C++ and Python"),
("Andrew", "Smith", "Business consultant and startup investor", "Scaling Business"),
("Michael", "Wilson", "UI designer with 5 years of experience", "Design"),
("Alex", "James", "Cyber security analyst", "Cyber Security"),
("Tom", "Oliver", "Web developer", "Web Developer"),
("Jack", "Henry", "Training and tuning AI providing custom solutions", "ML Developer");

INSERT INTO User (firstName, lastName, email, learningPreferences) VALUES
("Billy", "Bob", "bobbySmith@gmail.com", "Code along sessions"),
("John", "Smith", "jSmith@mail.co.uk", "Video lectures"),
("Daniel", "Horn", "danielHorn@gmail.com", "Design & Art"),
("Diane", "Robertson", "dianeRobertson@gmail.com", "Reading materials"),
("Peter", "Winters", "peterWinters@outlook.co.uk", "Code along sessions"),
("Mike", "Taylor", "mikeTaylor@gmail.com", "Video tutorials");

INSERT INTO Course (title, duration, level, price, providerID) VALUES
("Web Design & Databases", 45, 3, 79.99, 1),
("Software Development 2", 50, 2, 89.99, 1),
("Discrete Mathematics", 60, 5, 149.99, 6),
("Machine Learning Basics", 40, 3, 59.99, 2),
("Business Management", 35, 1, 49.99, 3),
("Cyber Security Essentials", 38, 4, 299.99, 6),
("Logic and Proof", 35, 1, 49.99, 3);

INSERT INTO CourseCategory (courseID, categoryID) VALUES
(1, 5), (2, 1), (3, 1), (4, 6), (5, 2), (6, 4), (7, 1);

INSERT INTO CourseInstructor (courseID, instructorID) VALUES
(1, 5), (2, 1), (3, 1), (4, 6), (5, 2), (6, 4), (7, 1);

INSERT INTO Review (rating, feedback, completionStatus, userID, courseID) VALUES
(10, "Such a great course, Excellent Instructor!", "Completed", 1, 1),
(4, "Some content was out of date, great instructor though", "Completed", 2, 1),
(7, "Interesting content, good instructor but sometimes challenging to follow", "Completed", 3, 1),
(3, "Instructor is very hard to understand at times", "In Progress", 4, 2),
(4, "Broad content, instructor was sufficient for understanding", "Completed", 5, 2),
(1, "Could not understand the instructor", "Completed", 6, 3),
(2, "Quite hard and theoretical", "In Progress", 1, 3),
(6, "Great course only if you enjoy math", "Completed", 2, 3),
(5, "Interesting topics but very time consuming", "Completed", 3, 3),
(8, "The instructor explained topics very well", "Completed", 4, 3),
(10, "Fantastic introduction to computer systems", "Completed", 1, 4),
(4, "Really useful and clear", "Completed", 3, 4),
(4, "Some sections needed more examples", "In Progress", 5, 4),
(8, "Helpful for understanding hardware and software interaction", "Completed", 2, 4),
(7, "Good beginner course for logic", "Completed", 2, 5),
(9, "Very clear and easy to understand", "Completed", 4, 5),
(4, "Interesting but a bit lengthy", "In Progress", 6, 5),
(7, "Nice explanations", "Completed", 1, 5),
(8, "Machine learning concepts were explained very well", "Completed", 2, 6),
(4, "Useful real-life examples and applications", "Completed", 3, 6),
(6, "Very engaging course and strong instructor", "Completed", 4, 6),
(5, "Decent course overall", "Completed", 5, 1),
(4, "Helpful content overall", "Completed", 6, 2),
(5, "Excellent teaching style", "Completed", 1, 3),
(2, "Too difficult for beginners", "In Progress", 2, 4),
(4, "Good balance of theory and practice", "Completed", 3, 5),
(5, "Clear explanations and useful examples", "Completed", 4, 6),
(3, "Average but acceptable", "Completed", 5, 2),
(4, "Enjoyed the learning experience", "Completed", 6, 1),
(8, "Highly recommend this course", "Completed", 1, 6);

-- 2.2 Querying the Database:

-- 1. Looks through the Course table and finds the 3 shortest courses.
SELECT title, duration FROM Course ORDER BY duration ASC LIMIT 3;

-- 2. Looks through the User table and finds users who like learning with videos and orders them alphabetically by last name.
SELECT lastName, learningPreferences FROM User WHERE learningPreferences IN ("Video lectures", "Video tutorials") ORDER BY lastName ASC;

-- 3. Uses the Category and CourseCategory tables to count how many courses belong to each category and sorts them from most to least popular.
SELECT Category.categoryName, COUNT(CourseCategory.courseID) AS courseCount
FROM Category
JOIN CourseCategory ON Category.categoryID = CourseCategory.categoryID
GROUP BY Category.categoryID, Category.categoryName
ORDER BY courseCount DESC;

-- 4. Lists all the instructors first and last names along with the courses they teach.
SELECT Instructor.firstName, Instructor.lastName, Course.title
FROM Instructor
JOIN CourseInstructor ON Instructor.instructorID = CourseInstructor.instructorID
JOIN Course ON CourseInstructor.courseID = Course.courseID;

-- 5. Gets the name of all the providers and the total price of all the courses they provide.
SELECT Provider.providerName, SUM(Course.price) AS totalPrice
FROM Provider
JOIN Course ON Provider.providerID = Course.providerID
GROUP BY Provider.providerID, Provider.providerName;

-- 6. Calculates the derived attribute averageRating for each course by averaging the ratings in the Review table.
SELECT Course.title, AVG(Review.rating) AS averageRating
FROM Course
LEFT JOIN Review ON Course.courseID = Review.courseID
GROUP BY Course.title
ORDER BY averageRating DESC;
