% consult
:- consult('regole_di_base.pl').
:- consult('control_dependence_Prodotto_matriciale.pl').
:- consult('fattiPrologProdottoMatriciale.pl').


%#############################################################################################################
% NOME: matrici_compatibili(Matrice1,Matrice2,Matrice3)
% DIPENDE DA: classe_metodo_matrice/3, dimensione_matrice_uguale_a_2/1, tipo_matrice/2, colonne_matrice/2, righe_matrice/2
% UTILIZZATO IN: 
% SERVE A: vero se valide tutte le ipotesi
%##############################################################################################################
matrici_compatibili_prodotto_matriciale(Matrice1, Matrice2, Matrice3):-
		%verifico che esistono 3 matrici
		array_var_def(Matrice1,TipoMatrice,2,_,[RigheMatrice1,ColonneMatrice1],ClasseMatrice,MetodoMatrice),
		array_var_def(Matrice2,TipoMatrice,2,_,[ColonneMatrice1,ColonneMatrice2],ClasseMatrice,MetodoMatrice),
		array_var_def(Matrice3,TipoMatrice,2,_,[RigheMatrice1,ColonneMatrice2],ClasseMatrice,MetodoMatrice).
%--------------------------------------------------------------------------------------------------------------

%#############################################################################################################
% NOME: cicli_for_compatibili(Matrice1,Matrice2,Matrice3)
% DIPENDE DA: 
% UTILIZZATO IN: 
% SERVE A: vero se valide tutte le ipotesi
%#############################################################################################################
cicli_for_compatibili(Matrice1,Matrice2,Matrice3,ID_CicloFor1,ID_CicloFor2,ID_CicloFor3):-
		%estrapolo i dati delle matrici :
		matrici_compatibili_prodotto_matriciale(Matrice1, Matrice2, Matrice3),
		righe_matrice(Matrice1, RigheMatrice1),
		colonne_matrice(Matrice2, ColonneMatrice2),
		righe_matrice(Matrice2, RigheMatrice2),
    	%verifico che esistono 3 cicli_for
		espressioni_ciclo_for_compatibili(ID_CicloFor1,_,0,RigheMatrice1),
		espressioni_ciclo_for_compatibili(ID_CicloFor2,_,0,ColonneMatrice2),
		espressioni_ciclo_for_compatibili(ID_CicloFor3,_,0,RigheMatrice2),		
		%verifico che il ciclo_for2 sia innestato nel ciclo_for1
		ciclo_for_innestato(ID_CicloFor1, ID_CicloFor2),
		%verifico che il ciclo_for3 sia innestato nel ciclo_for2
		ciclo_for_innestato(ID_CicloFor2,ID_CicloFor3)
		.
%-------------------------------------------------------------------------------------------------------------



%#############################################################################################################
% NOME: riconosci_prodotto_matriciale(Matrice1,Matrice2,Matrice3,ID_For1,ID_For2,ID_For3)
% DIPENDE DA: 
% UTILIZZATO IN: 
% SERVE A: vero se valide tutte le ipotesi
%#############################################################################################################
riconosci_prodotto_matriciale(Matrice1,Matrice2,Matrice3,ID_For1,ID_For2,ID_For3):-
    	 
			cicli_for_compatibili(Matrice1,Matrice2,Matrice3,ID_For1,ID_For2,ID_For3),
			%%verifico condizioni nel terzo cicloFor
			variabile_ciclo_for(ID_For1,NomeVariabile_For1),
			variabile_ciclo_for(ID_For2,NomeVariabile_For2),
			variabile_ciclo_for(ID_For3,NomeVariabile_For3),
			array_elem_inst(Expr,Matrice3,[NomeVariabile_For1,NomeVariabile_For2],_,_),
			control_dependence(ID_For3,Expr,true,_,_),
			plus_commutativo(Expr,Op1,Op2,Metodo,Classe),
			array_elem_inst(Expr,Matrice3,[NomeVariabile_For1,NomeVariabile_For2],_,_),
			times_commutativo(Op1,OpTimes1,OpTimes2,_,_),
			( 
				( 	
					equivalenza(Expr,Variabile1,[Id_Array1,NomeVariabile_For1,NomeVariabile_For3]),
					scalar_var_ref(OpTimes1,Variabile1)
				)
				;
				array_elem_ref(OpTimes1,Matrice1,[NomeVariabile_For1,NomeVariabile_For3])
					
			)
			,
			( 
				( 	
					equivalenza(Expr,Variabile2,[Id_Array2,NomeVariabile_For3,NomeVariabile_For2]),
					scalar_var_ref(OpTimes2,Variabile2)
				)
				;
				array_elem_ref(OpTimes2,Matrice2,[NomeVariabile_For3,NomeVariabile_For2])
			)			
		.
% -------------------------------------------------------------------------------------------------------------