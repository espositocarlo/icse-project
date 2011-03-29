% consult
:- consult('regole_di_base.pl').
:- consult('control_dependence_Cholesky.pl').
:- consult('fattiPrologCholesky.pl').


%#############################################################################################################
% NOME: normalizzazione_matrice()
% SERVE A: rappresenta il fatto che esiste una normalizzazione
%#############################################################################################################
%triangolarizzazione_inferiore_matrice(ID_Matrice, Matrice, ID_CicloForRow, ID_CicloForCol) :- 
triangolarizzazione_inferiore_matrice(ID_1,ID_2,Matrice) :- 
				
				
				% esiste la matrice
			%	array_var_def(Matrice,double,2,ID_Matrice,[DimRighe,DimColonne],Metodo,Classe),
				
				% % esite un cicloFor per le righe e uno per le colonne
	ciclo_for(
				ID_1,
				Variabile_1,
				uguaglianza(Init_CicloFor,Uguaglianza_ref,Metodo,Classe),
				less(Exit_CicloFor,Less_ref_1,Less_ref_2,Metodo,Classe),
				post_incr(Incr_CicloFor,Post_incr_ref,Metodo,Classe),
				Metodo,
				Classe
			),
	ciclo_for(
				ID_2,
				Variabile_2,
				plus_commutativo(InitForCol,VarRef_1,ConstRef_1,Metodo,Classe),
				less(ExitForCol,VarRef_2,VarRef_3,Metodo,Classe),
				post_incr(IncrForCol, VarRef_4, Metodo,Classe),
				Metodo,
				Classe
			),
				% verifico che il cicloForCol è innestato nel cicloForRow
				true_dependence(ID_1, ID_2).
				% 
				% % CICLO CHE SCORRE COLONNE
				% % la variabile che scorre le colonne deve essere posta uguale alla rigaCorrente + 1
				% scalar_var_inst(InitForCol,Nome_InitForCol,Metodo,Classe),
				% plus(InitForCol,VarRef_1,ConstRef_1,Metodo,Classe),		
				% scalar_var_ref(VarRef_1,Nome_InitForRow),
				% constant_ref(ConstRef_1,1),
				% % la condizione di uscita del for che scorre del colonne deve rispettare la dimensione delle colonne della matrice
				% less(ExitForCol,VarRef_2,VarRef_3,Metodo,Classe),
				% scalar_var_ref(VarRef_2, Nome_InitForCol),
				% scalar_var_ref(VarRef_3, DimColonne),
				% % verifico la condizione di post_incremento della variabile che scorre le colonne
				% post_incr(IncrForCol,VarRef_4,Metodo,Classe),
				% scalar_var_ref(VarRef_4, Nome_InitForCol),
				% 
				% % CICLO CHE SCORRE LE RIGHE
				% % la variabile che scorre le righe deve essere posta uguale 0
				% scalar_var_inst(InitForRow,Nome_InitForRow,Metodo,Classe),		
				% uguaglianza(InitForRow,ConstRef_2),
				% constant_ref(ConstRef_2,0),
				% % la condizione di uscita del for che scorre del righe deve rispettare la dimensione delle righe della matrice
				% less(ExitForRow,VarRef_5,VarRef_6,Metodo,Classe),
				% scalar_var_ref(VarRef_5, Nome_InitForRow),
				% scalar_var_ref(VarRef_6, DimRighe),
				% % verifico la condizione di post_incremento della variabile che scorre le righe
				% post_incr(IncrForRow,VarRef_7,Metodo,Classe),
				% scalar_var_ref(VarRef_7, Nome_InitForRow),
				% 
				% % elementi della matrice posti a zero
				% array_elem_inst(ID_Array_Elem_Inst_1,Matrice,[Nome_InitForRow, Nome_InitForCol],Metodo,Classe),
				% uguaglianza(ID_Array_Elem_Inst_1,ID_ConstRef_1),
				% constant_ref(ID_ConstRef_1,0.0).
				
%-------------------------------------------------------------------------------------------------------------

