/* regole base */

  member(X,[X|Xs],1).
  member(X,[Y|Ys],Pos) 		:- member(X,Ys,Pos_sofar), Pos is Pos_sofar+1.

  nonmember(X,[Y|Ys]) 		:- X \== Y, nonmember(X,Ys).
  nonmember(X,[]).

  subterm(Term,Term).
  subterm(Sub,Term) 		:- not(atomic(Term)), functor(Term,F,N), subterm(N,Sub,Term).
  subterm(N,Sub,Term) 		:- N > 1, N1 is N-1, subterm(N1,Sub,Term).
  subterm(N,Sub,Term) 		:- arg(N,Term,Arg), subterm(Sub,Arg).

  subterm_from_sec(Term,Term).
  subterm_from_sec(Sub,Term) 	:- not(atomic(Term)), functor(Term,F,N), subterm_from_sec(N,Sub,Term).
  subterm_from_sec(N,Sub,Term) 	:- N > 2, N1 is N-1, subterm_from_sec(N1,Sub,Term).
  subterm_from_sec(N,Sub,Term) 	:- arg(N,Term,Arg), subterm_from_sec(Sub,Arg).

/*****************************************************************************************************/

/* regole base sugli operatori unari e binari */

  same_exp(X,Y) :- X==Y.

  comm_add_exp(Stp,Op1Stp,Op2Stp,Class,Method) :- 		plus(Stp,Op1Stp,Op2Stp,Class,Method) ;
                                     				plus(Stp,Op2Stp,Op1Stp,Class,Method).

  comm_mul_exp(Stp,Op1Stp,Op2Stp,Class,Method) :- 		times(Stp,Op1Stp,Op2Stp,Class,Method) ;
                                     				times(Stp,Op2Stp,Op1Stp,Class,Method).

  comm_equal_exp(Stp,Op1Stp,Op2Stp,Class,Method) :- 		equal(Stp,Op1Stp,Op2Stp,Class,Method) ;
                                     				equal(Stp,Op2Stp,Op1Stp,Class,Method).

  comm_and_exp(Stp,Op1Stp,Op2Stp,Class,Method) :- 		and(Stp,Op1Stp,Op2Stp,Class,Method) ;
                                     				and(Stp,Op2Stp,Op1Stp,Class,Method).

  comm_and_and_exp(Stp,Op1Stp,Op2Stp,Class,Method) :- 	and_and(Stp,Op1Stp,Op2Stp,Class,Method) ;
                                     				and_and(Stp,Op2Stp,Op1Stp,Class,Method).

  comm_or_exp(Stp,Op1Stp,Op2Stp,Class,Method) :- 		or(Stp,Op1Stp,Op2Stp,Class,Method);
                                    				or(Stp,Op2Stp,Op1Stp,Class,Method).

  comm_or_or_exp(Stp,Op1Stp,Op2Stp,Class,Method) :- 		or_or(Stp,Op1Stp,Op2Stp,Class,Method);
                                    				or_or(Stp,Op2Stp,Op1Stp,Class,Method).

  comm_xor_exp(Stp,Op1Stp,Op2Stp,Class,Method) :- 		xor(Stp,Op1Stp,Op2Stp,Class,Method);
                                    				xor(Stp,Op2Stp,Op1Stp,Class,Method).

  comm_not_equal_exp(Stp,Op1Stp,Op2Stp,Class,Method) :- 	not_equal(Stp,Op1Stp,Op2Stp,Class,Method) ;
                                    				not_equal(Stp,Op2Stp,Op1Stp,Class,Method).

  comm_exp(Stp,Op1Stp,Op2Stp,Class,Method) :- 			comm_add_exp(Stp,Op1Stp,Op2Stp,Class,Method) ;
										comm_mul_exp(Stp,Op1Stp,Op2Stp,Class,Method) ;
										comm_and_exp(Stp,Op1Stp,Op2Stp,Class,Method) ;
										comm_or_exp(Stp,Op1Stp,Op2Stp,Class,Method) ;
								comm_and_and_exp(Stp,Op1Stp,Op2Stp,Class,Method) ;
								comm_or_or_exp(Stp,Op1Stp,Op2Stp,Class,Method) ;
								comm_xor_exp(Stp,Op1Stp,Op2Stp,Class,Method) ;
								comm_equal_exp(Stp,Op1Stp,Op2Stp,Class,Method) ;
								comm_not_equal_exp(Stp,Op1Stp,Op2Stp,Class,Method) .


  binary_exp(Stp,Op1Stp,Op2Stp,Class,Method) :- 		plus(Stp,Op1Stp,Op2Stp,Class,Method) ;
								minus(Stp,Op1Stp,Op2Stp,Class,Method) ;
								times(Stp,Op1Stp,Op2Stp,Class,Method) ;
								divide(Stp,Op1Stp,Op2Stp,Class,Method) ;
								equal(Stp,Op1Stp,Op2Stp,Class,Method) ;
								not_equal(Stp,Op1Stp,Op2Stp,Class,Method) ;
								and(Stp,Op1Stp,Op2Stp,Class,Method) ;
								or(Stp,Op1Stp,Op2Stp,Class,Method) ;
								and_and(Stp,Op1Stp,Op2Stp,Class,Method) ;
								or_or(Stp,Op1Stp,Op2Stp,Class,Method) ;
								modulo(Stp,Op1Stp,Op2Stp,Class,Method) ;
								xor(Stp,Op1Stp,Op2Stp,Class,Method) ;
								less(Stp,Op1Stp,Op2Stp,Class,Method) ;
								less_equal(Stp,Op1Stp,Op2Stp,Class,Method) ; 
								greater(Stp,Op1Stp,Op2Stp,Class,Method) ;
								greater_equal(Stp,Op1Stp,Op2Stp,Class,Method) ;
								left_shift(Stp,Op1Stp,Op2Stp,Class,Method) ;
								right_shift(Stp,Op1Stp,Op2Stp,Class,Method) ;
								unsigned_right_shift(Stp,Op1Stp,Op2Stp,Class,Method) .
							

  unary_exp(Stp,OpStp,Class,Method) :- 	                 	complement(Stp,OpStp,Class,Method) ;
								sign_negate(Stp,OpStp,Class,Method) ;
								post_decr(Stp,OpStp,Class,Method);
								post_incr(Stp,OpStp,Class,Method);
								pre_decr(Stp,OpStp,Class,Method);
								pre_incr(Stp,OpStp,Class,Method);
 								not_exp(Stp,OpStp,Class,Method).

/********************************************************************************************/

