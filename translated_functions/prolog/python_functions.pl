any(A) :- member(true,A).
all(B) :- forall(B,member(A,B)).
