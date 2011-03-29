% consult
:- consult('regole_di_base.pl').
:- consult('control_dependence_Cholesky.pl').
:- consult('fattiPrologCholesky.pl').


%#############################################################################################################
% NOME: normalizzazione_matrice()
% SERVE A: rappresenta il fatto che esiste una normalizzazione
%#############################################################################################################
triangolarizzazione_inferiore_matrice(Matrice) :- 
	
	% CICLO CHE SCORRE LE RIGHE -----------------------------
	ciclo_for(
				ID_1,
				Variabile_1,
				uguaglianza(Init_CicloFor_Row,Uguaglianza_ref,Metodo,Classe),
				less(Exit_CicloFor_Row,Less_ref_1,Less_ref_2,Metodo,Classe),
				post_incr(Incr_CicloFor_Row,Post_incr_ref_1,Metodo,Classe),
				Metodo,
				Classe
			),
	
	% la variabile che scorre le righe deve essere posta uguale 0
	constant_ref(Uguaglianza_ref,0),
	
	% la condizione di uscita del for che scorre del righe deve rispettare la dimensione delle righe della matrice			
	scalar_var_ref(Less_ref_2, Dim),
	% ----------------------------------------------------
	
	% CICLO CHE SCORRE COLONNE ---------------------------
	ciclo_for(
				ID_2,
				Variabile_2,
				plus_commutativo(Init_CicloFor_Col,Plus_commutativo_ref_1,Plus_commutativo_ref_2,Metodo,Classe),
				less(Exit_CicloFor_Col,Less_ref_3,Less_ref_4,Metodo,Classe),
				post_incr(Incr_CicloFor_Col, Post_incr_ref_2, Metodo,Classe),
				Metodo,
				Classe
			),
	% la variabile che scorre le colonne deve essere posta uguale alla rigaCorrente + 1
	scalar_var_ref(Plus_commutativo_ref_1,Variabile_1),
	constant_ref(Plus_commutativo_ref_2,1),
	
	% la condizione di uscita del for che scorre del colonne deve rispettare la dimensione delle colonne della matrice
	scalar_var_ref(Less_ref_4, Dim),		
	% ------------------------------------------------------
	
	% verifico che il cicloForCol è innestato nel cicloForRow
	control_dependence(ID_1, ID_2, Metodo,Classe),
	
	% elementi della matrice posti a zero
	array_elem_inst(Array_Elem_Inst_1,Matrice,[Variabile_1, Variabile_2],Metodo,Classe),
	uguaglianza(Array_Elem_Inst_1,Uguaglianza_ref_2,Metodo,Classe),
	constant_ref(Uguaglianza_ref_2,0.0).
	
	
				
%-------------------------------------------------------------------------------------------------------------

