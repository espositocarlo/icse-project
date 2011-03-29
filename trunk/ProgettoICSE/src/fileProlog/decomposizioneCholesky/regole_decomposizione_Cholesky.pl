% consult
:- consult('C:\Users\Carlo\Documents\NetBeansProjects\ProgettoICSE\src\fileProlog\regoleBase\regole_di_base.pl').
:- consult('C:\Users\Carlo\Documents\NetBeansProjects\ProgettoICSE\src\fileProlog\decomposizioneCholesky\KB\control_dependence_Cholesky.pl').
:- consult('C:\Users\Carlo\Documents\NetBeansProjects\ProgettoICSE\src\fileProlog\decomposizioneCholesky\KB\data_dependence_Cholesky.pl').
:- consult('C:\Users\Carlo\Documents\NetBeansProjects\ProgettoICSE\src\fileProlog\decomposizioneCholesky\KB\fattiPrologCholesky.pl').


%#############################################################################################################
% NOME: normalizzazione_matrice()
% SERVE A: rappresenta il fatto che esiste una normalizzazione
%#############################################################################################################
triangolarizzazione_inferiore_matrice(Matrice) :- 
	
	% CICLO CHE SCORRE LE RIGHE -----------------------------
	ciclo_for(
				ID_1,
				Variabile_1,
				uguaglianza(Init_CicloFor_Row,Uguaglianza_ref,Classe,Metodo),
				less(Exit_CicloFor_Row,Less_ref_1,Less_ref_2,Classe,Metodo),
				post_incr(Incr_CicloFor_Row,Post_incr_ref_1,Classe,Metodo),
				Classe,
				Metodo
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
				plus_commutativo(Init_CicloFor_Col,Plus_commutativo_ref_1,Plus_commutativo_ref_2,Classe,Metodo),
				less(Exit_CicloFor_Col,Less_ref_3,Less_ref_4,Classe,Metodo),
				post_incr(Incr_CicloFor_Col, Post_incr_ref_2,Classe,Metodo),
				Classe,
				Metodo
			),
	% la variabile che scorre le colonne deve essere posta uguale alla rigaCorrente + 1
	scalar_var_ref(Plus_commutativo_ref_1,Variabile_1),
	constant_ref(Plus_commutativo_ref_2,1),
	
	% la condizione di uscita del for che scorre del colonne deve rispettare la dimensione delle colonne della matrice
	scalar_var_ref(Less_ref_4, Dim),		
	% ------------------------------------------------------
	
	% verifico che il cicloForCol è innestato nel cicloForRow
	control_dependence(ID_1, ID_2,Classe,Metodo),
	
	% elementi della matrice posti a zero
	array_elem_inst(Array_Elem_Inst_1,Matrice,[Variabile_1, Variabile_2],Classe,Metodo),
	uguaglianza(Array_Elem_Inst_1,Uguaglianza_ref_2,Classe,Metodo),
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
				uguaglianza(Init_CicloFor_Row,Uguaglianza_ref_1,Classe,Metodo), % = 0
				less(Exit_CicloFor_Row,Less_ref_1,Less_ref_2,Classe,Metodo), % < n
				post_incr(Incr_CicloFor_Row,Post_incr_ref_1,Classe,Metodo), % ++
				Classe,
				Metodo
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
				uguaglianza(Init_CicloFor_Temp_1,Uguaglianza_ref_2,Classe,Metodo), % = 0
				less(Exit_CicloFor_Temp_1,Less_ref_3,Less_ref_4,Classe,Metodo), % < j
				post_incr(Incr_CicloFor_Temp_1,Post_incr_ref_2,Classe,Metodo), % ++
				Classe,
				Metodo
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
				uguaglianza(Init_CicloFor_Temp_2,Uguaglianza_ref_3,Classe,Metodo), % = 0
				less(Exit_CicloFor_Temp_2,Less_ref_5,Less_ref_6,Classe,Metodo), % < k
				post_incr(Incr_CicloFor_Temp_2,Post_incr_ref_3,Classe,Metodo), % ++
				Classe,
				Metodo
			),
	
	% la variabile che scorre le righe deve essere posta uguale 0
	constant_ref(Uguaglianza_ref_3,0),
	
	% la condizione di uscita del for che scorre del righe deve rispettare la dimensione delle righe della matrice			
	scalar_var_ref(Less_ref_6, Variabile_2),
	% ----------------------------------------------------

	
	% verifico gli innesti dei cicli for
	control_dependence(ID_2, ID_3,Classe,Metodo),
	control_dependence(ID_1, ID_2,Classe,Metodo),
	
	% tempLrowj = matriceU[j];
	scalar_var_inst(Id_Scalar_var_inst_1,Temp_1,Classe, Metodo),
	array_elem_ref(Id_Array_eleme_ref_1,MatriceU,[Variabile_1]),
	uguaglianza(Id_Scalar_var_inst_1,Id_Array_eleme_ref_1,Classe,Metodo),
	control_dependence(ID_1,Id_Scalar_var_inst_1,Classe,Metodo),
	
	% d = 0.0;
	scalar_var_inst(Id_Scalar_var_inst_2,Var_D,Classe,Metodo),
	constant_ref(Cref_1,0.0),
	uguaglianza(Id_Scalar_var_inst_2,Cref_1,Classe,Metodo),
	control_dependence(ID_1,Id_Scalar_var_inst_2,Classe,Metodo),
	
	% tempLrowk = matriceU[k];
    scalar_var_inst(Id_Scalar_var_inst_3,Temp_2,Classe,Metodo),
	array_elem_ref(Id_Array_eleme_ref_2,MatriceU,[Variabile_2]),
	uguaglianza(Id_Scalar_var_inst_3,Id_Array_eleme_ref_2,Classe,Metodo),
	control_dependence(ID_2,Id_Scalar_var_inst_3,Classe,Metodo),
	
	% s = 0.0;
	scalar_var_inst(Id_Scalar_var_inst_4,Var_S,Classe,Metodo),
	constant_ref(Cref_2,0.0),
	uguaglianza(Id_Scalar_var_inst_4,Cref_2,Classe,Metodo),
	control_dependence(ID_2,Id_Scalar_var_inst_4,Classe,Metodo),
 
	% s = s + tempLrowk[i]*tempLrowj[i]; 
	scalar_var_inst(Id_Scalar_var_inst_5,Var_S,Classe,Metodo),
	scalar_var_ref(Vref_1,Var_S),
	array_elem_ref(Aref_3,Temp_2,[Variabile_3]),
	array_elem_ref(Aref_4,Temp_1,[Variabile_3]),
	times_commutativo(Oref_1,Aref_3,Aref_4,Classe,Metodo),
	plus_commutativo(Id_Scalar_var_inst_5,Vref_1,Oref_1,Classe,Metodo),
	control_dependence(ID_3,Id_Scalar_var_inst_5,Classe,Metodo),
	true_data_dependence(Id_Scalar_var_inst_4, Id_Scalar_var_inst_5),
	true_data_dependence(Id_Scalar_var_inst_3, Id_Scalar_var_inst_5),
	true_data_dependence(Id_Scalar_var_inst_1, Id_Scalar_var_inst_5),
	
	%  s = (matriceA[j][k] - s)/matriceU[k][k];
	scalar_var_inst(Id_Scalar_var_inst_6,Var_S,Classe,Metodo),
	array_elem_ref(Aref_5,MatriceA,[Variabile_1,Variabile_2]),
	scalar_var_ref(Vref_2,Var_S),
	minus(Oref_2,Aref_5,Vref_2,Classe,Metodo),
	array_elem_ref(Aref_6,MatriceU,[Variabile_2,Variabile_2]),
	divide(Id_Scalar_var_inst_6,Oref_2,Aref_6,Classe,Metodo),
	control_dependence(ID_2,Id_Scalar_var_inst_6,Classe,Metodo),
	true_data_dependence(Id_Scalar_var_inst_5, Id_Scalar_var_inst_6),
	
	% tempLrowj[k] = s;
	array_elem_inst(Arr_elem_inst_1,Temp_1,[Variabile_2],Classe,Metodo),
	scalar_var_ref(Vref_3,Var_S),
	uguaglianza(Arr_elem_inst_1,Vref_3,Classe,Metodo),
	control_dependence(ID_2,Arr_elem_inst_1,Classe,Metodo),
	true_data_dependence(Id_Scalar_var_inst_6, Arr_elem_inst_1),
	
	%   d = d + s*s;
	scalar_var_inst(Id_Scalar_var_inst_7,Var_D,Classe,Metodo),
	scalar_var_ref(Vref_4,Var_D),
	scalar_var_ref(Vref_5,Var_S),
	scalar_var_ref(Vref_6,Var_S),
	times(Oref_3,Vref_5,Vref_6,Classe,Metodo),
	plus_commutativo(Id_Scalar_var_inst_7,Vref_4,Oref_3,Classe,Metodo),
	control_dependence(ID_2,Id_Scalar_var_inst_7,Classe,Metodo),
	true_data_dependence(Id_Scalar_var_inst_2, Id_Scalar_var_inst_7),
	true_data_dependence(Id_Scalar_var_inst_6, Id_Scalar_var_inst_7),
	
	%  d = matriceA[j][j] - d;
	scalar_var_inst(Id_Scalar_var_inst_8,Var_D,Classe,Metodo),
	array_elem_ref(Aref_7,MatriceA,[Variabile_1,Variabile_1]),
	scalar_var_ref(Vref_7,Var_D),
	minus(Id_Scalar_var_inst_8,Aref_7,Vref_7,Classe,Metodo),
	control_dependence(ID_1,Id_Scalar_var_inst_8,Classe,Metodo),
	true_data_dependence(Id_Scalar_var_inst_7, Id_Scalar_var_inst_8),
	
	%  matriceU[j][j] = Math.sqrt(d);
	array_elem_inst(Id_Scalar_var_inst_9,MatriceU,[Variabile_1,Variabile_1],Classe,Metodo),
	scalar_var_ref(Vref_8,Var_D),
	chiamata(Id_Scalar_var_inst_9,Var_Sqrt,[Vref_8]),
	control_dependence(ID_1,Id_Scalar_var_inst_9,Classe,Metodo),
	true_data_dependence(Id_Scalar_var_inst_8, Id_Scalar_var_inst_9).
	
%-------------------------------------------------------------------------------------------------------------

%#############################################################################################################
% NOME: decomposizione_di_Cholesky(Matrice)
% SERVE A: riconosce la decomposizione di Cholesky
%#############################################################################################################
decomposizone_di_Cholesky(MatriceA, MatriceU) :- 
	
	% controllo MatriceA
	array_var_def(MatriceA,double,2,_,[N,N],Classe,Metodo),
	% controllo MatriceU
	array_var_def(MatriceU,double,2,_,[N,N],Classe,Metodo),

	% controllo Temp_1
	array_var_def(Temp_1,double,1,_,[N],Classe,Metodo),
	
	%controllo Temp_2
	array_var_def(Temp_2,double,1,_,[N],Classe,Metodo),

	% controllo calcolo coefficienti di Cholesky
	calcolo_coefficienti_Cholesky(MatriceA, MatriceU, Temp_1, Temp_2),
	
	% controllo triangolarizzazione MatriceU
	triangolarizzazione_inferiore_matrice(MatriceU).
		
% -------------------------------------------------------------------------------------------------------------

	
	
	