import sys
def foo(arg1, arg2 = 0):
    print ('�������� ������� �����:')
    print (arg1[::3])
a = [1,2,3,4,5]
foo(a)
try:
    print ('������',sys.argv[1])
except:
    print('�������� ������')
	
input()