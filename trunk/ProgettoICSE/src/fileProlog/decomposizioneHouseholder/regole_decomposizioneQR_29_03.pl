% %%% consult pasquale
 :- consult('regole_di_base_29_03.pl').
 :- consult('control_and_data_dep_29_03.pl').
 :- consult('fatti_prolog_29_03.pl').

%#############################################################################################################
% NOME: decomposizione_qr(A,Q,R)
% SERVE A: riconosce la decomposizione QR della matrice A
%#############################################################################################################
decomposizione_qr(A,Q,R) :- calcolo_qr(A,QR),
							calcolo_rdiag(A,Rdiag),
							calcolo_r(QR,Rdiag,R),
							calcolo_q(QR,Q).
							

	
%#############################################################################################################
% NOME: decomposizione_qr(A,Q,R)
% SERVE A: riconosce la decomposizione QR della matrice A
%#############################################################################################################							
calcolo_qr(A,QR) :- 
% copia di un array
%scalar_var_inst(def_list_5,qr,qrdecomposition,qrdecomposition),
%scalar_var_ref(vref_3,a),
%uguaglianza(def_list_5,vref_3,qrdecomposition,qrdecomposition),
copia_array(Def_list5,QR,A),

%for_r(47,for(47,exit_147),init_1,exit_147,incr_2,qrdecomposition,qrdecomposition).
%scalar_var_def(k,init_1,qrdecomposition,qrdecomposition).
%scalar_var_inst(init_1,k,qrdecomposition,qrdecomposition).
%constant_ref(cref_4,0).
%uguaglianza(init_1,cref_4,qrdecomposition,qrdecomposition).
%scalar_var_ref(vref_5,k).
%scalar_var_ref(vref_6,n).
%less(exit_147,vref_5,vref_6,qrdecomposition,qrdecomposition).
%scalar_var_ref(vref_7,k).
%post_incr(incr_2,vref_7,qrdecomposition,qrdecomposition).
ciclo_for(ID_for1,  								 				%	 
			  K,										 			%
			  uguaglianza(_,Uguaglianza_Ref1,Classe,Metodo),  		%k = 0
			  less(_,_,Less_ref1,Classe,Metodo),					%k < n
			  post_incr(_,_,Classe,Metodo),							%k++
			  Classe,												%
			  Metodo),												%
	constant_ref(Uguaglianza_Ref1,0),					      		%
	scalar_var_ref(Less_ref1,N),							  		%

scalar_var_inst(Expr_in_for1,NRM,Classe,Metodo).
constant_ref(Cref_8,0).
uguaglianza(Expr_in_for1,Cref_8,Classe,Metodo).
scalar_var_inst(Def_list_5,R,Classe,Metodo).
constant_ref(Cref_9,0).
uguaglianza(Def_list_5,Cref_9,Classe,Metodo).
% da inserire 2 control dependence tra id ciclo for 1 e le due espressioni di sopra

ciclo_for(ID_for2,  								 				%	 
			  I,										 			%
			  uguaglianza(Init_5,Vref_10,Classe,Metodo),			%i = k
			  less(_,_,Vref_12,Classe,Metodo),						%k < n
			  post_incr(_,_,Classe,Metodo),							%k++
			  Classe,												%
			  Metodo),												%
	scalar_var_ref(Vref_10,K),										%
	scalar_var_ref(Less_ref1,M),							  		%

	
.
calcolo_rdiag(A,Rdiag) :- true.

	
	
	
%#############################################################################################################
% NOME: calcolo_r(QR,R,Rdiag)  
% SERVE A: riconosce la decomposizione QR della matrice A
%#############################################################################################################
calcolo_r(QR,R,Rdiag,Classe,Metodo,ID_for1,ID_for2)  :-

% condizioni sulla matrice R
	colonne_matrice(R,N),
	righe_matrice(R,N),
	matrice_bidimensionale(R),
	(
		array_var_def(R,_,_,_,_,Classe,Metodo);
		array_var_def(R,_,_,_,_,Classe,null)
	),% valutare l'aggiunta di un cut

ciclo_for(ID_for1,  								 				%	 
			  I,										 			%
			  uguaglianza(_,Uguaglianza_Ref1,Classe,Metodo),  		%i = 0
			  less(_,_,Less_ref1,Classe,Metodo),					%i < n
			  post_incr(_,_,Classe,Metodo),							%i++
			  Classe,												%
			  Metodo),												%
	constant_ref(Uguaglianza_Ref1,0),					      		%
	scalar_var_ref(Less_ref1,N),							  		%

ciclo_for(ID_for2,  								 				%	 
			  J,										 			%
			  uguaglianza(_,Uguaglianza_Ref2,Classe,Metodo),  		%j = 0
			  less(_,_,Less_ref2,Classe,Metodo),					%j < n
			  post_incr(_,_,Classe,Metodo),							%j++
			  Classe,												%
			  Metodo),												%
	constant_ref(Uguaglianza_Ref2,0),					      		%
	scalar_var_ref(Less_ref2,N),							  		%
		
	control_dependence(ID_for1,ID_for2,Classe,Metodo),

