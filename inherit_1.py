# !/usr/bin/python (specify exactly which interpreter will be used to run the script on a particular system)
# Piece of code, first, that shows how an 'inheritance' works extending properties (or capabilities) of a class (parent)
# to other classes (childs).


class PartyAnimal:  # class or template
    x = 0           # field
    name = ""
    def __init__(self, nam):   # construction of the object or objects
        self.name = nam
        print(self.name,'constructed')

    def party(self):    # method
        self.x = self.x + 1
        print(self.name,'party count', self.x)


class FootballFan(PartyAnimal):
    points = 0
    def touchdown(self):    # method
        self.points = self.points + 7
        self.party()
        print(self.name, "points", self.points)


s = PartyAnimal("Sally")
s.party()

j = FootballFan("Jim")
j.party()
j.touchdown()

