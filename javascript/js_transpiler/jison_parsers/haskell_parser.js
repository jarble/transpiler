/* parser generated by jison 0.4.18 */
/*
  Returns a Parser object of the following structure:

  Parser: {
    yy: {}
  }

  Parser.prototype: {
    yy: {},
    trace: function(),
    symbols_: {associative list: name ==> number},
    terminals_: {associative list: number ==> name},
    productions_: [...],
    performAction: function anonymous(yytext, yyleng, yylineno, yy, yystate, $$, _$),
    table: [...],
    defaultActions: {...},
    parseError: function(str, hash),
    parse: function(input),

    lexer: {
        EOF: 1,
        parseError: function(str, hash),
        setInput: function(input),
        input: function(),
        unput: function(str),
        more: function(),
        less: function(n),
        pastInput: function(),
        upcomingInput: function(),
        showPosition: function(),
        test_match: function(regex_match_array, rule_index),
        next: function(),
        lex: function(),
        begin: function(condition),
        popState: function(),
        _currentRules: function(),
        topState: function(),
        pushState: function(condition),

        options: {
            ranges: boolean           (optional: true ==> token location info will include a .range[] member)
            flex: boolean             (optional: true ==> flex-like lexing behaviour where the rules are tested exhaustively to find the longest match)
            backtrack_lexer: boolean  (optional: true ==> lexer regexes are tested in order and for each matching regex the action code is invoked; the lexer terminates the scan when a token is returned by the action code)
        },

        performAction: function(yy, yy_, $avoiding_name_collisions, YY_START),
        rules: [...],
        conditions: {associative list: name ==> set},
    }
  }


  token location info (@$, _$, etc.): {
    first_line: n,
    last_line: n,
    first_column: n,
    last_column: n,
    range: [start_number, end_number]       (where the numbers are indexes into the input string, regular zero-based)
  }


  the parseError function receives a 'hash' object with these members for lexer and parser errors: {
    text:        (matched text)
    token:       (the produced terminal token, if any)
    line:        (yylineno)
  }
  while parser (grammar) errors will also provide these members, i.e. parser errors deliver a superset of attributes: {
    loc:         (yylloc)
    expected:    (string describing the set of expected tokens)
    recoverable: (boolean: TRUE when the parser has a error recovery rule available for this particular error)
  }
*/
var haskell_parser = (function(){
var o=function(k,v,o,l){for(o=o||{},l=k.length;l--;o[k[l]]=v);return o},$V0=[1,5],$V1=[1,4],$V2=[1,14],$V3=[1,15],$V4=[1,20],$V5=[1,34],$V6=[1,25],$V7=[1,26],$V8=[1,27],$V9=[1,28],$Va=[1,30],$Vb=[1,32],$Vc=[1,33],$Vd=[1,35],$Ve=[5,9,17],$Vf=[8,18,25],$Vg=[1,38],$Vh=[5,8,9,17,40,41,44,67,71,73,75],$Vi=[1,48],$Vj=[1,53],$Vk=[1,50],$Vl=[1,54],$Vm=[1,55],$Vn=[1,56],$Vo=[1,57],$Vp=[1,58],$Vq=[1,59],$Vr=[1,60],$Vs=[1,61],$Vt=[1,62],$Vu=[1,63],$Vv=[1,64],$Vw=[1,65],$Vx=[1,66],$Vy=[1,67],$Vz=[1,68],$VA=[1,69],$VB=[5,8,9,13,17,18,31,39,40,41,44,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,67,68,69,71,73,75],$VC=[5,8,9,13,17,18,25,31,35,39,40,41,44,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,63,67,68,69,71,73,75],$VD=[2,61],$VE=[5,8,9,17],$VF=[1,110],$VG=[2,74],$VH=[1,116],$VI=[5,8,9,13,17,18,31,39,40,41,44,46,47,48,49,50,51,52,53,67,68,69,71,73,75],$VJ=[5,8,9,13,17,18,31,39,40,41,44,46,47,48,49,50,51,52,53,54,55,56,67,68,69,71,73,75],$VK=[5,8,9,13,17,18,31,39,40,41,44,46,47,48,49,50,51,52,53,54,55,56,57,58,59,67,68,69,71,73,75],$VL=[1,135],$VM=[41,68],$VN=[13,20],$VO=[13,68];
var parser = {trace: function trace() { },
yy: {},
symbols_: {"error":2,"expressions":3,"statements_":4,"EOF":5,"statement_":6,"data_type_or":7,"|":8,"IDENTIFIER":9,"data_type_and":10,"struct_statements":11,"struct_statement":12,",":13,"identifiers":14,"::":15,"type":16,"data":17,"=":18,"{":19,"}":20,"parameters":21,"guard_if_statement":22,"types":23,"statements":24,"->":25,"statement":26,"statement_with_parentheses":27,"statement_with_semicolon":28,"if":29,"e":30,"then":31,"elif":32,"case":33,"parentheses_expr":34,"of":35,"case_statements":36,"let":37,"declare_vars":38,"in":39,"(":40,")":41,"case_statement":42,"case_statements_":43,"_":44,"declare_var":45,"||":46,"&&":47,"==":48,"/=":49,"<=":50,"<":51,">=":52,">":53,"++":54,"+":55,"-":56,"*":57,"/":58,"mod":59,"**":60,"^":61,"access_array":62,"!!":63,"access_arr":64,"\\\\":65,"exprs":66,"[":67,"]":68,"<-":69,"list_comprehensions":70,"NUMBER":71,"args":72,"STRING_LITERAL":73,"parameter":74,"else":75,"guard_elif":76,"otherwise":77,"$accept":0,"$end":1},
terminals_: {2:"error",5:"EOF",8:"|",9:"IDENTIFIER",13:",",15:"::",17:"data",18:"=",19:"{",20:"}",25:"->",29:"if",31:"then",33:"case",35:"of",37:"let",39:"in",40:"(",41:")",44:"_",46:"||",47:"&&",48:"==",49:"/=",50:"<=",51:"<",52:">=",53:">",54:"++",55:"+",56:"-",57:"*",58:"/",59:"mod",60:"**",61:"^",63:"!!",65:"\\\\",67:"[",68:"]",69:"<-",71:"NUMBER",73:"STRING_LITERAL",75:"else",77:"otherwise"},
productions_: [0,[3,2],[4,2],[4,1],[7,3],[7,1],[10,2],[10,1],[11,3],[11,1],[12,3],[6,4],[6,7],[6,3],[6,7],[6,4],[6,3],[6,2],[23,3],[23,1],[26,1],[26,1],[27,5],[27,4],[27,4],[27,3],[42,3],[43,2],[43,1],[36,4],[45,3],[38,2],[38,1],[28,1],[30,3],[30,3],[30,3],[30,3],[30,3],[30,3],[30,3],[30,3],[30,3],[30,3],[30,3],[30,3],[30,3],[30,3],[30,3],[30,3],[30,2],[30,1],[62,3],[34,6],[34,3],[34,5],[34,2],[34,3],[34,7],[34,9],[34,1],[34,1],[34,3],[34,4],[34,1],[70,5],[70,1],[16,1],[74,1],[21,2],[21,1],[64,3],[64,1],[66,3],[66,1],[72,2],[72,1],[32,2],[14,3],[14,1],[22,5],[76,5],[76,4],[24,1]],
performAction: function anonymous(yytext, yyleng, yylineno, yy, yystate /* action[1] */, $$ /* vstack */, _$ /* lstack */) {
/* this == yyval */

var $0 = $$.length - 1;
switch (yystate) {
case 1:
return ["top_level_statements",$$[$0-1]]
break;
case 2: case 27: case 31: case 69: case 75:
this.$ = [$$[$0-1]].concat($$[$0]);
break;
case 3: case 9: case 19: case 28: case 32: case 70: case 72:
this.$ =
 [$$[$0]];
break;
case 4:
this.$ = ["data_type_or",$$[$0-2],$$[$0]];
break;
case 6:
this.$ = ["data_type_and",$$[$0-1],$$[$0]];
break;
case 7: case 20: case 51:
this.$ = $$[$0];
break;
case 8: case 18: case 71: case 73: case 78:
this.$ = [$$[$0-2]].concat($$[$0]);
break;
case 10:
this.$ = ["struct_statement",$$[$0],$$[$0-2]];
break;
case 11:
this.$ = ["algebraic_data_type",$$[$0-2],$$[$0]];
break;
case 12:
this.$ = ["struct",$$[$0-5],["struct_statements",$$[$0-1]]]
break;
case 13:
this.$ = ["function","public","Object",$$[$0-2],$$[$0-1],$$[$0]];
break;
case 14:

		var types = $$[$0-4];
		var parameter_names = $$[$0-2];
		var parameters = [];
		for(var i = 0; i < parameter_names.length; i++){
			parameters.push([types[i],parameter_names[i][1]]);
		}
		this.$ = ["function","public",types[types.length-1],$$[$0-6],parameters,$$[$0]];
	
break;
case 15:
this.$ = ["function","public","Object",$$[$0-3],$$[$0-2],$$[$0]];
break;
case 16:
this.$ = ["function","public","Object",$$[$0-2],[],$$[$0]];
break;
case 17:
this.$ = ["function","public","Object",$$[$0-1],[],$$[$0]];
break;
case 21:
this.$ = ["semicolon",$$[$0]];
break;
case 22: case 80:
this.$ = ["if",$$[$0-3],$$[$0-1],$$[$0]];
break;
case 23:
this.$ = ["switch",$$[$0-2],$$[$0]];
break;
case 24:
this.$ = ["lexically_scoped_vars",$$[$0-2],$$[$0]];
break;
case 25: case 54: case 62:
this.$ = $$[$0-1]
break;
case 26:
this.$ = ["case",$$[$0-2],$$[$0]]
break;
case 29:
this.$ = $$[$0-3].concat([["default",["statements",$$[$0]]]])
break;
case 30:
this.$ = ["lexically_scoped_var","Object",$$[$0-2],$$[$0]]
break;
case 33:
this.$ = ["return",$$[$0]];
break;
case 34: case 35: case 36: case 38: case 39: case 40: case 41: case 42: case 43: case 44: case 45: case 46: case 48:
this.$ = [$$[$0-1],$$[$0-2],$$[$0]];
break;
case 37:
this.$ = ['!=',$$[$0-2],$$[$0]];
break;
case 47:
this.$ = ["%",$$[$0-2],$$[$0]];
break;
case 49:
this.$ = ["**",$$[$0-2],$$[$0]];
break;
case 50:
this.$ = ["-",$$[$0]];
break;
case 52:
this.$ = ["access_array",$$[$0-2],[$$[$0]]];
break;
case 53:
this.$ = ["anonymous_function","Object",$$[$0-3],["statements",[["semicolon",["return",$$[$0-1]]]]]];
break;
case 55:
this.$ = ["initialize_tuple","Object",[$$[$0-3]].concat($$[$0-1])];
break;
case 56:
this.$ = ["initializer_list","Object",[]];
break;
case 57:
this.$ = ["initializer_list","Object",$$[$0-1]];
break;
case 58:
this.$ = ["list_comprehension",$$[$0-5],$$[$0-3],$$[$0-1]];
break;
case 59:
this.$ = ["list_comprehension",$$[$0-7],$$[$0-5],$$[$0-3],$$[$0-1]];
break;
case 60: case 64:
this.$ = yytext;
break;
case 63:

			if($$[$0-2] === "not"){
				this.$ = ["!",$$[$0-1]];
			}
			else{
				this.$ = ["function_call",$$[$0-2],$$[$0-1]];
			}
		
break;
case 65:
this.$ = ["list_comprehensions",$$[$0-4],$$[$0-2],$$[$0]];
break;
case 68:
this.$ = ["Object",$$[$0]];
break;
case 74: case 76: case 79:
this.$ = [$$[$0]];
break;
case 77: case 82:
this.$ = ["else",$$[$0]];
break;
case 81:
this.$ = ["elif",$$[$0-3],$$[$0-1],$$[$0]];
break;
case 83:
this.$ = ["statements",[$$[$0]]]
break;
}
},
table: [{3:1,4:2,6:3,9:$V0,17:$V1},{1:[3]},{5:[1,6]},{4:7,5:[2,3],6:3,9:$V0,17:$V1},{9:[1,8]},{8:$V2,9:$V3,15:[1,10],18:[1,11],21:9,22:12,74:13},{1:[2,1]},{5:[2,2]},{18:[1,16]},{8:$V2,18:[1,18],22:17},{9:$V4,23:19},{9:$V5,24:21,26:22,27:23,28:24,29:$V6,30:29,33:$V7,34:31,37:$V8,40:$V9,56:$Va,67:$Vb,71:$Vc,73:$Vd},o($Ve,[2,17]),o($Vf,[2,70],{74:13,21:36,9:$V3}),{9:$V5,30:37,34:31,40:$Vg,56:$Va,67:$Vb,71:$Vc,73:$Vd},o([8,9,18,25],[2,68]),{7:39,9:[1,40]},o($Ve,[2,13]),{9:$V5,24:41,26:22,27:23,28:24,29:$V6,30:29,33:$V7,34:31,37:$V8,40:$V9,56:$Va,67:$Vb,71:$Vc,73:$Vd},{9:[1,42]},{9:[2,19],25:[1,43]},o($Ve,[2,16]),o($Vh,[2,83]),o($Vh,[2,20]),o($Vh,[2,21]),{9:$V5,30:44,34:31,40:$Vg,56:$Va,67:$Vb,71:$Vc,73:$Vd},{9:$V5,34:45,40:$Vg,67:$Vb,71:$Vc,73:$Vd},{9:$Vi,38:46,45:47},{9:$Vj,27:49,29:$V6,30:52,33:$V7,34:31,37:$V8,40:$V9,56:$Va,62:51,65:$Vk,67:$Vb,71:$Vc,73:$Vd},o($Vh,[2,33],{46:$Vl,47:$Vm,48:$Vn,49:$Vo,50:$Vp,51:$Vq,52:$Vr,53:$Vs,54:$Vt,55:$Vu,56:$Vv,57:$Vw,58:$Vx,59:$Vy,60:$Vz,61:$VA}),{9:$V5,30:70,34:31,40:$Vg,56:$Va,67:$Vb,71:$Vc,73:$Vd},o($VB,[2,51]),{9:$V5,30:73,34:31,40:$Vg,56:$Va,66:72,67:$Vb,68:[1,71],71:$Vc,73:$Vd},o($VC,[2,60]),o($VC,$VD),o($VC,[2,64]),o($Vf,[2,69]),{18:[1,74],46:$Vl,47:$Vm,48:$Vn,49:$Vo,50:$Vp,51:$Vq,52:$Vr,53:$Vs,54:$Vt,55:$Vu,56:$Vv,57:$Vw,58:$Vx,59:$Vy,60:$Vz,61:$VA},{9:$Vj,30:52,34:31,40:$Vg,56:$Va,62:51,65:$Vk,67:$Vb,71:$Vc,73:$Vd},o($Ve,[2,11],{8:[1,75]}),o($VE,[2,5],{19:[1,76]}),o($Ve,[2,15]),{9:$V3,21:77,74:13},{9:$V4,23:78},{31:[1,79],46:$Vl,47:$Vm,48:$Vn,49:$Vo,50:$Vp,51:$Vq,52:$Vr,53:$Vs,54:$Vt,55:$Vu,56:$Vv,57:$Vw,58:$Vx,59:$Vy,60:$Vz,61:$VA},{35:[1,80]},{39:[1,81]},{9:$Vi,38:82,39:[2,32],45:47},{18:[1,83]},{41:[1,84]},{9:$V3,21:85,74:13},{41:[1,86]},{13:[1,87],41:[1,88],46:$Vl,47:$Vm,48:$Vn,49:$Vo,50:$Vp,51:$Vq,52:$Vr,53:$Vs,54:$Vt,55:$Vu,56:$Vv,57:$Vw,58:$Vx,59:$Vy,60:$Vz,61:$VA},o([13,41,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61],$VD,{72:89,34:91,9:$V5,40:$Vg,63:[1,90],67:$Vb,71:$Vc,73:$Vd}),{9:$V5,30:92,34:31,40:$Vg,56:$Va,67:$Vb,71:$Vc,73:$Vd},{9:$V5,30:93,34:31,40:$Vg,56:$Va,67:$Vb,71:$Vc,73:$Vd},{9:$V5,30:94,34:31,40:$Vg,56:$Va,67:$Vb,71:$Vc,73:$Vd},{9:$V5,30:95,34:31,40:$Vg,56:$Va,67:$Vb,71:$Vc,73:$Vd},{9:$V5,30:96,34:31,40:$Vg,56:$Va,67:$Vb,71:$Vc,73:$Vd},{9:$V5,30:97,34:31,40:$Vg,56:$Va,67:$Vb,71:$Vc,73:$Vd},{9:$V5,30:98,34:31,40:$Vg,56:$Va,67:$Vb,71:$Vc,73:$Vd},{9:$V5,30:99,34:31,40:$Vg,56:$Va,67:$Vb,71:$Vc,73:$Vd},{9:$V5,30:100,34:31,40:$Vg,56:$Va,67:$Vb,71:$Vc,73:$Vd},{9:$V5,30:101,34:31,40:$Vg,56:$Va,67:$Vb,71:$Vc,73:$Vd},{9:$V5,30:102,34:31,40:$Vg,56:$Va,67:$Vb,71:$Vc,73:$Vd},{9:$V5,30:103,34:31,40:$Vg,56:$Va,67:$Vb,71:$Vc,73:$Vd},{9:$V5,30:104,34:31,40:$Vg,56:$Va,67:$Vb,71:$Vc,73:$Vd},{9:$V5,30:105,34:31,40:$Vg,56:$Va,67:$Vb,71:$Vc,73:$Vd},{9:$V5,30:106,34:31,40:$Vg,56:$Va,67:$Vb,71:$Vc,73:$Vd},{9:$V5,30:107,34:31,40:$Vg,56:$Va,67:$Vb,71:$Vc,73:$Vd},o($VB,[2,50]),o($VC,[2,56]),{68:[1,108]},{8:[1,109],13:$VF,46:$Vl,47:$Vm,48:$Vn,49:$Vo,50:$Vp,51:$Vq,52:$Vr,53:$Vs,54:$Vt,55:$Vu,56:$Vv,57:$Vw,58:$Vx,59:$Vy,60:$Vz,61:$VA,68:$VG},{9:$V5,24:111,26:22,27:23,28:24,29:$V6,30:29,33:$V7,34:31,37:$V8,40:$V9,56:$Va,67:$Vb,71:$Vc,73:$Vd},{9:[1,112]},{9:$VH,11:113,12:114,14:115},{18:[1,117]},{9:[2,18]},{9:$V5,24:118,26:22,27:23,28:24,29:$V6,30:29,33:$V7,34:31,37:$V8,40:$V9,56:$Va,67:$Vb,71:$Vc,73:$Vd},{9:$V5,34:122,36:119,40:$Vg,42:121,43:120,67:$Vb,71:$Vc,73:$Vd},{9:$V5,24:123,26:22,27:23,28:24,29:$V6,30:29,33:$V7,34:31,37:$V8,40:$V9,56:$Va,67:$Vb,71:$Vc,73:$Vd},{39:[2,31]},{9:$V5,30:124,34:31,40:$Vg,56:$Va,67:$Vb,71:$Vc,73:$Vd},o($Vh,[2,25]),{25:[1,125]},o($VC,[2,54]),{9:$V5,30:127,34:31,40:$Vg,56:$Va,66:126,67:$Vb,71:$Vc,73:$Vd},o($VC,[2,62]),{41:[1,128]},{9:$V5,34:130,40:$Vg,64:129,67:$Vb,71:$Vc,73:$Vd},{9:$V5,34:91,40:$Vg,41:[2,76],67:$Vb,71:$Vc,72:131,73:$Vd},o([5,8,9,13,17,18,31,39,40,41,44,46,67,68,69,71,73,75],[2,34],{47:$Vm,48:$Vn,49:$Vo,50:$Vp,51:$Vq,52:$Vr,53:$Vs,54:$Vt,55:$Vu,56:$Vv,57:$Vw,58:$Vx,59:$Vy,60:$Vz,61:$VA}),o([5,8,9,13,17,18,31,39,40,41,44,46,47,67,68,69,71,73,75],[2,35],{48:$Vn,49:$Vo,50:$Vp,51:$Vq,52:$Vr,53:$Vs,54:$Vt,55:$Vu,56:$Vv,57:$Vw,58:$Vx,59:$Vy,60:$Vz,61:$VA}),o($VI,[2,36],{54:$Vt,55:$Vu,56:$Vv,57:$Vw,58:$Vx,59:$Vy,60:$Vz,61:$VA}),o($VI,[2,37],{54:$Vt,55:$Vu,56:$Vv,57:$Vw,58:$Vx,59:$Vy,60:$Vz,61:$VA}),o($VI,[2,38],{54:$Vt,55:$Vu,56:$Vv,57:$Vw,58:$Vx,59:$Vy,60:$Vz,61:$VA}),o($VI,[2,39],{54:$Vt,55:$Vu,56:$Vv,57:$Vw,58:$Vx,59:$Vy,60:$Vz,61:$VA}),o($VI,[2,40],{54:$Vt,55:$Vu,56:$Vv,57:$Vw,58:$Vx,59:$Vy,60:$Vz,61:$VA}),o($VI,[2,41],{54:$Vt,55:$Vu,56:$Vv,57:$Vw,58:$Vx,59:$Vy,60:$Vz,61:$VA}),o($VJ,[2,42],{57:$Vw,58:$Vx,59:$Vy,60:$Vz,61:$VA}),o($VJ,[2,43],{57:$Vw,58:$Vx,59:$Vy,60:$Vz,61:$VA}),o($VJ,[2,44],{57:$Vw,58:$Vx,59:$Vy,60:$Vz,61:$VA}),o($VK,[2,45],{60:$Vz,61:$VA}),o($VK,[2,46],{60:$Vz,61:$VA}),o($VK,[2,47],{60:$Vz,61:$VA}),o($VB,[2,48]),o($VB,[2,49]),o($VC,[2,57]),{9:$V5,30:132,34:31,40:$Vg,56:$Va,67:$Vb,71:$Vc,73:$Vd},{9:$V5,30:127,34:31,40:$Vg,56:$Va,66:133,67:$Vb,71:$Vc,73:$Vd},{8:$VL,76:134},o($VE,[2,4]),{20:[1,136]},{13:[1,137],20:[2,9]},{15:[1,138]},{13:[1,139],15:[2,79]},{9:$V5,24:140,26:22,27:23,28:24,29:$V6,30:29,33:$V7,34:31,37:$V8,40:$V9,56:$Va,67:$Vb,71:$Vc,73:$Vd},{32:141,75:[1,142]},o($Vh,[2,23]),{44:[1,143]},{9:$V5,34:122,40:$Vg,42:121,43:144,44:[2,28],67:$Vb,71:$Vc,73:$Vd},{25:[1,145]},o($Vh,[2,24]),o([9,39],[2,30],{46:$Vl,47:$Vm,48:$Vn,49:$Vo,50:$Vp,51:$Vq,52:$Vr,53:$Vs,54:$Vt,55:$Vu,56:$Vv,57:$Vw,58:$Vx,59:$Vy,60:$Vz,61:$VA}),{9:$V5,30:146,34:31,40:$Vg,56:$Va,67:$Vb,71:$Vc,73:$Vd},{41:[1,147]},o($VM,$VG,{13:$VF,46:$Vl,47:$Vm,48:$Vn,49:$Vo,50:$Vp,51:$Vq,52:$Vr,53:$Vs,54:$Vt,55:$Vu,56:$Vv,57:$Vw,58:$Vx,59:$Vy,60:$Vz,61:$VA}),o($VC,[2,63]),{41:[2,52]},{41:[2,72],63:[1,148]},{41:[2,75]},{46:$Vl,47:$Vm,48:$Vn,49:$Vo,50:$Vp,51:$Vq,52:$Vr,53:$Vs,54:$Vt,55:$Vu,56:$Vv,57:$Vw,58:$Vx,59:$Vy,60:$Vz,61:$VA,69:[1,149]},o($VM,[2,73]),o($Ve,[2,80]),{9:$V5,30:150,34:31,40:$Vg,56:$Va,67:$Vb,71:$Vc,73:$Vd,77:[1,151]},o($Ve,[2,12]),{9:$VH,11:152,12:114,14:115},{9:[1,154],16:153},{9:$VH,14:155},o($Ve,[2,14]),o($Vh,[2,22]),{9:$V5,24:156,26:22,27:23,28:24,29:$V6,30:29,33:$V7,34:31,37:$V8,40:$V9,56:$Va,67:$Vb,71:$Vc,73:$Vd},{25:[1,157]},{44:[2,27]},{9:$V5,24:158,26:22,27:23,28:24,29:$V6,30:29,33:$V7,34:31,37:$V8,40:$V9,56:$Va,67:$Vb,71:$Vc,73:$Vd},{41:[1,159],46:$Vl,47:$Vm,48:$Vn,49:$Vo,50:$Vp,51:$Vq,52:$Vr,53:$Vs,54:$Vt,55:$Vu,56:$Vv,57:$Vw,58:$Vx,59:$Vy,60:$Vz,61:$VA},o($VC,[2,55]),{9:$V5,34:130,40:$Vg,64:160,67:$Vb,71:$Vc,73:$Vd},{9:$V5,30:162,34:31,40:$Vg,56:$Va,67:$Vb,70:161,71:$Vc,73:$Vd},{18:[1,163],46:$Vl,47:$Vm,48:$Vn,49:$Vo,50:$Vp,51:$Vq,52:$Vr,53:$Vs,54:$Vt,55:$Vu,56:$Vv,57:$Vw,58:$Vx,59:$Vy,60:$Vz,61:$VA},{18:[1,164]},{20:[2,8]},o($VN,[2,10]),o($VN,[2,67]),{15:[2,78]},o($Vh,[2,77]),{9:$V5,24:165,26:22,27:23,28:24,29:$V6,30:29,33:$V7,34:31,37:$V8,40:$V9,56:$Va,67:$Vb,71:$Vc,73:$Vd},o([9,40,44,67,71,73],[2,26]),o($VC,[2,53]),{41:[2,71]},{13:[1,167],68:[1,166]},o($VO,[2,66],{46:$Vl,47:$Vm,48:$Vn,49:$Vo,50:$Vp,51:$Vq,52:$Vr,53:$Vs,54:$Vt,55:$Vu,56:$Vv,57:$Vw,58:$Vx,59:$Vy,60:$Vz,61:$VA}),{9:$V5,24:168,26:22,27:23,28:24,29:$V6,30:29,33:$V7,34:31,37:$V8,40:$V9,56:$Va,67:$Vb,71:$Vc,73:$Vd},{9:$V5,24:169,26:22,27:23,28:24,29:$V6,30:29,33:$V7,34:31,37:$V8,40:$V9,56:$Va,67:$Vb,71:$Vc,73:$Vd},o($Vh,[2,29]),o($VC,[2,58]),{9:$V5,30:170,34:31,40:$Vg,56:$Va,67:$Vb,71:$Vc,73:$Vd},{8:$VL,76:171},o($Ve,[2,82]),{46:$Vl,47:$Vm,48:$Vn,49:$Vo,50:$Vp,51:$Vq,52:$Vr,53:$Vs,54:$Vt,55:$Vu,56:$Vv,57:$Vw,58:$Vx,59:$Vy,60:$Vz,61:$VA,68:[1,172],69:[1,173]},o($Ve,[2,81]),o($VC,[2,59]),{9:$V5,30:174,34:31,40:$Vg,56:$Va,67:$Vb,71:$Vc,73:$Vd},o($VO,[2,65],{46:$Vl,47:$Vm,48:$Vn,49:$Vo,50:$Vp,51:$Vq,52:$Vr,53:$Vs,54:$Vt,55:$Vu,56:$Vv,57:$Vw,58:$Vx,59:$Vy,60:$Vz,61:$VA})],
defaultActions: {6:[2,1],7:[2,2],78:[2,18],82:[2,31],129:[2,52],131:[2,75],144:[2,27],152:[2,8],155:[2,78],160:[2,71]},
parseError: function parseError(str, hash) {
    if (hash.recoverable) {
        this.trace(str);
    } else {
        var error = new Error(str);
        error.hash = hash;
        throw error;
    }
},
parse: function parse(input) {
    var self = this, stack = [0], tstack = [], vstack = [null], lstack = [], table = this.table, yytext = '', yylineno = 0, yyleng = 0, recovering = 0, TERROR = 2, EOF = 1;
    var args = lstack.slice.call(arguments, 1);
    var lexer = Object.create(this.lexer);
    var sharedState = { yy: {} };
    for (var k in this.yy) {
        if (Object.prototype.hasOwnProperty.call(this.yy, k)) {
            sharedState.yy[k] = this.yy[k];
        }
    }
    lexer.setInput(input, sharedState.yy);
    sharedState.yy.lexer = lexer;
    sharedState.yy.parser = this;
    if (typeof lexer.yylloc == 'undefined') {
        lexer.yylloc = {};
    }
    var yyloc = lexer.yylloc;
    lstack.push(yyloc);
    var ranges = lexer.options && lexer.options.ranges;
    if (typeof sharedState.yy.parseError === 'function') {
        this.parseError = sharedState.yy.parseError;
    } else {
        this.parseError = Object.getPrototypeOf(this).parseError;
    }
    function popStack(n) {
        stack.length = stack.length - 2 * n;
        vstack.length = vstack.length - n;
        lstack.length = lstack.length - n;
    }
    _token_stack:
        var lex = function () {
            var token;
            token = lexer.lex() || EOF;
            if (typeof token !== 'number') {
                token = self.symbols_[token] || token;
            }
            return token;
        };
    var symbol, preErrorSymbol, state, action, a, r, yyval = {}, p, len, newState, expected;
    while (true) {
        state = stack[stack.length - 1];
        if (this.defaultActions[state]) {
            action = this.defaultActions[state];
        } else {
            if (symbol === null || typeof symbol == 'undefined') {
                symbol = lex();
            }
            action = table[state] && table[state][symbol];
        }
                    if (typeof action === 'undefined' || !action.length || !action[0]) {
                var errStr = '';
                expected = [];
                for (p in table[state]) {
                    if (this.terminals_[p] && p > TERROR) {
                        expected.push('\'' + this.terminals_[p] + '\'');
                    }
                }
                if (lexer.showPosition) {
                    errStr = 'Parse error on line ' + (yylineno + 1) + ':\n' + lexer.showPosition() + '\nExpecting ' + expected.join(', ') + ', got \'' + (this.terminals_[symbol] || symbol) + '\'';
                } else {
                    errStr = 'Parse error on line ' + (yylineno + 1) + ': Unexpected ' + (symbol == EOF ? 'end of input' : '\'' + (this.terminals_[symbol] || symbol) + '\'');
                }
                this.parseError(errStr, {
                    text: lexer.match,
                    token: this.terminals_[symbol] || symbol,
                    line: lexer.yylineno,
                    loc: yyloc,
                    expected: expected
                });
            }
        if (action[0] instanceof Array && action.length > 1) {
            throw new Error('Parse Error: multiple actions possible at state: ' + state + ', token: ' + symbol);
        }
        switch (action[0]) {
        case 1:
            stack.push(symbol);
            vstack.push(lexer.yytext);
            lstack.push(lexer.yylloc);
            stack.push(action[1]);
            symbol = null;
            if (!preErrorSymbol) {
                yyleng = lexer.yyleng;
                yytext = lexer.yytext;
                yylineno = lexer.yylineno;
                yyloc = lexer.yylloc;
                if (recovering > 0) {
                    recovering--;
                }
            } else {
                symbol = preErrorSymbol;
                preErrorSymbol = null;
            }
            break;
        case 2:
            len = this.productions_[action[1]][1];
            yyval.$ = vstack[vstack.length - len];
            yyval._$ = {
                first_line: lstack[lstack.length - (len || 1)].first_line,
                last_line: lstack[lstack.length - 1].last_line,
                first_column: lstack[lstack.length - (len || 1)].first_column,
                last_column: lstack[lstack.length - 1].last_column
            };
            if (ranges) {
                yyval._$.range = [
                    lstack[lstack.length - (len || 1)].range[0],
                    lstack[lstack.length - 1].range[1]
                ];
            }
            r = this.performAction.apply(yyval, [
                yytext,
                yyleng,
                yylineno,
                sharedState.yy,
                action[1],
                vstack,
                lstack
            ].concat(args));
            if (typeof r !== 'undefined') {
                return r;
            }
            if (len) {
                stack = stack.slice(0, -1 * len * 2);
                vstack = vstack.slice(0, -1 * len);
                lstack = lstack.slice(0, -1 * len);
            }
            stack.push(this.productions_[action[1]][0]);
            vstack.push(yyval.$);
            lstack.push(yyval._$);
            newState = table[stack[stack.length - 2]][stack[stack.length - 1]];
            stack.push(newState);
            break;
        case 3:
            return true;
        }
    }
    return true;
}};
/* generated by jison-lex 0.3.4 */
var lexer = (function(){
var lexer = ({

EOF:1,

parseError:function parseError(str, hash) {
        if (this.yy.parser) {
            this.yy.parser.parseError(str, hash);
        } else {
            throw new Error(str);
        }
    },

// resets the lexer, sets new input
setInput:function (input, yy) {
        this.yy = yy || this.yy || {};
        this._input = input;
        this._more = this._backtrack = this.done = false;
        this.yylineno = this.yyleng = 0;
        this.yytext = this.matched = this.match = '';
        this.conditionStack = ['INITIAL'];
        this.yylloc = {
            first_line: 1,
            first_column: 0,
            last_line: 1,
            last_column: 0
        };
        if (this.options.ranges) {
            this.yylloc.range = [0,0];
        }
        this.offset = 0;
        return this;
    },

// consumes and returns one char from the input
input:function () {
        var ch = this._input[0];
        this.yytext += ch;
        this.yyleng++;
        this.offset++;
        this.match += ch;
        this.matched += ch;
        var lines = ch.match(/(?:\r\n?|\n).*/g);
        if (lines) {
            this.yylineno++;
            this.yylloc.last_line++;
        } else {
            this.yylloc.last_column++;
        }
        if (this.options.ranges) {
            this.yylloc.range[1]++;
        }

        this._input = this._input.slice(1);
        return ch;
    },

// unshifts one char (or a string) into the input
unput:function (ch) {
        var len = ch.length;
        var lines = ch.split(/(?:\r\n?|\n)/g);

        this._input = ch + this._input;
        this.yytext = this.yytext.substr(0, this.yytext.length - len);
        //this.yyleng -= len;
        this.offset -= len;
        var oldLines = this.match.split(/(?:\r\n?|\n)/g);
        this.match = this.match.substr(0, this.match.length - 1);
        this.matched = this.matched.substr(0, this.matched.length - 1);

        if (lines.length - 1) {
            this.yylineno -= lines.length - 1;
        }
        var r = this.yylloc.range;

        this.yylloc = {
            first_line: this.yylloc.first_line,
            last_line: this.yylineno + 1,
            first_column: this.yylloc.first_column,
            last_column: lines ?
                (lines.length === oldLines.length ? this.yylloc.first_column : 0)
                 + oldLines[oldLines.length - lines.length].length - lines[0].length :
              this.yylloc.first_column - len
        };

        if (this.options.ranges) {
            this.yylloc.range = [r[0], r[0] + this.yyleng - len];
        }
        this.yyleng = this.yytext.length;
        return this;
    },

// When called from action, caches matched text and appends it on next action
more:function () {
        this._more = true;
        return this;
    },

// When called from action, signals the lexer that this rule fails to match the input, so the next matching rule (regex) should be tested instead.
reject:function () {
        if (this.options.backtrack_lexer) {
            this._backtrack = true;
        } else {
            return this.parseError('Lexical error on line ' + (this.yylineno + 1) + '. You can only invoke reject() in the lexer when the lexer is of the backtracking persuasion (options.backtrack_lexer = true).\n' + this.showPosition(), {
                text: "",
                token: null,
                line: this.yylineno
            });

        }
        return this;
    },

// retain first n characters of the match
less:function (n) {
        this.unput(this.match.slice(n));
    },

// displays already matched input, i.e. for error messages
pastInput:function () {
        var past = this.matched.substr(0, this.matched.length - this.match.length);
        return (past.length > 20 ? '...':'') + past.substr(-20).replace(/\n/g, "");
    },

// displays upcoming input, i.e. for error messages
upcomingInput:function () {
        var next = this.match;
        if (next.length < 20) {
            next += this._input.substr(0, 20-next.length);
        }
        return (next.substr(0,20) + (next.length > 20 ? '...' : '')).replace(/\n/g, "");
    },

// displays the character position where the lexing error occurred, i.e. for error messages
showPosition:function () {
        var pre = this.pastInput();
        var c = new Array(pre.length + 1).join("-");
        return pre + this.upcomingInput() + "\n" + c + "^";
    },

// test the lexed token: return FALSE when not a match, otherwise return token
test_match:function (match, indexed_rule) {
        var token,
            lines,
            backup;

        if (this.options.backtrack_lexer) {
            // save context
            backup = {
                yylineno: this.yylineno,
                yylloc: {
                    first_line: this.yylloc.first_line,
                    last_line: this.last_line,
                    first_column: this.yylloc.first_column,
                    last_column: this.yylloc.last_column
                },
                yytext: this.yytext,
                match: this.match,
                matches: this.matches,
                matched: this.matched,
                yyleng: this.yyleng,
                offset: this.offset,
                _more: this._more,
                _input: this._input,
                yy: this.yy,
                conditionStack: this.conditionStack.slice(0),
                done: this.done
            };
            if (this.options.ranges) {
                backup.yylloc.range = this.yylloc.range.slice(0);
            }
        }

        lines = match[0].match(/(?:\r\n?|\n).*/g);
        if (lines) {
            this.yylineno += lines.length;
        }
        this.yylloc = {
            first_line: this.yylloc.last_line,
            last_line: this.yylineno + 1,
            first_column: this.yylloc.last_column,
            last_column: lines ?
                         lines[lines.length - 1].length - lines[lines.length - 1].match(/\r?\n?/)[0].length :
                         this.yylloc.last_column + match[0].length
        };
        this.yytext += match[0];
        this.match += match[0];
        this.matches = match;
        this.yyleng = this.yytext.length;
        if (this.options.ranges) {
            this.yylloc.range = [this.offset, this.offset += this.yyleng];
        }
        this._more = false;
        this._backtrack = false;
        this._input = this._input.slice(match[0].length);
        this.matched += match[0];
        token = this.performAction.call(this, this.yy, this, indexed_rule, this.conditionStack[this.conditionStack.length - 1]);
        if (this.done && this._input) {
            this.done = false;
        }
        if (token) {
            return token;
        } else if (this._backtrack) {
            // recover context
            for (var k in backup) {
                this[k] = backup[k];
            }
            return false; // rule action called reject() implying the next rule should be tested instead.
        }
        return false;
    },

// return next match in input
next:function () {
        if (this.done) {
            return this.EOF;
        }
        if (!this._input) {
            this.done = true;
        }

        var token,
            match,
            tempMatch,
            index;
        if (!this._more) {
            this.yytext = '';
            this.match = '';
        }
        var rules = this._currentRules();
        for (var i = 0; i < rules.length; i++) {
            tempMatch = this._input.match(this.rules[rules[i]]);
            if (tempMatch && (!match || tempMatch[0].length > match[0].length)) {
                match = tempMatch;
                index = i;
                if (this.options.backtrack_lexer) {
                    token = this.test_match(tempMatch, rules[i]);
                    if (token !== false) {
                        return token;
                    } else if (this._backtrack) {
                        match = false;
                        continue; // rule action called reject() implying a rule MISmatch.
                    } else {
                        // else: this is a lexer rule which consumes input without producing a token (e.g. whitespace)
                        return false;
                    }
                } else if (!this.options.flex) {
                    break;
                }
            }
        }
        if (match) {
            token = this.test_match(match, rules[index]);
            if (token !== false) {
                return token;
            }
            // else: this is a lexer rule which consumes input without producing a token (e.g. whitespace)
            return false;
        }
        if (this._input === "") {
            return this.EOF;
        } else {
            return this.parseError('Lexical error on line ' + (this.yylineno + 1) + '. Unrecognized text.\n' + this.showPosition(), {
                text: "",
                token: null,
                line: this.yylineno
            });
        }
    },

// return next match that has a token
lex:function lex() {
        var r = this.next();
        if (r) {
            return r;
        } else {
            return this.lex();
        }
    },

// activates a new lexer condition state (pushes the new lexer condition state onto the condition stack)
begin:function begin(condition) {
        this.conditionStack.push(condition);
    },

// pop the previously active lexer condition state off the condition stack
popState:function popState() {
        var n = this.conditionStack.length - 1;
        if (n > 0) {
            return this.conditionStack.pop();
        } else {
            return this.conditionStack[0];
        }
    },

// produce the lexer rule set which is active for the currently active lexer condition state
_currentRules:function _currentRules() {
        if (this.conditionStack.length && this.conditionStack[this.conditionStack.length - 1]) {
            return this.conditions[this.conditionStack[this.conditionStack.length - 1]].rules;
        } else {
            return this.conditions["INITIAL"].rules;
        }
    },

// return the currently active lexer condition state; when an index argument is provided it produces the N-th previous condition state, if available
topState:function topState(n) {
        n = this.conditionStack.length - 1 - Math.abs(n || 0);
        if (n >= 0) {
            return this.conditionStack[n];
        } else {
            return "INITIAL";
        }
    },

// alias for begin(condition)
pushState:function pushState(condition) {
        this.begin(condition);
    },

// return the number of states currently on the stack
stateStackSize:function stateStackSize() {
        return this.conditionStack.length;
    },
options: {},
performAction: function anonymous(yy,yy_,$avoiding_name_collisions,YY_START) {
var YYSTATE=YY_START;
switch($avoiding_name_collisions) {
case 0:/* IGNORE */
break;
case 1:/* IGNORE */
break;
case 2:return 71
break;
case 3:return 73
break;
case 4:return "otherwise"
break;
case 5:return "if"
break;
case 6:return 35
break;
case 7:return "in"
break;
case 8:return "let"
break;
case 9:return "else"
break;
case 10:return "case"
break;
case 11:return "then"
break;
case 12:return "data"
break;
case 13:return "return"
break;
case 14:return 59
break;
case 15:return 13
break;
case 16:return ';'
break;
case 17:return '.'
break;
case 18:return 15
break;
case 19:return ':'
break;
case 20:return 47
break;
case 21:return 46
break;
case 22:return 8
break;
case 23:return 65
break;
case 24:return 52
break;
case 25:return 53
break;
case 26:return 50
break;
case 27:return 69
break;
case 28:return 25
break;
case 29:return 51
break;
case 30:return 48
break;
case 31:return 18
break;
case 32:return 61
break;
case 33:return '*='
break;
case 34:return 60
break;
case 35:return 57
break;
case 36:return 49
break;
case 37:return 58
break;
case 38:return '-='
break;
case 39:return '--'
break;
case 40:return 56
break;
case 41:return 54
break;
case 42:return '+='
break;
case 43:return 55
break;
case 44:return 19
break;
case 45:return 20
break;
case 46:return 63
break;
case 47:return 67
break;
case 48:return 68
break;
case 49:return 40
break;
case 50:return 41
break;
case 51:return 44
break;
case 52:return 9
break;
case 53:return 5
break;
case 54:return 'INVALID'
break;
}
},
rules: [/^(?:\s+)/,/^(?:--.*)/,/^(?:[0-9]+(\.[0-9]+)?\b)/,/^(?:"([^\\\"]|\\.)*")/,/^(?:otherwise\b)/,/^(?:if\b)/,/^(?:of\b)/,/^(?:in\b)/,/^(?:let\b)/,/^(?:else\b)/,/^(?:case\b)/,/^(?:then\b)/,/^(?:data\b)/,/^(?:return\b)/,/^(?:mod\b)/,/^(?:,)/,/^(?:;)/,/^(?:\.)/,/^(?:::)/,/^(?::)/,/^(?:&&)/,/^(?:\|\|)/,/^(?:\|)/,/^(?:\\)/,/^(?:>=)/,/^(?:>)/,/^(?:<=)/,/^(?:<-)/,/^(?:->)/,/^(?:<)/,/^(?:==)/,/^(?:=)/,/^(?:\^)/,/^(?:\*=)/,/^(?:\*\*)/,/^(?:\*)/,/^(?:\/=)/,/^(?:\/)/,/^(?:-=)/,/^(?:--)/,/^(?:-)/,/^(?:\+\+)/,/^(?:\+=)/,/^(?:\+)/,/^(?:\{)/,/^(?:\})/,/^(?:!!)/,/^(?:\[)/,/^(?:\])/,/^(?:\()/,/^(?:\))/,/^(?:_\b)/,/^(?:[a-zA-Z_][a-zA-Z0-9_]*)/,/^(?:$)/,/^(?:.)/],
conditions: {"INITIAL":{"rules":[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54],"inclusive":true}}
});
return lexer;
})();
parser.lexer = lexer;
function Parser () {
  this.yy = {};
}
Parser.prototype = parser;parser.Parser = Parser;
return new Parser;
})();


if (typeof require !== 'undefined' && typeof exports !== 'undefined') {
exports.parser = haskell_parser;
exports.Parser = haskell_parser.Parser;
exports.parse = function () { return haskell_parser.parse.apply(haskell_parser, arguments); };
exports.main = function commonjsMain(args) {
    if (!args[1]) {
        console.log('Usage: '+args[0]+' FILE');
        process.exit(1);
    }
    var source = require('fs').readFileSync(require('path').normalize(args[1]), "utf8");
    return exports.parser.parse(source);
};
if (typeof module !== 'undefined' && require.main === module) {
  exports.main(process.argv.slice(1));
}
}