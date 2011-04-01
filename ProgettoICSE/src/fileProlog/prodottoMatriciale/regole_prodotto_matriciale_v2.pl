% consult
:-consult('C:/Users/Carlo/Documents/NetBeansProjects/ProgettoICSE/src/fileProlog/regoleBase/regole_di_base.pl').
:-consult('C:/Users/Carlo/Documents/NetBeansProjects/ProgettoICSE/src/fileProlog/prodottoMatriciale/KB/versione_2/control_dependence_Prodotto_matriciale _v2.pl').
:-consult('C:/Users/Carlo/Documents/NetBeansProjects/ProgettoICSE/src/fileProlog/prodottoMatriciale/KB/versione_2/data_dependence_Prodotto_matriciale_v2.pl').
:-consult('C:/Users/Carlo/Documents/NetBeansProjects/ProgettoICSE/src/fileProlog/prodottoMatriciale/KB/versione_2/db_Syntax_prodotto_matriciale_v2.pl').
%
:-consult('C:/Users/Carlo/Documents/NetBeansProjects/ProgettoICSE/src/fileProlog/prodottoMatriciale/KB/versione_1/control_dependence_Prodotto_matriciale_v1.pl').
:-consult('C:/Users/Carlo/Documents/NetBeansProjects/ProgettoICSE/src/fileProlog/prodottoMatriciale/KB/versione_1/data_dependence_Prodotto_matriciale_v1.pl').
:-consult('C:/Users/Carlo/Documents/NetBeansProjects/ProgettoICSE/src/fileProlog/prodottoMatriciale/KB/versione_1/db_Syntax_prodotto_matriciale_v1.pl').


%#############################################################################################################
% NOME: prodotto_matriciale(Matrice1,Matrice2,Matrice3)
% DIPENDE DA: 
% UTILIZZATO IN: 
% SERVE A: vero se valide tutte le ipotesi
%#############################################################################################################
prodotto_matriciale(Matrice1,Matrice2,Matrice3):-
    
	% controllo Matrice1
	array_var_def(Matrice1,Tipo,2,_,[DimRow_1,DimCol_1],Classe,Metodo),
	% controllo Matrice2
	array_var_def(Matrice2,Tipo,2,_,[DimCol_1,DimCol_2],Classe,Metodo),
	% controllo Matrice3 = risultato
	array_var_def(Matrice3,Tipo,2,_,[DimRow_1,DimCol_2],Classe,Metodo),

	
	% CICLO CHE SCORRE LE RIGHE DI Matrice_1 -----------------------------
	ciclo_for(
				ID_1,
				Variabile_1,
				uguaglianza(Init_CicloFor_1,Uguaglianza_ref_1,Classe,Metodo),
				less(Exit_CicloFor_1,Less_ref_1,Less_ref_2,Classe,Metodo),
				post_incr(Incr_CicloFor_1,Post_incr_ref_1,Classe,Metodo),
				Classe,
				Metodo
			),
	
	% la variabile che scorre le righe di Matrice_1 deve essere posta uguale 0
	constant_ref(Uguaglianza_ref_1,0),
	
	% la condizione di uscita del for che scorre le righe di Matrice_1 deve rispettare la dimensione delle righe della stessa
	constant_ref(Less_ref_2, DimRow_1),
	% ----------------------------------------------------
			
	% CICLO CHE SCORRE LE Colonne DI Matrice_2 -----------------------------
	ciclo_for(
				ID_2,
				Variabile_2,
				uguaglianza(Init_CicloFor_2,Uguaglianza_ref_2,Classe,Metodo),
				less(Exit_CicloFor_2,Less_ref_3,Less_ref_4,Classe,Metodo),
				post_incr(Incr_CicloFor_2,Post_incr_ref_2,Classe,Metodo),
				Classe,
				Metodo
			),
	
	% la variabile che scorre le colonne di Matrice_2 deve essere posta uguale 0
	constant_ref(Uguaglianza_ref_2,0),
	
	% la condizione di uscita del for che scorre le colonne di Matrice_2 deve rispettare la dimensione delle colonne della stessa
	constant_ref(Less_ref_4, DimCol_2),
	% ----------------------------------------------------
	
	% CICLO CHE SCORRE LE righe DI Matrice_2 -----------------------------
	ciclo_for(
				ID_3,
				Variabile_3,
				uguaglianza(Init_CicloFor_3,Uguaglianza_ref_3,Classe,Metodo),
				less(Exit_CicloFor_3,Less_ref_5,Less_ref_6,Classe,Metodo),
				post_incr(Incr_CicloFor_3,Post_incr_ref_3,Classe,Metodo),
				Classe,
				Metodo
			),
	
	% la variabile che scorre le colonne di Matrice_2 deve essere posta uguale 0
	constant_ref(Uguaglianza_ref_3,0),
	
	% la condizione di uscita del for che scorre le colonne di Matrice_2 deve rispettare la dimensione delle colonne della Matrice_1
	constant_ref(Less_ref_6, DimCol_1),
	% ----------------------------------------------------
	
	% Verifico la control_dependence dei cilci for
	control_dependence(ID_1, ID_2, prodottomatriciale_versione_1,main),
	control_dependence(ID_2, ID_3, prodottomatriciale_versione_1,main),
	
	calcolo_prodotto(Matrice1, Matrice2, Matrice3, ID_1, ID_2, ID_3, Variabile_1, Variabile_2, Variabile_3, Classe, Metodo).

