%Copyright 2016, Anderson Green

:- set_prolog_flag(double_quotes,chars).
:- initialization(main).
%If X is an animal, then X is a bird or a mammal, and vice-versa.
:- use_module(library(chr)).

:- chr_constraint type/2.

species(X,X1),species(X,X2) <=> X1 = X2.

animal(X) <=> 
    (mammal(X);bird(X)),
    (male(X);female(X)).

male(X),female(X) ==> false.

bird(X) <=> species(X,pigeon);species(X,parrot).

mammal(X) <=> species(X,dog);species(X,cat);species(X,bull).

species(X,bull) ==> male(X).

main :- species(X,bull), age(X,20), age(X,13), writeln(X).
