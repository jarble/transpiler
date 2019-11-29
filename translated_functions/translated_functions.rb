class Python
   def initialize(this)
	@this = this
   end
   def includes(item)
	return @this.include?(item)
   end
   def self.int(item)
	return item.to_i
   end
  def self.print(a)
    puts(a)
  end
  def self.map(a,b)
	return array.map { |n| n * 2 }
  end
   def self.str(item)
	return item.to_s
   end
   def self.float(item)
	return item.to_f
   end
   def self.len(item)
	return item.size
   end
   def keys()
	return @self.keys
   end
   def self.sorted(a)
	return a.sort!
	#return a copy of the array
   end
   def self.type(a)
	if a.kind_of?(Array) then
		return "Array"
	elsif [true, false].include? a then
		return "bool"
 	end
   end
end

class Javascript
   def initialize(this)
	@self= this
   end
   def includes(item)
	return @self.include?(item)
   end
   def split(item)
	return @self.split(item)
   end
   def re
    return Re
   end
   class Re
	  def self.compile(a)
		  return  /#{Regexp.quote(a)}/
	  end
   end
   class Console
    def self.log(a)
      Python.print(a)
    end
   end
  def console
    return Console
   end
end

class Php
   def initialize(this)
	  @self= this
   end
   def self.in_array(needle,haystack)
	  return new
   end
   def self.array_merge(a,b)
	  return a + b
   end
end