/* espressioni di equivalenza */

  equiv_exp(X,Y,Class,Method) :- 				val_inst(X,SameType,SameVal,Class,Method),
                    						val_inst(Y,SameType,SameVal,Class,Method).

  equiv_exp(X,Y,Class,Method) :- 				scalar_var_inst(X,SameIdent,Class,Method),
                    						scalar_var_inst(Y,SameIdent,Class,Method).

  equiv_exp(X,Y,Class,Method) :- 				array_elem_inst(X,SameArrIdent,SubScrListX,Class,Method),
                    						array_elem_inst(Y,SameArrIdent,SubScrListY,Class,Method),
                    						equiv_subscr_list(SubScrListX,SubScrListY,Class,Method).

  equiv_exp(X,Y,Class,Method) :- 				plus(X,Op1X,Op2X,Class,Method), 
  								comm_add_exp(Y,Op1Y,Op2Y,Class,Method),
                    						equiv_exp(Op1X,Op1Y,Class,Method), 
                    						equiv_exp(Op2X,Op2Y,Class,Method).

  equiv_exp(X,Y,Class,Method) :- 				minus(X,Op1X,Op2X,Class,Method), 
  								minus(Y,Op1Y,Op2Y,Class,Method),
                    						equiv_exp(Op1X,Op1Y,Class,Method), 
                    						equiv_exp(Op2X,Op2Y,Class,Method).

  equiv_exp(X,Y,Class,Method) :- 				times(X,Op1X,Op2X,Class,Method), 
  								comm_mul_exp(Y,Op1Y,Op2Y,Class,Method),
                    						equiv_exp(Op1X,Op1Y,Class,Method), 
                    						equiv_exp(Op2X,Op2Y,Class,Method).

  equiv_exp(X,Y,Class,Method) :- 				divide(X,Op1X,Op2X,Class,Method), 
  								divide(Y,Op1Y,Op2Y,Class,Method),
                    						equiv_exp(Op1X,Op1Y,Class,Method), 
                    						equiv_exp(Op2X,Op2Y,Class,Method).

  equiv_exp(X,Y,Class,Method) :- 				sign_negate(X,OpX,Class,Method), 
  								sign_negate(Y,OpY,Class,Method), 
  								equiv_exp(OpX,OpY,Class,Method).

  equiv_exp(X,Y,Class,Method) :- 				equal(X,Op1X,Op2X,Class,Method), 
  								comm_equal_exp(Y,Op1Y,Op2Y,Class,Method),
                    						equiv_exp(Op1X,Op1Y,Class,Method), 
                    						equiv_exp(Op2X,Op2Y,Class,Method).

  equiv_exp(X,Y,Class,Method) :- 				not_equal(X,Op1X,Op2X,Class,Method), 
  								not_equal(Y,Op1Y,Op2Y,Class,Method),
                    						equiv_exp(Op1X,Op1Y,Class,Method), 
                    						equiv_exp(Op2X,Op2Y,Class,Method).

  equiv_exp(X,Y,Class,Method) :- 				and(X,Op1X,Op2X,Class,Method), 
  								comm_and_exp(Y,Op1Y,Op2Y,Class,Method),
                    						equiv_exp(Op1X,Op1Y,Class,Method), 
                    						equiv_exp(Op2X,Op2Y,Class,Method).

  equiv_exp(X,Y,Class,Method) :- 				xor(X,Op1X,Op2X,Class,Method), 
  								comm_xor_exp(Y,Op1Y,Op2Y,Class,Method),
                    						equiv_exp(Op1X,Op1Y,Class,Method), 
                    						equiv_exp(Op2X,Op2Y,Class,Method).

  equiv_exp(X,Y,Class,Method) :- 				or(X,Op1X,Op2X,Class,Method), 
  								comm_or_exp(Y,Op1Y,Op2Y,Class,Method),
                    						equiv_exp(Op1X,Op1Y,Class,Method), 
                    						equiv_exp(Op2X,Op2Y,Class,Method).

  equiv_exp(X,Y,Class,Method) :- 				and_and(X,Op1X,Op2X,Class,Method), 
  								comm_and_and_exp(Y,Op1Y,Op2Y,Class,Method),
                    						equiv_exp(Op1X,Op1Y,Class,Method), 
                    						equiv_exp(Op2X,Op2Y,Class,Method).

  equiv_exp(X,Y,Class,Method) :- 				or_or(X,Op1X,Op2X,Class,Method), 
  								comm_or_or_exp(Y,Op1Y,Op2Y,Class,Method),
                    						equiv_exp(Op1X,Op1Y,Class,Method), 
                    						equiv_exp(Op2X,Op2Y,Class,Method).

  equiv_exp(X,Y,Class,Method) :- 				modulo(X,Op1X,Op2X,Class,Method), 
  								modulo(Y,Op1Y,Op2Y,Class,Method),
                    						equiv_exp(Op1X,Op1Y,Class,Method), 
                    						equiv_exp(Op2X,Op2Y,Class,Method).

  equiv_exp(X,Y,Class,Method) :- 				less(X,Op1X,Op2X,Class,Method), 
  								less(Y,Op1Y,Op2Y,Class,Method),
                    						equiv_exp(Op1X,Op1Y,Class,Method), 
                    						equiv_exp(Op2X,Op2Y,Class,Method).

  equiv_exp(X,Y,Class,Method) :- 				less_equal(X,Op1X,Op2X,Class,Method), 
  								less_equal(Y,Op1Y,Op2Y,Class,Method),
                    						equiv_exp(Op1X,Op1Y,Class,Method), 
                    						equiv_exp(Op2X,Op2Y,Class,Method).

  equiv_exp(X,Y,Class,Method) :- 				greater(X,Op1X,Op2X,Class,Method), 
  								greater(Y,Op1Y,Op2Y,Class,Method),
                    						equiv_exp(Op1X,Op1Y,Class,Method), 
                    						equiv_exp(Op2X,Op2Y,Class,Method).

  equiv_exp(X,Y,Class,Method) :- 				greater_equal(X,Op1X,Op2X,Class,Method), 
  								greater_equal(Y,Op1Y,Op2Y,Class,Method),
                    						equiv_exp(Op1X,Op1Y,Class,Method), 
                    						equiv_exp(Op2X,Op2Y,Class,Method).

  equiv_exp(X,Y,Class,Method) :- 				left_shift(X,Op1X,Op2X,Class,Method), 
  								left_shift(Y,Op1Y,Op2Y,Class,Method),
                    						equiv_exp(Op1X,Op1Y,Class,Method), 
                    						equiv_exp(Op2X,Op2Y,Class,Method).

  equiv_exp(X,Y,Class,Method) :- 				right_shift(X,Op1X,Op2X,Class,Method), 
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