% condizione if (i < j) dentro il secondo ciclo for
	if_r(ID_If,If_expr,Classe,Metodo),
	control_dependence(ID_for2,ID_If,Classe,Metodo),
%condizione dell'if
	less(If_expr,Less_ref3,Less_ref4,Classe,Metodo),
		scalar_var_ref(Less_ref3,I),
		scalar_var_ref(Less_ref4,J),
%espressione nel then 	
	control_dependence(If_expr,Espressione_in_if,Classe,Metodo),	
	array_elem_inst(Espressione_in_if,R,[I,J],Classe,Metodo),
		uguaglianza(Espressione_in_if,Uguaglianza_ref1,Classe,Metodo),
		array_elem_ref(Uguaglianza_ref1,QR,[I,J]),	
%elseif...
	else_if_r(ID_If,_,Else_if_expr),
%condizione else if	
	equal(Else_if_expr,Equal_ref1,Equal_ref2,Classe,Metodo),
		scalar_var_ref(Equal_ref1,I),
		scalar_var_ref(Equal_ref2,J),
%espressione else if
	control_dependence(Else_if_expr,Espressione_in_else_if,Classe,Metodo),
	array_elem_inst(Espressione_in_else_if,R,[I,J],Classe,Metodo),
		uguaglianza(Espressione_in_else_if,Uguaglianza_ref2,Classe,Metodo),
		array_elem_ref(Uguaglianza_ref2,Rdiag,[I]),
%else...		
else_r(ID_If,ID_else),
%espressione else
	control_dependence(ID_else,Expr_in_else,Classe,Metodo),
	array_elem_inst(Expr_in_else,R,[I,J],Classe,Metodo),
		uguaglianza(Expr_in_else,Uguaglianza_ref3,Classe,Metodo),
		constant_ref(Uguaglianza_ref3,0)
	.

	
%#############################################################################################################
% NOME: calcolo_q(QR,Q)
% SERVE A: riconosce la decomposizione QR della matrice A
%#############################################################################################################
calcolo_q(QR,Q,Classe,Metodo,ID_for1,ID_for2,ID_for3,ID_for4,ID_for5)  :-

% Q = [M][N]
	righe_matrice(Q, M), 
	colonne_matrice(Q,N),
	matrice_bidimensionale(Q),

	% la matrice Q è definita nella classe o nel metodo	
	(
		array_var_def(Q,_,_,_,_,Classe,Metodo);
		array_var_def(Q,_,_,_,_,Classe,null)
	),
% K è definito nella classe o nel metodo
	( 
	scalar_var_def(K,_,Classe,Metodo);
	scalar_var_def(K,_,Classe,null)
	),

