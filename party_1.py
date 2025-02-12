# Piece of code that shows how a 'class' (or template) in python is constructed and works, 
# as well as a 'method' (or message, capability of a class), 'field' (or attribute, a bit of code)
# and an 'object' (or instance).

# dog (class), 1 (field), bark (method), lassie (object)


class PartyAnimal:  # class or template
    x = 0           # field
    name = ""
    def __init__(self, z):
        self.name = z
        print(self.name,'constructed')

    def party(self):    # method
        self.x = self.x + 1
        print(self.name,'party count', self.x)
    
    #def __del__(self):
    #    print('I am destructed', self.x)
        

#an = PartyAnimal()         # object

s = PartyAnimal("Sally")    # object
s.party()

j = PartyAnimal("Jeff")
j.party()
s.party()

#an.party()
#an.party()
#an = 42
#print('an contains', an)

#an.party()
#an.party()
#an = 42
#print('an contains', an)