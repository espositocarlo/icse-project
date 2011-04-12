% NAMING:
% Stp 	statement pointer
% Exp 	expression
% Nota: nella kb nuova tutte le scalar_var_inst devono essere rinominate in scalar_var_assign
% Nota: nella kb nuova tutte gli array_elem_inst devono essere rinominate in array_elem_assign
% Nota: nella kb nuova tutte gli uguaglianza devono essere rinominate in assignment
/* regole per la conversione dei fatti prolog */

% ExpStp1 is true control dependent from ExpStp2
control_dep(ExpStp1,ExpStp2,Bool,Class,Method) :- control_dependence(ExpStp2,ExpStp1,Class,Method),
												  Bool = true.
  
% use of Ident
  scalar_var_inst(Stp,Ident,Class,Method) 			:- 	scalar_var_ref(Stp,Ident).														
  scalar_var_inst(Stp,Ident,Class,Method) 			:- 	scalar_var_assign(Stp,Ident,Class,Method).

% use of Ident[][]
  array_elem_inst(Stp,Ident,SubScrList,_,_) 		 :-  array_elem_ref(Stp,Ident,SubScrList).
  array_elem_inst(Stp,Ident,SubScrList,Class,Method) :-  array_elem_assign(Stp,Ident,SubScrList,Class,Method).

% use of a literal  
  val_inst(Stp,Type,Value) :- constant_ref(Stp,Value), Type = integer.
  
% pure assignement ( a = b, a = 7, m[1][2] = c...)
  assign_r(Stp,HierAssign,ElemDefStp,Class,Method) :- 
													  (
													  scalar_var_assign(Stp,_,Class,Method);
													  array_elem_assign(Stp,_,_,Class,Method)
													  ),
													  uguaglianza(Stp,ElemDefStp,Class,Method),
													  HierAssign = assign(Stp,ElemDefStp).

% binary assignment (a = b + 4, c = 7 * 5, m[1] = a / 75...):
 assign_r(Stp,HierAssign,Elem1Stp,Elem2Stp,Class,Method) :- 
													  (
													  array_elem_assign(Stp,_,_,Class,Method);
													  scalar_var_assign(Stp,_,Class,Method),
													  ),
													  (
														  (
															plus(Stp,Elem1Stp,Elem2Stp,Class,Method),
															HierAssign = plus(Stp,Elem1Stp,Elem2Stp),!
														  );
														  (
															times(Stp,Elem1Stp,Elem2Stp,Class,Method),
															HierAssign = times(Stp,Elem1Stp,Elem2Stp),!
														  );	
														  (
															divide(Stp,Elem1Stp,Elem2Stp,Class,Method),
															HierAssign = divide(Stp,Elem1Stp,Elem2Stp),!
														  );
														  (
															minus(Stp,Elem1Stp,Elem2Stp,Class,Method),
															HierAssign = minus(Stp,Elem1Stp,Elem2Stp),!
														  )
													  )
													  .
									  
	array_var_def(DefStp,Type,1,ArrayIdent,[FirstRange|ArrayRangesList],Class,Method) :- 
	array_var_definition(DefStp,Type,Dim,ArrayIdent,IndexList,Class,Method),
	
	
	array_var_def(DefStp,Type,Dim,ArrayIdent,ArrayRangesList,Class,Method) :- 
	array_var_definition(DefStp,Type,Dim,ArrayIdent,IndexList,Class,Method),
	ranges(ArrayRangesList,IndexList,Dim)
	.
	
	ranges([Range|[]],[Index|[]],1) :- Range = [0,Index].
	
	ranges([FirstRange|ArrayRangesList],[FirstIndex|IndexList],Dim) :- 	  
																		FirstRange = [0,FirstIndex],
																		Dim_sofar is Dim-1, 
																		ranges(ArrayRangesList,IndexList,Dim_sofar) .

	
													  
/* regole base */
member(X,[X|Xs],1).
member(X,[Y|Ys],Pos):- member(X,Ys,Pos_sofar), Pos is Pos_sofar+1.

nonmember(X,[Y|Ys]):- X \== Y, nonmember(X,Ys).
nonmember(X,[]).

% Appartenenza di un termine ad un funtore
subterm(Term,Term).

subterm(Sub,Term):- not(atomic(Term)) , % Term non è atomico
                    functor(Term,F,N) , % Term ha come funtore principale F e molteplicità N
                    subterm(N,Sub,Term). % Richiamo subterm su Sub Term e N

subterm(N,Sub,Term):- 
					N > 1,N1 is N-1, 
				    subterm(N1,Sub,Term).
					
subterm(N,Sub,Term):- 
					arg(N,Term,Arg), 
					subterm(Sub,Arg).
					
subterm_from_sec(Term,Term).
subterm_from_sec(Sub,Term) 	:- 
							not(atomic(Term)),
							functor(Term,F,N),
							subterm_from_sec(N,Sub,Term).
							
subterm_from_sec(N,Sub,Term) 	:- 
					N > 2, N1 is N-1, 
					subterm_from_sec(N1,Sub,Term).
					
subterm_from_sec(N,Sub,Term):- 
					arg(N,Term,Arg), 
					subterm_from_sec(Sub,Arg).

% FINE REGOLE DI BASE
% Stessa espressione
same_exp(X,Y) :- X==Y.

%Espressioni commutative
 comm_add_exp(Stp,Op1Stp,Op2Stp,Class,Method) :- plus(Stp,Op1Stp,Op2Stp,Class,Method);%or
                                                 plus(Stp,Op2Stp,Op1Stp,Class,Method).

%
 comm_mul_exp(Stp,Op1Stp,Op2Stp,Class,Method) :- times(Stp,Op1Stp,Op2Stp,Class,Method);%or
                                                 times(Stp,Op2Stp,Op1Stp,Class,Method).

% 
 comm_equal_exp(Stp,Op1Stp,Op2Stp,Class,Method) :- equal(Stp,Op1Stp,Op2Stp,Class,Method);
                                                   equal(Stp,Op2Stp,Op1Stp,Class,Method).

%
 comm_and_exp(Stp,Op1Stp,Op2Stp,Class,Method) :- and(Stp,Op1Stp,Op2Stp,Class,Method);
                                                 and(Stp,Op2Stp,Op1Stp,Class,Method).

%
 comm_and_and_exp(Stp,Op1Stp,Op2Stp,Class,Method) :- and_and(Stp,Op1Stp,Op2Stp,Class,Method);
                                                     and_and(Stp,Op2Stp,Op1Stp,Class,Method).

%
 comm_or_exp(Stp,Op1Stp,Op2Stp,Class,Method) :- or(Stp,Op1Stp,Op2Stp,Class,Method);
                                                or(Stp,Op2Stp,Op1Stp,Class,Method).

%
 comm_or_or_exp(Stp,Op1Stp,Op2Stp,Class,Method) :- or_or(Stp,Op1Stp,Op2Stp,Class,Method);
                                                   or_or(Stp,Op2Stp,Op1Stp,Class,Method).

%
 comm_xor_exp(Stp,Op1Stp,Op2Stp,Class,Method) :- xor(Stp,Op1Stp,Op2Stp,Class,Method);
                                                 xor(Stp,Op2Stp,Op1Stp,Class,Method).

%
 comm_not_equal_exp(Stp,Op1Stp,Op2Stp,Class,Method) :-  not_equal(Stp,Op1Stp,Op2Stp,Class,Method);
                                                        not_equal(Stp,Op2Stp,Op1Stp,Class,Method).

%
 comm_exp(Stp,Op1Stp,Op2Stp,Class,Method) :- comm_add_exp(      Stp,Op1Stp,Op2Stp,Class,Method) ;
                                             comm_mul_exp(      Stp,Op1Stp,Op2Stp,Class,Method) ;
                                             comm_and_exp(      Stp,Op1Stp,Op2Stp,Class,Method) ;
                                             comm_or_exp(       Stp,Op1Stp,Op2Stp,Class,Method) ;
                                             comm_and_and_exp(  Stp,Op1Stp,Op2Stp,Class,Method) ;
                                             comm_or_or_exp(    Stp,Op1Stp,Op2Stp,Class,Method) ;
                                             comm_xor_exp(      Stp,Op1Stp,Op2Stp,Class,Method) ;
                                             comm_equal_exp(    Stp,Op1Stp,Op2Stp,Class,Method) ;
                                             comm_not_equal_exp(Stp,Op1Stp,Op2Stp,Class,Method) .
% Espressione binaria
 binary_exp(Stp,Op1Stp,Op2Stp,Class,Method) :- plus(  Stp,Op1Stp,Op2Stp,Class,Method) ;
                                               minus( Stp,Op1Stp,Op2Stp,Class,Method) ;
                                               times( Stp,Op1Stp,Op2Stp,Class,Method) ;
                                               divide(Stp,Op1Stp,Op2Stp,Class,Method) ;
                                               equal( Stp,Op1Stp,Op2Stp,Class,Method) ;
                                               and(   Stp,Op1Stp,Op2Stp,Class,Method) ;
                                               or(    Stp,Op1Stp,Op2Stp,Class,Method) ;
                                               or_or( Stp,Op1Stp,Op2Stp,Class,Method) ;
                                               modulo(Stp,Op1Stp,Op2Stp,Class,Method) ;
                                               xor(   Stp,Op1Stp,Op2Stp,Class,Method) ;
                                               less(  Stp,Op1Stp,Op2Stp,Class,Method) ;
                                               less_equal(Stp,Op1Stp,Op2Stp,Class,Method) ;
                                               and_and(   Stp,Op1Stp,Op2Stp,Class,Method) ;
                                               greater(   Stp,Op1Stp,Op2Stp,Class,Method) ;
                                               not_equal( Stp,Op1Stp,Op2Stp,Class,Method) ;
                                               greater_equal(       Stp,Op1Stp,Op2Stp,Class,Method) ;
                                               left_shift(          Stp,Op1Stp,Op2Stp,Class,Method) ;
                                               right_shift(         Stp,Op1Stp,Op2Stp,Class,Method) ;
                                               unsigned_right_shift(Stp,Op1Stp,Op2Stp,Class,Method) .

% Espressione unaria
 unary_exp(Stp,OpStp,Class,Method) :- 
									  complement( Stp,OpStp,Class,Method);
                                      sign_negate(Stp,OpStp,Class,Method);
                                      post_decr(  Stp,OpStp,Class,Method);
                                      post_incr(  Stp,OpStp,Class,Method);
                                      pre_decr(   Stp,OpStp,Class,Method);
                                      pre_incr(   Stp,OpStp,Class,Method);
                                      not_exp(    Stp,OpStp,Class,Method).