%condizioni primo ciclo for
	ciclo_for(ID_for1,  											%94		 
			  K,													%
			  minus(_,Minus_op1,Minus_op2,Classe,Metodo),			%k = n-1
			  greater_equal(_,_,Equal_ref2,Classe,Metodo),			%k >= 0
			  post_decr(_,_,Classe,Metodo),							%k--
			  Classe,										  		%
			  Metodo),							              		%
	scalar_var_ref(Minus_op1,N),							  		%
	constant_ref(Minus_op2,1),							      		%
	constant_ref(Equal_ref2,0),							      		%		
	
	%secondo ciclo for
	control_dependence(ID_for1,ID_for2,Classe,Metodo),	 			%
	ciclo_for(ID_for2,  								 			%73	 
			  I,										 			%
			  uguaglianza(_,Uguaglianza_Ref1,Classe,Metodo),  		%i = 0
			  less(_,_,Less_ref2,Classe,Metodo),					%i < m
			  post_incr(_,_,Classe,Metodo),							%i++
			  Classe,												%
			  Metodo),												%
	constant_ref(Uguaglianza_Ref1,0),					      		%
	scalar_var_ref(Less_ref2,M),							  		%
	
	% espressione nel secondo ciclo for											%q[i][k] = 0;
	control_dependence(ID_for2,Expr_in_ciclo_for2,Classe,Metodo),				%
	array_elem_inst(Expr_in_ciclo_for2,Q,[I,K],Classe,Metodo),					%
	uguaglianza(Expr_in_ciclo_for2,Uguaglianza_ref2,Classe,Metodo),				%
	constant_ref(Uguaglianza_ref2,0),											%
	
	% espressione nel primo ciclo for, dopo il secondo ciclo for			 	%q[k][k] = 1;
	array_elem_inst(Expr_in_for1,Q,[K,K],Classe,Metodo),				 		%
	uguaglianza(Expr_in_for1,Uguaglianza_ref3,Classe,Metodo), 					%
	constant_ref(Uguaglianza_ref3,1),                               			%
	control_dependence(ID_CicloFor1,Expr_in_for1,Classe,Metodo),      			%
	true_data_dependence(Expr_in_ciclo_for2,Expr_in_for1),						%
	
	%terzo ciclo for
	ciclo_for(ID_for3,  								 			%	 
			  J,										 			%
			  uguaglianza(_,Uguaglianza_Ref4,Classe,Metodo),  		%j = k
			  less(_,_,Less_ref3,Classe,Metodo),					%j < n
			  post_incr(_,_,Classe,Metodo),							%j++
			  Classe,												%
			  Metodo),												%
	scalar_var_ref(Uguaglianza_Ref4,K),					      		%
	scalar_var_ref(Less_ref3,N),							  		%
	control_dependence(ID_for1,ID_for3,Classe,Metodo),      		%
	
	%condizione if che si trova nel terzo ciclo for 		 		%if (qr[k][k] != 0)
	if_r(If_in_for3,Expr_if,Classe,Metodo),                  		% 
	not_equal(Expr_if,Not_eq_ref1,Not_eq_ref2,Classe,Metodo),		% 
	array_elem_ref(Not_eq_ref1,QR,[K,K]),                    		% 
	constant_ref(Not_eq_ref2,0),                             		% 
	control_dependence(ID_for3,If_in_for3,Classe,Metodo),    		% 
	true_data_dependence(Expr_in_for1,Expr_if),						%
	
	% espressione nel then
	scalar_var_inst(Expr_in_if,S,Classe,Metodo),		 			% 
	uguaglianza(Expr_in_if,Uguaglianza_ref5,Classe,Metodo),			% 	 
	constant_ref(Uguaglianza_ref5,0),		                 		% 
	control_dependence(Expr_if,Expr_in_if,Classe,Metodo), 			% s = 0.							 
			
	% quarto ciclofor
	ciclo_for(ID_for4,  								 			%	 
			  I,										 			% 
			  uguaglianza(_,Uguaglianza_Ref6,Classe,Metodo),  		%i = k
			  less(_,_,Less_ref4,Classe,Metodo),					%i < m
			  post_incr(_,_,Classe,Metodo),							%i++
			  Classe,												%
			  Metodo),												%
	scalar_var_ref(Uguaglianza_Ref6,K),					      		%
	scalar_var_ref(Less_ref4,M),							  		%
	control_dependence(Expr_if,ID_for4,Classe,Metodo),      		%
	
	% espressione nel quarto ciclo for
	scalar_var_inst(Expr_in_for4,S,Classe,Metodo),				 	% s = s + qr[i][k]*q[i][j]
	plus(Expr_in_for4,Plus_ref1,Plus_ref2,Classe,Metodo),		 	%   
	scalar_var_ref(Plus_ref1,S),		                         	%   
	times(Plus_ref2,Times_ref1,Times_ref2,Classe,Metodo),		 	%   
	array_elem_ref(Times_ref1,QR,[I,K]),		                 	%   
	array_elem_ref(Times_ref2,Q,[I,J]),		                     	%   
	control_dependence(ID_for4,Expr_in_for4,Classe,Metodo),		 	%   
	true_data_dependence(Expr_in_if,Expr_in_for4),		         	%   
		
	%espressione dopo il ciclo for 4
	scalar_var_inst(Expr_dopo_for4,S,Classe,Metodo),				%s = s/qr[k][k];
	divide(Expr_dopo_for4,Divide_ref1,Divide_ref2,Classe,Metodo),   %
	scalar_var_ref(Divide_ref1,S),                                  %
	array_elem_ref(Divide_ref2,QR,[K,K]),                           %
	true_data_dependence(Expr_in_for4,Expr_dopo_for4),		       	%  in for è expr_81 dopo è 84
	control_dependence(Expr_if,Expr_dopo_for4,Classe,Metodo),   	%  
	
	% quinto ciclo for
	ciclo_for(ID_for5,  								 			%	 
			  I,										 			% 
			  uguaglianza(_,Uguaglianza_Ref7,Classe,Metodo),  		%i = k
			  less(_,_,Less_ref5,Classe,Metodo),					%i < m
			  post_incr(_,_,Classe,Metodo),							%i++
			  Classe,												%
			  Metodo),												%
	scalar_var_ref(Uguaglianza_Ref7,K),					 			%
	scalar_var_ref(Less_ref5,M),                         			% 
	control_dependence(Expr_if,ID_for5,Classe,Metodo),				% 
	
	% espressione nel quinto ciclo for						 		%q[i][j] = q[i][j] - s*qr[i][k];
	array_elem_inst(Expr_in_for5,Q,[I,J],Classe,Metodo),     		%
	minus(Expr_in_for5,Minus_ref1,Minus_ref2,Classe,Metodo), 		%
	array_elem_ref(Minus_ref1,Q,[I,J]),                      		%
	times(Minus_ref2,Times_ref3,Times_ref4,Classe,Metodo),   		%
	scalar_var_ref(Times_ref3,S),                            		%
	array_elem_ref(Times_ref4,QR,[I,K]),                     		%
	control_dependence(ID_for5,Expr_in_for5,Classe,Metodo),         %
	true_data_dependence(Expr_dopo_for4,Expr_in_for5).         		%
	
	
	
	