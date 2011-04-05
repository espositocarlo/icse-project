% %%% consult pasquale
 :- consult('C:/Documents and Settings/Paolo/Documenti/NetBeansProjects/ProgettoICSE/src/fileProlog/regoleBase/regole_di_base.pl').
 :- consult('C:/Documents and Settings/Paolo/Documenti/NetBeansProjects/ProgettoICSE/src/fileProlog/decomposizioneHouseholder/KB/control_data_dependence.pl').
 :- consult('C:/Documents and Settings/Paolo/Documenti/NetBeansProjects/ProgettoICSE/src/fileProlog/decomposizioneHouseholder/KB/db_syntax_decomposizione_qr.pl').

%#############################################################################################################
% NOME: decomposizione_QR(A,Q,R)
% SERVE A: riconosce la decomposizione QR della matrice A
%#############################################################################################################
decomposizione_QR(A,Q,R) :- calcolo_QR(A,QR,Rdiag),
							calcolo_r(QR,R,Rdiag),
							calcolo_q(QR,Q).

	
%#############################################################################################################
% NOME: decomposizione_QR(A,Q,R)
% SERVE A: riconosce la decomposizione QR della matrice A
%#############################################################################################################							
calcolo_QR(A,QR,Rdiag) :- 

copia_array(Expr_copia_matrice,QR,A),

ciclo_for(ID_for48,  								 				%	 
			  K,										 			%
			  uguaglianza(Init_1,C_ref_4,Classe,Metodo),  
			  less(Exit_148,V_ref_5,V_ref_6,Classe,Metodo),
			  post_incr(Incr_2,V_ref_7,Classe,Metodo),
			  Classe,												%
			  Metodo),												%
constant_ref(C_ref_4,0),
scalar_var_ref(V_ref_6,N),

scalar_var_inst(Expr_l_4,NRM,Classe,Metodo),
constant_ref(C_ref_8,0),
uguaglianza(Expr_l_4,C_ref_8,Classe,Metodo),

scalar_var_inst(Expr_l_5,R,Classe,Metodo),
constant_ref(C_ref_9,0),
uguaglianza(Expr_l_5,C_ref_9,Classe,Metodo),

ciclo_for(ID_for19,  								 				%	 
			I,										 			%
			uguaglianza(Init_5,V_ref_10,Classe,Metodo),
			less(Exit_119,V_ref_11,V_ref_12,Classe,Metodo),
			post_incr(Incr_6,V_ref_13,Classe,Metodo),
			Classe,												%
			Metodo),												%
	scalar_var_ref(V_ref_10,K),										%
	scalar_var_ref(V_ref_12,M),							  		%

if_r(If_16,If_Expr_116,Classe,Metodo),
scalar_var_ref(V_ref_14,NRM),
chiamata(O_ref_1001,abs,[V_ref_14]),
array_elem_ref(A_ref_15,QR,[I,K]),
chiamata(O_ref_1002,abs,[A_ref_15]),
greater(If_Expr_116,O_ref_1001,O_ref_1002,Classe,Metodo),

scalar_var_inst(Expr_8,R,Classe,Metodo),
array_elem_ref(A_ref_16,QR,[I,K]),
scalar_var_ref(V_ref_17,NRM),
divide(Expr_8,A_ref_16,V_ref_17,Classe,Metodo),
scalar_var_inst(Expr_9,R,Classe,Metodo),
scalar_var_ref(V_ref_18,NRM),
chiamata(O_ref_1003,abs,[V_ref_18]),
constant_ref(C_ref_19,1),
scalar_var_ref(V_ref_20,R),
scalar_var_ref(V_ref_21,R),
times(O_ref_1006,V_ref_20,V_ref_21,Classe,Metodo),
plus(O_ref_1005,C_ref_19,O_ref_1006,Classe,Metodo),
chiamata(O_ref_1004,sqrt,[O_ref_1005]),
times(Expr_9,O_ref_1003,O_ref_1004,Classe,Metodo),

else_if_r(If_16,Else_If_15,If_Expr_115),
array_elem_ref(A_ref_22,QR,[I,K]),
constant_ref(C_ref_23,0),
not_equal(If_Expr_115,A_ref_22,C_ref_23,Classe,Metodo),

