
module Python = {
	module math = {
		let sin a = f32.sin a
		let cos a = f32.cos a
		let tan a = f32.tan a
		let asin a = f32.asin a
		let acos a = f32.acos a
		let atan a = f32.atan a
		let ceil a = f32.ceil a
		let floor a = f32.floor a
		let sqrt a = f32.sqrt a
		let fact (n: i32): i32 = reduce (*) 1 (1...n)
		let pow ((a:f32), (b:f32)):f32 = a**b
	}
	module functools = {
		let reduce (a, b) = reduce a b
	}
	let map (a,b) = map a b
	let filter (a,b) = filter a b
	let any a = any a
	let all a = all a
	let len a = length a
	let reversed a = reverse a
}

module Javascript = {
	module Math{
	   include Python.math
	}
}

module Php = {
	let strrev a = (Python.reversed a) 
	include Python.math
}

module GLSL = {
	let fract a = (Python.abs a) - (Python.math.floor a)
	include Python.math
}

let main = Python.map(Python.math.floor,[3.1,4.2,5.3])
