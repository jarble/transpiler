

struct Math_{
  float PI;
  float E;
  int sin;
  int cos;
  int tan;
  int min;
  int max;
  int pow;
  int exp;
};

struct java_{
    Math_ Math;
};

struct Python{
    Math_ math;
};

struct Lua{
    Math_ math;
};

java_ java = java_(Math_(PI,2.718281828459045,1,2,3,4,5));
lua_ lua = lua_(Math_(java.Math.PI,java.math.E,java.Math.sin,java.Math.cos,java.Math.tan,java.Math.min,java.Math.max,java.Math.pow,java.Math.exp));
python_ python = python_(Math_(java.Math.PI,java.math.E,java.Math.sin,java.Math.cos,java.Math.tan,java.Math.min,java.Math.max,java.Math.pow,java.Math.exp));

call()