/*********************************************************************************************************/
  
  var_inst(Stp,Ident,Class,Method) :- 				scalar_var_inst(Stp,Ident,Class,Method).

  var_inst(Stp,Ident,Class,Method) :- 				array_elem_inst(Stp,Ident,SubScrList,Class,Method).

  inst(Stp,ValOrIdent,Class,Method) :- 				var_inst(Stp,ValOrIdent,Class,Method).

  inst_in_exp(ValOrIdent,ExpStp,Class,Method) :- 		inst(ExpStp,ValOrIdent,Class,Method).
  
  inst_in_exp(ValOrIdent,ExpStp,Class,Method) :- 		binary_exp(ExpStp,Op1Stp,Op2Stp,Class,Method),
										( 
										inst_in_exp(ValOrIdent,Op1Stp,Class,Method) ;
								      	inst_in_exp(ValOrIdent,Op2Stp,Class,Method)
										).
								
  inst_in_exp(ValOrIdent,ExpStp,Class,Method) :- 		unary_exp(ExpStp,OpStp,Class,Method),
                                    				inst_in_exp(ValOrIdent,OpStp,Class,Method).
                                    				
  inst_in_exp(ValOrIdent,ExpStp,Class,Method) :- 		array_elem_inst(ExpStp,Dummy,SubScrList,Class,Method),
                                    				member(SubScrExp,SubScrList,Class,Method),
                                    				inst_in_exp(ValOrIdent,SubScrExp,Class,Method).

  inst_in_exp(ValOrIdent,ExpStp,ExpStp,Class,Method) :- 	inst(ExpStp,ValOrIdent,Class,Method).
  
  inst_in_exp(ValOrIdent,InstStp,ExpStp,Class,Method) :-	binary_exp(ExpStp,Op1Stp,Op2Stp,Class,Method),
										( 
										inst_in_exp(ValOrIdent,InstStp,Op1Stp,Class,Method) ;
								      	inst_in_exp(ValOrIdent,InstStp,Op2Stp,Class,Method)
										).
								
  inst_in_exp(ValOrIdent,InstStp,ExpStp,Class,Method) :-	unary_exp(ExpStp,OpStp,Class,Method),
                                    				inst_in_exp(ValOrIdent,InstStp,OpStp,Class,Method).
  
  inst_in_exp(ValOrIdent,InstStp,ExpStp,Class,Method) :-	array_elem_inst(ExpStp,Dummy,SubScrList,Class,Method),
                                    				member(SubScrExp,SubScrList,Class,Method),
                                    				inst_in_exp(ValOrIdent,InstStp,SubScrExp,Class,Method).

  inst_in_exp_notcheck_subexps(ValOrIdent,ExpStp,SubExpStpList,Class,Method) :-		not( member(ExpStp,SubExpStpList) ),
											inst(ExpStp,ValOrIdent,Class,Method).

  inst_in_exp_notcheck_subexps(ValOrIdent,ExpStp,SubExpStpList,Class,Method) :-		not( member(ExpStp,SubExpStpList) ),
															binary_exp(ExpStp,Op1Stp,Op2Stp,Class,Method),
															( 
															inst_in_exp_notcheck_subexps(ValOrIdent,Op1Stp,SubExpStpList,Class,Method) ;
															inst_in_exp_notcheck_subexps(ValOrIdent,Op2Stp,SubExpStpList,Class,Method)
															).
 
  inst_in_exp_notcheck_subexps(ValOrIdent,ExpStp,SubExpStpList,Class,Method) :- 	not( member(ExpStp,SubExpStpList) ),
											unary_exp(ExpStp,OpStp,Class,Method),
											inst_in_exp_notcheck_subexps(ValOrIdent,OpStp,SubExpStpList,Class,Method).
 
  inst_in_exp_notcheck_subexps(ValOrIdent,ExpStp,SubExpStpList,Class,Method) :- 	not( member(ExpStp,SubExpStpList) ),
											array_elem_inst(ExpStp,Dummy,SubScrList,Class,Method),
											member(SubScrExp,SubScrList),
											inst_in_exp_notcheck_subexps(ValOrIdent,SubScrExp,SubExpStpList,Class,Method).

  sub_exp_in_exp(SubExpStp,ExpStp,Class,Method) :- 	SubExpStp = ExpStp.

  sub_exp_in_exp(SubExpStp,ExpStp,Class,Method) :- 	binary_exp(ExpStp,Op1Stp,Op2Stp,Class,Method),
									(
									sub_exp_in_exp(SubExpStp,Op1Stp,Class,Method) ;
									sub_exp_in_exp(SubExpStp,Op2Stp,Class,Method)
									).

  sub_exp_in_exp(SubExpStp,ExpStp,Class,Method) :- 	unary_exp(ExpStp,OpStp,Class,Method),
                                      			sub_exp_in_exp(SubExpStp,OpStp,Class,Method).

  sub_exp_in_exp(SubExpStp,ExpStp,Class,Method) :- 	array_elem_inst(ExpStp,Dummy,SubScrList,Class,Method),
                                      			member(SubScrExp,SubScrList),
                                      			sub_exp_in_exp(SubExpStp,SubScrExp,Class,Method).


/****************************************************************************************************************/
/**************************************************************************************************/
/**************************************************************************************************/

  exp_in_stm(ExpStp,IDass,Assign) :- assign_r(IDass,Assign,ExpStp,Class,Method).

  exp_in_stm(ExpStp,IDdo,For) :- for_r(IDfor,For,InitExpStp,ExpStp,StepExpStp,Class,Method),
                               	( 
                                 	  sub_exp_in_exp(ExpStp,InitExpStp,Class,Method) ;
                                      sub_exp_in_exp(ExpStp,StepExpStp,Class,Method)
                                    ).

  exp_in_stm(ExpStp,IDforeach,Foreach) :- foreach_r(IDforeach,Foreach,ExpStp,VarDeclStp,Class,Method),
                                    	sub_exp_in_exp(ExpStp,VarDeclStp,Class,Method).


  exp_in_stm(ExpStp,IDwhile,While) :- while_r(IDwhile,While,ExpStp,Class,Method).
                               

  exp_in_stm(ExpStp,IDdo_while,Do_while) :- do_while_r(IDdo_while,Do_while,ExpStp,Class,Method).

  exp_in_stm(ExpStp,IDlabeled,Labeled) :- labeled_r(IDlabeled,Labeled,Ident_label,LoopStp),
                               	 	sub_exp_in_exp(ExpStp,LoopStp).

