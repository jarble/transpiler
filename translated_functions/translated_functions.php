class Python{
	private $self;
	public $re;
	public $math;
	public function __construct($self){
		$this->$self = $self;
		$this->$re = new class {
			static public function match($the_pattern,$the_string){
				return preg_match($the_pattern,$the_string);
			}
		};
		$this->$math = new class {
			static public function log($a){
				return log($a);
			}
		};
	}
	public function keys(){
		return array_keys($this->self);
	}
	public function pop(){
		return array_pop($this->self);
	}
	static public function any($the_list){
		return in_array(true,$the_list);
	}
	static public function all($the_list){
		foreach ($the_list as $value){
			if(Python::type($value) !== "bool" || $value !== true){
				return false;
			}
		}
		return true;
	}

	static public function reversed($the_list){
		return array_reverse($the_list);
	}
	public function count($a){
		return substr_count($this->self,$a);
	}
	public function tolower(){
		return strtolower($this->self);
	}
	public function toupper(){
		return strtoupper($this->self);
	}
	static public function print($a){
		echo $a;
	}
	static public function filter($func,$array){
		return array_filter($array,$func);
	}
	static public function type($a){
		if(gettype($a) === "string"){
			return "str";
		}
		else if(gettype($a) === "integer"){
			return "int";
		}
		else if(gettype($a) === "array"){
			return "list";
		}
		else if(gettype($a) === "double"){
			return "float";
		}
	}
	static function len($a){
		if(Python::type($a) === "str"){
			return strlen($a);
		}
		else if(Python::type($a) === "list"){
			return sizeof($a);
		}
	}
	function join($the_arr){
		return implode($this->self,$the_arr);
	}
}

class Prolog{
	static public function number($a){
		return is_numeric($a) && gettype($a) !== "string";
	}
	static public function append($a,$b,$c){
		return (Python.type($a) === "str") && $a . $b == $c;
	}
	static public function member($a,$b){
		return in_array($a,$b);
	}
}

class SQL{
	static public function REVERSE($a){
		return strrev($a);
	}
}
Python::print(Python::type(3.0));
