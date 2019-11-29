import math
import statistics
import hashlib
import json
import zlib
import random
import binascii
import sympy
import kanren
import gekko

class c_math:
	@staticmethod
	def sin(a):
		return math.sin(a)
	@staticmethod
	def cos(a):
		return math.cos(a)
	@staticmethod
	def tan(a):
		return math.tan(a)
	@staticmethod
	def asin(a):
		return math.asin(a)
	@staticmethod
	def acos(a):
		return math.acos(a)
	@staticmethod
	def atan(a):
		return math.atan(a)

class c_sharp_math:
	@staticmethod
	def Sin(a):
		return math.sin(a)
	@staticmethod
	def Cos(a):
		return math.cos(a)
	@staticmethod
	def Tan(a):
		return math.tan(a)
	@staticmethod
	def Asin(a):
		return math.asin(a)
	@staticmethod
	def Acos(a):
		return math.acos(a)
	@staticmethod
	def Atan(a):
		return math.atan(a)

class java():
	def __init__(self,a):
		self.length = len(a)
		self.this = a
	class String:
		def __init__(self,a):
			self.length = len(a)
			self.this = a
		def replaceAll(regex,replacement):
			return re.sub(regex,replacement,self.this)
	class Integer:
		@staticmethod
		def parseInt(a):
			return str(a)
	def charAt(self,index):
		return self.this[index]
	class Double:
		@staticmethod
		def parseDouble(a):
			return str(a)
	class System:
		class out:
			@staticmethod
			def println(a):
				print(a)
	class Math(c_math):
		pass

class c_sharp(c_sharp_math):
	class Int32:
		@staticmethod
		def Parse(this,a):
			return int(a)
	class Math(c_sharp_math):
		pass

class ruby:
	@staticmethod
	def puts(a):
		print(a)
	class digest:
		class MD5:
			def ___init__(self,this):
				self.this = this
			def hexdigest(self,text):
				hashlib.md5(text).hexdigest()

class c(c_math):
	@staticmethod
	def strlen(a):
		return len(a)
	def strcmp(a,b):
		return a == b

class prolog(c_math):
	def __init__(self,a):
		self.this = a
	@staticmethod
	def is_list(a):
		return type(a) == list
	@staticmethod
	def var(a):
		return a == None
	@staticmethod
	def nonvar(a):
		return a != None
	@staticmethod
	def len(the_list,the_length):
		return len(the_list) == the_length
	@staticmethod
	def append(a,b,c):
		return (type(a) == list and type(b) == list) or (type(a) == str and type(b) == str) and a + b == c
	@staticmethod
	def number_string(num,the_string):
		return str(num) == the_string
	@staticmethod
	def memberchk(a,b):
		return a in list(b)
	@staticmethod
	def member(a,b):
		return a in list(b)
	@staticmethod
	def sort(the_list,sorted_list):
		return sorted(the_list) == sorted_list
	@staticmethod
	def abs(a):
		return abs(a)
class javascript():
	def __init__(self,a):
		self.this = a
	def endsWith(self,a):
		if(type(a) == str):
			return self.this.endswith(a)
	def replace(self,a,b):
		if(type(a) == str):
			return self.this.replace(a,b)
	def includes(self,a):
		if(type(a) == list):
			return a in self.this
	def indexOf(self,a):
		if type(a) == str and type(self.this) == str:
			return self.this.find(a)
	class Math(c_math):
		pass
	class JSON:
		@staticmethod
		def stringify(a):
			return json.dumps(a)
	class Number:
		@staticmethod
		def isInteger(variable):
			return type(variable) == int

class clojure():
	@staticmethod
	def filter(array,func):
		return filter(func, array)
	class Math(c_math):
		pass

class sql():
	@staticmethod
	def char_index(the_char,the_string):
		return the_string.index(the_char)+1
	class Math(c_math):
		pass

class erlang():
	class math(c_math):
		pass
	@staticmethod
	def filter(array,func):
		return filter(func, array)
	class array:
		@staticmethod
		def is_array(a):
			return type(a) == list
		@staticmethod
		def map(function,array):
			return map(function,array)