/* espressioni di equivalenza */
  equiv_exp(X,Y,Class,Method) :- 	val_inst(X,SameType,SameVal,Class,Method),
                    				val_inst(Y,SameType,SameVal,Class,Method).
  equiv_exp(X,Y,Class,Method) :- 	scalar_var_inst(X,SameIdent,Class,Method),
                    				scalar_var_inst(Y,SameIdent,Class,Method).

  equiv_exp(X,Y,Class,Method) :- 	array_elem_inst(X,SameArrIdent,SubScrListX,Class,Method),
                    				array_elem_inst(Y,SameArrIdent,SubScrListY,Class,Method),
                    				equiv_subscr_list(SubScrListX,SubScrListY,Class,Method).

  equiv_exp(X,Y,Class,Method) :- 	plus(X,Op1X,Op2X,Class,Method), 
									comm_add_exp(Y,Op1Y,Op2Y,Class,Method),
                    				equiv_exp(Op1X,Op1Y,Class,Method), 
                    				equiv_exp(Op2X,Op2Y,Class,Method).

  equiv_exp(X,Y,Class,Method) :- 	minus(X,Op1X,Op2X,Class,Method), 
									minus(Y,Op1Y,Op2Y,Class,Method),
                    				equiv_exp(Op1X,Op1Y,Class,Method), 
                    				equiv_exp(Op2X,Op2Y,Class,Method).

  equiv_exp(X,Y,Class,Method) :- 	times(X,Op1X,Op2X,Class,Method), 
									comm_mul_exp(Y,Op1Y,Op2Y,Class,Method),
                    				equiv_exp(Op1X,Op1Y,Class,Method), 
                    				equiv_exp(Op2X,Op2Y,Class,Method).

  equiv_exp(X,Y,Class,Method) :- 	divide(X,Op1X,Op2X,Class,Method), 
									divide(Y,Op1Y,Op2Y,Class,Method),
                    				equiv_exp(Op1X,Op1Y,Class,Method), 
                    				equiv_exp(Op2X,Op2Y,Class,Method).

  equiv_exp(X,Y,Class,Method) :- 	sign_negate(X,OpX,Class,Method), 
									sign_negate(Y,OpY,Class,Method), 
									equiv_exp(OpX,OpY,Class,Method).

  equiv_exp(X,Y,Class,Method) :- 	equal(X,Op1X,Op2X,Class,Method), 
									comm_equal_exp(Y,Op1Y,Op2Y,Class,Method),
                    				equiv_exp(Op1X,Op1Y,Class,Method), 
                    				equiv_exp(Op2X,Op2Y,Class,Method).

  equiv_exp(X,Y,Class,Method) :- 	not_equal(X,Op1X,Op2X,Class,Method), 
									not_equal(Y,Op1Y,Op2Y,Class,Method),
                    				equiv_exp(Op1X,Op1Y,Class,Method), 
                    				equiv_exp(Op2X,Op2Y,Class,Method).

  equiv_exp(X,Y,Class,Method) :- 	and(X,Op1X,Op2X,Class,Method), 
									comm_and_exp(Y,Op1Y,Op2Y,Class,Method),
                    				equiv_exp(Op1X,Op1Y,Class,Method), 
                    				equiv_exp(Op2X,Op2Y,Class,Method).

  equiv_exp(X,Y,Class,Method) :- 	xor(X,Op1X,Op2X,Class,Method), 
									comm_xor_exp(Y,Op1Y,Op2Y,Class,Method),
                    				equiv_exp(Op1X,Op1Y,Class,Method), 
                    				equiv_exp(Op2X,Op2Y,Class,Method).

  equiv_exp(X,Y,Class,Method) :- 	or(X,Op1X,Op2X,Class,Method), 
									comm_or_exp(Y,Op1Y,Op2Y,Class,Method),
                    				equiv_exp(Op1X,Op1Y,Class,Method), 
                    				equiv_exp(Op2X,Op2Y,Class,Method).

  equiv_exp(X,Y,Class,Method) :- 	and_and(X,Op1X,Op2X,Class,Method), 
									comm_and_and_exp(Y,Op1Y,Op2Y,Class,Method),
                    				equiv_exp(Op1X,Op1Y,Class,Method), 
                    				equiv_exp(Op2X,Op2Y,Class,Method).

  equiv_exp(X,Y,Class,Method) :- 	or_or(X,Op1X,Op2X,Class,Method), 
									comm_or_or_exp(Y,Op1Y,Op2Y,Class,Method),
                    				equiv_exp(Op1X,Op1Y,Class,Method), 
                    				equiv_exp(Op2X,Op2Y,Class,Method).

  equiv_exp(X,Y,Class,Method) :- 	modulo(X,Op1X,Op2X,Class,Method), 
									modulo(Y,Op1Y,Op2Y,Class,Method),
                    				equiv_exp(Op1X,Op1Y,Class,Method), 
                    				equiv_exp(Op2X,Op2Y,Class,Method).

  equiv_exp(X,Y,Class,Method) :- 	less(X,Op1X,Op2X,Class,Method), 
									less(Y,Op1Y,Op2Y,Class,Method),
                    				equiv_exp(Op1X,Op1Y,Class,Method), 
                    				equiv_exp(Op2X,Op2Y,Class,Method).

  equiv_exp(X,Y,Class,Method) :- 	less_equal(X,Op1X,Op2X,Class,Method), 
									less_equal(Y,Op1Y,Op2Y,Class,Method),
                    				equiv_exp(Op1X,Op1Y,Class,Method), 
                    				equiv_exp(Op2X,Op2Y,Class,Method).

  equiv_exp(X,Y,Class,Method) :- 	greater(X,Op1X,Op2X,Class,Method), 
									greater(Y,Op1Y,Op2Y,Class,Method),
                    				equiv_exp(Op1X,Op1Y,Class,Method), 
                    				equiv_exp(Op2X,Op2Y,Class,Method).

  equiv_exp(X,Y,Class,Method) :- 	greater_equal(X,Op1X,Op2X,Class,Method), 
									greater_equal(Y,Op1Y,Op2Y,Class,Method),
                    				equiv_exp(Op1X,Op1Y,Class,Method), 
                    				equiv_exp(Op2X,Op2Y,Class,Method).

  equiv_exp(X,Y,Class,Method) :- 	left_shift(X,Op1X,Op2X,Class,Method), 
									left_shift(Y,Op1Y,Op2Y,Class,Method),
                    				equiv_exp(Op1X,Op1Y,Class,Method), 
                    				equiv_exp(Op2X,Op2Y,Class,Method).

  equiv_exp(X,Y,Class,Method) :- 	right_shift(X,Op1X,Op2X,Class,Method), 
									right_shift(Y,Op1Y,Op2Y,Class,Method),
                    				equiv_exp(Op1X,Op1Y,Class,Method), 
                    				equiv_exp(Op2X,Op2Y,Class,Method).

  equiv_exp(X,Y,Class,Method) :- 				unsigned_right_shift(X,Op1X,Op2X,Class,Method), 
  								unsigned_right_shift(Y,Op1Y,Op2Y,Class,Method),
                    						equiv_exp(Op1X,Op1Y,Class,Method), 
                    						equiv_exp(Op2X,Op2Y,Class,Method).

  equiv_exp(X,Y,Class,Method) :- 				complement(X,OpX,Class,Method), 
  								complement(Y,OpY,Class,Method),
                    						equiv_exp(OpX,OpY,Class,Method).

  equiv_exp(X,Y,Class,Method) :- 				post_decr(X,OpX,Class,Method), 
  								post_decr(Y,OpY,Class,Method), 
  								equiv_exp(OpX,OpY,Class,Method).

  equiv_exp(X,Y,Class,Method) :- 				post_incr(X,OpX,Class,Method), 
  								post_incr(Y,OpY,Class,Method), 
  								equiv_exp(OpX,OpY,Class,Method).

  equiv_exp(X,Y,Class,Method) :- 				pre_decr(X,OpX,Class,Method), 
  								pre_decr(Y,OpY,Class,Method), 
  								equiv_exp(OpX,OpY,Class,Method).

  equiv_exp(X,Y,Class,Method) :- 				pre_incr(X,OpX,Class,Method), 
  								pre_incr(Y,OpY,Class,Method), 
  								equiv_exp(OpX,OpY,Class,Method).

  equiv_exp(X,Y,Class,Method) :- 				not_exp(X,OpX,Class,Method), 
  								not_exp(Y,OpY,Class,Method), 
  								equiv_exp(OpX,OpY,Class,Method).

  equiv_subscr_list([X|Xs],[Y|Ys],Class,Method) :- 		equiv_exp(X,Y,Class,Method),
                                      				equiv_subscr_list(Xs,Ys,Class,Method).
  
  equiv_subscr_list([],[],Class,Method).

  
 % c'è una var_inst quando c'è una scalar_var_inst...
 var_inst(Stp,Ident,Class,Method) :- scalar_var_inst(Stp,Ident,Class,Method).
 
% ...oppure quando c'è un'array_el_inst
 var_inst(Stp,Ident,Class,Method) :- array_el_inst(Stp,Ident,SubScrList,Class,Method).
 
% c'è una inst quando c'è una var_inst
 inst(Stp,ValOrIdent,Class,Method) :- var_inst(Stp,ValOrIdent,Class,Method).


% c'è un'instanziazione in una espressione quando è verificata inst
 inst_in_exp(ValOrIdent,ExpStp,Class,Method) :- inst(ExpStp,ValOrIdent,Class,Method).

 % inst_in_exp quando è verificata binary_exp e se uno dei due termini dell espressione binaria è un inst_in_exp
 inst_in_exp(ValOrIdent,ExpStp,Class,Method) :- binary_exp(ExpStp,Op1Stp,Op2Stp,Class,Method),
                                                (
                                                  inst_in_exp(ValOrIdent,Op1Stp,Class,Method) ;
                                                  inst_in_exp(ValOrIdent,Op2Stp,Class,Method)
                                                ).

% inst_in_exp è verifiata quando è una espressione unaria e se il termine dell espressione unaria è un inst_in_exp
 inst_in_exp(ValOrIdent,ExpStp,Class,Method) :- unary_exp(ExpStp,OpStp,Class,Method),
                                                inst_in_exp(ValOrIdent,OpStp,Class,Method).



% inst_in_exp è verificata quando c'è un array_el_inst e gli indici dell'array devono essere inst_in_exp
 inst_in_exp(ValOrIdent,ExpStp,Class,Method) :-
												array_el_inst(ExpStp,Dummy,SubScrList,Class,Method),
												% CE member(SubScrExp,SubScrList,Class,Method),
												member(SubScrExp, SubScrList),
												inst_in_exp(ValOrIdent,SubScrExp,Class,Method).

% inst_in_exp/5 è verificata quado c'è un inst
 inst_in_exp(ValOrIdent,ExpStp,ExpStp,Class,Method) :- inst(ExpStp,ValOrIdent,Class,Method).




% inst_in_exp/5 è verificata quando c'è un espressione binaria con uno dei due operandi che verifica inst_in_exp
 inst_in_exp(ValOrIdent,InstStp,ExpStp,Class,Method) :-
													binary_exp(ExpStp,Op1Stp,Op2Stp,Class,Method),
													(
														inst_in_exp(ValOrIdent,InstStp,Op1Stp,Class,Method) ;
														inst_in_exp(ValOrIdent,InstStp,Op2Stp,Class,Method)
													).



% inst_in_exp/5 è verificata quando c'è un espressione unaria il cui operando verifica inst_in_exp
 inst_in_exp(ValOrIdent,InstStp,ExpStp,Class,Method) :-
														unary_exp(ExpStp,OpStp,Class,Method),
														inst_in_exp(ValOrIdent,InstStp,OpStp,Class,Method).





