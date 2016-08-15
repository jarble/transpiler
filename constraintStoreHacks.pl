%% Helpers to produce equivalents of remove_constraint rules
%% Changes in version 1.2 August 2016 to adapt with weird new convention for
%% representation of strings.

%%mk_removerRules(ConSpecs)

mk_removerRules((A,B)):- !,
   mk_removerRules(A), mk_removerRules(B).

mk_removerRules(Spec):-
   removeConstraintRule(Spec,Rule),
   assert(rule_stored_for_end_of_CHRG_source(Rule)).

%%%
removeConstraintPredName(P,RemoveP):-
    name(P,PChars),
    name('remove_constraint_',PrefixChars),
    append(PrefixChars,PChars, RemovePChars),
    name(RemoveP,RemovePChars).

removeConstraintRule(P/N, Rule):-
   removeConstraintPredName(P,RemoveP),
   length(As,N),
   PAtom=.. [P|As],
   RemovePAtom=.. [RemoveP|As],
%   Rule=
%          ((RemovePAtom, PAtom#ID <=> true pragma passive(ID)))
%         .
%% written without assuming operator declarations.
%% Necessary as a bug (in the chr compiler?) makes
%% necessary to load this file before chr library is loaded
   Rule = pragma(<=>(','(RemovePAtom,#(PAtom,ID)),true),
                 passive(ID)).

removeConstraintCall(P,Args,RemovePAtom):-
   removeConstraintPredName(P,RemoveP),
   RemovePAtom=.. [RemoveP|Args].
   
removeConstraintCall(Atom,RemovePAtom):-
   Atom=..[P|Args],
   removeConstraintCall(P,Args,RemovePAtom).
    
find_constraint(Pattern):-
     chr:find_chr_constraint(Pattern).

remove_constraint(Pattern):-
    removeConstraintCall(Pattern,Remover), call(Remover).

remove_all_constraints(Pred/N):-
   length(As,N),
   PAtom=.. [Pred|As],
   (find_constraint(PAtom)
     -> remove_constraint(PAtom), remove_all_constraints(Pred/N)
     ; true).

remove_all_constraints:-
   find_constraint(C)
   -> remove_constraint(C), remove_all_constraints
   ; true.

translate_constraint_specs_into_remover_specs((CA,CB),(RA,RB)):-
   !,
   translate_constraint_specs_into_remover_specs(CA,RA),
   translate_constraint_specs_into_remover_specs(CB,RB).

translate_constraint_specs_into_remover_specs(C/N, R/N):-
   removeConstraintPredName(C,R).