%#############################################################################################################
% NOME: calcolo_coefficienti_Cholesky(MatriceA, MatriceU)
% SERVE A: rappresenta il fatto vengono calcolati i coefficienti di Cholesky
%#############################################################################################################
calcolo_coefficienti_Cholesky(MATRIX_A, MATRIX_U, TEMP_VECT_1, TEMP_VECT_2, VAR_J, VAR_K, VAR_I, VAR_M, VAR_D, VAR_S, DIM) :- 
	dichiarazioni_Cholesky(MAT_A, MAT_U, TEMP_1, TEMP_2, DIM, VAR_J, VAR_K, VAR_I, VAR_M, VAR_D, VAR_S),
	% esiste un cicloFor1 con ID_CicloForRow che scorre le righe
	espressioni_ciclo_for_compatibili(ID_CicloForRow,VAR_J,0,_,_,DIM),
	espressioni_ciclo_for_compatibili(ID_CicloForCol,VAR_K,0,_,_,DIM).
	
	
	
	% esite un cicloFor2 con ID_CicloForCol che scorre le colonne
	
	% 
	% 
	% % esite un cicloFor3 con ID_CicloForTemp che scorre i vettori
	% for_r(ID_CicloForTemp,_,InitForTemp,ExitForTemp,IncrForTemp,Metodo,Classe),
	% scalar_var_def(Nome_InitForTemp,InitForTemp,Metodo,Classe),
	% 
	% % verifico che il cicloForCol è innestato nel cicloForRow
	% true_dependence(ID_CicloForCol, ID_CicloForRow),
	% 
	% % verifico che il cicloForTemp è innestato nel cicloForCol
	% true_dependence(ID_CicloForTemp, ID_CicloForCol),
	% 
	% 
	% 
	% 
	% % verifico che sia correttamente instanziato il vettore Temp1 uguale alla riga corrente della matriceU
	% scalar_var_inst(ID_Temp1,Temp1,Metodo,Classe),
	% uguaglianza(ID_Temp1,Ref_ID_MatriceU),
	% array_elem_ref(Ref_ID_MatriceU,MatriceU,[Var_ref_8]),
	% scalar_var_ref(Var_ref_8,Nome_InitForRow),
	% % verifico che ci sia la variabile di appoggio per il calcolo dei coefficienti della diagonale: double d = 0.0;
	% scalar_var_def(Nome_appD, Var_def_2, Metodo, Classe),
	% scalar_var_inst(Var_def_2,Nome_appD,Metodo, Classe),
	% uguaglianza(Var_def_2,Const_ref_3),
	% constant_ref(Const_ref_3, 0.0),
	% 
	% % CICLO CHE SCORRE LE COLONNE
	% % la variabile che scorre le colonne deve essere posta uguale 0
	% scalar_var_inst(InitForCol,Nome_InitForCol,Metodo,Classe),		
	% uguaglianza(InitForCol,ConstRef_3),
	% constant_ref(ConstRef_3,0),
	% % la condizione di uscita del for che scorre le colonne
	% less(ExitForCol,VarRef_9,VarRef_10,Metodo,Classe),
	% scalar_var_ref(VarRef_9, Nome_InitForCol),
	% scalar_var_ref(VarRef_10, Nome_InitForRow),
	% % verifico la condizione di post_incremento della variabile che scorre le colonne
	% post_incr(IncrForCol,VarRef_11,Metodo,Classe),
	% scalar_var_ref(VarRef_11, Nome_InitForCol),
	% 
	% % tempLrowk = matriceU[k];
    % scalar_var_inst(ID_Temp2,Temp2,Metodo,Classe),
    % uguaglianza(ID_Temp2,Arr_ref_2),
    % array_elem_ref(Arr_ref_2,MatriceU,[Var_ref_7]),
    % scalar_var_ref(Var_ref_7,Nome_InitForCol),
    % 
	% % double s = 0.0;
	% scalar_var_def(Nome_appS,Var_def_3,Metodo,Classe),
	% scalar_var_inst(Var_inst_3,Nome_appS,Metodo,Classe),
	% uguaglianza(Var_def_3,Const_ref_5),
	% constant_ref(Const_ref_5, 0.0),
	% 
	% % CICLO CHE SCORRE I VETTORI TEMP
	% % la variabile che scorre il vettore deve essere posta uguale 0
	% scalar_var_inst(InitForTemp,Nome_InitForTemp,Metodo,Classe),		
	% uguaglianza(InitForTemp,ConstRef_6),
	% constant_ref(ConstRef_6,0),
	% % la condizione di uscita del for che scorre i vettori
	% less(ExitForTemp,VarRef_12,VarRef_13,Metodo,Classe),
	% scalar_var_ref(VarRef_12, Nome_InitForTemp),
	% scalar_var_ref(VarRef_13, Nome_InitForCol),
	% % verifico la condizione di post_incremento della variabile che scorre i vettori
	% post_incr(IncrForTemp,VarRef_14,Metodo,Classe),
	% scalar_var_ref(VarRef_14, Nome_InitForTemp),
	% 
	% % s = s + tempLrowk[i]*tempLrowj[i];        DA_RIVEDERE   
	% scalar_var_inst(Var_inst_4,Nome_appS,Metodo, Classe),
	% plus(Var_inst_4,Var_ref_15,Times_exp_1,Metodo, Classe),		
	% scalar_var_ref(Var_ref_15,Nome_appS),
	% times(Times_exp_1,Arr_elem_ref_1,Arr_elem_ref_2,Metodo,Classe),		
	% array_elem_ref(Arr_elem_ref_2,Temp2,[Nome_InitForTemp]),
	% array_elem_ref(Arr_elem_ref_1,Temp1,[Nome_InitForTemp]),
	% 
	% 
	% 
	% % DA_RIVEDERE s = (matriceA[j][k] - s)/matriceU[k][k];
	% scalar_var_inst(VarInst5, Nome_appS, Metodo, Classe),
    % divide(VarInst5, Minus_exp_1, Arr_elem_ref_3, Metodo, Classe),
	% minus(Minus_exp_1, Arr_elem_ref_4, Var_ref_18, Metodo, Classe),
	% scalar_var_ref(Var_ref_18,Nome_appS),
	% array_elem_ref(Arr_elem_ref_4,MatriceA,[Nome_InitForRow,Nome_InitForCol]),
	% array_elem_ref(Arr_elem_ref_3,MatriceU,[Nome_InitForCol,Nome_InitForCol]),
	% 
	% % DA_RIVEDERE tempLrowj[k] = s;
	% array_elem_inst(Arr_inst_1,Temp2 ,[Nome_InitForCol],Metodo,Classe),
	% uguaglianza(Arr_inst_1,Var_ref_19),
	% scalar_var_ref(Var_ref_19, Nome_appS),
	% 
	% % DA_RIVEDERE d = d + s*s;
	% scalar_var_inst(Var_inst_6, Nome_appD, Metodo, Classe),
	% plus(Var_inst_6,Var_ref_20,Times_exp_2, Metodo, Classe),		
	% scalar_var_ref(Var_ref_20, Nome_appD),
	% times(Times_exp_2,Var_ref_21,Var_ref_22,Metodo, Classe),			
	% scalar_var_ref(Var_ref_21, Nome_appS),
	% scalar_var_ref(Var_ref_22, Nome_appS),
	% 
	% % d = matriceA[j][j] - d;
	% scalar_var_inst(Var_inst_7,Nome_appD,Metodo, Classe),
	% minus(Var_inst_7, Arr_elem_ref_5, Var_ref_23,Metodo, Classe),
	% array_elem_ref(Arr_elem_ref_5, MatriceA,[Nome_InitForRow, Nome_InitForRow]),
	% scalar_var_ref(Var_ref_23,Nome_appD),
	% 
	% % matriceU[j][j] = Math.sqrt(d);
	% array_elem_inst(Arr_inst_2,MatriceU,[Nome_InitForRow,Nome_InitForRow],Metodo, Classe),
	% uguaglianza(Arr_inst_2, Fun_1),
	% funzione(Fun_1, Sqrt, Var_ref_26),
	% scalar_var_ref(Var_ref_26, Nome_appD).
	

