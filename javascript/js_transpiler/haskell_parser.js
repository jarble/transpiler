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
var o=function(k,v,o,l){for(o=o||{},l=k.length;l--;o[k[l]]=v);return o},$V0=[1,4],$V1=[1,13],$V2=[1,12],$V3=[1,17],$V4=[1,27],$V5=[1,23],$V6=[1,21],$V7=[1,25],$V8=[1,26],$V9=[1,28],$Va=[5,7],$Vb=[12,14,41],$Vc=[1,31],$Vd=[5,7,37,41,50],$Ve=[1,39],$Vf=[1,36],$Vg=[1,40],$Vh=[1,41],$Vi=[1,42],$Vj=[1,43],$Vk=[1,44],$Vl=[1,45],$Vm=[1,46],$Vn=[1,47],$Vo=[1,48],$Vp=[1,49],$Vq=[1,50],$Vr=[1,51],$Vs=[1,52],$Vt=[5,7,12,18,19,20,21,22,23,24,25,26,27,28,29,30,37,40,41,42,43,50,52],$Vu=[5,7,12,18,19,20,21,22,23,24,25,26,27,28,29,30,33,35,37,38,40,41,42,43,44,46,50,52],$Vv=[2,36],$Vw=[2,47],$Vx=[1,81],$Vy=[5,7,12,18,19,20,21,22,23,24,37,40,41,42,43,50,52],$Vz=[5,7,12,18,19,20,21,22,23,24,25,26,27,37,40,41,42,43,50,52],$VA=[1,94],$VB=[1,105];
var parser = {trace: function trace() { },
yy: {},
symbols_: {"error":2,"expressions":3,"statements_":4,"EOF":5,"statement_":6,"IDENTIFIER":7,"parameters":8,"guard_if_statement":9,"::":10,"types":11,"=":12,"statement":13,"->":14,"if_statement":15,"statement_with_semicolon":16,"e":17,"||":18,"&&":19,"==":20,"<=":21,"<":22,">=":23,">":24,"++":25,"+":26,"-":27,"*":28,"/":29,"mod":30,"parentheses_expr":31,"access_array":32,"!!":33,"access_arr":34,"(":35,"\\\\":36,")":37,"[":38,"exprs":39,"]":40,"|":41,"<-":42,",":43,"NUMBER":44,"args":45,"STRING_LITERAL":46,"type":47,"parameter":48,"elif":49,"else":50,"if":51,"then":52,"identifiers":53,"guard_elif":54,"guard_otherwise":55,"otherwise":56,"$accept":0,"$end":1},
terminals_: {2:"error",5:"EOF",7:"IDENTIFIER",10:"::",12:"=",14:"->",18:"||",19:"&&",20:"==",21:"<=",22:"<",23:">=",24:">",25:"++",26:"+",27:"-",28:"*",29:"/",30:"mod",33:"!!",35:"(",36:"\\\\",37:")",38:"[",40:"]",41:"|",42:"<-",43:",",44:"NUMBER",46:"STRING_LITERAL",50:"else",51:"if",52:"then",56:"otherwise"},
productions_: [0,[3,2],[4,2],[4,1],[6,3],[6,7],[6,4],[6,3],[6,2],[11,3],[11,1],[13,1],[13,1],[16,1],[17,3],[17,3],[17,3],[17,3],[17,3],[17,3],[17,3],[17,3],[17,3],[17,3],[17,3],[17,3],[17,3],[17,2],[17,1],[32,3],[31,6],[31,3],[31,3],[31,7],[31,9],[31,1],[31,1],[31,3],[31,4],[31,1],[47,1],[48,1],[8,2],[8,1],[34,3],[34,1],[39,3],[39,1],[45,2],[45,1],[49,6],[49,2],[15,7],[15,6],[53,3],[53,1],[9,5],[54,5],[54,1],[55,4]],
performAction: function anonymous(yytext, yyleng, yylineno, yy, yystate /* action[1] */, $$ /* vstack */, _$ /* lstack */) {
/* this == yyval */

var $0 = $$.length - 1;
switch (yystate) {
case 1:
return ["top_level_statements",$$[$0-1]]
break;
case 2: case 42: case 48:
this.$ = [$$[$0-1]].concat($$[$0]);
break;
case 3: case 10: case 43: case 45:
this.$ =
 [$$[$0]];
break;
case 4:
this.$ = ["function","public","Object",$$[$0-2],$$[$0-1],$$[$0]];
break;
case 5:

		var types = $$[$0-4];
		var parameter_names = $$[$0-2];
		var parameters = [];
		for(var i = 0; i < parameter_names.length; i++){
			parameters.push([types[i+1],parameter_names[i][1]]);
		}
		this.$ = ["function","public",types[0],$$[$0-6],parameters,$$[$0]];
	
break;
case 6:
this.$ = ["function","public","Object",$$[$0-3],$$[$0-2],$$[$0]];
break;
case 7:
this.$ = ["function","public","Object",$$[$0-2],[],$$[$0]];
break;
case 8:
this.$ = ["function","public","Object",$$[$0-1],[],$$[$0]];
break;
case 9: case 44: case 46: case 54:
this.$ = [$$[$0-2]].concat($$[$0]);
break;
case 12:
this.$ = ["semicolon",$$[$0]];
break;
case 13:
this.$ = ["return",$$[$0]];
break;
case 14: case 15: case 16: case 17: case 18: case 19: case 20: case 21: case 22: case 24: case 25:
this.$ = [$$[$0-1],$$[$0-2],$$[$0]];
break;
case 23:
this.$ = ["-",$$[$0-2],$$[$0]];
break;
case 26:
this.$ = ["%",$$[$0-2],$$[$0]];
break;
case 27:
this.$ = ["-",$$[$0]];
break;
case 28:
this.$ = $$[$0];
break;
case 29:
this.$ = ["access_array",$$[$0-2],$$[$0]];
break;
case 30:
this.$ = ["anonymous_function","Object",$$[$0-3],["statements",[["semicolon",["return",$$[$0-1]]]]]];
break;
case 31: case 37:
this.$ = $$[$0-1]
break;
case 32:
this.$ = ["initializer_list","Object",$$[$0-1]];
break;
case 33:
this.$ = ["list_comprehension",$$[$0-5],$$[$0-3],$$[$0-1]];
break;
case 34:
this.$ = ["list_comprehension",$$[$0-7],$$[$0-5],$$[$0-3],$$[$0-1]];
break;
case 35: case 39:
this.$ = yytext;
break;
case 38:

			if($$[$0-2] === "not"){
				this.$ = ["!",$$[$0-1]];
			}
			else{
				this.$ = ["function_call",$$[$0-2],$$[$0-1]];
			}
		
break;
case 41:
this.$ = ["Object",$$[$0]];
break;
case 47: case 49: case 55:
this.$ = [$$[$0]];
break;
case 50:
this.$ = ["elif",$$[$0-3],$$[$0-1],$$[$0]]
break;
case 51: case 59:
this.$ = ["else",$$[$0]];
break;
case 52:
this.$ = ["if",$$[$0-4],$$[$0-2],$$[$0-1]];
break;
case 53:
this.$ = ["if",$$[$0-3],$$[$0-1]];
break;
case 56:
this.$ = ["if",$$[$0-3],$$[$0-1],$$[$0]];
break;
case 57:
this.$ = ["elif",$$[$0-3],$$[$0-1],$$[$0]];
break;
}
},
table: [{3:1,4:2,6:3,7:$V0},{1:[3]},{5:[1,5]},{4:6,5:[2,3],6:3,7:$V0},{7:$V1,8:7,9:10,10:[1,8],12:[1,9],41:$V2,48:11},{1:[2,1]},{5:[2,2]},{9:14,12:[1,15],41:$V2},{7:$V3,11:16},{7:$V4,13:18,15:19,16:20,17:22,27:$V5,31:24,35:$V6,38:$V7,44:$V8,46:$V9},o($Va,[2,8]),o($Vb,[2,43],{48:11,8:29,7:$V1}),{7:$V4,17:30,27:$V5,31:24,35:$Vc,38:$V7,44:$V8,46:$V9},o([7,12,14,41],[2,41]),o($Va,[2,4]),{7:$V4,13:32,15:19,16:20,17:22,27:$V5,31:24,35:$V6,38:$V7,44:$V8,46:$V9},{7:[1,33]},{7:[2,10],14:[1,34]},o($Va,[2,7]),o($Vd,[2,11]),o($Vd,[2,12]),{7:$Ve,17:38,27:$V5,31:24,32:37,35:$Vc,36:$Vf,38:$V7,44:$V8,46:$V9,51:[1,35]},o($Vd,[2,13],{18:$Vg,19:$Vh,20:$Vi,21:$Vj,22:$Vk,23:$Vl,24:$Vm,25:$Vn,26:$Vo,27:$Vp,28:$Vq,29:$Vr,30:$Vs}),{7:$V4,17:53,27:$V5,31:24,35:$Vc,38:$V7,44:$V8,46:$V9},o($Vt,[2,28]),{7:$V4,17:55,27:$V5,31:24,35:$Vc,38:$V7,39:54,44:$V8,46:$V9},o($Vu,[2,35]),o($Vu,$Vv),o($Vu,[2,39]),o($Vb,[2,42]),{12:[1,56],18:$Vg,19:$Vh,20:$Vi,21:$Vj,22:$Vk,23:$Vl,24:$Vm,25:$Vn,26:$Vo,27:$Vp,28:$Vq,29:$Vr,30:$Vs},{7:$Ve,17:38,27:$V5,31:24,32:37,35:$Vc,36:$Vf,38:$V7,44:$V8,46:$V9},o($Va,[2,6]),{7:$V1,8:57,48:11},{7:$V3,11:58},{7:$V4,17:59,27:$V5,31:24,35:$Vc,38:$V7,44:$V8,46:$V9},{7:$V1,8:60,48:11},{37:[1,61]},{18:$Vg,19:$Vh,20:$Vi,21:$Vj,22:$Vk,23:$Vl,24:$Vm,25:$Vn,26:$Vo,27:$Vp,28:$Vq,29:$Vr,30:$Vs,37:[1,62]},o([18,19,20,21,22,23,24,25,26,27,28,29,30,37],$Vv,{45:63,31:65,7:$V4,33:[1,64],35:$Vc,38:$V7,44:$V8,46:$V9}),{7:$V4,17:66,27:$V5,31:24,35:$Vc,38:$V7,44:$V8,46:$V9},{7:$V4,17:67,27:$V5,31:24,35:$Vc,38:$V7,44:$V8,46:$V9},{7:$V4,17:68,27:$V5,31:24,35:$Vc,38:$V7,44:$V8,46:$V9},{7:$V4,17:69,27:$V5,31:24,35:$Vc,38:$V7,44:$V8,46:$V9},{7:$V4,17:70,27:$V5,31:24,35:$Vc,38:$V7,44:$V8,46:$V9},{7:$V4,17:71,27:$V5,31:24,35:$Vc,38:$V7,44:$V8,46:$V9},{7:$V4,17:72,27:$V5,31:24,35:$Vc,38:$V7,44:$V8,46:$V9},{7:$V4,17:73,27:$V5,31:24,35:$Vc,38:$V7,44:$V8,46:$V9},{7:$V4,17:74,27:$V5,31:24,35:$Vc,38:$V7,44:$V8,46:$V9},{7:$V4,17:75,27:$V5,31:24,35:$Vc,38:$V7,44:$V8,46:$V9},{7:$V4,17:76,27:$V5,31:24,35:$Vc,38:$V7,44:$V8,46:$V9},{7:$V4,17:77,27:$V5,31:24,35:$Vc,38:$V7,44:$V8,46:$V9},{7:$V4,17:78,27:$V5,31:24,35:$Vc,38:$V7,44:$V8,46:$V9},o($Vt,[2,27]),{40:[1,79]},{18:$Vg,19:$Vh,20:$Vi,21:$Vj,22:$Vk,23:$Vl,24:$Vm,25:$Vn,26:$Vo,27:$Vp,28:$Vq,29:$Vr,30:$Vs,40:$Vw,41:[1,80],43:$Vx},{7:$V4,13:82,15:19,16:20,17:22,27:$V5,31:24,35:$V6,38:$V7,44:$V8,46:$V9},{12:[1,83]},{7:[2,9]},{18:$Vg,19:$Vh,20:$Vi,21:$Vj,22:$Vk,23:$Vl,24:$Vm,25:$Vn,26:$Vo,27:$Vp,28:$Vq,29:$Vr,30:$Vs,52:[1,84]},{14:[1,85]},o($Vu,[2,31]),o($Vu,[2,37]),{37:[1,86]},{7:$V4,31:88,34:87,35:$Vc,38:$V7,44:$V8,46:$V9},{7:$V4,31:65,35:$Vc,37:[2,49],38:$V7,44:$V8,45:89,46:$V9},o([5,7,12,18,37,40,41,42,43,50,52],[2,14],{19:$Vh,20:$Vi,21:$Vj,22:$Vk,23:$Vl,24:$Vm,25:$Vn,26:$Vo,27:$Vp,28:$Vq,29:$Vr,30:$Vs}),o([5,7,12,18,19,37,40,41,42,43,50,52],[2,15],{20:$Vi,21:$Vj,22:$Vk,23:$Vl,24:$Vm,25:$Vn,26:$Vo,27:$Vp,28:$Vq,29:$Vr,30:$Vs}),o($Vy,[2,16],{25:$Vn,26:$Vo,27:$Vp,28:$Vq,29:$Vr,30:$Vs}),o($Vy,[2,17],{25:$Vn,26:$Vo,27:$Vp,28:$Vq,29:$Vr,30:$Vs}),o($Vy,[2,18],{25:$Vn,26:$Vo,27:$Vp,28:$Vq,29:$Vr,30:$Vs}),o($Vy,[2,19],{25:$Vn,26:$Vo,27:$Vp,28:$Vq,29:$Vr,30:$Vs}),o($Vy,[2,20],{25:$Vn,26:$Vo,27:$Vp,28:$Vq,29:$Vr,30:$Vs}),o($Vz,[2,21],{28:$Vq,29:$Vr,30:$Vs}),o($Vz,[2,22],{28:$Vq,29:$Vr,30:$Vs}),o($Vz,[2,23],{28:$Vq,29:$Vr,30:$Vs}),o($Vt,[2,24]),o($Vt,[2,25]),o($Vt,[2,26]),o($Vu,[2,32]),{7:$V4,17:90,27:$V5,31:24,35:$Vc,38:$V7,44:$V8,46:$V9},{7:$V4,17:92,27:$V5,31:24,35:$Vc,38:$V7,39:91,44:$V8,46:$V9},{41:$VA,54:93,55:95},{7:$V4,13:96,15:19,16:20,17:22,27:$V5,31:24,35:$V6,38:$V7,44:$V8,46:$V9},{7:$V4,13:97,15:19,16:20,17:22,27:$V5,31:24,35:$V6,38:$V7,44:$V8,46:$V9},{7:$V4,17:98,27:$V5,31:24,35:$Vc,38:$V7,44:$V8,46:$V9},o($Vu,[2,38]),{37:[2,29]},{33:[1,99],37:[2,45]},{37:[2,48]},{18:$Vg,19:$Vh,20:$Vi,21:$Vj,22:$Vk,23:$Vl,24:$Vm,25:$Vn,26:$Vo,27:$Vp,28:$Vq,29:$Vr,30:$Vs,42:[1,100]},{40:[2,46]},{18:$Vg,19:$Vh,20:$Vi,21:$Vj,22:$Vk,23:$Vl,24:$Vm,25:$Vn,26:$Vo,27:$Vp,28:$Vq,29:$Vr,30:$Vs,40:$Vw,43:$Vx},o($Va,[2,56]),{7:$V4,17:101,27:$V5,31:24,35:$Vc,38:$V7,44:$V8,46:$V9,56:[1,102]},o($Va,[2,58]),o($Va,[2,5]),{37:[1,104],49:103,50:$VB},{18:$Vg,19:$Vh,20:$Vi,21:$Vj,22:$Vk,23:$Vl,24:$Vm,25:$Vn,26:$Vo,27:$Vp,28:$Vq,29:$Vr,30:$Vs,37:[1,106]},{7:$V4,31:88,34:107,35:$Vc,38:$V7,44:$V8,46:$V9},{7:$V4,17:108,27:$V5,31:24,35:$Vc,38:$V7,44:$V8,46:$V9},{12:[1,109],18:$Vg,19:$Vh,20:$Vi,21:$Vj,22:$Vk,23:$Vl,24:$Vm,25:$Vn,26:$Vo,27:$Vp,28:$Vq,29:$Vr,30:$Vs},{12:[1,110]},{37:[1,111]},o($Vd,[2,53]),{7:$V4,13:113,15:19,16:20,17:22,27:$V5,31:24,35:$V6,38:$V7,44:$V8,46:$V9,51:[1,112]},o($Vu,[2,30]),{37:[2,44]},{18:$Vg,19:$Vh,20:$Vi,21:$Vj,22:$Vk,23:$Vl,24:$Vm,25:$Vn,26:$Vo,27:$Vp,28:$Vq,29:$Vr,30:$Vs,40:[1,114],43:[1,115]},{7:$V4,13:116,15:19,16:20,17:22,27:$V5,31:24,35:$V6,38:$V7,44:$V8,46:$V9},{7:$V4,13:117,15:19,16:20,17:22,27:$V5,31:24,35:$V6,38:$V7,44:$V8,46:$V9},o($Vd,[2,52]),{7:$V4,17:118,27:$V5,31:24,35:$Vc,38:$V7,44:$V8,46:$V9},{37:[2,51]},o($Vu,[2,33]),{7:$V4,17:119,27:$V5,31:24,35:$Vc,38:$V7,44:$V8,46:$V9},{41:$VA,54:120,55:95},o($Va,[2,59]),{18:$Vg,19:$Vh,20:$Vi,21:$Vj,22:$Vk,23:$Vl,24:$Vm,25:$Vn,26:$Vo,27:$Vp,28:$Vq,29:$Vr,30:$Vs,52:[1,121]},{18:$Vg,19:$Vh,20:$Vi,21:$Vj,22:$Vk,23:$Vl,24:$Vm,25:$Vn,26:$Vo,27:$Vp,28:$Vq,29:$Vr,30:$Vs,40:[1,122]},o($Va,[2,57]),{7:$V4,13:123,15:19,16:20,17:22,27:$V5,31:24,35:$V6,38:$V7,44:$V8,46:$V9},o($Vu,[2,34]),{49:124,50:$VB},{37:[2,50]}],
defaultActions: {5:[2,1],6:[2,2],58:[2,9],87:[2,29],89:[2,48],91:[2,46],107:[2,44],113:[2,51],124:[2,50]},
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
case 0:/* skip whitespace */
break;
case 1:return 44
break;
case 2:return 46
break;
case 3:return "otherwise"
break;
case 4:return "if"
break;
case 5:return "else"
break;
case 6:return "then"
break;
case 7:return "return"
break;
case 8:return 30
break;
case 9:return 43
break;
case 10:return ';'
break;
case 11:return '.'
break;
case 12:return 10
break;
case 13:return ':'
break;
case 14:return 19
break;
case 15:return 18
break;
case 16:return 41
break;
case 17:return 36
break;
case 18:return 23
break;
case 19:return 24
break;
case 20:return 21
break;
case 21:return 42
break;
case 22:return 14
break;
case 23:return 22
break;
case 24:return 20
break;
case 25:return 12
break;
case 26:return '*='
break;
case 27:return 28
break;
case 28:return '/='
break;
case 29:return 29
break;
case 30:return '-='
break;
case 31:return '--'
break;
case 32:return 27
break;
case 33:return 25
break;
case 34:return '+='
break;
case 35:return 26
break;
case 36:return '^'
break;
case 37:return '{'
break;
case 38:return '}'
break;
case 39:return 33
break;
case 40:return 38
break;
case 41:return 40
break;
case 42:return 35
break;
case 43:return 37
break;
case 44:return 7
break;
case 45:return 5
break;
case 46:return 'INVALID'
break;
}
},
rules: [/^(?:\s+)/,/^(?:[0-9]+(\.[0-9]+)?\b)/,/^(?:"([^\\\"]|\\.)*")/,/^(?:otherwise\b)/,/^(?:if\b)/,/^(?:else\b)/,/^(?:then\b)/,/^(?:return\b)/,/^(?:mod\b)/,/^(?:,)/,/^(?:;)/,/^(?:\.)/,/^(?:::)/,/^(?::)/,/^(?:&&)/,/^(?:\|\|)/,/^(?:\|)/,/^(?:\\)/,/^(?:>=)/,/^(?:>)/,/^(?:<=)/,/^(?:<-)/,/^(?:->)/,/^(?:<)/,/^(?:==)/,/^(?:=)/,/^(?:\*=)/,/^(?:\*)/,/^(?:\/=)/,/^(?:\/)/,/^(?:-=)/,/^(?:--)/,/^(?:-)/,/^(?:\+\+)/,/^(?:\+=)/,/^(?:\+)/,/^(?:\^)/,/^(?:\{)/,/^(?:\})/,/^(?:!!)/,/^(?:\[)/,/^(?:\])/,/^(?:\()/,/^(?:\))/,/^(?:[a-zA-Z_][a-zA-Z0-9_]*)/,/^(?:$)/,/^(?:.)/],
conditions: {"INITIAL":{"rules":[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46],"inclusive":true}}
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