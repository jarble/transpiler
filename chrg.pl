% CHR Grammars
% - a grammar notation based on CHR
% (c) 2010, 2011, 2016 Henning Christiansen, Roskilde University, DENMARK

chrg_version('CHRG, version 1.2, August 2016').

% Version 1.0
% adapted from version 0.1 to SICStus 4 and SWI (0.1 for SICStus 3 only)
% Compared with the earlier version, the syntax for declarations have
% been adapted so it it resembles the new CHR systems.

% 1.1 Differs from version 1.0, November 2010
% by adding more generality when using word boundaries in Rules
% In addition to nonterminal:(Start,End) we can also write nonterminal:Range (for example)

% 1.2 Differs August 2016
% Adapts to a really weird change in SWI 7: "abc" is not a list of numbers but
% something they call string object!!!!!!!!!


% Web site for CHR Grammars: http://www.ruc.dk/~henning/chrg

% Web site provides this source code running under SICSTUS Prolog,
% documentation, scientific papers on the subject, and sample files.

%%%%%%%% Freely available for any peaceful and noncommercial applications.
%%%%%%%% For other purposes, write to the author.


:- chrg_version(X), nl, write(X), nl,
   write('(C) Henning Christiansen, henning@ruc.dk'),nl,nl.

% Status - needs more testing

% IMPLEMENTATION PRINCIPLES:

% The notation is implemented using the hook predicate term_expansion
% that modifies Prolog's reader. However, the predicate is not
% applied recursively by Prolog, so it is a bit tricky to mix
% our use of term_expansion clauses with the CHR library's ditto.
% We work the following way: Define term_expansion clauses for
% our own *top-level operators*, do our translation into a
% new term with the matching CHR top-level operator and give
% it to another call to term_expansion.

%% IMPORTANT NOTICE: This file needs to be included before chr is loaded in
%% - probably due to bug in the chr implementation
:- include(constraintStoreHacks).

:- use_module(library(chr)).
:- use_module(library(terms)).
:- set_prolog_flag(discontiguous_warnings,off).

:- include(termExpandHacks).
:- include(chrgTestPrint).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% CHRG options
:- dynamic current_chrg_option/2.

term_expansion( chrg_option(Option,Value), (:- chrg_option(Option,Value))).

chrg_option(Option,Value):-
   (member(Option, [show_text, show_rules, lr_optimize, verbose_AG, compact_abduction])
    -> true
     ;     write('WARNING: Unknown CHRG option '),
           write(Option),
           write('. Expected one of {show_text, show_rules, '),
           write('lr_optimize, verbose_AB, compact_abduction}.'),nl,
           fail),
   (member(Value, [on,off])
    -> true
    ;  write('WARNING: Wrong value for option '),
       write(Option), write(': '),write(Value),
       write('. Expected one of {on,off}.'), nl,
       fail),

   (current_chrg_option(Option,ValueCurrent) ->
        retract( current_chrg_option(Option,ValueCurrent) )
    ; true),

   assert( current_chrg_option(Option,Value) ).

%%% set defaults:

set_default_chrg_options:- 
   chrg_option(show_text, on).
   chrg_option(show_rules, off).
   chrg_option(lr_optimize, off).
   chrg_option(verbose_AG, off).
   chrg_option(compact_abduction, off).

:- set_default_chrg_options.



% helper for show_rules

test_print_rule(T):-
    current_chrg_option(show_rules, on) -> chr_pp_top(T), ! ; true.

test_print_comment(Comment):-
    current_chrg_option(show_rules, on) -> write('%%%% '), write(Comment), ! ; true.