%-------------------------------------------------------------------------------------------------------------
%#############################################################################################################
% NOME: dichiarazioni_Cholesky()
% SERVE A: verifica le dichiarazioni degli elementi necessari per la decomposizione di Cholesky
%#############################################################################################################
dichiarazioni_Cholesky(MAT_A, MAT_U, TEMP_1, TEMP_2, DIM, J, K, I, M, D, S) :-
    % dimensione matrice
	scalar_var_def(N,Def_list_1,Metodo,Classe),
	scalar_var_inst(Def_list_1,N,Metodo,Classe),
	uguaglianza(Def_list_1,Cref_1,Metodo,Classe),
	constant_ref(Cref_1,DIM),

	% dichiarazione matriceA
	array_var_def(MAT_A,double,2,ID_MAT_A,[N,N],Metodo,Classe),
	
	% dichiarazione matriceU
	array_var_def(MAT_U,double,2,ID_MAT_U,[N,N],Metodo,Classe),
	
	% dichiarazioe vettori temp
    array_var_def(TEMP_1,double,1,ID_TEMP_1,[N],Metodo,Classe),
	array_var_def(TEMP_2,double,1,ID_TEMP_2,[N],Metodo,Classe),
	
    % indici dei for
	scalar_var_def(J,ID_J,Metodo,Classe),
    scalar_var_def(K,ID_K,Metodo,Classe),
	scalar_var_def(I,ID_I,Metodo,Classe),
	scalar_var_def(M,ID_M,Metodo,Classe),
    
    % variabili temp
	scalar_var_def(D,ID_D,Metodo,Classe),
    scalar_var_def(S,ID_S,Metodo,Classe).
  

% -------------------------------------------------------------------------------------------------------------


%#############################################################################################################
% NOME: decomposizione_di_Cholesky(Matrice)
% SERVE A: riconosce la decomposizione di Cholesky
%#############################################################################################################
decomposizone_di_Cholesky(MAT_A, MAT_U) :- 
		dichiarazioni_Cholesky(MAT_A, MAT_U, TEMP_1, TEMP_2, J, K, I, M, D, S),
		% calcolo_coefficienti_Cholesky(MatriceA, MatriceU),
		triangolarizzazione_inferiore_matrice(MAT_U).
		
% -------------------------------------------------------------------------------------------------------------

	
	
	