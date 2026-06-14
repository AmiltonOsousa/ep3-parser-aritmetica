Gramática utilizada pelo parser CYK.

S -> E
E -> E_ADD_T | E_SUB_T | T
T -> T_MUL_P | T_DIV_P | P
P -> F_POW | F
F -> NEG_F | A
A -> num | LP E_RP

Demais regras estão em parser-cyk/gramatica_aritmetica.rb.