scalar_var_inst(Expr_11,R,Classe,Metodo),
scalar_var_ref(V_ref_24,NRM),
array_elem_ref(A_ref_25,QR,[I,K]),
divide(Expr_11,V_ref_24,A_ref_25,Classe,Metodo),

scalar_var_inst(Expr_12,R,Classe,Metodo),
array_elem_ref(A_ref_26,QR,[I,K]),
chiamata(O_ref_1007,abs,[A_ref_26]),
constant_ref(C_ref_27,1),
scalar_var_ref(V_ref_28,R),
scalar_var_ref(V_ref_29,R),
times(O_ref_1010,V_ref_28,V_ref_29,Classe,Metodo),
plus(O_ref_1009,C_ref_27,O_ref_1010,Classe,Metodo),
chiamata(O_ref_1008,sqrt,[O_ref_1009]),
times(Expr_12,O_ref_1007,O_ref_1008,Classe,Metodo),

else_r(If_16,Else_14),

scalar_var_inst(Expr_14,R,Classe,Metodo),
constant_ref(C_ref_30,0),
uguaglianza(Expr_14,C_ref_30,Classe,Metodo),

scalar_var_inst(Expr_18,NRM,Classe,Metodo),
scalar_var_ref(V_ref_31,R),
uguaglianza(Expr_18,V_ref_31,Classe,Metodo),

if_r(If_22,If_Expr_122,Classe,Metodo),
array_elem_ref(A_ref_32,QR,[K,K]),
constant_ref(C_ref_33,0),
less(If_Expr_122,A_ref_32,C_ref_33,Classe,Metodo),

ciclo_for(ID_for27,  								 				 
			I,										 			
			uguaglianza(Init_23,V_ref_36,Classe,Metodo),        
			less(Exit_127,V_ref_37,V_ref_38,Classe,Metodo),     
			post_incr(Incr_24,V_ref_39,Classe,Metodo),          
			  Classe,											
			  Metodo),		
scalar_var_ref(V_ref_36,K),
scalar_var_ref(V_ref_38,M),

array_elem_inst(Expr_26,QR,[I,K],Classe,Metodo),
array_elem_ref(A_ref_40,QR,[I,K]),
scalar_var_ref(V_ref_41,NRM),
divide(Expr_26,A_ref_40,V_ref_41,Classe,Metodo),

array_elem_inst(Expr_29,QR,[K,K],Classe,Metodo),
array_elem_ref(A_ref_42,QR,[K,K]),
constant_ref(C_ref_43,1),
plus(Expr_29,A_ref_42,C_ref_43,Classe,Metodo),
ciclo_for(ID_for45,  								 
			J,									
			plus_commutativo(Init_30,V_ref_44,C_ref_45,Classe,Metodo),
			less(Exit_145,V_ref_46,V_ref_47,Classe,Metodo),
			post_incr(Incr_31,V_ref_48,Classe,Metodo),
			  Classe,									
			  Metodo),									
scalar_var_ref(V_ref_44,K),
constant_ref(C_ref_45,1),
scalar_var_ref(V_ref_47,N),


scalar_var_inst(Expr_l_33,S,Classe,Metodo),
constant_ref(C_ref_49,0),
uguaglianza(Expr_l_33,C_ref_49,Classe,Metodo),

ciclo_for(ID_for37,  								 				%	 
			I,										 			%
			uguaglianza(Init_33,V_ref_50,Classe,Metodo),
			less(Exit_137,V_ref_51,V_ref_52,Classe,Metodo),
			post_incr(Incr_34,V_ref_53,Classe,Metodo),
			  Classe,												%
			  Metodo),												%
scalar_var_ref(V_ref_50,K),
scalar_var_ref(V_ref_52,M),

scalar_var_inst(Expr_36,S,Classe,Metodo),
scalar_var_ref(V_ref_54,S),
array_elem_ref(A_ref_55,QR,[I,K]),
array_elem_ref(A_ref_56,QR,[I,J]),
times(O_ref_1012,A_ref_55,A_ref_56,Classe,Metodo),
plus(Expr_36,V_ref_54,O_ref_1012,Classe,Metodo),

scalar_var_inst(Expr_39,S,Classe,Metodo),
scalar_var_ref(V_ref_57,S),
negazione(O_ref_1013,V_ref_57,Classe,Metodo),
array_elem_ref(A_ref_58,QR,[K,K]),
divide(Expr_39,O_ref_1013,A_ref_58,Classe,Metodo),