/*** Necessita di essere rivista insieme al professore a causa di informazioni mancanti nella grammatica Java sull'espressione condizionale***/

  exp_in_stm(ExpStp,IDif,If) :- if_r(IDif,If,ExpStp,Class,Method).

  exp_in_stm(ExpStp,IDswitch,Switch) :- switch_r(IDswitch,Switch,Ident_label,Class,Method).
            
  exp_in_stm(ExpStp,IDassert,Assert) :- assert_r(IDassert,Assert,Class,Method).

  exp_in_stm(ExpStp,IDbreak,Break) :- break_r(IDbreak,Break,Ident_label,Class,Method).

  

 
/***************************************************************************************************/
/*********** questo va bene *****************************************/

 inherit_dep(Concetto,ListaSottoConc) :- 
    findall( AltroConc, 
      ( 
        between(1,Concetto,AltroConc), 
        findall( DepBranch, 
          ( member(DepBranch,[true,false]), 
            ( ( forall( member(SottoConc1,ListaSottoConc), 
                        control_dep(SottoConc1,AltroConc,DepBranch,Class,Method) ), 
                not( member(AltroConc,ListaSottoConc) ) 
              ) -> 
              assert_ifnotalready(control_dep(Concetto,AltroConc,DepBranch,Class,Method)) ; 
              true 
            ),    
            ( ( member(SottoConc2,ListaSottoConc), 
                control_dep(AltroConc,SottoConc2,DepBranch,Class,Method), 
                not( member(AltroConc,ListaSottoConc) )  
              ) ->  
              assert_ifnotalready(control_dep(AltroConc,Concetto,DepBranch,Class,Method)) ; 
              true  
            )     
          ),      
          DepBranchList ), 
        forall( member(SottoConc3,ListaSottoConc), 
                ( 
                  forall( ( data_dep(Type,SottoConc3,AltroConc,DepVar,DepLevel,Class,Method),
                            not( member(AltroConc,ListaSottoConc) ) 
                          ), 
                   assert_ifnotalready(data_dep(Type,Concetto,AltroConc,DepVar,DepLevel,Class,Method))
                  ), 
                  forall( ( data_dep(Type,AltroConc,SottoConc3,DepVar,DepLevel,Class,Method),
                            not( member(AltroConc,ListaSottoConc) ) 
                          ),  
                   assert_ifnotalready(data_dep(Type,AltroConc,Concetto,DepVar,DepLevel,Class,Method))
                  ), 
                  forall( data_dep(Type,SottoConc3,SottoConc3,DepVar,DepLevel,Class,Method), 
                   assert_ifnotalready(data_dep(Type,Concetto,Concetto,DepVar,DepLevel,Class,Method)) 
                  )
                ) 
              )
      ),    
      AltroConcList ).

  assert_ifnotalready(Term) :-
  ( clause(Term,true) ->
      true ;
      assert(Term)
    ).

  asserisci(Term)  :-
    ( clause(Term,true) ->
      true ;
      ( flag(global_ID,GIDold,GIDold+1),
        ID is GIDold + 1,
        arg(1,Term,ID),
        asserta( Term )
      )
    ).

  dep_chain(HierChain,SrcStm,SinkStm,ListStm,ListVar) :-
    chained(SrcStm,SinkStm,ListStm,ListVar,ListHierStm,[]),
    HierChain =.. [dep_chain,IN|ListHierStm],
    flag(global_ID,GIDold,GIDold+1),
    ID is GIDold + 1,
    asserisci( dep_chain_r(IN,HierChain,SrcStm,SinkStm,ListStm,ListVar) ),
    inherit_dep(IN,ListStm).

  chained(SrcStm,SinkStm,[SrcStm|ListStm],[VarIdent|ListVar],[HierSrcStm|ListHierStm],ListAlreadyInChain) :-
    SrcStm \== SinkStm,
    assign_r(SrcStm,HierSrcStm,_,Class,Method),
    data_dep(true,MiddleSinkStm,SrcStm,VarIdent,0,Class,Method),
    SrcStm \== MiddleSinkStm,
    not( member(MiddleSinkStm,ListAlreadyInChain) ),
    chained(MiddleSinkStm,SinkStm,ListStm,ListVar,ListHierStm,[SrcStm|ListAlreadyInChain]).

  chained(SinkStm,SinkStm,[SinkStm],[],[HierSinkStm],ListAlreadyInChain) :-
    assign_r(SinkStm,HierSinkStm,_,Class,Method).


/**************************** problema con assign: informazione mancante ********************************/

  elem_update_r(ID,HierElUp,ElemUpdateStruct) :-
    assign_r(Def,HierDef,ElemDefStp,RhsDefStp,Class,Method),
    var_inst(ElemDefStp,ElemIdent,Class,Method),
    assign_r(Use,HierUse,LhsUseStp,RhsUseStp,Class,Method),
    inst_in_exp(ElemIdent,ElemUseStp,RhsUseStp,Class,Method),
    equiv_exp(ElemDefStp,ElemUseStp,Class,Method),
    ( Def == Use ->
      ( HierElUp = elem_update(ID,HierDef), 
        CompList = [Def],
        ChainVarsList = [ElemIdent]
      ) ;
      ( data_dep(anti,Def,Use,ElemIdent,0,Class,Method), 
        dep_chain(HierChain,Use,Def,CompList,ChainVarsListButFirst),
        append([ElemIdent],ChainVarsListButFirst,ChainVarsList),
        HierElUp = elem_update(IN,HierChain)
      )
    ),
    ElemUpdateStruct = elem_update_s(ElemIdent,[ElemDefStp,ElemUseStp],CompList,ChainVarsList),
    asserisci( elem_update_r(IN,HierElUp,ElemUpdateStruct) ),
    inherit_dep(ID,CompList).

  elem_shift_r(ID,elem_shift(ID,HierElUp),ElemShiftStruct) :-
    elem_update_r(ElUp,HierElUp,ElemShiftStruct),
    ElemShiftStruct = elem_update_s(ElemIdent,[ElemDefStp,ElemUseStp],CompList,ChainVarsList),
    forall( member(ChainStm,CompList,Pos), 
            ( member(ChainVar,ChainVarsList,Pos),
              assign_r(ChainStm,_,_,ChainStmRhs,Class,Method),
              inst_descent_of_add_or_leftminus_unique(ChainVar,ChainStmRhs,_,Class,Method)),
              forall( (member(Var,ChainVarsList), Var \== ChainVar),
                      not( inst_in_exp(Var,ChainStmRhs) )
              )
            )
          ),
    asserisci( elem_shift_r(ID,elem_shift(ID,HierElUp),ElemShiftStruct) ),
    inherit_dep(ID,[ElUp]).

/**************************************************************************************************/
/**************************************************************************************************/
/**************************************************************************************************/