%#############################################################################################################
% NOME: calcolo_coefficienti_Cholesky(MatriceA, MatriceU)
% SERVE A: rappresenta il fatto vengono calcolati i coefficienti di Cholesky
%#############################################################################################################
calcolo_coefficienti_Cholesky(MatriceA, MatriceU, Temp_1, Temp_2) :- 	
	% CICLO CHE SCORRE LE RIGHE -----------------------------
	ciclo_for(
				ID_1, % ciclo for 1
				Variabile_1, % j
				uguaglianza(Init_CicloFor_Row,Uguaglianza_ref_1,Metodo,Classe), % = 0
				less(Exit_CicloFor_Row,Less_ref_1,Less_ref_2,Metodo,Classe), % < n
				post_incr(Incr_CicloFor_Row,Post_incr_ref_1,Metodo,Classe), % ++
				Metodo,
				Classe
			),
	
	% la variabile che scorre le righe deve essere posta uguale 0
	constant_ref(Uguaglianza_ref_1,0),
	
	% la condizione di uscita del for che scorre del righe deve rispettare la dimensione delle righe della matrice			
	scalar_var_ref(Less_ref_2, Dim),
	% ----------------------------------------------------
	
	% CICLO 2 CHE SCORRE I VETTORI TEMP----------------
	ciclo_for(
				ID_2, % ciclo for 2
				Variabile_2, % k
				uguaglianza(Init_CicloFor_Temp_1,Uguaglianza_ref_2,Metodo,Classe), % = 0
				less(Exit_CicloFor_Temp_1,Less_ref_3,Less_ref_4,Metodo,Classe), % < j
				post_incr(Incr_CicloFor_Temp_1,Post_incr_ref_2,Metodo,Classe), % ++
				Metodo,
				Classe
			),
	
	% la variabile che scorre le righe deve essere posta uguale 0
	constant_ref(Uguaglianza_ref_2,0),
	
	% la condizione di uscita del for che scorre del righe deve rispettare la dimensione delle righe della matrice			
	scalar_var_ref(Less_ref_4, Variabile_1),
	% ----------------------------------------------------

	% CICLO 3 CHE SCORRE I VETTORI TEMP
	ciclo_for(
				ID_3, % ciclo for 2
				Variabile_3, % i
				uguaglianza(Init_CicloFor_Temp_2,Uguaglianza_ref_3,Metodo,Classe), % = 0
				less(Exit_CicloFor_Temp_2,Less_ref_5,Less_ref_6,Metodo,Classe), % < k
				post_incr(Incr_CicloFor_Temp_2,Post_incr_ref_3,Metodo,Classe), % ++
				Metodo,
				Classe
			),
	
	% la variabile che scorre le righe deve essere posta uguale 0
	constant_ref(Uguaglianza_ref_3,0),
	
	% la condizione di uscita del for che scorre del righe deve rispettare la dimensione delle righe della matrice			
	scalar_var_ref(Less_ref_6, Variabile_2),
	% ----------------------------------------------------

	
	% verifico gli innesti dei cicli for
	control_dependence(ID_2, ID_3, Metodo,Classe),
	control_dependence(ID_1, ID_2, Metodo,Classe),
	
	% tempLrowj = matriceU[j];
	scalar_var_inst(Id_Scalar_var_inst_1,Temp_1, Metodo, Classe),
	array_elem_ref(Id_Array_eleme_ref_1,MatriceU,[Variabile_1]),
	uguaglianza(Id_Scalar_var_inst_1,Id_Array_eleme_ref_1,Metodo,Classe),
	
	% d = 0.0;
	scalar_var_inst(Id_Scalar_var_inst_2,Var_D,Metodo,Classe),
	constant_ref(Cref_1,0.0),
	uguaglianza(Id_Scalar_var_inst_2,Cref_1,Metodo,Classe),
	
	% tempLrowk = matriceU[k];
    scalar_var_inst(Id_Scalar_var_inst_3,Temp_2,Metodo,Classe),
	array_elem_ref(Id_Array_eleme_ref_2,MatriceU,[Variabile_2]),
	uguaglianza(Id_Scalar_var_inst_3,Id_Array_eleme_ref_2,Metodo,Classe),
	
	% s = 0.0;
	scalar_var_inst(Id_Scalar_var_inst_4,Var_S,Metodo,Classe),
	constant_ref(Cref_2,0.0),
	uguaglianza(Id_Scalar_var_inst_4,Cref_2,Metodo,Classe),
 
	% s = s + tempLrowk[i]*tempLrowj[i]; 
	scalar_var_inst(Id_Scalar_var_inst_5,Var_S,Metodo,Classe),
	scalar_var_ref(Vref_1,Var_S),
	array_elem_ref(Aref_3,Temp_2,[Variabile_3]),
	array_elem_ref(Aref_4,Temp_1,[Variabile_3]),
	times(Oref_1,Aref_3,Aref_4,Metodo,Classe),
	plus(Id_Scalar_var_inst_5,Vref_1,Oref_1,Metodo,Classe),
	scalar_var_inst(Id_Scalar_var_inst_6,Var_S,Metodo,Classe),
	
	%  s = (matriceA[j][k] - s)/matriceU[k][k];
	array_elem_ref(Aref_5,MatriceA,[Variabile_1,Variabile_2]),
	scalar_var_ref(Vref_2,Var_S),
	minus(Oref_2,Aref_5,Vref_2,Metodo,Classe),
	array_elem_ref(Aref_6,MatriceU,[Variabile_2,Variabile_2]),
	divide(Id_Scalar_var_inst_6,Oref_2,Aref_6,Metodo,Classe),
	
	% tempLrowj[k] = s;
	array_elem_inst(Arr_elem_inst_1,Temp_1,[Variabile_2],Metodo,Classe),
	scalar_var_ref(Vref_3,Var_S),
	uguaglianza(Arr_elem_inst_1,Vref_3,Metodo,Classe),
	
	%   d = d + s*s;
	scalar_var_inst(Id_Scalar_var_inst_7,Var_D,Metodo,Classe),
	scalar_var_ref(Vref_4,Var_D),
	scalar_var_ref(Vref_5,Var_S),
	scalar_var_ref(Vref_6,Var_S),
	times(Oref_3,Vref_5,Vref_6,Metodo,Classe),
	plus(Id_Scalar_var_inst_7,Vref_4,Oref_3,Metodo,Classe),
	
	%  d = matriceA[j][j] - d;
	scalar_var_inst(Id_Scalar_var_inst_8,Var_D,Metodo,Classe),
	array_elem_ref(Aref_7,MatriceA,[Variabile_1,Variabile_1]),
	scalar_var_ref(Vref_7,Var_D),
	minus(Id_Scalar_var_inst_8,Aref_7,Vref_7,Metodo,Classe),
	
	%  matriceU[j][j] = Math.sqrt(d);
	array_elem_inst(Id_Scalar_var_inst_9,MatriceU,[Variabile_1,Variabile_1],Metodo,Classe),
	scalar_var_ref(Vref_8,Var_D),
	chiamata(Id_Scalar_var_inst_9,Var_Sqrt,[Vref_8]).
	
%-------------------------------------------------------------------------------------------------------------

%#############################################################################################################
% NOME: decomposizione_di_Cholesky(Matrice)
% SERVE A: riconosce la decomposizione di Cholesky
%#############################################################################################################
decomposizone_di_Cholesky(MatriceA, MatriceU) :- 
	
	% controllo MatriceA
	array_var_def(MatriceA,double,2,_,[N,N],Metodo,Classe),
	% controllo MatriceU
	array_var_def(MatriceU,double,2,_,[N,N],Metodo,Classe),

	% controllo Temp_1
	array_var_def(Temp_1,double,1,_,[N],Metodo,Classe),
	
	%controllo Temp_2
	array_var_def(Temp_2,double,1,_,[N],Metodo,Classe),

	% controllo calcolo coefficienti di Cholesky
	calcolo_coefficienti_Cholesky(MatriceA, MatriceU, Temp_1, Temp_2),
	
	% controllo triangolarizzazione MatriceU
	triangolarizzazione_inferiore_matrice(MatriceU).
		
% -------------------------------------------------------------------------------------------------------------

	
	
	