% Grammar ops mixed with the following CHR ops:
% op(1200, xfx, @).
% op(1190,xfx, pragma).
% op(1180,xfx, <=>).
% op(1180,xfx, ==>).
% op(1150,fx, constraints).
% op(1100, xfx, '|').
% op(1100, xfx, \ ).
% op(1050, xfx, &).
% op(1000,xfy, ',').
% op(400,yfx, '/').
% op( 500, yfx, #).

% NEW OPERATORS:

% Declaring grammar symbols:
% Used similarly to CHR's 'constraint' device
% but adds 2 to all arities.
% the following singular/plural versions is included to make textual reading easier
:- op(1150,fx, chrg_symbol).
:- op(1150,fx, chrg_symbols).
:- op(1150,fx, chr_constraints).

% Declaring abducible predicates:
% Used similarly to CHR's 'constraint' device
%:- op(1150,fx, abducibles).
:- op(1150,fx, chrg_abducible).
:- op(1150,fx, chrg_abducibles).

% For grammar rules:
:- op(1180,xfx,[ <:>, ::> ]).

% Labels in front of grammar rules, use
:- op(1200, xfx, @@).

% Pragmas following grammar rules, use
:- op(1190,xfx, gpragma).


% for left and right contexts in head of rules
% (right context is the same as lookahead)

:- op(1150, xfy, [ -\ , /- ]).

% parallel matching of grammar symbols

:- op(1050, xfy, $$ ).

% gap with indices

:- op(700, xfx, '...' ).
:- op(700, fy, '...' ).


% a 'where' clause

:- op(1200,yfx,where).

%%
% ops for assumption grammars in CHRG:
% +, -, are already declared as ops.

:- op(500,fx,[*,=+,=-,=*]).
%%%% 

predicates_that_may_be_used_in_bodies_without_curly_brackets(
  [(=) /2,(dif) /2,(true) /0,(false) /0,(fail) /0,(+) /1,(-) /1,(*) /1,(=+) /1,(=-) /1,(=*) /1]
).
%%%% 

% Simpagations written in a different way as order of things at rhs
% means something! Calls to be PRESERVED indicated by prefix !.
% Op similar to prefix-minus

:- op(500,fy,!).

% DROP Prefix-question mark - used for optional head elements

%%%%%%:- op(500,fy,?).  % 1 greater than '!' so that syntax '? ! booh' is allowed

% This may be used together with ? as follows '? grammar_symbol(X) :: X=noway
%%%%:- op(701,xfx,::).

:- dynamic defined_grammar_symbol/2. % Remember grammar symbol with *original* arity
% init:
defined_grammar_symbol(token,1).
defined_grammar_symbol('...',0).
defined_grammar_symbol('...',1).
defined_grammar_symbol('...',2).
defined_grammar_symbol(all,0).

%%%%%%%%%%%

grammar_symbol_not_allowed_in_body('...',0).
grammar_symbol_not_allowed_in_body('...',1).
grammar_symbol_not_allowed_in_body('...',2).
grammar_symbol_not_allowed_in_body(all,0).
%... no reason to prohibit token

%%%%%%%%%%%%%%%%%%%%%
% Plural form of old friend

term_expansion( (:- chr_constraints C), T):- expand_term( (:- chr_constraint C), T).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Declarations fo grammar symbols


term_expansion( (:- chrg_symbol G), T):-
  translate_grammar_symbol_specs_to_constraint_specs(G,C),
  mk_removerRules(C), % stored till the end_of_chrg_source directive
  translate_constraint_specs_into_remover_specs(C,C_Remove),
  CHRG_built_in_constraints =
       (token/3,
        all/2,
        (=+) / 1, (=-) /1, (=*) /1,
        (+) / 2, (-) / 2, (*) / 2,
        tried_rule_AG_eq_plus_minus/2,
        tried_rule_AG_eq_star_minus/2,
        tried_rule_AG_plus_minus/4,
        tried_rule_AG_star_minus/4),
  mk_removerRules(CHRG_built_in_constraints), % stored till the end_of_chrg_source directive
  translate_constraint_specs_into_remover_specs(CHRG_built_in_constraints,CHRG_built_in_constraints_Remove),
  ConstraintDecl = (:- chr_constraint CHRG_built_in_constraints,
                                      CHRG_built_in_constraints_Remove,
                                      C, C_Remove),
  test_print_rule(ConstraintDecl),
  expand_term(ConstraintDecl, T).

term_expansion( (:- chrg_symbols G), T):- expand_term( (:- chrg_symbol G), T).

translate_grammar_symbol_specs_to_constraint_specs((G1,G2),(C1,C2)):-
    translate_grammar_symbol_specs_to_constraint_specs(G1,C1),
    translate_grammar_symbol_specs_to_constraint_specs(G2,C2).

translate_grammar_symbol_specs_to_constraint_specs((Symbol/Arity), (Symbol/Arity2)):-
    integer(Arity),!,
    asserta( defined_grammar_symbol(Symbol,Arity)),
    Arity2 is Arity + 2.

translate_grammar_symbol_specs_to_constraint_specs(Nonsense,Nonsense).
  % let CHR raise the exception

%%%%%%%%%%%%%%%%%%%%%
% declarations of abducibles

:- dynamic defined_abducibles/2. % Remember abducibles with arity

term_expansion( (:- chrg_abducibles G), T):- expand_term((:- chrg_abducible G), T).

term_expansion( (:- chrg_abducible G), T):-
  translate_abducibles_specs_to_constraint_specs(G,C,AbduciblesExplicitNegICs),
  translate_constraint_specs_into_remover_specs((C, compact_abducibles/0), Removers),
  mk_removerRules((C, compact_abducibles/0)), % stored till the end_of_chrg_source directive
  ConstraintDecl = (:- chr_constraint C, compact_abducibles/0, Removers),
  test_print_rule(ConstraintDecl),
  expand_term(ConstraintDecl,T),
  % notice that AbduciblesExplicitNegICs does not contain connect rules
  % as they are stored for being processed by end_of_CHRG_source
  term_expansion_list(AbduciblesExplicitNegICs).

translate_abducibles_specs_to_constraint_specs((G1,G2),(C1,C2),IC):-
    translate_abducibles_specs_to_constraint_specs(G1,C1,IC1),
    translate_abducibles_specs_to_constraint_specs(G2,C2,IC2),
    append(IC1,IC2,IC).

translate_abducibles_specs_to_constraint_specs((P/Arity), 
                                               (P/Arity,NotP/Arity),IC):-
    integer(Arity),!,
    (ends_with_underscore(P) -> nl, write('Error: Abducible predicate '),
       write(P), write(' ends with underscore.'),nl,
       write('Compilation stopped'), abort
      ; true),
    asserta( defined_abducibles(P,Arity)),
    negate_abducible_predicate_name(P,NotP),
    mk_specialized_ICs_for_abducible(P,Arity,IC).

translate_abducibles_specs_to_constraint_specs(Nonsense,Nonsense,[]).
  % let CHR raise the exception
  
% about adding underscore to end of predicate to express negation

negate_abducible_predicate_name(P,NotP):-
     name('_',UnderscoreChars),
 (ground(P) ->
     name(P,NameP), append(NameP,UnderscoreChars,NameNotP), name(NotP,NameNotP)
   ;
   ground(NotP) ->
     name(NotP,NameNotP), append(NameP,UnderscoreChars,NameNotP), name(P,NameP)
   ;
   write('BUG IN CHRG: negate_abducible_predicate_name CALLED '),
   write('WITH BOTH ARGS NONGROUND'), nl, abort).


ends_with_underscore(P):-
    name('_',UnderscoreChars),
    name(P,NameP), append(_,UnderscoreChars,NameP).

negation_of_defined_abducible(NotP,A):-
    negate_abducible_predicate_name(P,NotP),
    defined_abducibles(P,A).

abducible_predicate(P,A):-
    defined_abducibles(P,A) -> true
    ;
    negation_of_defined_abducible(P,A).

%%%%% To be refined as to avoid multiple generation of same solution


%%%%% - notice optimization for arity 0 and 1 in the following.

mk_specialized_ICs_for_abducible(P,A,[ExplicitNegationRule]):-
   negate_abducible_predicate_name(P,NotP),
   length(L1,A), length(L2,A),
   Patom1=.. [P|L1], Patom2=.. [P|L2], 
   NotPatom1=.. [NotP|L1], NotPatom2=.. [NotP|L2],

   (A==1 -> [XL1]=L1, [XL2]=L2 ; XL1=L1, XL2=L2),

   (A == 0 -> true
    ;
    current_chrg_option(compact_abduction, on) ->
         ConnectRuleP = (Patom1, Patom2#Id ==>
                             (XL1\==XL2, unifiable(XL1,XL2))
                           | (XL1=XL2, remove_constraint(Patom2) ; 
                              dif(XL1,XL2))    
                         pragma passive(Id)),

         assert(rule_stored_for_end_of_CHRG_source(ConnectRuleP)),

         ConnectRuleNotP = (NotPatom1, NotPatom2#Id ==>
                                (XL1\==XL2, unifiable(XL1,XL2))
                              | (XL1=XL2, remove_constraint(NotPatom2) ;
                              dif(XL1,XL2))   
                            pragma passive(Id)),

         assert(rule_stored_for_end_of_CHRG_source(ConnectRuleNotP))

      ;
       true),
         
   PosterioriConnectRuleP = (compact_abducibles, Patom1#Id1, Patom2#Id2 ==>
                       (XL1\==XL2, unifiable(XL1,XL2))
                     | (XL1=XL2, remove_constraint(Patom2) ; 
                        dif(XL1,XL2))    
                   pragma passive(Id1), passive(Id2) ),

   assert(rule_stored_for_end_of_CHRG_source(PosterioriConnectRuleP)),

   PosterioriConnectRuleNotP = (compact_abducibles, NotPatom1#Id1, NotPatom2#Id2 ==>
                       (XL1\==XL2, unifiable(XL1,XL2))
                     | (XL1=XL2, remove_constraint(NotPatom2)  ; 
                        dif(XL1,XL2))    
                   pragma passive(Id1), passive(Id2) ),

   assert(rule_stored_for_end_of_CHRG_source(PosterioriConnectRuleNotP)),

   ExplicitNegationRule = (Patom1, NotPatom1 ==> fail).


%%%

term_expansion_list([]).
term_expansion_list([T|Ts]):-
    test_print_rule(T),expand_term(T,_),term_expansion_list(Ts).
   


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Machinery to store rules generated by CHRG behind the back of the user
% for having them processed when "end_of_CHRG_source." is entered.

term_expansion((:- end_of_CHRG_source),T):-expand_term((end_of_CHRG_source),T).

term_expansion(end_of_CHRG_source, (:- true)):-
    %%%%write('CALL ME!!'),
    assert(end_of_CHRG_source_has_been_called), % applied for text in 
                                                % parse predicate
    findall(_, (retract(rule_stored_for_end_of_CHRG_source(R)),
                test_print_rule(R),
                expand_term(R,_)), _),

    findall(_, (static_rule_stored_for_end_of_CHRG_source(R),
                test_print_rule(R), 
                expand_term(R,_)), _),
    
    (defined_abducibles(_,_) ->
        expand_term((compact_abducibles <=> true),_)
     ; true).

:- dynamic rule_stored_for_end_of_CHRG_source/1.
:- dynamic end_of_CHRG_source_has_been_called/0.

% init with rules for AG:  always to be included

static_rule_stored_for_end_of_CHRG_source((
    =+A, =-B <=>
        (\+ has_tried_rule_AG_eq_plus_minus(A,B), unifiable(A,B))
      |
        (A=B ; tried_rule_AG_eq_plus_minus(A,B), =+A, =-B)
)).

static_rule_stored_for_end_of_CHRG_source((
    =*A \ =-B <=>
        (\+ has_tried_rule_AG_eq_star_minus(A,B), unifiable(A,B))
      |
        (A=B ; tried_rule_AG_eq_star_minus(A,B), =-B)
)).

static_rule_stored_for_end_of_CHRG_source((
    +(A,NA), -(B,NB) <=>
        (NA =< NB, \+ has_tried_rule_AG_plus_minus(A,NA,B,NB), unifiable(A,B))
      |
        (A=B ; tried_rule_AG_plus_minus(A,NA,B,NB), +(A,NA), -(B,NB))
)).

static_rule_stored_for_end_of_CHRG_source((
    *(A,NA) \ -(B,NB) <=>
        (NA =< NB, \+ has_tried_rule_AG_star_minus(A,NA,B,NB), unifiable(A,B))
      |
        (A=B ; tried_rule_AG_star_minus(A,NA,B,NB), -(B,NB))
)).

%%% helpers for the guard

has_tried_rule_AG_eq_plus_minus(A,B):-
    find_constraint(tried_rule_AG_eq_plus_minus(AA,BB)),
    A==AA,B==BB.

has_tried_rule_AG_eq_star_minus(A,B):-
    find_constraint(tried_rule_AG_eq_star_minus(AA,BB)),
    A==AA,B==BB.

has_tried_rule_AG_plus_minus(A,NA,B,NB):-
    find_constraint(tried_rule_AG_plus_minus(AA,NNAA,BB,NNBB)),
    A==AA,B==BB,NA==NNAA,NB==NNBB.

has_tried_rule_AG_star_minus(A,NA,B,NB):-
    find_constraint(tried_rule_AG_star_minus(AA,NNAA,BB,NNBB)),
    A==AA,B==BB,NA==NNAA,NB==NNBB.


%%%%%%%%%%%%%%%%%%%%%%%%%%%% RULES



term_expansion((Rule where Goal), Result):-
    (Goal -> expand_term(Rule, Result)
     ;
     write('Error: where-clause failed: <rule> where '),write(Goal),nl,
       write('Compilation stopped'), abort).



term_expansion((L @@ X gpragma P), T):-
   translate_grammar_rule_to_CHR_rule((L @ X pragma P),Rule),
   test_print_rule(Rule),
   term_expansion_comma_structure(Rule, T).

term_expansion((L @@ X), T):-
   translate_grammar_rule_to_CHR_rule((L @ X),Rule),
   test_print_rule(Rule),
   term_expansion_comma_structure(Rule, T).

term_expansion((R gpragma P), T):-
   translate_grammar_rule_to_CHR_rule((R pragma P),Rule),
   test_print_rule(Rule),
   term_expansion_comma_structure(Rule, T).

term_expansion((G_Head <:> G_Body), T):- 
   translate_grammar_rule_to_CHR_rule((G_Head <:> G_Body),Rule),
   test_print_rule(Rule),
   term_expansion_comma_structure(Rule, T).

term_expansion( (G_Head ::> G_Body), T):-
   translate_grammar_rule_to_CHR_rule((G_Head ::> G_Body),Rule),
   test_print_rule(Rule),
   term_expansion_comma_structure(Rule, T).

% traverse syntax for rules...

translate_grammar_rule_to_CHR_rule((L @ G),Return):-
   translate_grammar_rule_to_CHR_rule(G,C),
   (C = (_,_)
    -> nl, write('Rule '),write(L), write(' replaced by'),
       distribute_label_over_comma_struct(L, C, Return,1,_), nl
    ;
    Return = (L @ C)).

translate_grammar_rule_to_CHR_rule((G pragma P),Return):-
   translate_grammar_rule_to_CHR_rule(G,C),
   distribute_pragma_over_comma_struct(P,C,Return).


% Unroll rules with disjunctions in left and or right
% context into several rules -- returns a comma-tree of rules


translate_grammar_rule_to_CHR_rule((((LG1;LG2) -\ CG /- RG) <:> G_Body), (C1,C2)):-
    !,
    translate_grammar_rule_to_CHR_rule(((LG1 -\ CG /- RG) <:> G_Body), C1),
    translate_grammar_rule_to_CHR_rule(((LG2 -\ CG /- RG) <:> G_Body), C2).

translate_grammar_rule_to_CHR_rule(((LG -\ CG /- (RG1;RG2)) <:> G_Body), (C1,C2)):-
    !,
    translate_grammar_rule_to_CHR_rule(((LG -\ CG /- RG1) <:> G_Body), C1),
    translate_grammar_rule_to_CHR_rule(((LG -\ CG /- RG2) <:> G_Body), C2).

translate_grammar_rule_to_CHR_rule((((LG1;LG2) -\ CG) <:> G_Body), (C1,C2)):-
    !,
    translate_grammar_rule_to_CHR_rule(((LG1 -\ CG) <:> G_Body), C1),
    translate_grammar_rule_to_CHR_rule(((LG2 -\ CG) <:> G_Body), C2).

translate_grammar_rule_to_CHR_rule(((CG /- (RG1;RG2)) <:> G_Body), (C1,C2)):-
    !,
    translate_grammar_rule_to_CHR_rule(((CG /- RG1) <:> G_Body), C1),
    translate_grammar_rule_to_CHR_rule(((CG /- RG2) <:> G_Body), C2).


translate_grammar_rule_to_CHR_rule((((LG1;LG2) -\ CG /- RG) ::> G_Body), (C1,C2)):-
    !,
    translate_grammar_rule_to_CHR_rule(((LG1 -\ CG /- RG) ::> G_Body), C1),
    translate_grammar_rule_to_CHR_rule(((LG2 -\ CG /- RG) ::> G_Body), C2).

translate_grammar_rule_to_CHR_rule(((LG -\ CG /- (RG1;RG2)) ::> G_Body), (C1,C2)):-
    !,
    translate_grammar_rule_to_CHR_rule(((LG -\ CG /- RG1) ::> G_Body), C1),
    translate_grammar_rule_to_CHR_rule(((LG -\ CG /- RG2) ::> G_Body), C2).

translate_grammar_rule_to_CHR_rule((((LG1;LG2) -\ CG) ::> G_Body), (C1,C2)):-
    !,
    translate_grammar_rule_to_CHR_rule(((LG1 -\ CG) ::> G_Body), C1),
    translate_grammar_rule_to_CHR_rule(((LG2 -\ CG) ::> G_Body), C2).

translate_grammar_rule_to_CHR_rule(((CG /- (RG1;RG2)) ::> G_Body), (C1,C2)):-
    !,
    translate_grammar_rule_to_CHR_rule(((CG /- RG1) ::> G_Body), C1),
    translate_grammar_rule_to_CHR_rule(((CG /- RG2) ::> G_Body), C2).


% Now some interesting rules:

translate_grammar_rule_to_CHR_rule((G_Head <:> G_Body),(C_Rule1,C_Rule2)):-
    split_head_on_optional_grammar_symbol(G_Head, G_Head1, G_Head2, Substitution2),
    !,
    translate_grammar_rule_to_CHR_rule( (G_Head1  <:> G_Body), C_Rule1),
    (Substitution2 = no_substitution -> 
        translate_grammar_rule_to_CHR_rule( (G_Head2  <:> G_Body), C_Rule2)
     ;
     mk_variant( (G_Head2  <:> G_Body)+Substitution2, (G_Head2VAR  <:> G_BodyVAR)+Substitution2VAR),

     (Substitution2VAR -> translate_grammar_rule_to_CHR_rule( (G_Head2VAR  <:> G_BodyVAR), C_Rule2)
      ;
      write('Error: substitution part for optional symbol failed: optional(<symbol>, '),
      write(Substitution2VAR),write(')'), nl,
       write('Compilation stopped'), abort)).
        
translate_grammar_rule_to_CHR_rule((G_Head ::> G_Body),(C_Rule1,C_Rule2)):-
    split_head_on_optional_grammar_symbol(G_Head, G_Head1, G_Head2, Substitution2),
    !,
    translate_grammar_rule_to_CHR_rule( (G_Head1  ::> G_Body), C_Rule1),
    (Substitution2 = no_substitution -> 
        translate_grammar_rule_to_CHR_rule( (G_Head2  ::> G_Body), C_Rule2)
     ;
     mk_variant( (G_Head2  <:> G_Body)+Substitution2, (G_Head2VAR  <:> G_BodyVAR)+Substitution2VAR),

     (Substitution2VAR -> translate_grammar_rule_to_CHR_rule( (G_Head2VAR  ::> G_BodyVAR), C_Rule2)
      ;
      write('Error: substitution part for optional symbol failed: optional(<symbol>, '),
      write(Substitution2VAR),write(')'), nl,
       write('Compilation stopped'), abort)).
        


translate_grammar_rule_to_CHR_rule((G_Head <:> G_Body),C_Rule):-
   (bounded(G_Head) -> true ; write('Unbounded head core in rule '),
                              write((G_Head <:> G_Body)),nl,
                              write('Compilation stopped'), abort),
                              
   (current_chrg_option(lr_optimize, on) ->
        label_all_but_rightmost(G_Head,G_Head_L,Labels)
    ;
    G_Head_L=G_Head),

   (G_Head_L = (LG -\ CG /- RG)
    -> translate_grammar_head_to_CHR_head(LG, LC, _, N1_head),
       translate_grammar_head_to_CHR_head(CG, CC, N1_head,N2_head),
       translate_grammar_head_to_CHR_head(RG, RC, N2_head, _),
       ( take_out_simpagation_marked_from_head(CC,CCremove,CCkeep)
         -> C_Head = (LC, RC, CCkeep \ CCremove)
         ;
         C_Head = (LC, RC \ CC))
    ;
    G_Head_L = (LG -\ CG)
    -> translate_grammar_head_to_CHR_head(LG, LC,  _,N1_head),
       translate_grammar_head_to_CHR_head(CG, CC, N1_head,N2_head),
       ( take_out_simpagation_marked_from_head(CC,CCremove,CCkeep)
         -> C_Head = (LC,CCkeep \ CCremove)
         ;
         C_Head = (LC\ CC))
    ;
    G_Head_L = (CG /- RG)
    -> translate_grammar_head_to_CHR_head(CG, CC, N1_head,N2_head),
       translate_grammar_head_to_CHR_head(RG, RC, N2_head, _),
       ( take_out_simpagation_marked_from_head(CC,CCremove,CCkeep)
         -> C_Head = (RC,CCkeep \ CCremove)
         ;
         C_Head = (RC\ CC))
    ;       
      translate_grammar_head_to_CHR_head(G_Head_L,CC,N1_head,N2_head),
       ( take_out_simpagation_marked_from_head(CC,CCremove,CCkeep)
         -> C_Head = (CCkeep \ CCremove)
         ;
         C_Head = CC)),
 
   (N1_head==N2_head -> nl, write('Head core without grammar symbols in rule: '),
                        write((G_Head <:> G_Body)), nl, write('Compilation stopped'), abort
        ; true),

   (G_Body = (Guard | Real_G_Body)
    -> translate_grammar_body_to_CHR_body(Real_G_Body, Real_C_Body,N1_body,N2_body),
       C_Body = (Guard | Real_C_Body)
    ;
      translate_grammar_body_to_CHR_body(G_Body, C_Body,N1_body,N2_body)),
   

   % gapping stuff:
   translate_gaps_into_guards((C_Head <=> C_Body), RuleNoGapSymbols),
    

   % LRstuff
   (current_chrg_option(lr_optimize, on), Labels \= []
    -> make_passive_pragmas_from_label_list(Labels,Pragmas),
       C_Rule = (RuleNoGapSymbols pragma Pragmas)
    ;
    C_Rule = RuleNoGapSymbols),

   % the following stuff to catch special case of body nongrammatical:
   (N1_body == N2_body -> true
    ; N1_head=N1_body, N2_head=N2_body).
    
    
    
    
    

translate_grammar_rule_to_CHR_rule((G_Head ::> G_Body),C_Rule):-
   (bounded(G_Head) -> true ; write('Unbounded head core in rule '),
                              write((G_Head ::> G_Body)),nl,
                              write('Compilation stopped'), abort),

                              
   (current_chrg_option(lr_optimize, on) ->
        label_all_but_rightmost(G_Head,G_Head_L,Labels)
    ;
    G_Head_L=G_Head),

                              
   (G_Head_L = (LG -\ CG /- RG)
    -> translate_grammar_head_to_CHR_head(LG, LC, _, N1_head),
       translate_grammar_head_to_CHR_head(CG, CC, N1_head,N2_head),
       translate_grammar_head_to_CHR_head(RG, RC, N2_head, _),
       C_Head = (LC, CC, RC)
    ;
    G_Head_L = (LG -\ CG)
    -> translate_grammar_head_to_CHR_head(LG, LC,  _,N1_head),
       translate_grammar_head_to_CHR_head(CG, CC, N1_head,N2_head),
       C_Head = (LC, CC)
    ;
    G_Head_L = (CG /- RG)
    -> translate_grammar_head_to_CHR_head(CG, CC, N1_head,N2_head),
       translate_grammar_head_to_CHR_head(RG, RC, N2_head, _),
       C_Head = (CC, RC)
    ;       
      translate_grammar_head_to_CHR_head(G_Head_L,C_Head,N1_head,N2_head)),
   (G_Body = (Guard | Real_G_Body)
    -> translate_grammar_body_to_CHR_body(Real_G_Body, Real_C_Body,N1_body,N2_body),
       C_Body = (Guard | Real_C_Body)
    ;
      translate_grammar_body_to_CHR_body(G_Body, C_Body,N1_body,N2_body)),
   % the following stuff to catch special case of head or body nongrammatical:
   (N1_head==N2_head -> nl, write('Head core without grammar symbols in rule: '),
            write((G_Head ::> G_Body)), nl,write('Compilation stopped'), abort
     ; true),
     
   % test no malplaced '!' in propagation rule:
   (take_out_simpagation_marked_from_head(C_Head,XXX,_),
     C_Head \== XXX  -> nl, write('Prefix ''!'' not allowed in head of ::> rule: '),
                            write((G_Head ::> G_Body)), nl,write('Compilation stopped'), abort
     
     ; true),
   % gapping stuff:
   translate_gaps_into_guards((C_Head ==> C_Body), RuleNoGapSymbols),

   % LRstuff
   (current_chrg_option(lr_optimize, on), Labels \= []
    -> make_passive_pragmas_from_label_list(Labels,Pragmas),
       C_Rule = (RuleNoGapSymbols pragma Pragmas)
    ;
    C_Rule = RuleNoGapSymbols),


   (N1_body == N2_body -> true
    ; N1_head=N1_body, N2_head=N2_body).


% Notice: If, following the call, the two N's are identical,
% it means that the G argument is nongrammatical, i.e.
% has no grammar symbols.

%nb: the first three rules correct for imperfections in operator precedences



translate_grammar_head_to_CHR_head((!G:Range), (!H), N1,N2):- 
    var(Range), !,
    Range=(N1,N2),
    translate_grammar_head_to_CHR_head((!G:Range), (!H), N1,N2).


translate_grammar_head_to_CHR_head((!G:(N1,N2)#Id), (!H#Id), N1,N2):- 
    !,
    translate_grammar_head_to_CHR_head(G, H, N1,N2).

translate_grammar_head_to_CHR_head(G:Range, H, N1,N2):-
    var(Range),
    !,
    Range=(N1,N2),
    translate_grammar_head_to_CHR_head(G:Range, H, N1,N2).


translate_grammar_head_to_CHR_head((G:(N1,N2)#Id), (H#Id), N1,N2):-
    !,
    translate_grammar_head_to_CHR_head(G, H, N1,N2).

translate_grammar_head_to_CHR_head(G:(N1,N2), H, N1,N2):-
    !,
    translate_grammar_head_to_CHR_head(G, H, N1,N2).

translate_grammar_head_to_CHR_head((G1,G2),(C1,C2),N1,N3):-
    !,
    translate_grammar_head_to_CHR_head(G1,C1,N1,N2),
    translate_grammar_head_to_CHR_head(G2,C2,N2,N3).

translate_grammar_head_to_CHR_head((G1$$G2),(C1,C2),N1,N2):-
    !,
    translate_grammar_head_to_CHR_head(G1,C1,N1,N2),
    translate_grammar_head_to_CHR_head(G2,C2,N1,N2).


translate_grammar_head_to_CHR_head((G#Id),(C#Id),N1,N2):-
    !,
    translate_grammar_head_to_CHR_head(G,C,N1,N2).

translate_grammar_head_to_CHR_head([Tok|Toks],TokenCalls,N1,N2):-
    !,
    translate_token_list_to_CHR_calls([Tok|Toks],TokenCalls,N1,N2).


translate_grammar_head_to_CHR_head(G,C,N1,N2):-
    functor(G,Sym,Arity),
    defined_grammar_symbol(Sym,Arity),!,
    translate_grammar_symbol_to_constraint(G,C,N1,N2).


% special syntax for simpagation rules - ignore simpagation effect here
% and move to later analysis!

translate_grammar_head_to_CHR_head((!G),(!C),N1,N2):-
    !,
    translate_grammar_head_to_CHR_head(G,C,N1,N2).

translate_grammar_head_to_CHR_head({Gcode},Gcode,N,N).
   % we have no way to check contents because it is not possible
   % to cehck if a symbol was declared as a constraints
   % (CHR's test for this does not work before the it has compiled the file).



% nongrammatical constraint in head without curly bracket

translate_grammar_head_to_CHR_head(C,C,N,N):-
    functor(C,Pred,Arity),
    (abducible_predicate(Pred,Arity) ->
        write('Abducible '), write(C), write(' without {} in head of rule.'), nl,
        write('Please write {'),write(C),write('} and try again'),nl,
        write('Compilation stopped'),nl, abort
     ;
     write('Illegal item '), write(C), write(' in head of rule.'), nl,
     write('Compilation stopped'),nl, abort).
     
%%%%%%%%%%%%%%%
% Device used for expanding rules with optional arguments

% penetrate through context parts:

split_head_on_optional_grammar_symbol((L-\C/-R), (L-\C1/-R), (L-\C2/-R), Subst2):-
   !, 
   (split_head_on_optional_grammar_symbol(C,C1,C2,Subst2) -> true).

split_head_on_optional_grammar_symbol((C/-R), (C1/-R), (C2/-R), Subst2):-
   !, 
   (split_head_on_optional_grammar_symbol(C,C1,C2,Subst2) -> true).

split_head_on_optional_grammar_symbol((L-\C), (L-\C1), (L-\C2), Subst2):-
   !, 
   (split_head_on_optional_grammar_symbol(C,C1,C2,Subst2) -> true).


% Not all grammar symbols in a core may be optional

split_head_on_optional_grammar_symbol( optional(A,S), _, _, _):-
   !, 
   nl, write('Error: Rule with only optional elements in core of head not allowed: '),
       write(optional(A,S)), nl,
       write('Compilation stopped'), abort.

split_head_on_optional_grammar_symbol( optional(A), _, _, _):-
   !, 
   nl, write('Error: Rule with only optional elements in core of head not allowed: '),
       write(optional(A)), nl,
       write('Compilation stopped'), abort.

% normal decomposition:

split_head_on_optional_grammar_symbol( (optional(A,S), More),  (A,More), More, S):- !.

split_head_on_optional_grammar_symbol( (optional(A), More),  (A,More), More, no_substitution):- !.

split_head_on_optional_grammar_symbol( (More, optional(A,S)),  (More,A), More, S):- !.

split_head_on_optional_grammar_symbol( (More, optional(A)),  (More,A), More, no_substitution):- !.

split_head_on_optional_grammar_symbol((A,B), One, Two, Subst):-
    split_head_on_optional_grammar_symbol(A, Aone, Atwo, Subst) ->
       One=(Aone, B), Two = (Atwo, B)
    ;
    split_head_on_optional_grammar_symbol(B, Bone, Btwo, Subst) ->
       One=(A, Bone), Two = (A, Btwo).
    % otherwise failure




%%%%%%%%

% traverse syntax of Prolog's callable terms to locate grammar symbols
% NOTICE CHANGE SINCE FIRST VERSION (sep-oct 2001) - the rule for comma now
% distributes identical indices to both sides!

translate_grammar_body_to_CHR_body(G:(N1,N2), H, _,_):-
    !,
    translate_grammar_body_to_CHR_body(G, H, N1,N2).


translate_grammar_body_to_CHR_body((G1,G2),(C1,C2),N1,N2):-
    !,
    translate_grammar_body_to_CHR_body(G1,C1,N1,N2),
    translate_grammar_body_to_CHR_body(G2,C2,N1,N2).

translate_grammar_body_to_CHR_body((G1$$G2),(C1,C2),N1,N2):-
    !,
    translate_grammar_body_to_CHR_body(G1,C1,N1,N2),
    translate_grammar_body_to_CHR_body(G2,C2,N1,N2).


translate_grammar_body_to_CHR_body([Tok|Toks],TokenCalls,N1,N2):-
    !,
    translate_token_list_to_CHR_calls([Tok|Toks],TokenCalls,N1,N2).

translate_grammar_body_to_CHR_body((LG;RG),(LCx;RCx),N1,N2):-
    !,
    translate_grammar_body_to_CHR_body(LG,LC,N1_left,N2_left),
    translate_grammar_body_to_CHR_body(RG,RC,N1_right,N2_right),
    % special cases with nongrammatical LGs or RGs
    (N1_left==N2_left % i.e. LG nongrammatical
     -> (N1_right==N2_right -> N1=N2, LCx=LC, RCx=RC
         ; LCx=(LC,N1=N2), % notice dynamic '='
           N1=N1_right, N2=N2_right, RCx=RC)
     ;
     N1_right==N2_right ->
        N1=N1_left, N2=N2_left, LCx=LC,
        RCx=(RC,N1=N2) % notice dynamic '=')
     ;
     N1_right=N1, N2_right=N2, RCx=RC,
     N1_left=N1, N2_left=N2, LCx=LC).
    
translate_grammar_body_to_CHR_body((Cond->G),(Cond->C),N1,N2):-
    !,
    translate_grammar_body_to_CHR_body(G,C,N1,N2).

translate_grammar_body_to_CHR_body({Code},Code,_,_):- !.

translate_grammar_body_to_CHR_body(=+H, =+H, _,_):- !.
translate_grammar_body_to_CHR_body(=-H, =-H, _,_):- !.
translate_grammar_body_to_CHR_body(=*H, =*H, _,_):- !.

translate_grammar_body_to_CHR_body(+H, H+N, N,_):- !.
translate_grammar_body_to_CHR_body(-H, H-N, N,_):- !.
translate_grammar_body_to_CHR_body(*H, H*N, N,_):- !.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

translate_grammar_body_to_CHR_body(G,C,N1,N2):-
    functor(G,Sym,Arity),
    (defined_grammar_symbol(Sym,Arity), \+grammar_symbol_not_allowed_in_body(Sym,Arity) ->
          translate_grammar_symbol_to_constraint(G,C,N1,N2)
     ;
     predicates_that_may_be_used_in_bodies_without_curly_brackets(X),
     member(Sym/Arity, X) -> G=C
     ;
     write('Illegal item in rule body: '), write(G),nl,
     write('Perhaps code that should have been put in {}'),nl,
     write('Compilation stopped'),abort).

translate_grammar_body_to_CHR_body(=+(H),=+(H),_,_):- !.



% nongrammatical callable in body
translate_grammar_body_to_CHR_body(C,C,N,N).

%%%%%%%%%%%%

translate_grammar_symbol_to_constraint(G,C,N1,N2):-
    G=.. [P|Args],
    C=.. [P,N1,N2|Args].

%%%%%%%%%%%%%%%%%%

% checking that a core (or whole head) is bounded (i.e., no open gaps at the ends)

bounded( (_ -\ C /- _) ):- !, bounded(C).

bounded( (_ -\ C) ):- bounded(C).

bounded( (C /- _) ):- bounded(C).

bounded(C):- leftbounded(C), rightbounded(C).

leftbounded((A$$B)) :- !, (leftbounded(A) -> true ; leftbounded(B)).
leftbounded((...)):- !, fail.
leftbounded((..._)):- !, fail.
leftbounded((_..._)):- !, fail.
leftbounded((A,_)):- !, leftbounded(A).
leftbounded(_).

rightbounded((A$$B)) :- !, (rightbounded(A) -> true ; rightbounded(B)).
rightbounded((...)):- !, fail.
rightbounded((..._)):- !, fail.
rightbounded((_..._)):- !, fail.
rightbounded((_,A)):- !, rightbounded(A).
rightbounded(_).



%%% stupid helpers

distribute_label_over_comma_struct(L, (C1,C2), (LC1,LC2), X1,X3):-
    !, distribute_label_over_comma_struct(L, C1, LC1,X1,X2),
    distribute_label_over_comma_struct(L, C2, LC2,X2,X3).

distribute_label_over_comma_struct(L, C, (Lx @ C),X1,X2):-
    X2 is X1+1,
    number_codes(X1,CodesX1), atom_codes(L,CodesL), append(CodesL, CodesX1,CodesLx),
    atom_codes(Lx,CodesLx),
    write(' '), write(Lx).
    
distribute_pragma_over_comma_struct(P,(C1,C2),(PC1,PC2)):-
    !, distribute_pragma_over_comma_struct(P,C1,PC1),
    distribute_pragma_over_comma_struct(P,C2,PC2).

distribute_pragma_over_comma_struct(P,(C pragma P1),(C pragma P,P1)):- !.

distribute_pragma_over_comma_struct(P,C,(C pragma P)).

%%%

term_expansion_comma_structure((A,B),R):-
    !, term_expansion_comma_structure(A,_),
    term_expansion_comma_structure(B,R).
    % assumes that term_expansion does not return
    % interesting stuff for CHR rules

term_expansion_comma_structure(A,R):-
    expand_term(A,R).
    
translate_token_list_to_CHR_calls([Tok],token(N1,N2,Tok),N1,N2).
    
translate_token_list_to_CHR_calls([Tok|Toks],(token(N1,N2,Tok),TCs),N1,N3):-
   translate_token_list_to_CHR_calls(Toks,TCs,N2,N3).  


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Process head of rule to pick up those marked by !.
% - fails if no such!

% take_out_simpagation_marked_from_head( head, head-without-such, such)

take_out_simpagation_marked_from_head(H,HWC,S):-
    take_out_simpagation_marked_from_head_aux(H,HWC,S),
    (HWC = 'TheEmptyHead&//'
     -> nl, write('Error: Not allowed to put ''!'' on *all* grammar symbols/constraints in <:> rule'),
        nl, write('Compilation stopped'),nl, abort
     ;
     true).


take_out_simpagation_marked_from_head_aux( !A#X, 'TheEmptyHead&//', A#X):- !.

take_out_simpagation_marked_from_head_aux( !A, 'TheEmptyHead&//', A):- !.


take_out_simpagation_marked_from_head_aux( ( !A#X , B), Bx, Such):-
    !,
    ( take_out_simpagation_marked_from_head_aux(B,Bx,Bsuch)
      -> Such=(A#X,Bsuch)
      ;
      Such=A#X,Bx=B).

take_out_simpagation_marked_from_head_aux( ( A , !B#X), Ax, Such):-
    !,
    ( take_out_simpagation_marked_from_head_aux(A,Ax,Asuch)
      -> Such = (Asuch,B#X)
      ;
      Ax=A,Such = B#X).



take_out_simpagation_marked_from_head_aux( ( !A , B), Bx, Such):-
    !,
    ( take_out_simpagation_marked_from_head_aux(B,Bx,Bsuch)
      -> Such=(A,Bsuch)
      ;
      Such=A,Bx=B).

take_out_simpagation_marked_from_head_aux( ( A , !B), Ax, Such):-
    !,
    ( take_out_simpagation_marked_from_head_aux(A,Ax,Asuch)
      -> Such = (Asuch,B)
      ;
      Ax=A,Such = B).

take_out_simpagation_marked_from_head_aux( (A,B),AxBx, Such):-
    (take_out_simpagation_marked_from_head_aux(A,Ax,Asuch)
     -> (take_out_simpagation_marked_from_head_aux(B,Bx,Bsuch)
         -> Such = (Asuch,Bsuch)
         ;
         Bx=B, Such=Asuch)
     ;
     take_out_simpagation_marked_from_head_aux(B,Bx,Bsuch)
      -> Ax=A, Such = Bsuch),
     compose_intermediate_heads_maybe_with_empty(Ax,Bx,AxBx).

compose_intermediate_heads_maybe_with_empty(A,'TheEmptyHead&//',A):- !.
compose_intermediate_heads_maybe_with_empty('TheEmptyHead&//',B,B):- !.
compose_intermediate_heads_maybe_with_empty(A,B,(A,B)):- !.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% this to implement "set passive pragmas on all but leftmost"
% Goes through a head and generate labels, perhaps reusing existing ones
% - here "head" is a structure built with
%     comma, -\, /-
%   of constraints, perhaps with ! and or #

label_all((A,B),(LA,LB),LabelsAB):-
    !, label_all(A,LA,LabelsA),
    label_all(B,LB,LabelsB),
    append(LabelsA, LabelsB, LabelsAB).


label_all((A$$B),(LA$$LB),LabelsAB):-
    !, label_all(A,LA,LabelsA),
    label_all(B,LB,LabelsB),
    append(LabelsA, LabelsB, LabelsAB).

label_all({C},{LC},LabelsC):- !,
    labels(C,LC,LabelsC).

label_all(A#X,A#X,[X]):- !.

label_all(A,A#X,[X]).


label_all_but_rightmost((A,B),LAcommaLB,LabelsAB):-
    !, label_all_but_rightmost((A,B),rightmost,LAcommaLB,LabelsAB).

label_all_but_rightmost((A$$B), LA_2dollar_LB,LabelsAB):-
    !, label_all_but_rightmost((A$$B),rightmost,LA_2dollar_LB,LabelsAB).

label_all_but_rightmost({C},{LC},LabelsC):-
    label_all_but_rightmost(C,LC,LabelsC).

label_all_but_rightmost((A-\B/-C),(LA-\LB/-LC),LabelsABC):-
    !,
    label_all(A,LA,LabelsA),
    label_all_but_rightmost(B,LB,LabelsB),
    label_all_but_rightmost(C,LC,LabelsC),
    append(LabelsB,LabelsC,LabelsBC),
    append(LabelsA,LabelsBC,LabelsABC).
    
label_all_but_rightmost((B/-C),(LB/-LC),LabelsBC):-
    !,
    label_all_but_rightmost(B,LB,LabelsB),
    label_all_but_rightmost(C,LC,LabelsC),
    append(LabelsB,LabelsC,LabelsBC).

label_all_but_rightmost((A-\B),(LA-\LB),LabelsAB):-
    !,
    label_all(A,LA,LabelsA),
    label_all_but_rightmost(B,LB,LabelsB),
    append(LabelsA,LabelsB,LabelsAB).
    
  

label_all_but_rightmost(A,A,[]).

label_all_but_rightmost((A,B),Side,(LA,LB),LabelsAB):-
    !, label_all_but_rightmost(A,non_rightmost,LA,LabelsA),
    label_all_but_rightmost(B,Side,LB,LabelsB),
    append(LabelsA, LabelsB, LabelsAB).

label_all_but_rightmost((A$$B),Side,(LA$$LB),LabelsAB):-
    !, label_all_but_rightmost(A,Side,LA,LabelsA),
    label_all_but_rightmost(B,Side,LB,LabelsB),
    append(LabelsA, LabelsB, LabelsAB).

label_all_but_rightmost({C},Side,{LC},LabelsC):-
    label_all_but_rightmost(C,Side,LC,LabelsC).


label_all_but_rightmost(A#X,non_rightmost,A#X,[X]):- !.

label_all_but_rightmost(A#X,rightmost,A#X,[]):- !.

label_all_but_rightmost(A,non_rightmost,A#X,[X]):- !.

label_all_but_rightmost(A,rightmost,A,[]):- !.


% make_passive_pragmas_from_label_list
% should not be called with empty list!

make_passive_pragmas_from_label_list([L],passive(L)).

make_passive_pragmas_from_label_list([L|Ls],(passive(L),Ps)):-
    make_passive_pragmas_from_label_list(Ls,Ps).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
% translate_gaps_into_guards(CHR-Rule, CHR-Rule-no-gaps)
% --- take gaps out of rhs and replace with guards


translate_gaps_into_guards((R pragma P),(R1 pragma P)):-
    translate_gaps_into_guards(R,R1).

translate_gaps_into_guards((H <=> G | B), (H1 <=> G1 | B)):-
    !,
    remove_gaps_from_lhs_and_make_ineqs(H,H1,InEqs),
    (InEqs==[]
     -> H=H1, G=G1
     ;
     merge_guard_list_with_guard(InEqs,G,G1)).

translate_gaps_into_guards((H ==> G | B), (H1 ==> G1 | B)):-
    !,
    remove_gaps_from_lhs_and_make_ineqs(H,H1,InEqs),
    (InEqs==[]
     -> H=H1, G=G1
     ;
     merge_guard_list_with_guard(InEqs,G,G1)).

translate_gaps_into_guards((H <=> B), R):-
    !,
    remove_gaps_from_lhs_and_make_ineqs(H,H1,InEqs),
    (InEqs==[]
     -> R = (H <=> B)
     ;
     list_to_comma(InEqs,InEqsComma),
     R=(H1 <=> InEqsComma | B)).

translate_gaps_into_guards((H ==> B), R):-
    !,
    remove_gaps_from_lhs_and_make_ineqs(H,H1,InEqs),
    (InEqs==[]
     -> R = (H ==> B)
     ;
     list_to_comma(InEqs,InEqsComma),
     R=(H1 ==> InEqsComma | B)).



% 

%%% Was this in 0.1
%merge_guard_list_with_guard(InEqs,G,G1):-
%   list_to_comma(InEqs,InEqComma),
%   (G = (Ask & Tell) -> G1 = ((Ask,InEqComma) & Tell)
%    ;
%    G1 = (G,InEqComma)).

merge_guard_list_with_guard(InEqs,G,G1):-
   list_to_comma(InEqs,InEqComma),!,
   G1 = (G,InEqComma).


list_to_comma([A],A).
list_to_comma([A|As],(A,AsComma)):-
    list_to_comma(As,AsComma).

% remove_gaps_from_lhs_and_make_ineqs(CHRleft-hand-side, CHRleft-hand-side-No-gaps,
%                            list-of-ineqs)


remove_gaps_from_lhs_and_make_ineqs(Left,LeftNoGaps,Ineq):-
    remove_gaps_from_lhs_and_make_ineqs_aux(Left,LeftNoGaps1,Ineq),
    remove_placeholders_for_nothing(LeftNoGaps1,LeftNoGaps).


% BAD code structure ===> repeated code :(

% Singleton ... can occur in rare cases
remove_gaps_from_lhs_and_make_ineqs_aux('...'(M1,M2),'!!!NOTHING-SCAR-OF-GAP!!!',[(M1=<M2)]):-
    !.

% Singleton ... before comma
remove_gaps_from_lhs_and_make_ineqs_aux(('...'(M1,M2),B),BX,[(M1=<M2)|NB]):-
    !,
    remove_gaps_from_lhs_and_make_ineqs_aux(B,BX,NB).

% gaps with no args.

% Singleton ... after comma
remove_gaps_from_lhs_and_make_ineqs_aux((A, '...'(M1,M2)),AX,[(M1=<M2)|NA]):-
    !,
    remove_gaps_from_lhs_and_make_ineqs_aux(A,AX,NA).

% Singleton ...# before comma
remove_gaps_from_lhs_and_make_ineqs_aux(('...'(M1,M2)#_,B),BX,[(M1=<M2)|NB]):-
    !, remove_gaps_from_lhs_and_make_ineqs_aux(B,BX,NB).

% Singleton ...# after comma
remove_gaps_from_lhs_and_make_ineqs_aux((A, '...'(M1,M2)#_),AX,[(M1=<M2)|NA]):-
    remove_gaps_from_lhs_and_make_ineqs_aux(A,AX,NA).


% gaps with 1 args:

% Singleton ... can occur in rare cases

remove_gaps_from_lhs_and_make_ineqs_aux('...'(M1,M2,X),'!!!NOTHING-SCAR-OF-GAP!!!',
       [(X is M2-M1)]):-
    !.

% Singleton _..._ before comma
remove_gaps_from_lhs_and_make_ineqs_aux(('...'(M1,M2,X),B),BX,
       [(X is M2-M1)|NB]):-
    !,
    remove_gaps_from_lhs_and_make_ineqs_aux(B,BX,NB).

% Singleton _..._ after comma
remove_gaps_from_lhs_and_make_ineqs_aux((A, '...'(M1,M2,X)),AX,
       [(X is M2-M1)|NA]):-
    !,
    remove_gaps_from_lhs_and_make_ineqs_aux(A,AX,NA).

% Singleton _..._# before comma
remove_gaps_from_lhs_and_make_ineqs_aux(('...'(M1,M2,X)#_,B),BX,
       [(X is M2-M1)|NB]):-
    !, remove_gaps_from_lhs_and_make_ineqs_aux(B,BX,NB).

% Singleton _..._# after comma
remove_gaps_from_lhs_and_make_ineqs_aux((A, '...'(M1,M2,X)#_),AX,
       [(X is M2-M1)|NA]):-
    remove_gaps_from_lhs_and_make_ineqs_aux(A,AX,NA).


% gaps with 2 args:

% Singleton ... can occur in rare cases

remove_gaps_from_lhs_and_make_ineqs_aux('...'(M1,M2,X,Y),'!!!NOTHING-SCAR-OF-GAP!!!',
       [(Delta is M2-M1, X =< Delta, Delta =< Y)]):-
    !.

% Singleton _..._ before comma
remove_gaps_from_lhs_and_make_ineqs_aux(('...'(M1,M2,X,Y),B),BX,
       [(Delta is M2-M1, X =< Delta, Delta =< Y)|NB]):-
    !,
    remove_gaps_from_lhs_and_make_ineqs_aux(B,BX,NB).

% Singleton _..._ after comma
remove_gaps_from_lhs_and_make_ineqs_aux((A, '...'(M1,M2,X,Y)),AX,
       [(Delta is M2-M1, X =< Delta, Delta =< Y)|NA]):-
    !,
    remove_gaps_from_lhs_and_make_ineqs_aux(A,AX,NA).

% Singleton _..._# before comma
remove_gaps_from_lhs_and_make_ineqs_aux(('...'(M1,M2,X,Y)#_,B),BX,
       [(Delta is M2-M1, X =< Delta, Delta =< Y)|NB]):-
    !, remove_gaps_from_lhs_and_make_ineqs_aux(B,BX,NB).

% Singleton _..._# after comma
remove_gaps_from_lhs_and_make_ineqs_aux((A, '...'(M1,M2,X,Y)#_),AX,
       [(Delta is M2-M1, X =< Delta, Delta =< Y)|NA]):-
    remove_gaps_from_lhs_and_make_ineqs_aux(A,AX,NA).



% general comma


remove_gaps_from_lhs_and_make_ineqs_aux((A,B),(AX,BX),NAB):-
    !,
    remove_gaps_from_lhs_and_make_ineqs_aux(A,AX,NA),
    remove_gaps_from_lhs_and_make_ineqs_aux(B,BX,NB),
    append(NA,NB,NAB).

% parallel


remove_gaps_from_lhs_and_make_ineqs_aux((A$$B),(AX$$BX),NAB):-
    !,
    remove_gaps_from_lhs_and_make_ineqs_aux(A,AX,NA),
    remove_gaps_from_lhs_and_make_ineqs_aux(B,BX,NB),
    append(NA,NB,NAB).

% more on no-arg gaps

% Singleton _..._ before \
remove_gaps_from_lhs_and_make_ineqs_aux(('...'(M1,M2)\B),BX,[(M1=<M2)|NB]):-
    !,
    remove_gaps_from_lhs_and_make_ineqs_aux(B,BX,NB).

% Singleton _..._ after \
remove_gaps_from_lhs_and_make_ineqs_aux((A\'...'(M1,M2)),AX,[(M1=<M2)|NA]):-
    !,
    remove_gaps_from_lhs_and_make_ineqs_aux(A,AX,NA).

% Singleton _..._# before \
remove_gaps_from_lhs_and_make_ineqs_aux(('...'(M1,M2)#_\B),BX,[(M1=<M2)|NB]):-
    !,
    remove_gaps_from_lhs_and_make_ineqs_aux(B,BX,NB).

% Singleton _..._# after \
remove_gaps_from_lhs_and_make_ineqs_aux((A\'...'(M1,M2)#_),AX,[(M1=<M2)|NA]):-
    !,
    remove_gaps_from_lhs_and_make_ineqs_aux(A,AX,NA).




% more on one-arg gaps

% Singleton ..._ before \
remove_gaps_from_lhs_and_make_ineqs_aux(('...'(M1,M2,X)\B),BX,
     [(X is M2-M1)|NB]):-
    !,
    remove_gaps_from_lhs_and_make_ineqs_aux(B,BX,NB).

% Singleton ..._ after \
remove_gaps_from_lhs_and_make_ineqs_aux((A\'...'(M1,M2,X)),AX,
      [(X is M2-M1)|NA]):-
    !,
    remove_gaps_from_lhs_and_make_ineqs_aux(A,AX,NA).

% Singleton ..._# before \
remove_gaps_from_lhs_and_make_ineqs_aux(('...'(M1,M2,X)#_\B),BX,
     [(X is M2-M1)|NB]):-
    !,
    remove_gaps_from_lhs_and_make_ineqs_aux(B,BX,NB).

% Singleton ..._# after \
remove_gaps_from_lhs_and_make_ineqs_aux((A\'...'(M1,M2,X)#_),AX,
      [(X is M2-M1)|NA]):-
    !,
    remove_gaps_from_lhs_and_make_ineqs_aux(A,AX,NA).






% more on two-arg gaps

% Singleton _..._ before \
remove_gaps_from_lhs_and_make_ineqs_aux(('...'(M1,M2,X,Y)\B),BX,
     [(Delta is M2-M1, X =< Delta, Delta =< Y)|NB]):-
    !,
    remove_gaps_from_lhs_and_make_ineqs_aux(B,BX,NB).

% Singleton _..._ after \
remove_gaps_from_lhs_and_make_ineqs_aux((A\'...'(M1,M2,X,Y)),AX,
      [(Delta is M2-M1, X =< Delta, Delta =< Y)|NA]):-
    !,
    remove_gaps_from_lhs_and_make_ineqs_aux(A,AX,NA).

% Singleton _..._# before \
remove_gaps_from_lhs_and_make_ineqs_aux(('...'(M1,M2,X,Y)#_\B),BX,
     [(Delta is M2-M1, X =< Delta, Delta =< Y)|NB]):-
    !,
    remove_gaps_from_lhs_and_make_ineqs_aux(B,BX,NB).

% Singleton _..._# after \
remove_gaps_from_lhs_and_make_ineqs_aux((A\'...'(M1,M2,X,Y)#_),AX,
      [(Delta is M2-M1, X =< Delta, Delta =< Y)|NA]):-
    !,
    remove_gaps_from_lhs_and_make_ineqs_aux(A,AX,NA).


%General \
remove_gaps_from_lhs_and_make_ineqs_aux((A\B),(AX\BX),NAB):-
    !,
    remove_gaps_from_lhs_and_make_ineqs_aux(A,AX,NA),
    remove_gaps_from_lhs_and_make_ineqs_aux(B,BX,NB),
    append(NA,NB,NAB).


% just something

remove_gaps_from_lhs_and_make_ineqs_aux(X,X,[]).

%%%%% a hack to correct for bad design elsewhere in the program
%% will go wrong if someone has a simp rule with everything !ed
%% or gaps with passive stuff
%% --- indicates that something should be redesigned

remove_placeholders_for_nothing((Bla\Blop),(Bla1\Blop1)):- !,
   remove_placeholders_for_nothing(Bla,Bla1),
   remove_placeholders_for_nothing(Blop,Blop1).

remove_placeholders_for_nothing(('!!!NOTHING-SCAR-OF-GAP!!!',A), A):- !.
remove_placeholders_for_nothing((A,'!!!NOTHING-SCAR-OF-GAP!!!'), A):- !.

remove_placeholders_for_nothing((Bla,Blop),(Bla1,Blop1)):- !,
   remove_placeholders_for_nothing(Bla,Bla1),
   remove_placeholders_for_nothing(Blop,Blop1).

remove_placeholders_for_nothing(A,A).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
% Run the parser, perhaps with ecco of string:

parse(L):-
    end_of_CHRG_source_has_been_called ->
           (% - MOVED to rule for parse([],...) for efficiency: 
            % length(L,N),
            %%insert_constraint(all(0,N),_), % enter constraint into the store so that a
            %%                               % call to 'all' in head of rule goes right!
            %%                               % see precautions in User's Guide
            parse(L,0))
    ;
    write('You must load a CHRG file ending with ''end_of_CHRG_source'''),
    write('before you can use the parse predicate'), abort.

parse([],N):-
   (current_chrg_option(show_text, on) -> write(' <'), write(N), write('> '), nl
   ; true),
   all(0,N), % so that grammar rules with 'all' can apply
   (current_chrg_option(verbose_AG, off) ->
        % unhappy expectations not allowed
        (find_constraint(=-_) -> fail; true),
        (find_constraint(_-_) -> fail; true),
        % do not show helpers
        remove_all_eq_plus,
        remove_all_eq_star,
        remove_all_plus,
        remove_all_star,
        remove_all_tried_rule_AG_eq_plus_minus,
        remove_all_tried_rule_AG_eq_star_minus,
        remove_all_tried_rule_AG_plus_minus,
        remove_all_tried_rule_AG_star_minus
    ; true).

parse([T|Ts],N):- 
    (current_chrg_option(show_text, on) -> write(' <'), write(N), write('> '), write(T)
     ; true),
    N1 is N+1,token(N,N1,T),parse(Ts,N1).

%%% helpers for the removal of AG stuff

remove_all_tried_rule_AG_eq_plus_minus:-
    find_constraint(tried_rule_AG_eq_plus_minus(A,B))
      -> remove_constraint(tried_rule_AG_eq_plus_minus(A,B)), remove_all_tried_rule_AG_eq_plus_minus
    ; true.

remove_all_tried_rule_AG_eq_star_minus:-
    find_constraint(tried_rule_AG_eq_star_minus(A,B))
      -> remove_constraint(tried_rule_AG_eq_star_minus(A,B)), remove_all_tried_rule_AG_eq_star_minus
    ; true.

remove_all_tried_rule_AG_plus_minus:-
    find_constraint(tried_rule_AG_plus_minus(A,B,C,D))
      -> remove_constraint(tried_rule_AG_plus_minus(A,B,C,D)), remove_all_tried_rule_AG_plus_minus
    ; true.

remove_all_tried_rule_AG_star_minus:-
    find_constraint(tried_rule_AG_star_minus(A,B,C,D))
      -> remove_constraint(tried_rule_AG_star_minus(A,B,C,D)), remove_all_tried_rule_AG_star_minus
    ; true.

remove_all_eq_plus:-
    find_constraint(=+A)
      -> remove_constraint(=+A), remove_all_eq_plus
    ; true.

remove_all_eq_star:-
    find_constraint(=*A)
      -> remove_constraint(=*A), remove_all_eq_star
    ; true.

remove_all_plus:-
    find_constraint(A+B)
      -> remove_constraint(A+B), remove_all_plus
    ; true.

remove_all_star:-
    find_constraint(A*B)
      -> remove_constraint(A*B), remove_all_star
    ; true.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Helper used in abduction and assumption grammars

%%%%%% HELPERS:



unifiable(X,Y):-
     var(X) -> true % no occurs-check
   ; var(Y) -> true
   ; atom(X) -> X==Y
   ; atom(Y) -> X==Y
   ; X=..[F|Xs], Y=..[F|Ys],
     unifiable_list(Xs,Ys).
 
unifiable_list([],[]).
 
unifiable_list([X|Xs],[Y|Ys]):- unifiable(X,Y), unifiable_list(Xs,Ys).

test(X):- (write(do(X));write(undo(X)), fail).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%
%%% various auxiliaries offered to the user:
%%% REMOVED: CANNOT BE IMPLEMENTED IN SP4 OR SWI
%%% and is anyhow uninteresting
%%% Stop constraint solving/parsing with current constraints in store.
%%%%
%%%%% stop:- findall_constraints(_,L), insert_constraints(L).
%%%% 8-sep-2010 jeg antager vi må droppe den facilitet
%%%%
%%%%%insert_constraints([]).
%%%%%insert_constraints([C#_|Cs]):- insert_constraint(C,_), insert_constraints(Cs).

%%%%% THE FOLLOWING IS LOGICALLY OK BUT RESULTS IN AN EXPLOSION OF REPEATED CONSTRAINTS
%%%%%%%%% Resume constraint solving (only interesting after a stop).
%%5%%%
%%%%resume:- findall_constraints(_,L), call_constraints(L).
%%%%
%%%%call_constraints([]).
%%%%call_constraints([C#_|Cs]):- C, call_constraints(Cs).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  accept, acceptc - extracts a single pattern from the constraint store;
%%                    the second of the two in addition emties the constraint store

accept(G):-
    (find_constraint(all(Zero,Max)) -> true;
        write('Predicate '),write(accept(G)),
        write(' could not find all(0,length-of-string) constraints'),nl,abort),
    translate_grammar_symbol_to_constraint(G,C,Zero,Max),
    find_constraint(C).

acceptc(G):-
    (find_constraint(all(Zero,Max)) -> true;
        write('Predicate '),write(acceptc(G)),
        write(' could not find all(0,length-of-string) constraints'),nl,abort),
    translate_grammar_symbol_to_constraint(G,C,Zero,Max),
    find_constraint(C),
    remove_all_constraints.

remove_constraints([]).
remove_constraints([Id|Cs]):- remove_constraint(Id), remove_constraints(Cs).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% mk_variant(X,Y) -
%  - as copy_term but without copying goals blocked on X.

mk_variant(X,Y):- !, mk_variant(X,Y,_,_).

mk_variant(V,W,VList,Wlist):-
    var(V), !, locate(V,W,VList,Wlist).

mk_variant(T,T1,VList,Wlist):-
    T=..[F|TL], mk_variant1(TL,TL1,VList,Wlist), T1=..[F|TL1].

mk_variant1([],[],_,_).

mk_variant1([A|As],[B|Bs],VList,Wlist):-
    mk_variant(A,B,VList,Wlist), mk_variant1(As,Bs,VList,Wlist).


locate(V,W,VL,WL):-
    var(VL), !, VL=[V|_], WL=[W|_].

locate(V,W,[V1|_],[W|_]):- V==V1, !.

locate(V,W,[_|VL],[_|WL]):- locate(V,W,VL,WL).