ciclo_for(ID_for43,  								 			%	 
			I,										 			%
			uguaglianza(Init_39,V_ref_59,Classe,Metodo),
			less(Exit_143,V_ref_60,V_ref_61,Classe,Metodo),
			post_incr(Incr_40,V_ref_62,Classe,Metodo),
			  Classe,												%
			  Metodo),												%
scalar_var_ref(V_ref_59,K),
scalar_var_ref(V_ref_61,M),
scalar_var_ref(V_ref_62,I),

array_elem_inst(Expr_42,QR,[I,J],Classe,Metodo),
array_elem_ref(A_ref_63,QR,[I,J]),
scalar_var_ref(V_ref_64,S),
array_elem_ref(A_ref_65,QR,[I,K]),
times(O_ref_1014,V_ref_64,A_ref_65,Classe,Metodo),
plus(Expr_42,A_ref_63,O_ref_1014,Classe,Metodo),

array_elem_inst(Expr_47,Rdiag,[K],Classe,Metodo),
constant_ref(C_ref_66,1),
negazione(O_ref_1015,C_ref_66,Classe,Metodo),
scalar_var_ref(V_ref_67,NRM),
times(Expr_47,O_ref_1015,V_ref_67,Classe,Metodo),

% info sulle data e control dep
true_data_dependence(Expr_l_4,Expr_8),
true_data_dependence(Expr_8,Expr_9),
true_data_dependence(Expr_l_4,Expr_11),
true_data_dependence(Expr_11,Expr_12),
true_data_dependence(Expr_14,Expr_18),
true_data_dependence(Expr_9,Expr_18),
true_data_dependence(Expr_12,Expr_18),
true_data_dependence(Expr_18,Expr_21),
true_data_dependence(Expr_21,Expr_26),
true_data_dependence(Expr_26,Expr_29),
true_data_dependence(Expr_l_33,Expr_36),
true_data_dependence(Expr_l_33,Expr_39),
true_data_dependence(Expr_39,Expr_42),
true_data_dependence(Expr_21,Expr_47),

control_dependence(ID_for48,Expr_l_4,Classe,Metodo),
control_dependence(ID_for48,Expr_l_5,Classe,Metodo),
control_dependence(ID_for48,ID_for19,Classe,Metodo),
control_dependence(ID_for48,If_22,Classe,Metodo),
control_dependence(ID_for48,ID_for27,Classe,Metodo),
control_dependence(ID_for48,Expr_29,Classe,Metodo),
control_dependence(ID_for48,ID_for45,Classe,Metodo),
control_dependence(ID_for48,Expr_47,Classe,Metodo),
control_dependence(ID_for19,If_16,Classe,Metodo),
control_dependence(ID_for19,Expr_18,Classe,Metodo),
control_dependence(If_Expr_116,Expr_8,Classe,Metodo),
control_dependence(If_Expr_116,Expr_9,Classe,Metodo),
control_dependence(If_Expr_115,Expr_11,Classe,Metodo),
control_dependence(If_Expr_115,Expr_12,Classe,Metodo),
control_dependence(Else_14,Expr_14,Classe,Metodo),        
control_dependence(If_Expr_122,Expr_21,Classe,Metodo),
control_dependence(ID_for27,Expr_26,Classe,Metodo),
control_dependence(ID_for45,Expr_l_33,Classe,Metodo),
control_dependence(ID_for45,ID_for37,Classe,Metodo),
control_dependence(ID_for37,Expr_36,Classe,Metodo),
control_dependence(ID_for45,Expr_39,Classe,Metodo),
control_dependence(ID_for45,ID_for43,Classe,Metodo),
control_dependence(ID_for43,Expr_42,Classe,Metodo).


	
%#############################################################################################################
% NOME: calcolo_r(QR,R,Rdiag)  
% SERVE A: riconosce la decomposizione QR della matrice A
%#############################################################################################################
calcolo_r(QR,R,Rdiag)  :-

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
	if_r(ID_If,If_Expr,Classe,Metodo),
	control_dependence(ID_for2,ID_If,Classe,Metodo),
