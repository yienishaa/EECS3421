USE PROJECT2_W23;

#1 How many students have taken “Introduction to Database Systems”?
SELECT COUNT(StudentID) FROM CourseTaken INNER JOIN Course ON CourseTaken.CourseCode=Course.CourseCode WHERE Course.Description LIKE "Introduction to Database Systems";

#2 For the given year, what courses did not have a final exam as an assessment?
SELECT Course_Assessment.CourseCode, Course.Description, Assessment.AssessmentType FROM (
	(Course_Assessment INNER JOIN Course ON Course.CourseCode=Course_Assessment.CourseCode)
    INNER JOIN Assessment ON Course_Assessment.AssessmentID=Assessment.AssessmentID) WHERE Assessment.AssessmentType 
    NOT LIKE "final exam";

#3 Find all the courses that the given question has been used to assess the students. The
#description of the question is given (i.e. question attribute in the Questions table)

SELECT Questions.CourseCode, Course.Description FROM ((Questions 
INNER JOIN Course_Assessment ON Course_Assessment.CourseCode=Questions.CourseCode)
INNER JOIN Course ON Course.CourseCode=Course_Assessment.CourseCode)
WHERE Question="What is A";

#4 Which professor has used “seminar” as an assessment at least once?

SELECT Professor_has_Course.Professor_PID FROM Professor_has_Course 
    WHERE Professor_has_Course.Course_Code IN (SELECT CourseCode FROM Course_Assessment WHERE AssessmentID LIKE 
    (SELECT AssessmentID FROM Assessment WHERE AssessmentType="seminar")) GROUP BY Professor_has_Course.Professor_PID;


#5- For the given course, what CLOs and GAIs have been assessed?
SELECT CLO, GAI FROM Questions WHERE CourseCode=3421;

#6- What percentage of students passed a given course. The course code is given to solve this problem.
(SELECT SUM(GradeRecieved) FROM Exam WHERE CourseCode=3421 GROUP BY StudentID);
SELECT GradeRecieved FROM Exam INNER JOIN Questions ON Questions.CourseCode=Exam.CourseCode WHERE Exam.CourseCode=3421;

#7- What percentage of the assessment for the given course, meets the given learning outcome. The course code and CLO is given.

SELECT SUM(Exam.GradeRecieved) FROM Exam INNER JOIN Questions ON Questions.QuestionID AND Questions.AssessmentID AND Questions.CourseCode
	WHERE Exam.CourseCode = 3421 AND Questions.CLO=1 AND GradeRecieved > 2;

#8- What types of assessments have been offered by the given course in a given year and term.

SELECT Assessment.AssessmentType FROM Assessment 
INNER JOIN Course_Assessment ON Course_Assessment.AssessmentID=Assessment.AssessmentID
 WHERE Course_Assessment.CourseCode = 3421;

#9- What students have been assessed for the given CLO at least once in any of the courses that they have taken.

SELECT StudentID FROM Exam INNER JOIN Questions ON Questions.QuestionID=Exam.QuestionID AND 
	Questions.AssessmentID=Exam.AssessmentID AND Questions.CourseCode=Exam.CourseCode WHERE CLO LIKE 1

#10- Find the student who has received either the minimum or the maximum grade for the given course and assessment. 
	#Course code and assessment id is given.