/* ok*/
  inst_descent_of_add_or_leftminus_unique(Ident,Exp,Exp,Class,Method) :-
    var_inst(Exp,_,Ident,Class,Method).

  inst_descent_of_add_or_leftminus_unique(Ident,Exp,IdentStp,Class,Method) :-
    ( comm_add_exp(Exp,Op1,Op2,Class,Method) ;
      minus(Exp,Op1,Op2,Class,Method)
    ),
    inst_descent_of_add_or_leftminus_unique(Ident,Op1,IdentStp,Class,Method),
    not( inst_in_exp(Ident,Op2,Class,Method) ).

    

/*********** spiegazione al problema sollevato dal professore da trovare nei fatti prodotti da cocktail, SubScribe è parametro di uscita *********/
/* forse l' ultima non va bene (solo Ident) per gli arrays */

  inst_descent_of_mul_or_leftdiv_unique(Ident,Exp,Exp,Class,Method) :-
    var_inst(Exp,Ident,Class,Method).

  inst_descent_of_mul_or_leftdiv_unique(Ident,Exp,IdentStp,Class,Method) :-
    ( comm_mul_exp(Exp,Op1,Op2,Class,Method) ;
      divide(Exp,Op1,Op2,Class,Method)
    ),
    inst_descent_of_mul_or_leftdiv_unique(Ident,Op1,IdentStp,Class,Method),
    not( inst_in_exp(Ident,Op2,Class,Method) ). 