class futhark():
	@staticmethod
	def filter(func,array):
		return filter(func, array)
	@staticmethod
	def reverse(the_array):
		return reversed(the_array)
	@staticmethod
	def size(a):
		return len(a)

class perl(c_math):
	def __init__(self,a):
		self.this = a
	@staticmethod
	def join(a,b):
		return a.join(b)
	@staticmethod
	def uc(a):
		return a.toupper()
	@staticmethod
	def lc(a):
		return a.tolower()
	@staticmethod
	def index(a,b):
		return javascript(a).indexOf(b)

class php(c_math):
	@staticmethod
	def echo(a):
		print(a)
	@staticmethod
	def array_rand(a):
		return random.choice(a)
	@staticmethod
	def sort(a):
		a.sort()
	@staticmethod
	def mt_rand(a,b):
		return random.randrange(a,b)
	@staticmethod
	def implode(a,b):
		return a.join(b)
	@staticmethod
	def crc32(a):
		return hex(binascii.crc32(a))
	@staticmethod
	def trim(a):
		return a.strip()
	@staticmethod
	def base_convert(number, frombase, tobase):
		pass
	@staticmethod
	def number_format(a):
		return number(a)
	@staticmethod
	def array_filter(array,func):
		return filter(func, array)
	@staticmethod
	def preg_match_all(pattern,text):
		return re.findall(pattern, text)
	@staticmethod
	def array_keys(array):
		return array.keys()
	@staticmethod
	def array_map(func, array):
		return map(func,array)
	@staticmethod
	def array_merge(a,b):
		return a+b
	@staticmethod
	def strval(a):
		return str(a)
	@staticmethod
	def strpos(a,b):
		return a.find(b)
	@staticmethod
	def hash(a, b):
		if a == 'sha256':
			return hashlib.sha256(b.encode() ).hexdigest()
		elif a == 'md4':
			return hashlib.new("md4",b.encode('utf-16le')).hexdigest()
	def md5(a):
		m = hashlib.md5()
		m.update(a.encode('utf-8'))
		return m.hexdigest()
	@staticmethod
	def sha1(a):
		# https://rosettacode.org/wiki/SHA-1
		h = hashlib.sha1()
		h.update(bytes(a, encoding="ASCII"))
		return h.hexdigest()
	@staticmethod
	def gettype(a):
		if type(a) == bool:
			return "boolean"
		elif type(a) == int:
			return "integer"
		elif type(a) == str:
			return "string"
		elif type(a) == list:
			return "array"
		elif type(a) == float:
			return "double"
		elif type(a) == None:
			return "NULL"
class lua():
	class math(c_math):
		pass
	@staticmethod
	def min(*a):
		return min(a)
	@staticmethod
	def tostring(a):
		return str(a)
class haskell():
	@staticmethod
	def show(a):
		return str(a)
class go():
	class fmt:
		@staticmethod
		def Println(a):
			print(a)
class r():
	@staticmethod
	def mean(a):
		return statistics.mean(a)
	@staticmethod
	def median(a):
		return statistics.median(a)
	@staticmethod
	def sort(a):
		return sorted(a)
class wolfram(c_sharp_math):
	pass

java.System.out.println(1)
b = java.String("hello")
java.System.out.println(java.String("hello").length)
print(lua.min(3,4,5))
ruby.puts(3)
print(wolfram.Sin(3))
print(c_sharp.Math.Sin(3))
go.fmt.Println(3)
print(java.Double.parseDouble("3"))
print(javascript.Number.isInteger(3))
print(php.gettype(3))
print(prolog.append("3","4","34"))
print(java("hello").charAt(0))
print(php.sha1("Hello, World!"))
print(php.hash('md4', "Rosetta Code"))
print(php.md5("Hello!"))
print((javascript.JSON.stringify([1,2,3])) == "[1,2,3]")
print(perl.index("Hello","o"))
print(java.Integer.parseInt("3"))
print(java.Double.parseDouble("3.0"))
print(php.md5("blah"))

to_sort = [3,2,1]
php.sort(to_sort)
print(to_sort)
print(php.mt_rand(0,3))

def assign_if_not_exist(myVar):
	try:
		myVar
	except NameError:
		myVar = []
		
assign_if_not_exist(var1)
