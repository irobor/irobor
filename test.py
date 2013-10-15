import sys
def foo(arg1, arg2 = 0):
    print ('Аргумент функции равен:')
    print (arg1[::3])
a = [1,2,3,4,5]
foo(a)
try:
    print ('Привет!',sys.argv[1])
except:
    print('Извините ошибка')
	
input()