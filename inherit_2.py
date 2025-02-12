# !/usr/bin/python (specify exactly which interpreter will be used to run the script on a particular system)
# Piece of code, second, that shows how an 'inheritance' works extending properties (or capabilities) of a class (parent)
# to other classes (childs).

class SchoolMember:
    '''Represents ay school member'''
    def __init__(self, name, age):
        self.name = name
        self.age = age
        print'(Initialized SchoolMember: %s)' % self.name
        #print('Initialized SchoolMember:', format(self.name))

        def tell(self):
            '''Tell my details'''
            print'Name:"%s" Age:"%s"' % (self.name, self.age),
            #print('Name:\t Age:' format(self.name, self.age)),


class Teacher(SchoolMember):
    '''Represents a teacher'''
    def __init__(self, name, age, salary):
        SchoolMember.__init__(self, name, age)
        self.salary = salary
        print '(Initialized teacher: %s)' % self.name
        #print('Initialized teacher is: ', format(self.name))
    
    def tell(self):
        SchoolMember.tell(self)
        print'Salary:"%d"' % self.salary
        #print('Salary is: ', format(self.salary))

class Student(SchoolMember):
    '''Represents a student'''
    def __init__(self, name, age, marks):
        SchoolMember.__init__(self, name, age)
        self.marks = marks
        print'(Initialized student: %s)' % self.name
        #print('Initialized student:', format(self.name))

    def tell(self):
        SchoolMember.tell(self)
        print 'Marks:"%d"' % self.marks
        #print('Marks:', format(self.marks))

t = Teacher('Mr. Jimenez', 40, 30000)
s1 = Student('Aranka', 10, 100)
s2 = Student('Julen', 7, 100)

members = [t, s1, s2]
for member in member:
    member.tell()   # works for both, Teachers and Students


            




