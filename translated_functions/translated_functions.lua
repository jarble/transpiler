c_math = {
sin = function(a) return math.sin(a) end,
cos = function(a) return math.cos(a) end,
tan = function(a) return math.cos(a) end,
abs = function(x)
  return x >= 0 and x or -x
end
}

python = {
	filter = function(func, tbl)
     local newtbl= {}
     for i,v in pairs(tbl) do
         if func(v) then
	     newtbl[i]=v
         end
     end
     return newtbl
	end,
	statistics = {
    mean = function(t)
      local sum = 0
      local count= 0

      for k,v in pairs(t) do
        if type(v) == 'number' then
          sum = sum + v
          count = count + 1
        end
      end

      return (sum / count)
    end
  },
  math = c_math,
	map = function(predicate, t)
  	--http://inmatarian.github.io/2015/08/09/send_more_money/
	  local result = {}
	  for i = 1, #t do
		result[i] = predicate(t)
	  end
	  return result
	end,
  print = function(a) print(a) end,
}
php = {
	array_merge = function(t1,t2)
    for i=1,#t2 do
        t1[#t1+1] = t2[i]
    end
    return t1
  end,
  is_numeric = function(a) return tonumber(a) ~= nil end,
  array_keys = function(tab)
    --from https://stackoverflow.com/questions/12674345/lua-retrieve-list-of-keys-in-a-table
    local keyset={}
    local n=0
    for k,v in pairs(tab) do
      n=n+1
      keyset[n]=k
    end
    return keyset
  end,
  levenshtein = function(s,t)
  -- from https://rosettacode.org/wiki/Levenshtein_distance#Lua
    if s == '' then return t:len() end
    if t == '' then return s:len() end
 
    local s1 = s:sub(2, -1)
    local t1 = t:sub(2, -1)
 
    if s:sub(0, 1) == t:sub(0, 1) then
        return leven(s1, t1)
    end
 
    return 1 + math.min(
        leven(s1, t1),
        leven(s,  t1),
        leven(s1, t )
      )
  end,
  strtolower = function(a) return a:lower() end,
  strtoupper = function(a) return a:upper() end,
  explode = function(sep,inputstr)
        if sep == nil then
                sep = "%s"
        end
        local t={}
        for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
                table.insert(t, str)
        end
        return t
end,
	trim = function(a) return trim(a) end,
	strlen = function(a) return len end,
  echo = function(a) print(a) end
}
c = c_math
ruby = {puts=function(a) print(a) end}
perl = {uc = php.strtoupper,lc=php.strtolower}
python.abs = c_math.abs


-- Get the mean value of a table


-- Get the mode of a table.  Returns a table of values.
-- Works on anything (not just numbers).


print(python.print(1))
print(ruby.puts(1))
print(perl.uc("Hi"))
print(perl.lc("Hi"))
print(python.abs(3))
print(python.statistics.mean({1,2,5}))
