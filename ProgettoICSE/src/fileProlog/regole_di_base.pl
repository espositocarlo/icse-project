%#############################################################################################################
% questo file contiene delle regole di base per il riconoscimento di concetti algoritmici
%
% DA FARE:  documentare il file (nell'apposita sezione della relazione)
%			creare una lista di KB, funtori prolog necessari a questo file
%
%
%#############################################################################################################


%#############################################################################################################
% NOME: plus_commutativo(Expr,Op1,Op2,Metodo,Classe)
% SERVE A: somma commutativa
%#############################################################################################################
plus_commutativo(Expr,Op1,Op2,Metodo,Classe) :-
												plus(Expr,Op1,Op2,Metodo,Classe);%or
                                                plus(Expr,Op2,Op1,Metodo,Classe).
% -------------------------------------------------------------------------------------------------------------

%#############################################################################################################
% NOME: times_commutativo(Expr, OpTimes1, OpTimes2, Metodo, Classe)
% SERVE A: moltiplicazione commutativa
%#############################################################################################################
times_commutativo(Expr,OpTimes1,OpTimes2,Metodo,Classe)  :-
												times(Expr,OpTimes1,OpTimes2,Metodo,Classe);%or
                                                times(Expr,OpTimes2,OpTimes1,Metodo,Classe).
% -------------------------------------------------------------------------------------------------------------

%#############################################################################################################
% NOME: ciclo_for(ID, Variabile, Funtore_init, Funtore_exit, Funtore_incr, Metodo,Classe)
% SERVE A: riconoscere un ampia classe di cicli for
%#############################################################################################################
ciclo_for(ID, Variabile, Funtore_init, Funtore_exit, Funtore_incr, Metodo,Classe):-
		for_r(ID,_,Init_CicloFor, Exit_CicloFor, Incr_CicloFor, Metodo,Classe),
		scalar_var_inst(Init_CicloFor,Variabile,Metodo,Classe),
		% condizioni di inizializzazione
		(
			% esempio i=0
			(
				uguaglianza(Init_CicloFor,Uguaglianza_ref,Metodo,Classe)
			) -> Funtore_init = uguaglianza(Init_CicloFor,Uguaglianza_ref,Metodo,Classe)
			;
			% esempio i=j+1
			(
				plus_commutativo(Init_CicloFor,Plus_commutativo_ref_1,Plus_commutativo_ref_2,Metodo,Classe)
			) -> Funtore_init = plus_commutativo(Init_CicloFor,Plus_commutativo_ref_1,Plus_commutativo_ref_2,Metodo,Classe)
		),
		% condizione di uscita
		(
			% esempio i<10
			(
				less(Exit_CicloFor,Less_ref_1,Less_ref_2,Metodo,Classe),
				scalar_var_ref(Less_ref_1,Variabile)
			) -> Funtore_exit = less(Exit_CicloFor,Less_ref_1,Less_ref_2,Metodo,Classe)
			;
			% esempio i>=10
			(
				greater_equal(Exit_CicloFor,Greater_equal_ref_1,Greater_equal_ref_2,Metodo,Classe),
				scalar_var_ref(Greater_equal_ref_1,Variabile)
			) -> Funtore_exit = greater_equal(Exit_CicloFor,Greater_equal_ref_1,Greater_equal_ref_2,Metodo,Classe)
		),
		% incremento
		(
			(
				post_incr(Incr_CicloFor,Post_incr_ref,Metodo,Classe),
				scalar_var_ref(Post_incr_ref,Variabile)
			) -> Funtore_incr = post_incr(Incr_CicloFor,Post_incr_ref,Metodo,Classe)
			;
			(
				post_decr(Incr_CicloFor,Post_decr_ref,Metodo,Classe),
				scalar_var_ref(Post_decr_ref,Variabile)
			) -> Funtore_incr = post_decr(Incr_CicloFor,Post_decr_ref,Metodo,Classe)
		).


% --------------------------------------------------------------------------------------------------------------

%#############################################################################################################
% NOME: copia_matrice()
% SERVE A: rappresenta il fatto un espressione rappresenta una copia di una matrice.
% DA FARE: aggiungere in or il fatto che la copia potrebbe essere fatta a mano mediante 2 cicli for innestati
%#############################################################################################################
copia_matrice(IdMatrice1, Matrice1, IdMatrice2, Matrice2) :-
				% c'è un' espressione di valorizzazione
				scalar_var_inst(IdMatrice1,Matrice1,Metodo,Classe),
				% c'è una definizione della variabile valorizzata come matrice
				array_var_def(Matrice1,TipoMatrice,DimMatrice,IdMatrice1,[DimRig,DimCol],Metodo,Classe),
				% c'è un'uguaglianza tra la variabile e un'altra
				uguaglianza(IdMatrice1,IdMatrice2),
				% l'uguaglianza comprende un array al secondo membro
				array_elem_ref(IdMatrice2,Matrice2,[DimRig,DimCol]),
				% l'array al secondo membro è definito come una matrice
				array_var_def(Matrice2,TipoMatrice,DimMatrice,IdMatrice2,[DimRig,DimCol],Metodo,Classe).

%-------------------------------------------------------------------------------------------------------------

%#############################################################################################################
% NOME: copia_array()
% SERVE A: rappresenta il fatto che esiste una copia di un array.
%#############################################################################################################
% inizio replace pasquale
%copia_array(IdArray1, Array1, IdArray2, Array2) :-
%				% c'è un' espressione di valorizzazione
%				scalar_var_inst(IdArray1,Array1,Metodo,Classe),
%				% c'è una definizione della variabile valorizzata come vettore
%				array_var_def(Array1,_,1,IdArray1,[_],Metodo,Classe),
%				% c'è un'uguaglianza tra la variabile e un'altra
%				uguaglianza(IdArray1,IdArray2),
%				% l'uguaglianza comprende un array al secondo membro
%				array_elem_ref(IdArray2,Array2,[_]).
%--------------------------------------------------------------
copia_array(ID_expression,Array1,Array2) :-
				scalar_var_inst(ID_expression,Array1,Metodo,Classe),			%Array1
				uguaglianza(ID_expression,Uguaglianza_ref,Metodo,Classe),		% = ...
				scalar_var_ref(Uguaglianza_ref,Array2,Metodo,Classe),						%Array2
				(
					array_var_def(Array1,Tipo,Dimensione,_,_,Metodo,Classe);
					array_var_def(Array1,Tipo,Dimensione,_,_,null,Classe)
				),
				(
					array_var_def(Array2,Tipo,Dimensione,_,_,Metodo,Classe);
					array_var_def(Array2,Tipo,Dimensione,_,_,null,Classe)
				)
				.
% fine replace pasquale
%-------------------------------------------------------------------------------------------------------------

%#############################################################################################################
% NOME: appartenenza(equazione,id1,posizione)
% SERVE A: rappresenta il fatto che esiste un riferimento ad una variabile scalare in un espressione
%#############################################################################################################
 appartenenza(Equazione,Id,Posizione) :- ( scalar_var_inst(Equazione,Id,_,_) , Posizione = left  );
										 (  scalar_var_ref(Equazione,Id)     , Posizione = right ).

 appartenenza(Equazione,Id,Posizione) :- (
										  plus_commutativo(Equazione,Riferimento1,_,_,_)  ;
										  times_commutativo(Equazione,Riferimento1,_,_,_) ;
										  divide(Equazione,Riferimento1,Riferimento2,_,_)
										  %DA FARE aggiungere gli altri operatori binari (mi scoccio)
										 ),
										 (
										   appartenenza(Riferimento1,Id,Posizione);
										   appartenenza(Riferimento2,Id,Posizione)
										 ).

%-------------------------------------------------------------------------------------------------------------

%#############################################################################################################
% NOME: equivalenza(equazione,id1,[Id_Array,Indice1,Indice2])
% SERVE A: rappresenta il fatto che in una certa equazione è equivalente avere un riferimento ad una variabile id1
%		   piuttosto che ad un'altra espressione.
%#############################################################################################################
 equivalenza(Equazione,Id1,Oggetto_equivalente )  :-
									%la variabile viene utilizzata a destra nell'equazione
									appartenenza(Equazione,Id1,right),
									%c'è un espressione in cui tale id viene valorizzato
									scalar_var_inst(Equazione2,Id1,Metodo,Classe),
									%c'è una data dependence fra i due statement
									data_dependence(Equazione2,Equazione),
									(
									  (
										uguaglianza(Equazione2,Uguaglianza_ref,Metodo,Classe),
										array_elem_ref(Uguaglianza_ref,Id_Array,[Indice1,Indice2])
									  ) -> Oggetto_equivalente = array_elem_ref(Uguaglianza_ref,Id_Array,[Indice1,Indice2])
									;
									  (
										uguaglianza(Equazione2,Uguaglianza_ref,Metodo,Classe),
									    scalar_var_ref(Uguaglianza_ref,Id_scalar_var)
									  ) -> Oggetto_equivalente = scalar_var_ref(Uguaglianza_ref,Id_scalar_var)
									;
									  (
										plus_commutativo(Equazione2,Riferimento1,Riferimento2,Classe,Metodo)
									  ) -> Oggetto_equivalente = plus_commutativo(Equazione2,Riferimento1,Riferimento2,Classe,Metodo)
									;
									  (
										times_commutativo(Equazione2,Riferimento1,Riferimento2,Classe,Metodo)
									  ) -> Oggetto_equivalente = times_commutativo(Equazione2,Riferimento1,Riferimento2,Classe,Metodo)
									;
									  (
										divide(Equazione2,Riferimento1,Riferimento2,Classe,Metodo)
									  ) -> Oggetto_equivalente = divide(Equazione2,Riferimento1,Riferimento2,Classe,Metodo)
									).

equivalenza(Equazione,Id1,Id1)  :- appartenenza(Equazione,Id1,right).

%-------------------------------------------------------------------------------------------------------------

%#############################################################################################################
% NOME: righe_matrice(A,N)
% SERVE A: vero se Matrice è una matrice che ha N righe.
%##############################################################################################################
righe_matrice(Matrice, N):-	array_var_def(Matrice,_,_,_,[N,_],_,_).

%--------------------------------------------------------------------------------------------------------------
%#############################################################################################################
% NOME: colonne_matrice(A,N)
% SERVE A: vero se Matrice è una matrice che ha N colonne.
%##############################################################################################################
colonne_matrice(Matrice, N):- array_var_def(Matrice,_,_,_,[_,N],_,_).


%-------------------------------------------------------------------------------------------------------------
%#############################################################################################################
% NOME: matrice_bidimensionale(Matrice)
% SERVE A: vero se Matrice ha la dimensione pari a 2.
%#############################################################################################################
matrice_bidimensionale(Matrice):- array_var_def(Matrice,_,2,_,_,_,_).


%--------------------------------------------------------------------------------------------------------------
%#############################################################################################################
% NOME: true_dependence(ID1,ID2)
% DIPENDE DA:
% UTILIZZATO IN:
% SERVE A: vero se ID2 è true data dependent da ID1
%#############################################################################################################
true_data_dependence(ID1, ID2):- data_dependence(ID1, ID2, true,_,_).
%--------------------------------------------------------------------------------------------------------------