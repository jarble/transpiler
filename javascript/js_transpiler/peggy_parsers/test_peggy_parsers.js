var zig = require('./from_typescript/typescript_to_zig.js');

function parse(a){
	return zig.parse(a);
}
window.parse = parse;