% inst_in_exp è verificata quando c'è un array_el_inst e gli indici dell'array verificano inst_in_exp/5
 inst_in_exp(ValOrIdent,InstStp,ExpStp,Class,Method) :-
													array_el_inst(ExpStp,Dummy,SubScrList,Class,Method),
													% CE member(SubScrExp,SubScrList,Class,Method),
													member(SubScrExp,SubScrList),

													inst_in_exp(ValOrIdent,InstStp,SubScrExp,Class,Method).

%per le variabili
 inst_in_exp_notcheck_subexps(ValOrIdent,ExpStp,SubExpStpList,Class,Method) :-
																				not( member(ExpStp,SubExpStpList) ),
																				inst(ExpStp,ValOrIdent,Class,Method).

% per le espressioni binarie
 inst_in_exp_notcheck_subexps(ValOrIdent,ExpStp,SubExpStpList,Class,Method) :-
																				not( member(ExpStp,SubExpStpList) ),
																				binary_exp(ExpStp,Op1Stp,Op2Stp,Class,Method),
																				(
																				inst_in_exp_notcheck_subexps(ValOrIdent,Op1Stp,SubExpStpList,Class,Method) ;
																				inst_in_exp_notcheck_subexps(ValOrIdent,Op2Stp,SubExpStpList,Class,Method)
																				).



% per le espressioni unarie
 inst_in_exp_notcheck_subexps(ValOrIdent,ExpStp,SubExpStpList,Class,Method) :-
																			not( member(ExpStp,SubExpStpList) ),
																			unary_exp(ExpStp,OpStp,Class,Method),
																			inst_in_exp_notcheck_subexps(ValOrIdent,OpStp,SubExpStpList,Class,Method).


% per gli array
 inst_in_exp_notcheck_subexps(ValOrIdent,ExpStp,SubExpStpList,Class,Method) :-
																			not( member(ExpStp,SubExpStpList) ),
																			array_el_inst(ExpStp,Dummy,SubScrList,Class,Method),
																			member(SubScrExp,SubScrList),
																			inst_in_exp_notcheck_subexps(ValOrIdent,SubScrExp,SubExpStpList,Class,Method).



% sub_exp in un espressione se l'espressione e la sub sono uguali
 sub_exp_in_exp(SubExpStp,ExpStp,Class,Method) :- SubExpStp = ExpStp.


% sub_exp in un espressione binaria
 sub_exp_in_exp(SubExpStp,ExpStp,Class,Method) :- binary_exp(ExpStp,Op1Stp,Op2Stp,Class,Method),
                                                  (
                                                   sub_exp_in_exp(SubExpStp,Op1Stp,Class,Method) ;
                                                   sub_exp_in_exp(SubExpStp,Op2Stp,Class,Method)
                                                  ).
% sub_exp in un espressione unaria
 sub_exp_in_exp(SubExpStp,ExpStp,Class,Method) :- unary_exp(ExpStp,OpStp,Class,Method),
                                                  sub_exp_in_exp(SubExpStp,OpStp,Class,Method).


% sub_exp_in_exp per gli array è verificata quando gli indici dell'array verificano sub_exp_in_exp
 sub_exp_in_exp(SubExpStp,ExpStp,Class,Method) :-
												array_el_inst(ExpStp,Dummy,SubScrList,Class,Method),
												member(SubScrExp,SubScrList),

												sub_exp_in_exp(SubExpStp,SubScrExp,Class,Method).



% espressione in uno statement se verifica assign_r
 exp_in_stm(ExpStp,IDass,Assign) :- assign_r(IDass,Assign,ExpStp,Class,Method).




% exp in uno statement for è verificata se esiste un ciclo for con una InitExpStp o una StepExpStp che verificano sub_exp_in_exp
 exp_in_stm(ExpStp,IDdo,For) :- for_r(IDfor,For,InitExpStp,ExpStp,StepExpStp,Class,Method),
                                (
                                sub_exp_in_exp(ExpStp,InitExpStp,Class,Method) ;
                                sub_exp_in_exp(ExpStp,StepExpStp,Class,Method)
                                ).

% exp in uno statement foreach 
 exp_in_stm(ExpStp,IDforeach,Foreach)   :-
											foreach_r(IDforeach,Foreach,ExpStp,VarDeclStp,Class,Method),
											sub_exp_in_exp(ExpStp,VarDeclStp,Class,Method).

% while
 exp_in_stm(ExpStp,IDwhile,While)       :- while_r(IDwhile,While,ExpStp,Class,Method).

% do while
 exp_in_stm(ExpStp,IDdo_while,Do_while) :- do_while_r(IDdo_while,Do_while,ExpStp,Class,Method).

% labeled
 exp_in_stm(ExpStp,IDlabeled,Labeled)   :- labeled_r(IDlabeled,Labeled,Ident_label,LoopStp),
                                           sub_exp_in_exp(ExpStp,LoopStp).

% if
 exp_in_stm(ExpStp,IDif,If) :- if_r(IDif,If,ExpStp,Class,Method).

% switch
 exp_in_stm(ExpStp,IDswitch,Switch) :- switch_r(IDswitch,Switch,Ident_label,Class,Method).

% assert
 exp_in_stm(ExpStp,IDassert,Assert) :- assert_r(IDassert,Assert,Class,Method).

% break
 exp_in_stm(ExpStp,IDbreak,Break)   :- break_r(IDbreak,Break,Ident_label,Class,Method).

%findall(+Template, :Goal, -Bag)                                   [ISO]
%Creates  a list of the instantiations Template gets  successively on
%backtracking  over Goal and unifies the  result with Bag.   Succeeds
%with  an  empty  list  if Goal  has  no  solutions.    findall/3  is
%equivalent  to  bagof/3  with  all free  variables  bound  with  the
%existential  operator (^), except that  bagof/3 fails when goal  has
%no solutions.

 inherit_dep(Concetto,ListaSottoConc) :- findall(
												AltroConc, % primo argomento di findall
												( 



													between(1,Concetto,AltroConc),
													findall( DepBranch,
																( member(DepBranch,[true,false]),
																	(	 
																		( 
																			forall  ( 
																						member(SottoConc1,ListaSottoConc),
																						control_dep(SottoConc1,AltroConc,DepBranch,Class,Method)
																					),% forall è vera solo se tutte le azioni control_dep sono vere
																			not( member(AltroConc,ListaSottoConc))
																		) ->

																		assert_ifnotalready(control_dep(Concetto,AltroConc,DepBranch,Class,Method)) ;
																		true
																	),
																	( 
																		( 


																			member(SottoConc2,ListaSottoConc),
																			control_dep(AltroConc,SottoConc2,DepBranch,Class,Method),
																			not( member(AltroConc,ListaSottoConc) )
																		) ->

																		assert_ifnotalready(control_dep(AltroConc,Concetto,DepBranch,Class,Method)) ;
																		true
																	)	
																),
																DepBranchList %... in DepBranchList ho il risultato del backtracking
															),
												forall ( 




															member(SottoConc3,ListaSottoConc),%inizio forall...
															(
																forall	( 
																			( 

																				data_dep(Type,SottoConc3,AltroConc,DepVar,DepLevel,Class,Method),
																				not( member(AltroConc,ListaSottoConc) )
																			),

																			assert_ifnotalready(data_dep(Type,Concetto,AltroConc,DepVar,DepLevel,Class,Method))
																		),
																forall	( 
																			( 

																				data_dep(Type,AltroConc,SottoConc3,DepVar,DepLevel,Class,Method),
																				not( member(AltroConc,ListaSottoConc) )
																			),

																			assert_ifnotalready(data_dep(Type,AltroConc,Concetto,DepVar,DepLevel,Class,Method))
																		),
																forall	( 

																				data_dep(Type,SottoConc3,SottoConc3,DepVar,DepLevel,Class,Method),
																			assert_ifnotalready(data_dep(Type,Concetto,Concetto,DepVar,DepLevel,Class,Method))
																		)
															)
														)% ...fine forall
												), % FINE SECONDO ARGOMENTO DEL PRIMO FINDALL
										AltroConcList 
									).% ULTIMO ARGOMENTO DEL PRIMO FINDALL
% asserisce se non è già presente nel db
 assert_ifnotalready(Term) :-
							( 
								clause(Term,true) -> true ; % se già esiste non fa nulla altrimenti..
								assert(Term) % ..aggiungo il termine al db
							).

% Asserisce
 asserisci(Term) :-
					( 
						clause(Term,true) -> true ; % se già esiste non fa nulla altrimenti..
						( 
							flag(global_ID,GIDold,GIDold+1), 
							ID is GIDold + 1,
							arg(1,Term,ID), %..aggiorna il primo argomento di Term con il nuovo ID = GIDold + 1 ..
							asserta( Term ) %..aggiunge il Term in testa al db
						)
					).
% 
 dep_chain(HierChain,SrcStm,SinkStm,ListStm,ListVar) :-
												chained(SrcStm,SinkStm,ListStm,ListVar,ListHierStm,[]),
												HierChain =.. [dep_chain,IN|ListHierStm], % il risultato sarà la costruzione di un funtore dep_chain(n arg)

												flag(global_ID,GIDold,GIDold+1),
												ID is GIDold + 1,
												asserisci( dep_chain_r(IN,HierChain,SrcStm,SinkStm,ListStm,ListVar) ),
												inherit_dep(IN,ListStm).

%
 chained(SrcStm,SinkStm,[SrcStm|ListStm],[VarIdent|ListVar],[HierSrcStm|ListHierStm],ListAlreadyInChain) :-
													SrcStm \== SinkStm,
													assign_r(SrcStm,HierSrcStm,_,Class,Method),
													data_dep(true,MiddleSinkStm,SrcStm,VarIdent,0,Class,Method),
													SrcStm \== MiddleSinkStm,
													not( member(MiddleSinkStm,ListAlreadyInChain) ),
													chained(MiddleSinkStm,SinkStm,ListStm,ListVar,ListHierStm,[SrcStm|ListAlreadyInChain]).

%
 chained(SinkStm,SinkStm,[SinkStm],[],[HierSinkStm],ListAlreadyInChain) :-
													assign_r(SinkStm,HierSinkStm,_,Class,Method).

% PDS 
 elem_update_r(ID,					% id del concetto, generato automaticamente da "asserisci"
				HierElUp,			% è sempre elem_update(IN,B) dove B è:
									% HierDef   ( che è la tipologia di assign dello statement unico di aggiornamento)
									% HierChain catena di dipendenza
				ElemUpdateStruct    % funtore fisso del tipo elem_update_s(...)
			   ) :- 
  % devo avere un assign_r (definizione)
    assign_r(ElemDefStp,HierDef,LhsDefStp,RhsDefStp,Class,Method),
  % sto facendo un assign ad un vettore o ad uno scalare (ElemIdent)
	var_inst(ElemDefStp,ElemIdent,Class,Method),
  % devo avere un assign_r (uso) di un qualsiasi tipo binario ( HierUse è singletone)
	assign_r(Use,HierUse,LhsUseStp,RhsUseStp,Class,Method),
  % l'elemento viene usato in quest'espressione (a destra o a sinistra)
    (
    inst_in_exp(ElemIdent,ElemUseStp,RhsUseStp,Class,Method);
    inst_in_exp(ElemIdent,ElemUseStp,LhsUseStp,Class,Method)
	),	
  % i puntatori puntano allo stesso elemento	
    equiv_exp(ElemDefStp,ElemUseStp,Class,Method),
    ( ElemDefStp == Use ->
      % se gli assignment sono proprio lo stesso.. ho finito, sto aggiornando un elemento
	  ( HierElUp = elem_update(ID,HierDef), 
        CompList = [ElemDefStp],
        ChainVarsList = [ElemIdent]
      ) ;
	  % sono due assignment separati.. vediamo se sono tra di loro connessi...
      ( 
		% con un data dep anti
		data_dep(anti,ElemDefStp,Use,ElemIdent,0,Class,Method), 
        % catena di dipendenza
		dep_chain(HierChain,Use,ElemDefStp,CompList,ChainVarsListButFirst),
        append([ElemIdent],ChainVarsListButFirst,ChainVarsList),
        HierElUp = elem_update(IN,HierChain)
      )
    ),
    ElemUpdateStruct = elem_update_s(ElemIdent,[ElemDefStp,ElemUseStp],CompList,ChainVarsList),
    asserisci( elem_update_r(IN,HierElUp,ElemUpdateStruct) ),
    inherit_dep(ID,CompList).
	
	
	
