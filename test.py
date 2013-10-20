import sys
def foo(arg1, arg2 = 0):
    print ('Аргумент функции равен:')
    print (arg1[::3])
a = [1,2,3,4,10]
foo(a)
try:
    print ('Привет!',sys.argv[1])
except:
    print('Извините ошибка111')
	
class Parent:#класс родитель
		def setdata(self,data):
			self.data = data
		def show(self):
			print (self.data)

class Child(Parent):# Класс ребёнок
		def show(self):
			print (self.data + "| это из Child")
		def show_alt(self):
			str = str(len(self.data))
			print (self.data)

myexp1 = Child()	

myexp1.setdata("Привет, это мой первый объект")
myexp1.show() 		
input()