%condizione dell'if
	less(If_Expr,Less_ref3,Less_ref4,Classe,Metodo),
		scalar_var_ref(Less_ref3,I),
		scalar_var_ref(Less_ref4,J),
%espressione nel then 	
	control_dependence(If_Expr,Espressione_in_if,Classe,Metodo),	
	array_elem_inst(Espressione_in_if,R,[I,J],Classe,Metodo),
		uguaglianza(Espressione_in_if,Uguaglianza_ref1,Classe,Metodo),
		array_elem_ref(Uguaglianza_ref1,QR,[I,J]),	
%elseif...
	else_if_r(ID_If,_,Else__If_Expr),
%condizione else if	
	equal(Else__If_Expr,Equal_ref1,Equal_ref2,Classe,Metodo),
		scalar_var_ref(Equal_ref1,I),
		scalar_var_ref(Equal_ref2,J),
%espressione else if
	control_dependence(Else__If_Expr,Espressione_in_Else_if,Classe,Metodo),
	array_elem_inst(Espressione_in_Else_if,R,[I,J],Classe,Metodo),
		uguaglianza(Espressione_in_Else_if,Uguaglianza_ref2,Classe,Metodo),
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
calcolo_q(QR,Q)  :-

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
	
	% espressione nel secondo ciclo for											%q[i][K] = 0;
	control_dependence(ID_for2,Expr_in_ciclo_for2,Classe,Metodo),				%
	array_elem_inst(Expr_in_ciclo_for2,Q,[I,K],Classe,Metodo),					%
	uguaglianza(Expr_in_ciclo_for2,Uguaglianza_ref2,Classe,Metodo),				%
	constant_ref(Uguaglianza_ref2,0),											%
	
	% espressione nel primo ciclo for, dopo il secondo ciclo for			 	%q[K][K] = 1;
	array_elem_inst(Expr_in_for1,Q,[K,K],Classe,Metodo),				 		%
	uguaglianza(Expr_in_for1,Uguaglianza_ref3,Classe,Metodo), 					%
	constant_ref(Uguaglianza_ref3,1),                               			%
	control_dependence(ID_for1,Expr_in_for1,Classe,Metodo),      			%
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
	
	%condizione if che si trova nel terzo ciclo for 		 		%if (QR[K][K] != 0)
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
	scalar_var_inst(Expr_in_for4,S,Classe,Metodo),				 	% s = s + QR[i][K]*q[i][j]
	plus(Expr_in_for4,Plus_ref1,Plus_ref2,Classe,Metodo),		 	%   
	scalar_var_ref(Plus_ref1,S),		                         	%   
	times(Plus_ref2,Times_ref1,Times_ref2,Classe,Metodo),		 	%   
	array_elem_ref(Times_ref1,QR,[I,K]),		                 	%   
	array_elem_ref(Times_ref2,Q,[I,J]),		                     	%   
	control_dependence(ID_for4,Expr_in_for4,Classe,Metodo),		 	%   
	true_data_dependence(Expr_in_if,Expr_in_for4),		         	%   
		
	%espressione dopo il ciclo for 4
	scalar_var_inst(Expr_dopo_for4,S,Classe,Metodo),				%s = s/QR[K][K];
	divide(Expr_dopo_for4,Divide_ref1,Divide_ref2,Classe,Metodo),   %
	scalar_var_ref(Divide_ref1,S),                                  %
	array_elem_ref(Divide_ref2,QR,[K,K]),                           %
	true_data_dependence(Expr_in_for4,Expr_dopo_for4),		       	%  in for è Expr_81 dopo è 84
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
	
	% espressione nel quinto ciclo for						 		%q[i][j] = q[i][j] - s*QR[i][K];
	array_elem_inst(Expr_in_for5,Q,[I,J],Classe,Metodo),     		%
	minus(Expr_in_for5,Minus_ref1,Minus_ref2,Classe,Metodo), 		%
	array_elem_ref(Minus_ref1,Q,[I,J]),                      		%
	times(Minus_ref2,Times_ref3,Times_ref4,Classe,Metodo),   		%
	scalar_var_ref(Times_ref3,S),                            		%
	array_elem_ref(Times_ref4,QR,[I,K]),                     		%
	control_dependence(ID_for5,Expr_in_for5,Classe,Metodo),         %
	true_data_dependence(Expr_dopo_for4,Expr_in_for5).         		%
	