% PDS quando faccio uno shift?
  elem_shift_r(ID,
			   elem_shift(ID,HierElUp),
			   ElemShiftStruct
			  ):-
    % ho l'update di un elemento
	elem_update_r(ElUp,HierElUp,ElemShiftStruct),
    ElemShiftStruct = elem_update_s(ElemIdent,[ElemDefStp,ElemUseStp],CompList,ChainVarsList),
    forall( member(ChainStm,CompList,Pos), 			% PDS per ogni elemento di CompList, che chiamo ChainStm
            ( member(ChainVar,ChainVarsList,Pos),   % PDS per ogni elemento di ChainVarsList (nella stessa Pos)
              assign_r(ChainStm,_,_,ChainStmRhs,Class,Method),
              inst_descent_of_add_or_leftminus_unique(ChainVar,ChainStmRhs,_,Class,Method)),
              forall( (member(Var,ChainVarsList), Var \== ChainVar),
                      not( inst_in_exp(Var,ChainStmRhs) )
              )
          ),
    asserisci( elem_shift_r(ID,elem_shift(ID,HierElUp),ElemShiftStruct) ),
    inherit_dep(ID,[ElUp]).
	
 inst_descent_of_add_or_leftminus_unique(Ident,Exp,Exp,Class,Method) :-
																% CE var_inst(Exp,_,Ident,Class,Method).
																var_inst(Exp,Ident,Class,Method).
																
 inst_descent_of_add_or_leftminus_unique(Ident,Exp,IdentStp,Class,Method) :-
															( 
																comm_add_exp(Exp,Op1,Op2,Class,Method) ;
																minus(Exp,Op1,Op2,Class,Method)
															),
															inst_descent_of_add_or_leftminus_unique(Ident,Op1,IdentStp,Class,Method),
															not( inst_in_exp(Ident,Op2,Class,Method) ).

 inst_descent_of_mul_or_leftdiv_unique(Ident,Exp,Exp,Class,Method) :-
																var_inst(Exp,Ident,Class,Method).

 inst_descent_of_mul_or_leftdiv_unique(Ident,Exp,IdentStp,Class,Method) :-
															( 
																comm_mul_exp(Exp,Op1,Op2,Class,Method) ;
																divide(Exp,Op1,Op2,Class,Method)
															),
															inst_descent_of_mul_or_leftdiv_unique(Ident,Op1,IdentStp,Class,Method),
															not( inst_in_exp(Ident,Op2,Class,Method) ).

 inst_descent_of_add_or_leftminus_or_mul_or_leftdiv_unique(Ident,Exp,Exp,Class,Method) :-
																var_inst(Exp,Ident,Class,Method).

 inst_descent_of_add_or_leftminus_or_mul_or_leftdiv_unique(Ident,Exp,IdentStp,Class,Method) :-
															( 
																comm_add_exp(Exp,Op1,Op2,Class,Method) ;
																minus(Exp,Op1,Op2,Class,Method)
															),
															inst_descent_of_add_or_leftminus_or_mul_or_leftdiv_unique(Ident,Op1,IdentStp,Class,Method),
															not( inst_in_exp(Ident,Op2,Class,Method) ).

 inst_descent_of_add_or_leftminus_or_mul_or_leftdiv_unique(Ident,Exp,IdentStp,Class,Method) :-
															( 
																comm_mul_exp(Exp,Op1,Op2,Class,Method) ;
																divide(Exp,Op1,Op2,Class,Method)
															),

															inst_descent_of_add_or_leftminus_or_mul_or_leftdiv_unique(Ident,Op1,IdentStp,Class,Method),
															not( inst_in_exp(Ident,Op2,Class,Method) ).



 inst_descent_of_and_or_or_unique(Ident,Exp,Exp,Class,Method) :-
																var_inst(Exp,Ident,Class,Method).



 inst_descent_of_and_or_or_unique(Ident,Exp,IdentStp,Class,Method) :-
															( 
																comm_and_exp(Exp,Op1,Op2,Class,Method) ;
																comm_or_exp(Exp,Op1,Op2,Class,Method)
															),
															inst_descent_of_and_or_or_unique(Ident,Op1,IdentStp,Class,Method),
															not( inst_in_exp(Ident,Op2,Class,Method) ).

 inst_descent_of_xor_unique(Ident,Exp,Exp,Class,Method) :-




															var_inst(Exp,Ident,Class,Method).

 inst_descent_of_xor_unique(Ident,Exp,IdentStp,Class,Method) :-
															comm_xor_exp(Exp,Op1,Op2,Class,Method),
															inst_descent_of_xor_unique(Ident,Op1,IdentStp,Class,Method),
															not( inst_in_exp(Ident,Op2,Class,Method) ).

 inst_descent_of_modulo_unique(Ident,Exp,Exp,Class,Method) :-
																var_inst(Exp,Ident,Class,Method).



 inst_descent_of_modulo_unique(Ident,Exp,IdentStp,Class,Method) :-
																modulo(Exp,Op1,Op2,Class,Method),
																inst_descent_of_modulo_unique(Ident,Op1,IdentStp,Class,Method),
																not( inst_in_exp(Ident,Op2,Class,Method) ).
% verifica le espressioni composte di somma
  exp_composed_of_add(Exp,Class,Method) :-
										plus(Exp,Op1,Op2,Class,Method),
										(
											inst(Op1,_,Class,Method) ;
											exp_composed_of_add(Op1,Class,Method)
										),
										(
											inst(Op2,_,Class,Method) ;
											exp_composed_of_add(Op2,Class,Method)
										).
	% verifica le espressioni di divisione composte
exp_composed_of_divide(Exp,Class,Method) :-
										divide(Exp,Op1,Op2,Class,Method),
										(
										inst(Op1,_,Class,Method) ;
										exp_composed_of_divide(Op1,Class,Method)
										),
										(
										inst(Op2,_,Class,Method) ;
										exp_composed_of_divide(Op2,Class,Method)
										).
% verifica le espressioni di sottrazione composte
 exp_composed_of_minus(Exp,Class,Method) :-
										minus(Exp,Op1,Op2,Class,Method),
										(
										inst(Op1,_,Class,Method) ;
										exp_composed_of_minus(Op1,Class,Method)
										),
										(
										inst(Op2,_,Class,Method) ;
										exp_composed_of_minus(Op2,Class,Method)
										).
										
% verifica le espressioni composte di and
  exp_composed_of_and(Exp,Class,Method) :-
											and(Exp,Op1,Op2,Class,Method),
											(
											inst(Op1,_,Class,Method) ;
											exp_composed_of_and(Op1,Class,Method)
											),
											(
											inst(Op2,_,Class,Method) ;
											exp_composed_of_and(Op2,Class,Method)
											).
											
  exp_composed_of_or(Exp,Class,Method) :-
											or(Exp,Op1,Op2,Class,Method),
											(
											inst(Op1,_,Class,Method) ;
											exp_composed_of_or(Op1,Class,Method)
											),
											(
											inst(Op2,_,Class,Method) ;
											exp_composed_of_or(Op2,Class,Method)
											).
											
  exp_composed_of_xor(Exp,Class,Method) :-
											or(Exp,Op1,Op2,Class,Method),
											(
											inst(Op1,_,Class,Method) ;
											exp_composed_of_xor(Op1,Class,Method)
											),
											(
											inst(Op2,_,Class,Method) ;
											exp_composed_of_xor(Op2,Class,Method)
											).


 exp_composed_of_mul(Exp,Class,Method) :-

											times(Exp,Op1,Op2,Class,Method),
											(
											inst(Op1,_,Class,Method) ;

											exp_composed_of_mul(Op1,Class,Method)
											),
											(
											inst(Op2,_,Class,Method) ;
											exp_composed_of_mul(Op2,Class,Method)
											).


  exp_descent_of_divide(SubExp,Exp,Class,Method):- SubExp = Exp.
  exp_descent_of_divide(SubExp,Exp,Class,Method):-
												divide(Exp,Op1,Op2,Class,Method),
												exp_descent_of_divide(SubExp,Op1,Class,Method).


  exp_descent_of_and(SubExp,Exp,Class,Method):- SubExp = Exp.
  exp_descent_of_and(SubExp,Exp,Class,Method):-
												and(Exp,Op1,Op2,Class,Method),
												exp_descent_of_and(SubExp,Op1,Class,Method).


  exp_descent_of_or(SubExp,Exp,Class,Method):- SubExp = Exp.
  exp_descent_of_or(SubExp,Exp,Class,Method):-
												or(Exp,Op1,Op2,Class,Method),
												exp_descent_of_or(SubExp,Op1,Class,Method).


  exp_descent_of_xor(SubExp,Exp,Class,Method):- SubExp = Exp.
  exp_descent_of_xor(SubExp,Exp,Class,Method):-
   xor(Exp,Op1,Op2,Class,Method),
   exp_descent_of_xor(SubExp,Op1,Class,Method).

   
  exp_descent_of_modulo(SubExp,Exp,Class,Method):- SubExp = Exp.
  exp_descent_of_modulo(SubExp,Exp,Class,Method):-
   modulo(Exp,Op1,Op2,Class,Method),
   exp_descent_of_modulo(SubExp,Op1,Class,Method).



  exp_descent_of_add_or_leftminus(SubExp,Exp,Class,Method):- SubExp = Exp.
  exp_descent_of_add_or_leftminus(SubExp,Exp,Class,Method):-
   (
    comm_add_exp(Exp,Op1,Op2,Class,Method) ;
    minus(Exp,Op1,Op2,Class,Method)
   ),
   exp_descent_of_add_or_leftminus(SubExp,Op1,Class,Method).

  exp_descent_of_mul(SubExp,Exp,Class,Method):- SubExp = Exp.
  exp_descent_of_mul(SubExp,Exp,Class,Method):-
   comm_mul_exp(Exp,Op1,Op2,Class,Method),
   exp_descent_of_mul(SubExp,Op1,Class,Method).


  scan_r(IN,HierScan,Kind,Range,Stride,IndexIdent,ArrayInstStp,SubScrExp,SubScrPos) :-
    simple_scan(Loop,HierLoop,ScanStm,HierScanStm,Range,Stride,IndexIdent,ArrayInstStp,SubScrExp,SubScrPos),
    HierScan =.. [scan,IN,HierLoop,HierScanStm],
    Kind = k_simple_scan,
    asserisci( scan_r(IN,HierScan,Kind,Range,Stride,IndexIdent,ArrayInstStp,SubScrExp,SubScrPos) ),
    inherit_dep(IN,[Loop,ScanStm]).


  scan_r(IN,HierScan,Kind,Range,Stride,IndexIdent,ArrayInstStp,SubScrExp,SubScrPos) :-
      strip_mined_scan(OutLoop,HierOutLoop,InLoop,HierInLoop,ScanStm,HierScanStm,Range,Stride,IndexIdent,ArrayInstStp,SubScrExp,SubScrPos,StripSize,NumStrips),
        HierScan =.. [strip_mined_scan,IN,HierOutLoop,HierInLoop,HierScanStm],
        Kind = k_strip_mined_scan_constant(StripSize,NumStrips),
        asserisci( scan_r(IN,HierScan,Kind,Range,Stride,IndexIdent,ArrayInstStp,SubScrExp,SubScrPos) ),
        inherit_dep_strip_mined_scan(IN,[OutLoop,InLoop,ScanStm]).



  inherit_dep_strip_mined_scan(Concetto,ListaSottoConc) :- 
    findall( AltroConc, 
      (  
        between(1,Concetto,AltroConc), 
        findall( DepBranch, 
          ( member(DepBranch,[true,false]), 
            ( ( forall( member(SottoConc1,ListaSottoConc), 
                        control_dep(SottoConc1,AltroConc,DepBranch) ), 
                not( member(AltroConc,ListaSottoConc) ) 
              ) -> 
              assert_ifnotalready(control_dep(Concetto,AltroConc,DepBranch)) ; 
              true 
            ),
/* diff: AltroConc deve dipendere da entrambi OutLoop e InLoop */    
            ( ( member(OutLoop,ListaSottoConc,1),
                member(InLoop,ListaSottoConc,2), 
                control_dep(AltroConc,OutLoop,DepBranch), 
                control_dep(AltroConc,InLoop,DepBranch), 
                not( member(AltroConc,ListaSottoConc) )  
              ) ->  
              assert_ifnotalready(control_dep(AltroConc,Concetto,DepBranch)) ; 
              true  
            )     
          ),      
          DepBranchList ), 
        forall( member(SottoConc3,ListaSottoConc), 
                ( 
                  forall( ( data_dep(Type,SottoConc3,AltroConc,DepVar,DepLevel),
                            not( member(AltroConc,ListaSottoConc) ) 
                          ), 
                   assert_ifnotalready(data_dep(Type,Concetto,AltroConc,DepVar,DepLevel))
                  ), 
                  forall( ( data_dep(Type,AltroConc,SottoConc3,DepVar,DepLevel),
                            not( member(AltroConc,ListaSottoConc) ) 
                          ),  
                   assert_ifnotalready(data_dep(Type,AltroConc,Concetto,DepVar,DepLevel))
                  ), 
                  forall( data_dep(Type,SottoConc3,SottoConc3,DepVar,DepLevel), 
                   assert_ifnotalready(data_dep(Type,Concetto,Concetto,DepVar,DepLevel)) 
                  )
                )  
              )
      ),    
      AltroConcList ).

	  
	  