% -------------------------------------------------------------------------------------------------------------
%#############################################################################################################
% NOME: calcolo_prodotto()
% DIPENDE DA: 
% UTILIZZATO IN: 
% SERVE A: vero se valide tutte le ipotesi
%#############################################################################################################
calcolo_prodotto(Matrice1, Matrice2, Matrice3, ID_1, ID_2, ID_3, Variabile_1, Variabile_2, Variabile_3, Classe, Metodo):-
% appA=a[i][z];
	scalar_var_inst(Expr_1,AppA,Classe, Metodo),
	array_elem_ref(Aref_1,Matrice1,[Variabile_1,Variabile_3]),
	uguaglianza(Expr_1,Aref_1,Classe,Metodo),
	control_dependence(ID_3, Expr_1, Classe,Metodo),
	
	% appB=b[z][j];
	scalar_var_inst(Expr_2,AppB,Classe,Metodo),
	array_elem_ref(Aref_2,Matrice2,[Variabile_3,Variabile_2]),
	uguaglianza(Expr_2,Aref_2,Classe,Metodo),
	control_dependence(ID_3, Expr_2, Classe,Metodo),
	
	% appMul=appA*appB;
	scalar_var_inst(Expr_3,AppMul,Classe,Metodo),
	scalar_var_ref(Vref_1,AppA),
	scalar_var_ref(Vref_2,AppB),
	times_commutativo(Expr_3,Vref_1,Vref_2,Classe,Metodo),
	control_dependence(ID_3, Expr_3, Classe,Metodo),
	true_data_dependence(Expr_1, Expr_3),
	true_data_dependence(Expr_2, Expr_3),
	
	% appC=c[i][j];
	scalar_var_inst(Expr_4,AppC,Classe,Metodo),
	array_elem_ref(Aref_3,Matrice3,[Variabile_1,Variabile_2]),
	uguaglianza(Expr_4,Aref_3,Classe,Metodo),
	control_dependence(ID_3, Expr_4, Classe,Metodo),
	
	% c[i][j]=appC+appMul;
	array_elem_inst(Expr_5,Matrice3,[Variabile_1,Variabile_2],Classe,Metodo),
	scalar_var_ref(Vref_3,AppC),
	scalar_var_ref(Vref_4,AppMul),
	plus_commutativo(Expr_5,Vref_3,Vref_4,Classe,Metodo),
	control_dependence(ID_3, Expr_5, Classe,Metodo),
	true_data_dependence(Expr_3, Expr_5),
	true_data_dependence(Expr_4, Expr_5).
% ---------
calcolo_prodotto(Matrice1, Matrice2, Matrice3, ID_1, ID_2, ID_3, Variabile_1, Variabile_2, Variabile_3, Classe, Metodo):-
	% R[i][j] = 0;
	array_elem_inst(Expr_6,Matrice3,[Variabile_1,Variabile_2],Classe,Metodo),
	constant_ref(Cref_1,0),
	uguaglianza(Expr_6,Cref_1,Classe,Metodo),
	control_dependence(ID_2, Expr_6, Classe,Metodo),
	
	% R[i][j] = R[i][j] + A[i][k] * B[k][j];
	array_elem_inst(Expr_7,Matrice3,[Variabile_1,Variabile_2],Classe,Metodo),
	array_elem_ref(Aref_4,Matrice3,[Variabile_1,Variabile_2]),
	array_elem_ref(Aref_5,Matrice1,[Variabile_1,Variabile_3]),
	array_elem_ref(Aref_6,Matrice2,[Variabile_3,Variabile_2]),
	times_commutativo(OpRef_1001,Aref_5,Aref_6,Classe,Metodo),
	plus_commutativo(Expr_7,Aref_4,OpRef_1001,Classe,Metodo),
	control_dependence(ID_3, Expr_7, Classe,Metodo),
	true_data_dependence(Expr_6, Expr_7).

	
	
	