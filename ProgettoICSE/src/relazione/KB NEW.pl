% A
array_var_def(Nome,Tipo,Dimensione,ID,[DimRighe,DimColonne],Classe,Metodo). % Definizione di un array
array_elem_ref(ID_Ref,Nome,[Nome_VarRighe,Nome_VarColonne]). % Riferimento ad un array
array_elem_inst(ID,Nome,[NomeVarRighe,NomeVarColonne],Metodo,Classe). % Instanziazione di un array

% B

% C
constant_ref(ID,Valore). % Riferimento ad una costante
chiamata(ID,NomeFunzione,[Parametri]). % Chimata ad una funzione

% D
divide(ID_Expr,Op1,Op2,Classe,Metodo). % Operazione aritmetica: Divisione

% E

% F
for_r(ID,_,ID_init,ID_exit,ID_incr,Classe,Metodo). % Cilco For

% G

% I

% L
less(ID_Expr,Op1,Op2,Classe,Metodo). % Operazione di confronto "minore"

% M
minus(ID_Expr,Op1,Op2,Classe,Metodo). % Operazione aritmetica: Sottrazione

% N

% O

% P
post_incr(ID_Expr,Op,Classe,Metodo). % Operazione di post incremento (i++)
plus(ID_Expr,Op1,Op2,Classe,Metodo). % Operazione aritmetica: Addizione

% R

% S
scalar_var_def(NomeVariabile,ID,Classe,Metodo). % Definizione di una variabile scalare
scalar_var_inst(ID,NomeVariabile,Classe,Metodo). % Istanziazione di una variabile scalare
scalar_var_ref(ID,NomeVariabile). % Riferimendo ad una variabile scalare

% T
times(ID_Expr,Op1,Op2,Classe,Metodo). % Operazione aritmetica: Moltiplicazione

% U
uguaglianza(Op1,Op2,Classe,Metodo). % Operatore di assegnazione

% V

% X

% W






.