% concetto di simple scan 
% significato: 
% quando ho un simple scan?
simple_scan(
			Loop,					% identificativo loop
			HierLoop,				% è un funtore che identifica la tipologia di loop ( for, while, do while...)
			ScanStm,				% espressione di scan
			HierScanStm,			% tipologia dell espressione di scan
			Range,					% range di scan, è sempre whole_array_scan(range dell'array)
			Stride,					% è fisso, unit_stride
			IndexIdent,				% identificativo indice
			ArrayInstStp,			% puntatore al riferimento all'array
			SubScrExp,				% espressione indice
			SubScrPos				%
			) :-
% se ho un loop prima di tutto
    count_loop_r(Loop,HierLoop,IndexIdent,InitExpStp,LastExpStp,StepExpStp),
% poi ci deve essere una control dep tra il loop e lo statement di scan 	
    control_dep(ScanStm,Loop,true,Class,Method),   
% concetto della KB, riferimento all array
    array_elem_inst(ArrayInstStp,ArrayIdent,SubScrList,Class,Method),
% nello statement di scan c'è il riferimento all'array:
   exp_in_stm(ArrayInstStp,ScanStm,HierScanStm), 
% concetto della KB definizione di un array
    array_var_def(_,ArrayType,NDim,ArrayIdent,ArrayRangesList,Class,Method),
% relazioni di member tra l'espressione del subscript e la lista di subscript    
	member(SubScrExp,SubScrList,SubScrPos),
% relazione di member tra il range di valori che puo assumere l'indice di un array e la lista di ranges	
    member(ArrayDimRange,ArrayRangesList,SubScrPos),
% l'indice nel for deve essere presente nella lista di indici
    inst_in_exp(IndexIdent,SubScrExp),
% condizione sulla inizializzazione ciclo for
    val_inst(InitExpStp,integer,InitValueLB),
% condizione sulla condizione di uscita del ciclo for	
    val_inst(LastExpStp,integer,LastValueLB),
% condizone di incremento del ciclo for, gestito solo l'incremento di tipo ++
    % commento PDS StepExpStp = lnull,
	post_incr(StepExpStp,IndexIdent,Class,Method), % PDS
    Stride = unit_stride,
% nth1 è vero se il valore di init del ciclo for è il primo valore del range dell array
    nth1(1,ArrayDimRange,InitValueRange),
% qui invece controllo se il valore di exit del ciclo for è il secondo valore del range dell array
    nth1(2,ArrayDimRange,LastValueRange),
% qui vado a dire quanto è grande il range dell'array	
    ArrayDimRangeValue is (LastValueRange - InitValueRange + 1),
% e quanto è grande il range del loop?	
    LoopRangeValue is (LastValueLB - InitValueLB + 1),
% e guarda un po devono essere uguali    
	ArrayDimRangeValue == LoopRangeValue,
% ok range è quindi lo scan dell intero array!
    Range = whole_array_scan(LoopRangeValue).

% PDS	
  strip_mined_scan( OutLoop,	  % loop esterno	
					HierOutLoop,  % tipologia loop esterno
					InLoop,       % loop interno
					HierInLoop,   % tipologia loop interno
					ScanStm,      % statement di scan
					HierScanStm,  %	tipologia statement di scan
                    Range,        % range
					Stride,       % passo (fissato)
					InIndexIdent, % indice interno
					ArrayInstStp, % espressione di instanziazione
					SubScrExp,    %
					SubScrPos,    %
                    StripSize,    % size delle strisce
				    NumStrips     % numero di strisce
				) :-
	% loop esterno				
    count_loop_r(OutLoop,HierOutLoop,OutIndexIdent,OutInitExpStp,OutLastExpStp,
                 OutStepExpStp),
	% loop interno			 
    count_loop_r(InLoop,HierInLoop,InIndexIdent,InInitExpStp,InLastExpStp,
                 InStepExpStp),
	% il loop interno si trova dentro il loop esterno			 
    control_dep(InLoop,OutLoop,true),
	% c'è uno scan Statement nel loop interno
    control_dep(ScanStm,InLoop,true),
	% PDS rappresenta il fatto che l'espressione di scan si trova in uno statement di tipo HierScanStm 
    % PDS nota: deve essere modificato exp_in_stm in maniera da essere congruente con la KB aggiornata. 
    exp_in_stm(ArrayInstStp,ScanStm,HierScanStm),
	% PDS commento arr_el_inst(ArrayInstStp,ArrayIdent,SubScrList),
    array_elem_inst(ArrayInstStp,ArrayIdent,SubScrList,Class,Method),
	% PDS commento array_var(ArrayIdent,ArrayType,NDim,ArrayRangesList),
	array_var_def(_,ArrayType,NDim,ArrayIdent,ArrayRangesList,Class,Method),
    member(SubScrExp,SubScrList,SubScrPos),
    member(ArrayDimRange,ArrayRangesList,SubScrPos),
    % condizioni sulle espressioni di inizializzazione dei due loop
	val_inst(OutInitExpStp,integer,OutInitValue),
    val_inst(OutLastExpStp,integer,OutLastValue),
    OutStepExpStp = lnull,
    NumStrips is OutLastValue - OutInitValue + 1,
    ( % l'indice del loop è presente nell'espressione indice
	  inst_in_exp(OutIndexIdent,SubScrExp) ->
      ( 
	    % condizioni sul ciclo for interno
		val_inst(InInitExpStp,integer,InInitValue),
        val_inst(InLastExpStp,integer,InLastValue),
        % l'incremento è fissato come unitario
		InStepExpStp = lnull,
        Stride = unit_stride, 
		% lunghezza della striscia
        StripSize is InLastValue - InInitValue + 1,
        
		% vedi commenti dentro:
		comm_add_exp(SubScrExp,SubScrAddOp1,SubScrAddOp2),
        scal_var_inst(SubScrAddOp2,InIndexIdent),
        ( 
			% questo blocco rappresenta il fatto che l'indice è del tipo :
			% ident_for_interno + ident_for_esterno * lunghezza striscia
		  ( 
			
			comm_mul_exp(SubScrAddOp1,SubScrMulOp1,SubScrMulOp2),
            scal_var_inst(SubScrMulOp2,OutIndexIdent),
            val_inst(SubScrMulOp1,integer,StripSize),
            0 is 1 - InInitValue - (OutInitValue * StripSize)
          ) ;
		  
		    % questo blocco rappresenta il fatto che l'indice è del tipo :
			% ident_for_interno + ( Temp +  lunghezza striscia * ident_for_esterno )
		  ( comm_add_exp(SubScrAddOp1,AddAddOp1,AddAddOp2),
            comm_mul_exp(AddAddOp2,SubScrMulOp1,SubScrMulOp2),
            scal_var_inst(SubScrMulOp2,OutIndexIdent), 
            val_inst(SubScrMulOp1,integer,StripSize),
            val_inst(AddAddOp1,integer,TempValue1),
            TempValue1 is 1 - InInitValue - (OutInitValue * StripSize)
          )
        )
      ) ;
      ( 
        ( 
		
		   % init ciclo for interno: InIndexIdent = OutIndexIdent * StripSize
		  ( 
			comm_mul_exp(InInitExpStp,InInitMulOp1,InInitMulOp2),
            scal_var_inst(InInitMulOp2,OutIndexIdent),
            val_inst(InInitMulOp1,integer,StripSize),
            InInitValue is OutInitValue * StripSize
          ) ;
		   % init ciclo for interno: InIndexIdent = Temp +( StripSize * OutIndexIdent)
          ( comm_add_exp(InInitExpStp,InInitAddOp1,InInitAddOp2),
            comm_mul_exp(InInitAddOp2,InInitMulOp1,InInitMulOp2),
            scal_var_inst(InInitMulOp2,OutIndexIdent),
            val_inst(InInitMulOp1,integer,StripSize),
            val_inst(InInitAddOp1,integer,TempValue2),
            InInitValue is TempValue2 + (OutInitValue * StripSize)
          ) 
        ),
        ( 
		  % condizione uscita ciclo for interno:
		  % InIndexIdent <(?) OutIndexIdent * StripSize
		  ( comm_mul_exp(InLastExpStp,InLastMulOp1,InLastMulOp2),
            scal_var_inst(InLastMulOp2,OutIndexIdent),
            val_inst(InLastMulOp1,integer,StripSize),
            0 is InInitValue - 1 - (OutInitValue * StripSize) + StripSize
          ) ;
		  
		  % condizione uscita ciclo for interno:
		  % InIndexIdent <(?) TempValue + (StripSize * OutIndexIdent)
          ( comm_add_exp(InLastExpStp,InLastAddOp1,InLastAddOp2),
            comm_mul_exp(InLastAddOp2,InLastMulOp1,InLastMulOp2),
            scal_var_inst(InLastMulOp2,OutIndexIdent),
            val_inst(InLastMulOp1,integer,StripSize),
            val_inst(InLastAddOp1,integer,TempValue3),
            TempValue3 is InInitValue - 1 - OutInitValue * StripSize + StripSize
          ) 
        ),
		% statement di incremento ciclo for interno: nessuna condizione
        InStepExpStp = lnull,
        ( 
		  % l'indice della matrice è proprio l'indice interno
		  ( 
			scal_var_inst(SubScrExp,InIndexIdent),
            InInitValue is 1
          ) ;
          % l'indice è tempvalue + InIndexIdent
		  ( comm_add_exp(SubScrExp,SubScrAddOp1,SubScrAddOp2),
            scal_var_inst(SubScrAddOp2,InIndexIdent),
            val_inst(SubScrAddOp1,integer,TempValue4),
            TempValue4 is 1 - InInitValue
          )
        )
      )
    ),
    nth1(1,ArrayDimRange,InitValueRange),
    nth1(2,ArrayDimRange,LastValueRange),
    ArrayDimRangeValue is (LastValueRange - InitValueRange + 1),
    Range = whole_array_scan(ArrayDimRangeValue).

	
% PDS 	
% array_update_values_r(IN,															
%                       array_update_values(IN,HierScanDef,HierScanUse,HierElUp),
%                       ElemStruct,
%		    			SubScrPos,
%					    IndexIdent) :-
  array_update_values_r(IN,
                      array_update_values(IN,HierScanDef,HierScanUse,HierElUp),
                      ElemStruct,SubScrPos,IndexIdent) :-
    elem_update_r(ElUp,HierElUp,ElemStruct),
    % che cosa sto aggiornando? un array con i puntatori agli statement di definizione e uso.
	ElemStruct = elem_update_s(ArrayIdent,[ArrayDefStp,ArrayUseStp],_,_),
	% pppp nota : array_var_def 
	array_var(ArrayIdent,_,_,_),
	%c'è uno scan di un array 
    scan_r(ScanDef,HierScanDef,KindScan,whole_array_scan(RangeValue),
           unit_stride,IndexIdent,ArrayDefStp,DefSubScrExp,SubScrPos),
    % c'è una dipendenza di controllo fra il loop dove si fa lo scan e l'istruzione di update
	control_dep(ElUp,ScanDef,true),
	% c'è un altro scan di un array
    scan_r(ScanUse,HierScanUse,KindScan,whole_array_scan(RangeValue),
           unit_stride,IndexIdent,ArrayUseStp,UseSubScrExp,SubScrPos),
    % c'è una dipendenza di controllo fra il loop dove si fa lo scan e l'istruzione di update
	control_dep(ElUp,ScanUse,true),
	% nota: HiesrScanDef e HierScanUse sono tipicamente for_r(A,B) quindi quello che faccio è 
	%		associare for_r a conceptname, Scandef a A etc etc..
    HierScanDef =.. [ConceptName,ScanDef|ScanDefHierList],
    append(ScanDefHierListButLast,[HierScanDefStm],ScanDefHierList),
	%PDS secondo me è da modificare l'ordine degli argomenti mettendo ScanDefHierListButLast alla fine.
    HierScanUse =.. [ConceptName,ScanUse|ScanUseHierList],
    append(ScanUseHierListButLast,[HierScanUseStm],ScanUseHierList),
    %PDS secondo me è da modificare l'ordine degli argomenti mettendo ScanUseHierListButLast alla fine.
	% se ho un uguaglianza fra le due liste...
	ScanDefHierListButLast == ScanUseHierListButLast,
    asserisci( array_update_values_r(IN,
                      array_update_values(IN,HierScanDef,HierScanUse,HierElUp),
                      ElemStruct,SubScrPos,IndexIdent) ),
    inherit_dep(IN,[ScanDef,ScanUse,ElUp]).

%PDS
%   array_shift_values_r(IN,
%						 array_shift_values(IN,HierScanDef,HierScanUse,HierElSh),
%						 ElemStruct,
%						 SubScrPos,
%						 IndexIdent) :-  
  array_shift_values_r(IN,
                      array_shift_values(IN,HierScanDef,HierScanUse,HierElSh),
                      ElemStruct,SubScrPos,IndexIdent) :-  
  elem_shift_r(ElSh,HierElSh,ElemStruct),
  ElemStruct = elem_update_s(ArrayIdent,[ArrayDefStp,ArrayUseStp],_,_),
		array_var(ArrayIdent,_,_,_),
  scan_r(ScanDef,HierScanDef,KindScan,whole_array_scan(RangeValue),
         unit_stride,IndexIdent,ArrayDefStp,DefSubScrExp,SubScrPos),
  control_dep(ElSh,ScanDef,true),
  scan_r(ScanUse,HierScanUse,KindScan,whole_array_scan(RangeValue),
         unit_stride,IndexIdent,ArrayUseStp,UseSubScrExp,SubScrPos),
  control_dep(ElSh,ScanUse,true),
  HierScanDef =.. [ConceptName,ScanDef|ScanDefHierList],
  append(ScanDefHierListButLast,[HierScanDefStm],ScanDefHierList),
  HierScanUse =.. [ConceptName,ScanUse|ScanUseHierList],
  append(ScanUseHierListButLast,[HierScanUseStm],ScanUseHierList),
  ScanDefHierListButLast == ScanUseHierListButLast,
  asserisci( array_shift_values_r(IN,
                    array_shift_values(IN,HierScanDef,HierScanUse,HierElSh),
                    ElemStruct,SubScrPos,IndexIdent) ),
  inherit_dep(IN,[ScanDef,ScanUse,ElSh]).

  shift_reduction_r(IN,HierRed,ElemAccumStruct,ArrayReducedStruct) :-
/* puo' essere anche: elem_scale; controllare e modificare */
    elem_shift_r(ElSh,HierElSh,ElemAccumStruct),
    ElemAccumStruct =
      elem_update_s(ElemIdent,[ElemDefStp,ElemUseStp],ShiftCompList,_),
    last(ElemDefStm,ShiftCompList),
    nth1(1,ShiftCompList,ElemUseStm),
    scan_r(Scan,HierScan,KindScan,whole_array_scan(RangeValue),
           unit_stride,IndexIdent,ArrayInstStp,SubScrExp,SubScrPos),
    control_dep(ElSh,Scan,true),
/* dip. loop carried che chiude il ciclo con dep_chain; controllare ev. probl.*/
    data_dep(true,ElemUseStm,ElemDefStm,ElemIdent,DepLevel),
    DepLevel \== 0,
 /* studiare perche' non basta: DepLevel = 1 */
    HierScan =.. HierScanList,
    last(HierScanStm,HierScanList),
    assign_r(ScanStm,HierScanStm,LhsExpStp,RhsExpStp),
    inst_in_exp(ArrayIdent,ArrayInstStp,RhsExpStp), /*per ctrl. che sia un uso*/
    dep_chain(HierChainScanDef,ScanStm,ElemDefStm,ChainScanDefListStm,
              ChainScanDefListVarButFirst),
    append([ArrayIdent],ChainScanDefListVarButFirst,ChainScanDefListVar),
/* definire per bene le prop. della riduzione, e appl. a ChainScanDefListStm */
    not( inst_in_exp(IndexIdent,ElemDefStp) ), 
    not(( inst_in_exp(VarIdent,VarStp,ElemDefStp),
          var_inst(VarStp,VarIdent),
          data_dep(true,Stm,Scan,IndexIdent,AnyLevel1), /* check il livello */
                            /* att: non check i sbcn di Scan*/
          assign_r(Stm,_,_,_),
          dep_chain(_,Stm,ElemDefStm,_,ListVar),
          last(VarIdent,ListVar)
       )),
    not(( data_dep(true,ElemUseStm,Stm2,ElemIdent,AnyLevel2), /* check il liv.*/
          Stm2 \== ElemUseStm, 
          control_dep(Stm2,Scan,true),
          Stm2 \== ElemDefStm
       )),
    ( ScanStm == ElemDefStm  -> 
        HierRed = shift_reduction(IN,HierScan,HierElSh) ;
        HierRed = shift_reduction(IN,HierScan,HierElSh,HierChainScanDef)
    ),
    ArrayReducedStruct =
      array_reduced_s([ArrayIdent,ArrayInstStp,SubScrExp,SubScrPos],
                      IndexIdent,
                      ChainScanDefListStm,ChainScanDefListVar),
    asserisci(shift_reduction_r(IN,HierRed,ElemAccumStruct,ArrayReducedStruct)),
    ( ScanStm == ElemDefStm  ->
        inherit_dep(IN,[Scan,ElSh]) ;
        inherit_dep(IN,[Scan,ElSh|ChainScanDefListStm])
    ).

  nonsimul_relaxation_step_r(IN,HierNSRStep,NSRStepArrayStruct) :-
    array_update_values_r(AUVal,HierAUVal,AUValElUpStruct,AUValSubScrPos,
                           AUValIndexIdent),
    shift_reduction_r(Red,HierRed,RedAccumStruct,RedArrStruct),
    control_dep(Red,AUVal,true),
    RedArrStruct = array_reduced_s([ArrIdent,_,_,ArrSubScrPos],_,_,_),
    AUValSubScrPos == ArrSubScrPos,
    AUValElUpStruct = elem_update_s(ArrIdent,_,AUValElUpStmList,_),
    HierRed =.. [_,Red,_,HierRedElSh|_],
    HierRedElSh =..[_,_,HierRedElUp], HierRedElUp =.. [_,RedElUp|_],
    HierAUVal =.. [_,AUVal,_,_,HierAUValElUp],
    HierAUValElUp =.. [_,AUValElUp|_],
    last(AUValElUpDefStm,AUValElUpStmList),
    RedAccumStruct = elem_update_s(RedAccumIdent,_,RedAccumStmList,_),
    last(RedAccumDefStm,RedAccumStmList),
    ( RedElUp == AUValElUp ->
      ( HierNSRStep = nonsimul_relaxation_step(IN,HierAUVal,HierRed),
        CompList = [AUVal,Red]
      ) ;
      ( dep_chain(HierChain,RedAccumDefStm,AUValElUpDefStm,ChainStmList,_),
/*controllare che venga asserito questo fatto; altrimenti, ristrutturare tutto
        data_dep(true,AUVal,Red,RedAccumIdent,0), */
        HierNSRStep = nonsimul_relaxation_step(IN,HierAUVal,HierRed,HierChain),
        CompList = [AUVal,Red|ChainStmList]
      )
    ),
    NSRStepArrayStruct = nsr_step_array_s(ArrIdent,ArrSubScrPos),
    asserisci( nonsimul_relaxation_step_r(IN,HierNSRStep,NSRStepArrayStruct) ),
    inherit_dep(IN,CompList).


  dot_product_r(IN,HierDotProd,AccumStruct,Arr1Struct,Arr2Struct) :-
    shift_reduction_r(Red1,HierRed1,AccumStruct,Arr1Struct),
    shift_reduction_r(Red2,HierRed2,AccumStruct,Arr2Struct),
                      /* restr: = AccumStruct per le due rid */
    Red1 \== Red2,
    HierRed1 =.. [shift_reduction,Red1,HierScan1,HierElSh1|Dummy1],
    HierRed2 =.. [shift_reduction,Red2,HierScan2,HierElSh2|Dummy2],
    HierElSh1 == HierElSh2,   /* restr: = elem_shift per le due rid (ridond.) */
    HierScan1 =.. [ScanName,Scan1|Scan1HierList],
    append(Scan1HierListButLast,[HierScan1Stm],Scan1HierList),
    HierScan2 =.. [ScanName,Scan2|Scan2HierList], 
    append(Scan2HierListButLast,[HierScan2Stm],Scan2HierList),
    Scan1HierListButLast == Scan2HierListButLast,
    /* i due scan devono essere comp. dagli stessi count loop(s) */
    Arr1Struct =
      array_reduced_s([Arr1Ident,Arr1InstStp,Arr1SubScrExp,Arr1SubScrPos],
                      IndexIdent,
                      Arr1ChainListStm,Arr1ChainListVar),
    Arr2Struct =
      array_reduced_s([Arr2Ident,Arr2InstStp,Arr2SubScrExp,Arr2SubScrPos],
                      IndexIdent,  /* restr: = IndexIdent per le due strutt. */
                      Arr2ChainListStm,Arr2ChainListVar),
    not( same_exp(Arr1InstStp,Arr2InstStp) ), /* forse ridond. */
    equiv_exp(Arr1SubScrExp,Arr2SubScrExp),
/* migliorare con simb. an. e/o consid. le caratt. dello scan */
    append(DistArr1ChainListStm,CommonArr12ChainListStm,Arr1ChainListStm),
    append(DistArr2ChainListStm,CommonArr12ChainListStm,Arr2ChainListStm),
    forall( member(DistArr1ChainStm,DistArr1ChainListStm,Pos1),
            ( assign_r(DistArr1ChainStm,_,_,DistArr1ChainStmRhs),
              member(DistArr1ChainVar,Arr1ChainListVar,Pos1),
              inst_descent_of_mul_or_leftdiv_unique(DistArr1ChainVar,
                                                    DistArr1ChainStmRhs,_),
              not( inst_in_exp_notcheck_subexps(IndexIdent,DistArr1ChainStmRhs,
                                               [Arr1SubScrExp,Arr2SubScrExp]) )
/* ridondante con il check di sotto; ma serve per contr. Scan1Stm, che non viene
  contr. dal check di sotto perche' e' un subconc. di Scan1 (data_dep n.f.) */
            )
          ),
    forall( member(DistArr2ChainStm,DistArr2ChainListStm,Pos2),
            ( assign_r(DistArr2ChainStm,_,_,DistArr2ChainStmRhs),
              member(DistArr2ChainVar,Arr2ChainListVar,Pos2),
              inst_descent_of_mul_or_leftdiv_unique(DistArr2ChainVar,
                                                    DistArr2ChainStmRhs,_),
              not( inst_in_exp_notcheck_subexps(IndexIdent,DistArr2ChainStmRhs,
                                               [Arr1SubScrExp,Arr2SubScrExp]) )
            )
          ),
    length(DistArr1ChainListStm,Length1),
    length(Temp1ListLength,Length1),
    append(Temp1ListLength,TailArr1ChainListVar,Arr1ChainListVar),
    length(DistArr2ChainListStm,Length2),
    length(Temp2ListLength,Length2),
    append(Temp2ListLength,TailArr2ChainListVar,Arr2ChainListVar),
    TailArr1ChainListVar = [LastDistArr1ChainVar|CommonSubList],
    TailArr2ChainListVar = [LastDistArr2ChainVar|CommonSubList],
      /* restr: controllo sulla parte comune: = CommonSubList */ 
    nth1(1,CommonArr12ChainListStm,FirstCommonArr12ChainStm),
    assign_r(FirstCommonArr12ChainStm,_,_,FirstCommonArr12ChainStmRhs),
    sub_exp_in_exp(RootCommonExp,FirstCommonArr12ChainStmRhs),
    exp_composed_of_mul(RootCommonExp),
    inst_in_exp(LastDistArr1ChainVar,RootCommonExp),
    inst_in_exp(LastDistArr2ChainVar,RootCommonExp),
    inst_descent_of_add_or_leftminus_or_mul_or_leftdiv_unique(
      LastDistArr2ChainVar,FirstCommonArr12ChainStmRhs,_),
    forall( member(CommonArr12ChainStm,CommonArr12ChainListStm,Pos3),
            ( assign_r(CommonArr12ChainStm,_,_,CommonArr12ChainStmRhs),
              member(Arr12ChainVar,TailArr1ChainListVar,Pos3),
              inst_descent_of_add_or_leftminus_or_mul_or_leftdiv_unique(
                                      Arr12ChainVar,CommonArr12ChainStmRhs,_)
            )
          ),
    AccumStruct = elem_update_s(_,_,AccumChainListStm,_),
    last(AccumDefStm,AccumChainListStm),
    not(( data_dep(true,TmpStm,Scan1,IndexIdent,AnyLevel),
                           /* non check i sbcn di Scan; check il livello */
          assign_r(TmpStm,_,_,TmpStmRhs),
          inst_in_exp_notcheck_subexps(IndexIdent,TmpStmRhs,
                                       [Arr1SubScrExp,Arr2SubScrExp]),
          dep_chain(_,TmpStm,AccumDefStm,_,_)
       )),
    HierDotProd = dot_product(IN,HierRed1,HierRed2),
    asserisci(dot_product_r(IN,HierDotProd,AccumStruct,Arr1Struct,Arr2Struct) ),
    inherit_dep(IN,[HierRed1,HierRed2]).

/*
  matrix_vector_multiply_r(IN,HierMVMul,
*/

  array_updated_from_temp_var_in_count_loop_r(IN,using_temp_var(IN,HierTempUsing),
      Loop,IndexIdent,TempInstStp,TempUpdate,ArrayIdent,ArrayInstStp) :-
    scal_var_inst(TempInstStp,TempIdent),
    assign_r(TempUsing,HierTempUsing,ArrayInstStp,TempUsingRhs),
    inst_in_exp(TempIdent,TempUsingRhs),
    arr_el_inst(ArrayInstStp,ArrayIdent,Dummy1),
    inst_in_exp(IndexIdent,ArrayInstStp),
    control_dep(TempUsing,Loop,true),
    data_dep(true,TempUsing,TempUpdate,TempIdent),
    asserisci( array_updated_from_temp_var_in_count_loop_r(IN,
               using_temp_var(IN,HierTempUsing),Loop,IndexIdent,TempInstStp,
               TempUpdate,ArrayIdent,ArrayInstStp) ).
    
  matrix_vector_multiply_r(IN,MVStruct,
                         Array1Ident,ScPrPosInArray1,MVPosInArray1,
                         Array2Ident,ScPrPosInArray2,
                         ResArrayIdent,MVPosInResArray,
                         SubScrListArrEl2,SubScrListResArr) :-
    scalar_product_r(ScalarProd,HierScalarProd,AccumScPrVar,
                   Array1Ident,SubScrListArrEl1,ScPrPosInArray1,
                   Array2Ident,SubScrListArrEl2,ScPrPosInArray2),
    arg(2,HierScalarProd,HierScPrLoop),
    arg(1,HierScPrLoop,ScPrLoop),
    arg(3,HierScalarProd,HierScPrUpdateAccum),
    arg(1,HierScPrUpdateAccum,ScPrUpdateAccum),
    ( strip_mined_scan_r(Loop,HierLoop,IndexIdent,Array1InstStp,SubScrExpArr1,
                         StripSize,NumStrips) ;
      count_loop_r(Loop,HierLoop,IndexIdent,InitExpStp,LastExpStp,StepExpStp)
    ),
/*
      count_loop_r(Loop,HierLoop,IndexIdent,InitExpStp,LastExpStp,StepExpStp),
*/
    control_dep(ScPrUpdateAccum,Loop,true),
    member(SubScrExpArr1,SubScrListArrEl1,MVPosInArray1),
    MVPosInArray1 \== ScPrPosInArray1,
    ( functor(HierLoop,strip_mined_scan,4) ->
      true ;
      ( scal_var_inst(SubScrExpArr1,IndexIdent),
        array_var(Array1Ident,ArrayType,NDim,Array1RangesList),
        member(Range,Array1RangesList,MVPosInArray1)
        /* implementare: LastExpStp - InitExpStp + 1 = Range */
      )
    ),
/*  forall(
           (member(SubScrExpArr2,SubScrListArrEl2,PosInArray2),
            PosInArray2 \== ScPrPosInArray2,
            inst_in_exp(VarIdent,SubScrExpArr2),
            var_inst(Dummy10,VarIdent)
           ),
           not(( data_dep(true,ScPrUpdateAccum,Stm,VarIdent),
                 control_dep(Stm,Loop,true)
              ))
          ), */
    arg(2,AccumScPrVar,ScPrAccumInstList),
    member(ScPrAccumStp,ScPrAccumInstList,2),
    ( ( arr_el_inst(ScPrAccumStp,ResArrayIdent,SubScrListResArr),
        Temp1List = []
      ) ;
      ( array_updated_from_temp_var_in_count_loop_r(AccumUsing,HierAccumUsing,
                               Loop,IndexIdent,ScPrAccumStp,ScPrUpdateAccum,
                                              ResArrayIdent,ResArrayInstStp),
/*
        ( control_dep(AccumUsing,ScPrLoop,true) ->
          ( count_loop_r(ScPrloop,HierScPrLoop,ScPrLoopIndexIdent,Dummy1,Dummy2,Dummy3),
            not( inst_in_exp(ScPrLoopIndexIdent,ResArrStp) )
          ) ;
          true
        ),
*/
        arr_el_inst(ResArrayInstStp,ResArrayIdent,SubScrListResArr),
        Temp1List = [HierAccumUsing]
      )
    ),
    member(SubScrExpResArr,SubScrListResArr,MVPosInResArray),
    equiv_exp(SubScrExpArr1,SubScrExpResArr),
    append([matrix_vector_multiply,IN,HierLoop,HierScalarProd],Temp1List,Temp2List),
    MVStruct =.. Temp2List,
    asserisci( matrix_vector_multiply_r(IN,MVStruct,Array1Ident,ScPrPosInArray1,
               MVPosInArray1,Array2Ident,ScPrPosInArray2,ResArrayIdent,
               MVPosInResArray,SubScrListArrEl2,SubScrListResArr) ),
    inherit_dep(IN,[ScalarProd,Loop]).

  matrix_matrix_multiply_r(IN,matrix_matrix_multiply(IN,HierLoop,HierMatrVecMul),
                         Array1Ident,ScPrPosInArray1,MmPosInArray1,
                         Array2Ident,ScPrPosInArray2,MmPosInArray2,
                         ResArrayIdent,MmPos1InResArray,MmPos2InResArray) :-
    matrix_vector_multiply_r(MatrVecMul,HierMatrVecMul,
                           Array1Ident,ScPrPosInArray1,MmPosInArray1,
                           Array2Ident,ScPrPosInArray2,
                           ResArrayIdent,MmPos1InResArray,
                           SubScrListArr2,SubScrListResArr),
    arg(2,HierMatrVecMul,HierMVLoop),
    arg(1,HierMVLoop,MVLoop),
    arg(3,HierMatrVecMul,HierScalarProd),
    arg(1,HierScalarProd,ScalarProd),
    arg(2,HierScalarProd,HierScPrLoop),
    arg(1,HierScPrLoop,ScPrLoop),
    arg(3,HierScalarProd,HierScPrUpdateAccum),
    arg(1,HierScPrUpdateAccum,ScPrUpdateAccum),
    ( strip_mined_scan_r(Loop,HierLoop,IndexIdent,Array2InstStp,SubScrExpArr2,
                         StripSize,NumStrips) ;
      count_loop_r(Loop,HierLoop,IndexIdent,InitExpStp,LastExpStp,StepExpStp)
    ),
/*
      count_loop_r(Loop,HierLoop,IndexIdent,InitExpStp,LastExpStp,StepExpStp),
*/
    control_dep(ScPrUpdateAccum,Loop,true),
/* in effetti serve, ma rallenta meledettamente 
    abs_control_dep(MVLoop,Loop,true),
*/
    member(SubScrExpArr2,SubScrListArr2,MmPosInArray2),
    MmPosInArray2 \== ScPrPosInArray2,
    ( functor(HierLoop,strip_mined_scan,4) ->
      true ;
      ( scal_var_inst(SubScrExpArr2,IndexIdent),
        array_var(Array2Ident,ArrayType,NDim,Array2RangesList),
        member(Range,Array2RangesList,MmPosInArray2)
        /* implementare: LastExpStp - InitExpStp + 1 = Range */
      )
    ),
    member(SubScrExpResArr,SubScrListResArr,MmPos2InResArray),
    equiv_exp(SubScrExpArr2,SubScrExpResArr),
    MmPos1InResArray \== MmPos2InResArray,
    asserisci( matrix_matrix_multiply_r(IN,
               matrix_matrix_multiply(IN,HierLoop,HierMatrVecMul),Array1Ident,
               ScPrPosInArray1,MmPosInArray1,Array2Ident,ScPrPosInArray2,
               MmPosInArray2,ResArrayIdent,MmPos1InResArray,MmPos2InResArray) ),
    inherit_dep(IN,[MatrVecMul,Loop]).


/************************** fine regole professore **********************************/


/**************** nuovi concetti *********************************************/

swap_r(IdentVar1,IdentVar2,SwapSourceStp,SwapSinkStp,Var2AssignStp,Class,Method) :-	
							   (
							     (
								(
									data_dep('true',SwapSinkStp,SwapSourceStp,IdentSwap,_,Class,Method),
									assign_r(IDswap,assign(IDswap,SwapSourceStp),SwapSourceStp,Class,Method)
								),
								(
									data_dep('anti',SwapSinkStp,Var2AssignStp,IdentVar2,_,Class,Method),
									assign_r(IDvar2,assign(IDvar2,Var2AssignStp),Var2AssignStp,Class,Method)
								),
								(	
									data_dep('anti',Var2AssignStp,SwapSourceStp,IdentVar1,_,Class,Method),
									assign_r(IDvar1,assign(IDvar1,SwapSourceStp),SwapSourceStp,Class,Method)
								)
							     ),
							     (
							    		control_dep(SwapSourceStp,Stp,_,Class,Method),
							    		control_dep(SwapSinkStp,Stp,_,Class,Method),
							    		control_dep(Var2AssignStp,Stp,_,Class,Method)
							      ),
								not( data_dep('output',_,Var2AssignStp,_,_,Class,Method) )
							     );
							   (
							     (
								(
									data_dep('true',SwapSinkStp,SwapSourceStp,IdentSwap,_,Class,Method),
									assign_r(IDswap,assign(IDswap,SwapSourceStp),SwapSourceStp,Class,Method)
								),
								(
									data_dep('anti',DummyStp,SwapSourceStp,IdentVar2,_,Class,Method),
									assign_r(IDdummy,assign(IDdummy,DummyStp),DummyStp,Class,Method)
								),
								(
									data_dep('output',Var2AssignStp,DummyStp,IdentVar2,_,Class,Method),
									assign_r(IDvar2,assign(IDvar2,Var2AssignStp),Var2AssignStp,Class,Method)
								),
								(	
									data_dep('anti',SwapSinkStp,Var2AssignStp,IdentVar1,_,Class,Method),
									assign_r(IDvar1,assign(IDvar1,SwapSinkStp),SwapSinkStp,Class,Method)
								)
							     ),
							     (
							    		control_dep(SwapSourceStp,Stp,_,Class,Method),
							    		control_dep(SwapSinkStp,Stp,_,Class,Method),
							    		control_dep(Var2AssignStp,Stp,_,Class,Method)
							     )
							   ),
							   asserta( swap(IdentVar1,IdentVar2) ).

array_inversion_r(IdentArray,Class,Method) :-  (
							     	swap_r(IdentVar2,IdentVar1,SwapSourceStp,SwapSinkStp,Var2AssignStp,Class,Method),
							     	IdentVar1 == IdentVar2,
							     	IdentArray = IdentVar1
							     ),
							     (
								control_dep(SwapSourceStp,Stp,_,Class,Method),
								control_dep(SwapSinkStp,Stp,_,Class,Method),
								control_dep(Var2AssignStp,Stp,_,Class,Method)
							     ),								
							     for_r(IDfor,for(IDfor,Stp),InitStp,Stp,IncrStp,Class,Method),
							     asserta( array_inversion(IdentArray) ).

array_sort_r(IdentArray,Class,Method) :- 	     (
		        					swap_r(IdentVar2,IdentVar1,SwapSourceStp,SwapSinkStp,Var2AssignStp,Class,Method),
								IdentVar1 == IdentVar2,
			  					IdentArray = IdentVar1
							     ),
							     (
			  					control_dep(SwapSourceStp,IfStp,_,Class,Method),
			  					control_dep(SwapSinkStp,IfStp,_,Class,Method),
			  					control_dep(Var2AssignStp,IfStp,_,Class,Method)
				 			     ),								
			 				     (
			  					if_r(IDif,if(IDif,IfStp),IfStp,Class,Method),
			  					control_dep(IfStp,InnerForStp,_,Class,Method),
			  					nested_for_r(Nfor,InnerForStp)
			 				     ),				  
			 				     asserta( array_sort(IdentArray) ).

nested_for_r(Nfor,InnerForStp) :- 		     (
			  					for_r(IDfor,for(IDfor,InnerForStp),InitInnerStp,InnerForStp,IncrInnerStp,Class,Method),
			  					control_dep(InnerForStp,OuterForStp,_,Class,Method),
			  					for_r(IDfor2,for(IDfor2,OuterForStp),InitOuterStp,OuterForStp,IncrOuterStp,Class,Method),
			  					Nfor is 2,
								asserta( nested_for(Nfor) ),!	
			  				     );
			 				     (
		        					for_r(IDfor,for(IDfor,InnerForStp),InitInnerStp,InnerForStp,IncrInnerStp,Class,Method),
			  					control_dep(InnerForStp,MiddleForStp,_,Class,Method),
			  					for_r(IDfor2,for(IDfor2,MiddleForStp),InitMiddleStp,MiddleForStp,IncrMiddleStp,Class,Method),
			  					control_dep(MiddleForStp,OuterForStp,_,Class,Method),
			  					for_r(IDfor3,for(IDfor3,OuterForStp),InitOuterStp,OuterForStp,IncrOuterStp,Class,Method),
			  					Nfor is 3,
								asserta( nested_for(Nfor) ),!	
			  				     ).

% count_loop_r(ID,count_loop(ID,X),CntVarIdent,InitExpStp,StepExpStp)
% ID				id del loop ( che poi è l'espressione di uscita nel caso sia un ciclo for
% count_loop(ID,X)	funtore 
% CntVarIdent		variabile contatore 
% InitExpStp		espressione di inizializzazione
% StepExpStp		espressione di incremento
% quando ho un count loop?
% PDS commento count_loop_r(ID,count_loop(ID,X),CntVarIdent,InitExpStp,StepExpStp) :-	
count_loop_r(ID,count_loop(ID,X),CntVarIdent,InitExpStp,LastExpStp,StepExpStp) :- % PDS
								 (  
									for_r(IDfor,X,InitExpStp,LastExpStp,StepExpStp,Class,Method),
										% PDS commento scalar_var_inst(CntVarIdent,InitExpStp,Class,Method),
										% qui vuole imporre che la variabile del ciclo for è CntVarIdent	
										scalar_var_inst(InitExpStp,CntVarIdent,Class,Method),% PDS 
									% PDS commento ID=Stp, 
									ID=IDfor,% PDS
									% PDS nota: ho trovato quello che cercavo. asserto e non faccio il backtracking
									% PDS commento asserta( count_loop(ID,count_loop(ID,X),CntVarIdent,InitExpStp,StepExpStp) ),!
									asserta( count_loop(ID,count_loop(ID,X),CntVarIdent,InitExpStp,LastExpStp,StepExpStp) ),! % PDS
								  )
								%  ;
								%  % PDS un count_loop può essere anche un while: nota , non testato.
								%(
								%	while_r(IDwhile,X,Stp,Class,Method),
								%	control_dep(InitStp,Stp,_,Class,Method),
								%	(
								%		post_decr(InitStp,VarDefStp,Class,Method);
								%		post_incr(InitStp,VarDefStp,Class,Method);
								%		pre_decr(InitStp,VarDefStp,Class,Method);
								%		pre_incr(InitStp,VarDefStp,Class,Method)	
								%	),
								%	scalar_var_def(CntVarIdent,VarDefStp,Class,Method),
								%	InitExpStp = InitStp,
                                %                     StepExpStp = InitExpStp,
								%	not( control_dep(VarDefStp,Stp,_,Class,Method) ),
								%	ID=Stp,
								%	asserta( count_loop(ID,count_loop(ID,X),CntVarIdent,InitExpStp,StepExpStp) ),!
								% );
								%% PDS un count_loop può essere anche un do while: nota: non testato
								%(
								%	do_while_r(IDdo_while,X,Stp,Class,Method),
								%	control_dep(InitStp,Stp,_,Class,Method),
								%	(
								%		post_decr(InitStp,VarDefStp,Class,Method);
								%		post_incr(InitStp,VarDefStp,Class,Method);
								%		pre_decr(InitStp,VarDefStp,Class,Method);
								%		pre_incr(InitStp,VarDefStp,Class,Method)	
								%	),
								%	scalar_var_def(CntVarIdent,VarDefStp,Class,Method),
								%	InitExpStp = InitStp,
                                %                     StepExpStp = InitExpStp,
								%	not( control_dep(VarDefStp,Stp,_,Class,Method) ),
								%	ID=Stp,
								%	asserta( count_loop(ID,count_loop(ID,X),CntVarIdent,InitExpStp,StepExpStp) ),!
								%  )
								.