/******************** spiegazione da trovare nei fatti prodotti da cocktail, SubScribe è parametro di uscita *********/
    /* forse l' ultima non va bene (solo Ident) per gli arrays */

  inst_descent_of_add_or_leftminus_or_mul_or_leftdiv_unique(Ident,Exp,Exp,Class,Method) :-
    var_inst(Exp,Ident,Class,Method).

  inst_descent_of_add_or_leftminus_or_mul_or_leftdiv_unique(Ident,Exp,IdentStp,Class,Method) :-
    ( comm_add_exp(Exp,Op1,Op2,Class,Method) ;
      minus(Exp,Op1,Op2,Class,Method)    
    ),
    inst_descent_of_add_or_leftminus_or_mul_or_leftdiv_unique(Ident,Op1,IdentStp,Class,Method),
    not( inst_in_exp(Ident,Op2,Class,Method) ). 

  inst_descent_of_add_or_leftminus_or_mul_or_leftdiv_unique(Ident,Exp,IdentStp,Class,Method) :-
    ( comm_mul_exp(Exp,Op1,Op2,Class,Method) ;
      divide(Exp,Op1,Op2,Class,Method)    
    ),
    inst_descent_of_add_or_leftminus_or_mul_or_leftdiv_unique(Ident,Op1,IdentStp,Class,Method),
    not( inst_in_exp(Ident,Op2,Class,Method) ).



  inst_descent_of_and_or_or_unique(Ident,Exp,Exp,Class,Method) :-
    var_inst(Exp,Ident,Class,Method).

  inst_descent_of_and_or_or_unique(Ident,Exp,IdentStp,Class,Method) :-
    ( comm_and_exp(Exp,Op1,Op2,Class,Method) ;
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




   exp_composed_of_add(Exp,Class,Method) :-
    plus(Exp,Op1,Op2,Class,Method),
    ( inst(Op1,_,Class,Method) ;
      exp_composed_of_add(Op1,Class,Method)
    ),
    ( inst(Op2,_,Class,Method) ;
      exp_composed_of_add(Op2,Class,Method)
    ).




   exp_composed_of_divide(Exp,Class,Method) :-
    divide(Exp,Op1,Op2,Class,Method),
    ( inst(Op1,_,Class,Method) ;
      exp_composed_of_divide(Op1,Class,Method)
    ),
    ( inst(Op2,_,Class,Method) ;
      exp_composed_of_divide(Op2,Class,Method)
    ).



 
  exp_composed_of_minus(Exp,Class,Method) :-
    minus(Exp,Op1,Op2,Class,Method),
    ( inst(Op1,_,Class,Method) ;
      exp_composed_of_minus(Op1,Class,Method)
    ),
    ( inst(Op2,_,Class,Method) ;
      exp_composed_of_minus(Op2,Class,Method)
    ).




   exp_composed_of_and(Exp,Class,Method) :-
    and(Exp,Op1,Op2,Class,Method),
    ( inst(Op1,_,Class,Method) ;
      exp_composed_of_and(Op1,Class,Method)
    ),
    ( inst(Op2,_,Class,Method) ;
      exp_composed_of_and(Op2,Class,Method)
    ).



   exp_composed_of_or(Exp,Class,Method) :-
    or(Exp,Op1,Op2,Class,Method),
    ( inst(Op1,_,Class,Method) ;
      exp_composed_of_or(Op1,Class,Method)
    ),
    ( inst(Op2,_,Class,Method) ;
      exp_composed_of_or(Op2,Class,Method)
    ).




   exp_composed_of_xor(Exp,Class,Method) :-
    or(Exp,Op1,Op2,Class,Method),
    ( inst(Op1,_,Class,Method) ;
      exp_composed_of_xor(Op1,Class,Method)
    ),
    ( inst(Op2,_,Class,Method) ;
      exp_composed_of_xor(Op2,Class,Method)
    ).

 exp_composed_of_mul(Exp,Class,Method) :-
    times(Exp,Op1,Op2,Class,Method),
    ( inst(Op1,_,Class,Method) ;
      exp_composed_of_mul(Op1,Class,Method)
    ),
    ( inst(Op2,_,Class,Method) ;
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
      ( comm_add_exp(Exp,Op1,Op2,Class,Method) ;
        minus(Exp,Op1,Op2,Class,Method)
      ),
      exp_descent_of_add_or_leftminus(SubExp,Op1,Class,Method).

    exp_descent_of_mul(SubExp,Exp,Class,Method):- SubExp = Exp.
    exp_descent_of_mul(SubExp,Exp,Class,Method):-
      comm_mul_exp(Exp,Op1,Op2,Class,Method),
      exp_descent_of_mul(SubExp,Op1,Class,Method).


/*************************************************** ok ***********************************/

/***********  concetti del professore da rivedere                 ***********/


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






simple_scan(Loop,HierLoop,ScanStm,HierScanStm,Range,Stride,IndexIdent,ArrayInstStp,SubScrExp,SubScrPos) :-
    count_loop_r(Loop,HierLoop,IndexIdent,InitExpStp,LastExpStp,StepExpStp),
    control_dep(ScanStm,Loop,true,Class,Method),   
    exp_in_stm(ArrayInstStp,ScanStm,HierScanStm),
    arr_el_inst(ArrayInstStp,ArrayIdent,SubScrList),
    array_var(ArrayIdent,ArrayType,NDim,ArrayRangesList),
    member(SubScrExp,SubScrList,SubScrPos),
    member(ArrayDimRange,ArrayRangesList,SubScrPos),
    inst_in_exp(IndexIdent,SubScrExp),

/* migliorare: implementare an. simb. con i loop-bounds */
    val_inst(InitExpStp,integer,InitValueLB), /* assume esp. simpl. e n. */
    val_inst(LastExpStp,integer,LastValueLB),
    StepExpStp = lnull,
    Stride = unit_stride, /* modificare */
    nth1(1,ArrayDimRange,InitValueRange),
    nth1(2,ArrayDimRange,LastValueRange),
    ArrayDimRangeValue is (LastValueRange - InitValueRange + 1),
    LoopRangeValue is (LastValueLB - InitValueLB + 1),
    ArrayDimRangeValue == LoopRangeValue,
    Range = whole_array_scan(LoopRangeValue).




  strip_mined_scan(OutLoop,HierOutLoop,InLoop,HierInLoop,ScanStm,HierScanStm,
                   Range,Stride,InIndexIdent,ArrayInstStp,SubScrExp,SubScrPos,
                   StripSize,NumStrips) :-
    count_loop_r(OutLoop,HierOutLoop,OutIndexIdent,OutInitExpStp,OutLastExpStp,
                 OutStepExpStp),
    count_loop_r(InLoop,HierInLoop,InIndexIdent,InInitExpStp,InLastExpStp,
                 InStepExpStp),
    control_dep(InLoop,OutLoop,true),
    control_dep(ScanStm,InLoop,true),
    exp_in_stm(ArrayInstStp,ScanStm,HierScanStm),
    arr_el_inst(ArrayInstStp,ArrayIdent,SubScrList),
    array_var(ArrayIdent,ArrayType,NDim,ArrayRangesList),
    member(SubScrExp,SubScrList,SubScrPos),
    member(ArrayDimRange,ArrayRangesList,SubScrPos),
    val_inst(OutInitExpStp,integer,OutInitValue), /* assume esp. simpl. e n. */
    val_inst(OutLastExpStp,integer,OutLastValue),
    OutStepExpStp = lnull,
    NumStrips is OutLastValue - OutInitValue + 1,
    ( inst_in_exp(OutIndexIdent,SubScrExp) ->
      ( val_inst(InInitExpStp,integer,InInitValue),
        val_inst(InLastExpStp,integer,InLastValue),
        InStepExpStp = lnull,
        Stride = unit_stride, /* modificare */
        StripSize is InLastValue - InInitValue + 1,
        comm_add_exp(SubScrExp,SubScrAddOp1,SubScrAddOp2),
        scal_var_inst(SubScrAddOp2,InIndexIdent),
        ( ( comm_mul_exp(SubScrAddOp1,SubScrMulOp1,SubScrMulOp2),
            scal_var_inst(SubScrMulOp2,OutIndexIdent),
            val_inst(SubScrMulOp1,integer,StripSize),
            0 is 1 - InInitValue - (OutInitValue * StripSize)
          ) ;
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
        ( ( comm_mul_exp(InInitExpStp,InInitMulOp1,InInitMulOp2),
            scal_var_inst(InInitMulOp2,OutIndexIdent),
            val_inst(InInitMulOp1,integer,StripSize),
            InInitValue is OutInitValue * StripSize
          ) ;
          ( comm_add_exp(InInitExpStp,InInitAddOp1,InInitAddOp2),
            comm_mul_exp(InInitAddOp2,InInitMulOp1,InInitMulOp2),
            scal_var_inst(InInitMulOp2,OutIndexIdent),
            val_inst(InInitMulOp1,integer,StripSize),
            val_inst(InInitAddOp1,integer,TempValue2),
            InInitValue is TempValue2 + (OutInitValue * StripSize)
          ) 
        ),
        ( ( comm_mul_exp(InLastExpStp,InLastMulOp1,InLastMulOp2),
            scal_var_inst(InLastMulOp2,OutIndexIdent),
            val_inst(InLastMulOp1,integer,StripSize),
            0 is InInitValue - 1 - (OutInitValue * StripSize) + StripSize
          ) ;
          ( comm_add_exp(InLastExpStp,InLastAddOp1,InLastAddOp2),
            comm_mul_exp(InLastAddOp2,InLastMulOp1,InLastMulOp2),
            scal_var_inst(InLastMulOp2,OutIndexIdent),
            val_inst(InLastMulOp1,integer,StripSize),
            val_inst(InLastAddOp1,integer,TempValue3),
            TempValue3 is InInitValue - 1 - OutInitValue * StripSize + StripSize
          ) 
        ),
        InStepExpStp = lnull,
        ( ( scal_var_inst(SubScrExp,InIndexIdent),
            InInitValue is 1
          ) ;
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
    /* implementare: StripSize*NumStrips == ArrayDimRangeValue */
    Range = whole_array_scan(ArrayDimRangeValue).




  array_update_values_r(IN,
                      array_update_values(IN,HierScanDef,HierScanUse,HierElUp),
                      ElemStruct,SubScrPos,IndexIdent) :-
    elem_update_r(ElUp,HierElUp,ElemStruct),
    ElemStruct = elem_update_s(ArrayIdent,[ArrayDefStp,ArrayUseStp],_,_),
    array_var(ArrayIdent,_,_,_),
    scan_r(ScanDef,HierScanDef,KindScan,whole_array_scan(RangeValue),
           unit_stride,IndexIdent,ArrayDefStp,DefSubScrExp,SubScrPos),
    control_dep(ElUp,ScanDef,true),
    scan_r(ScanUse,HierScanUse,KindScan,whole_array_scan(RangeValue),
           unit_stride,IndexIdent,ArrayUseStp,UseSubScrExp,SubScrPos),
    control_dep(ElUp,ScanUse,true),
    HierScanDef =.. [ConceptName,ScanDef|ScanDefHierList],
    append(ScanDefHierListButLast,[HierScanDefStm],ScanDefHierList),
    HierScanUse =.. [ConceptName,ScanUse|ScanUseHierList],
    append(ScanUseHierListButLast,[HierScanUseStm],ScanUseHierList),
    ScanDefHierListButLast == ScanUseHierListButLast,
    asserisci( array_update_values_r(IN,
                      array_update_values(IN,HierScanDef,HierScanUse,HierElUp),
                      ElemStruct,SubScrPos,IndexIdent) ),
    inherit_dep(IN,[ScanDef,ScanUse,ElUp]).

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

count_loop_r(ID,count_loop(ID,X),CntVarIdent,InitExpStp,StepExpStp) :-	
								 (
									for_r(IDfor,X,InitExpStp,Stp,StepExpStp,Class,Method),
    									scalar_var_inst(CntVarIdent,InitExpStp,Class,Method),
									ID=Stp,
									asserta( count_loop(ID,count_loop(ID,X),CntVarIdent,InitExpStp,StepExpStp) ),!
								  );
								 (
									while_r(IDwhile,X,Stp,Class,Method),
									control_dep(InitStp,Stp,_,Class,Method),
									(
										post_decr(InitStp,VarDefStp,Class,Method);
										post_incr(InitStp,VarDefStp,Class,Method);
										pre_decr(InitStp,VarDefStp,Class,Method);
										pre_incr(InitStp,VarDefStp,Class,Method)	
									),
									scalar_var_def(CntVarIdent,VarDefStp,Class,Method),
									InitExpStp = InitStp,
                                                      StepExpStp = InitExpStp,
									not( control_dep(VarDefStp,Stp,_,Class,Method) ),
									ID=Stp,
									asserta( count_loop(ID,count_loop(ID,X),CntVarIdent,InitExpStp,StepExpStp) ),!
								  );
								 (
									do_while_r(IDdo_while,X,Stp,Class,Method),
									control_dep(InitStp,Stp,_,Class,Method),
									(
										post_decr(InitStp,VarDefStp,Class,Method);
										post_incr(InitStp,VarDefStp,Class,Method);
										pre_decr(InitStp,VarDefStp,Class,Method);
										pre_incr(InitStp,VarDefStp,Class,Method)	
									),
									scalar_var_def(CntVarIdent,VarDefStp,Class,Method),
									InitExpStp = InitStp,
                                                      StepExpStp = InitExpStp,
									not( control_dep(VarDefStp,Stp,_,Class,Method) ),
									ID=Stp,
									asserta( count_loop(ID,count_loop(ID,X),CntVarIdent,InitExpStp,StepExpStp) ),!
								  ).

scalar_map_r(ArrayVarName) :- 			  (
					 				for_r(IDfor,for(IDfor,ForStp),InitStp,ForStp,StepStp,Class,Method),
					 				assign_r(_,assign(_,InitStp),InitStp,Class,Method),
					 				scalar_var_inst(IdentVarName,InitStp,Class,Method)
				      			  ),
								  assign_r(_,assign(_,VarStp),VarStp,Class,Method),
							  	  scalar_var_inst(IdentVarName,VarStp,Class,Method),
								  array_reference(ArrayVarName,VarStp,[IdentVarName],Class,Method),
								  control_dep(VarStp,ForStp,_,Class,Method),
								  asserta( scalar_map(ArrayVarName) ).

scalar_array_reduction_r(ScalarVarName,ArrayVarName) :-    	   assign_r(ID,assign(ID,Stp),Stp,Class,Method),
										   scalar_var_inst(ScalarVarName,Stp,Class,Method),
										   array_reference(ArrayVarName,Stp,_,Class,Method),
										   asserta( scalar_array_reduction(ScalarVarName,ArrayVarName) ).
                                                                
basic_linear_induction_variable_r(IdentVarName,Tipo) :- (
										for_r(IDfor,for(IDfor,ForStp),InitStp,ForStp,StepStp,Class,Method),
										assign_r(_,assign(_,InitStp),InitStp,Class,Method),
										scalar_var_inst(IdentVarName,InitStp,Class,Method)
									  ),
									  (
										assign_r(IDassign,assign(IDassign,VarStp),VarStp,Class,Method),
										scalar_var_inst(IdentVarName,VarStp,Class,Method),
								 		(
										     (
											plus(VarStp,IdentVarName,Op2,Class,Method);
											minus(VarStp,IdentVarName,Op2,Class,Method)
									           ),
											VarStp\==StepStp
								 		),
										not( 
										    (
											assign_r(_,assign(_,Op2Stp),Op2Stp,Class,Method),
                                                                  (
                                                                  scalar_var_inst(Op2,Op2Stp,Class,Method);
                                                                  array_elem_inst(Op2,Op2Stp,[IdentVarName],Class,Method)
											),
											control_dep(Op2Stp,ForStp,_,Class,Method)
										    )
										   )
									  ),
									  control_dep(VarStp,ForStp,_,Class,Method),
									  Tipo = basic_linear,
									  asserta( basic_linear_induction_variable(IdentVarName,Tipo) ).								  

basic_geometric_induction_variable_r(IdentVarName,Tipo) :- (
										for_r(IDfor,for(IDfor,ForStp),InitStp,ForStp,StepStp,Class,Method),
										assign_r(_,assign(_,InitStp),InitStp,Class,Method),
										scalar_var_inst(IdentVarName,InitStp,Class,Method)
									     ),
									     (
										assign_r(IDassign,assign(IDassign,VarStp),VarStp,Class,Method),
										scalar_var_inst(IdentVarName,VarStp,Class,Method),
								 		(
											(
											times(VarStp,IdentVarName,Op2,Class,Method);
											divide(VarStp,IdentVarName,Op2,Class,Method)
											),
											VarStp\==StepStp
								 		),
										not( 
											(
											assign_r(_,assign(_,Op2Stp),Op2Stp,Class,Method),
                                                                  (
                                                                  scalar_var_inst(Op2,Op2Stp,Class,Method);
                                                                  array_elem_inst(Op2,Op2Stp,[IdentVarName],Class,Method)
											),
											control_dep(Op2Stp,ForStp,_,Class,Method)
											)
										    )
									  ),
									  control_dep(VarStp,ForStp,_,Class,Method),
									  Tipo = basic_geometric,
									  asserta( basic_geometric_induction_variable(IdentVarName,Tipo) ).

linear_induction_variable_r(IdentVarName,Tipo) :-      while_r(IDwhile,while(IDwhile,WhileStp),WhileStp,Class,Method),    
									 (
									   assign_r(IDassign,assign(IDassign,VarStp),VarStp,Class,Method),
									   scalar_var_inst(CntVarIdent,VarStp,Class,Method),
								         (
									     (
										plus(VarStp,CntVarIdent,Op2,Class,Method);
										minus(VarStp,CntVarIdent,Op2,Class,Method)
									     )
									   ),	   
									   not( 
										  (
										    assign_r(_,assign(_,Op2Stp),Op2Stp,Class,Method),
                                                                (
                                                                  scalar_var_inst(Op2,Op2Stp,Class,Method);
                                                                  array_elem_inst(Op2,Op2Stp,[CntVarIdent],Class,Method)
										    ),
										    control_dep(Op2Stp,WhileStp,_,Class,Method),
									          scalar_var_def(Op2,Op2DefStp,_,_,Class,Method),
									    	    not( control_dep(Op2DefStp,WhileStp,_,Class,Method) )
										   )
										 )
									  ),
									  control_dep(VarStp,WhileStp,_,Class,Method),
									  scalar_var_def(CntVarIdent,VarDefStp,_,_,Class,Method),
									  not( control_dep(VarDefStp,WhileStp,_,Class,Method) ),
                                                        IdentVarName = CntVarIdent,
  						        		  Tipo = linear,
									  asserta( linear_induction_variable(IdentVarName,Tipo) ).

geometric_induction_variable_r(IdentVarName,Tipo) :-    while_r(IDwhile,while(IDwhile,WhileStp),WhileStp,Class,Method),    
									 (
									   assign_r(IDassign,assign(IDassign,VarStp),VarStp,Class,Method),
									   scalar_var_inst(CntVarIdent,VarStp,Class,Method),
								         (
									     (
										times(VarStp,CntVarIdent,Op2,Class,Method);
										divide(VarStp,CntVarIdent,Op2,Class,Method)
									     )
									   ),	   
									   not( 
										  (
										    assign_r(_,assign(_,Op2Stp),Op2Stp,Class,Method),
                                                                (
                                                                  scalar_var_inst(Op2,Op2Stp,Class,Method);
                                                                  array_elem_inst(Op2,Op2Stp,[CntVarIdent],Class,Method)
										    ),
										    control_dep(Op2Stp,WhileStp,_,Class,Method),
									          scalar_var_def(Op2,Op2DefStp,_,_,Class,Method),
									    	    not( control_dep(Op2DefStp,WhileStp,_,Class,Method) )
										   )
										 )
									  ),
									  control_dep(VarStp,WhileStp,_,Class,Method),
									  scalar_var_def(CntVarIdent,VarDefStp,_,_,Class,Method),
									  not( control_dep(VarDefStp,WhileStp,_,Class,Method) ),
                                                        IdentVarName = CntVarIdent,
  						        		  Tipo = geometric,
									  asserta( linear_induction_variable(IdentVarName,Tipo) ).


basic_polynomial_induction_variable_r(BasicIdentVarName,OuterIdentVarName,Tipo) :- 
									  (
										for_r(IDfor,for(IDfor,ForStp),InitStp,ForStp,StepStp,Class,Method),
										assign_r(_,assign(_,InitStp),InitStp,Class,Method),
										scalar_var_inst(BasicIdentVarName,InitStp,Class,Method)
									  ),
									  (
										assign_r(IDassign,assign(IDassign,BasicVarStp),BasicVarStp,Class,Method),
										scalar_var_inst(BasicIdentVarName,BasicVarStp,Class,Method),
								 		(
										     (
											plus(BasicVarStp,BasicIdentVarName,Op2,Class,Method);
											minus(BasicVarStp,BasicIdentVarName,Op2,Class,Method)
									           ),
											BasicVarStp\==StepStp,
											BasicVarStp\==InitStp
								 		),
										not( 
										    (
											assign_r(_,assign(_,Op2Stp),Op2Stp,Class,Method),
                                                                  (
                                                                  scalar_var_inst(Op2,Op2Stp,Class,Method);
                                                                  array_elem_inst(Op2,Op2Stp,[BasicIdentVarName],Class,Method)
											),
											control_dep(Op2Stp,ForStp,_,Class,Method)
										    )
										   ),
										control_dep(BasicVarStp,ForStp,_,Class,Method)
									  ),
									  (
										scalar_var_def(OuterIdentVarName,OuterVarStp,_,_,Class,Method),
									  	not( control_dep(OuterVarStp,ForStp,_,Class,Method) ),
  									  	assign_r(ID2assign,assign(ID2assign,InnerVarStp),InnerVarStp,Class,Method),
									  	scalar_var_inst(OuterIdentVarName,InnerVarStp,Class,Method),
								 	  	(
								            	(
											 plus(InnerVarStp,OuterIdentVarName,BasicIdentVarName,Class,Method);
											 minus(InnerVarStp,OuterIdentVarName,BasicIdentVarName,Class,Method)
									            ),
											InnerVarStp\==StepStp,
											InnerVarStp\==InitStp
								 	  	),
									  	control_dep(InnerVarStp,ForStp,_,Class,Method)
									  ),
									  Tipo = basic_polynomial,
									  asserta( basic_polynomial_induction_variable(BasicIdentVarName,OuterIdentVarName,Tipo) ).

polynomial_induction_variable_r(IdentVarName,OuterIdentVarName,Tipo) :- 
                                                       while_r(IDwhile,while(IDwhile,WhileStp),WhileStp,Class,Method),    								
									 (
									   assign_r(IDassign,assign(IDassign,VarStp),VarStp,Class,Method),
									   scalar_var_inst(CntVarIdent,VarStp,Class,Method),
								         (
									     (
										plus(VarStp,CntVarIdent,Op2,Class,Method);
										minus(VarStp,CntVarIdent,Op2,Class,Method)
									     )
									   ),
               	     	  	 		  		   not( 
										  (
										    assign_r(_,assign(_,Op2Stp),Op2Stp,Class,Method),
                                                                (
                                                                  scalar_var_inst(Op2,Op2Stp,Class,Method);
                                                                  array_elem_inst(Op2,Op2Stp,[CntVarIdent],Class,Method)
										    ),
										    control_dep(Op2Stp,WhileStp,_,Class,Method),
										    scalar_var_def(Op2,Op2DefStp,_,_,Class,Method),
									    	    not( control_dep(Op2DefStp,WhileStp,_,Class,Method) )
										   )
										 ),
									    control_dep(VarStp,WhileStp,_,Class,Method)
									  ),
									  (
										scalar_var_def(OuterIdentVarName,OuterVarStp,_,_,Class,Method),
									  	not( control_dep(OuterVarStp,WhileStp,_,Class,Method) ),
  									  	assign_r(ID2assign,assign(ID2assign,InnerVarStp),InnerVarStp,Class,Method),
									  	scalar_var_inst(OuterIdentVarName,InnerVarStp,Class,Method),
								 	  	(
								            	(
											 plus(InnerVarStp,OuterIdentVarName,CntVarIdent,Class,Method);
											 minus(InnerVarStp,OuterIdentVarName,CntVarIdent,Class,Method)
									            )
								 	  	),
									  	control_dep(InnerVarStp,WhileStp,_,Class,Method)
									  ),
									  IdentVarName = CntVarIdent,
  						        		  Tipo = polynomial,
									  asserta( polynomial_induction_variable(IdentVarName,OuterIdentVarName,Tipo) ).