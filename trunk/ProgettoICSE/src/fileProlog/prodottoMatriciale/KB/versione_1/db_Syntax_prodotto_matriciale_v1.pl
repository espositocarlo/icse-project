scalar_var_def(i,def_list_1,prodottomatriciale_versione_1,main).
scalar_var_inst(def_list_1,i,prodottomatriciale_versione_1,main).
constant_ref(cref_1,0).
uguaglianza(def_list_1,cref_1,prodottomatriciale_versione_1,main).
scalar_var_def(j,def_list_2,prodottomatriciale_versione_1,main).
scalar_var_inst(def_list_2,j,prodottomatriciale_versione_1,main).
constant_ref(cref_2,0).
uguaglianza(def_list_2,cref_2,prodottomatriciale_versione_1,main).
scalar_var_def(z,def_list_3,prodottomatriciale_versione_1,main).
scalar_var_inst(def_list_3,z,prodottomatriciale_versione_1,main).
constant_ref(cref_3,0).
uguaglianza(def_list_3,cref_3,prodottomatriciale_versione_1,main).
scalar_var_def(appmul,def_list_4,prodottomatriciale_versione_1,main).
scalar_var_def(appa,def_list_5,prodottomatriciale_versione_1,main).
scalar_var_def(appb,def_list_6,prodottomatriciale_versione_1,main).
scalar_var_def(appc,def_list_7,prodottomatriciale_versione_1,main).
array_var_def(a,int,2,def_list_5,[10,5],prodottomatriciale_versione_1,main).
array_var_def(b,int,2,def_list_6,[5,8],prodottomatriciale_versione_1,main).
array_var_def(c,int,2,def_list_7,[10,8],prodottomatriciale_versione_1,main).
% ---------------------------------------------------------------------------------
for_r(23,for(23,exit_123),init_7,exit_123,incr_8,prodottomatriciale_versione_1,main).
scalar_var_inst(init_7,i,prodottomatriciale_versione_1,main).
constant_ref(cref_4,0).
uguaglianza(init_7,cref_4,prodottomatriciale_versione_1,main).
scalar_var_ref(vref_5,i).
constant_ref(cref_6,10).
less(exit_123,vref_5,cref_6,prodottomatriciale_versione_1,main).
scalar_var_ref(vref_7,i).
post_incr(incr_8,vref_7,prodottomatriciale_versione_1,main).
% ----------------------------------------------------------------------------------
for_r(21,for(21,exit_121),init_9,exit_121,incr_10,prodottomatriciale_versione_1,main).
scalar_var_inst(init_9,j,prodottomatriciale_versione_1,main).
constant_ref(cref_8,0).
uguaglianza(init_9,cref_8,prodottomatriciale_versione_1,main).
scalar_var_ref(vref_9,j).
constant_ref(cref_10,8).
less(exit_121,vref_9,cref_10,prodottomatriciale_versione_1,main).
scalar_var_ref(vref_11,j).
post_incr(incr_10,vref_11,prodottomatriciale_versione_1,main).
% -----------------------------------------------------------------------------------
for_r(19,for(19,exit_119),init_11,exit_119,incr_12,prodottomatriciale_versione_1,main).
scalar_var_inst(init_11,z,prodottomatriciale_versione_1,main).
constant_ref(cref_12,0).
uguaglianza(init_11,cref_12,prodottomatriciale_versione_1,main).
scalar_var_ref(vref_13,z).
constant_ref(cref_14,5).
less(exit_119,vref_13,cref_14,prodottomatriciale_versione_1,main).
scalar_var_ref(vref_15,z).
post_incr(incr_12,vref_15,prodottomatriciale_versione_1,main).
% ------------------------------------------------------------------------------------
scalar_var_inst(expr_14,appa,prodottomatriciale_versione_1,main).
array_elem_ref(aref_16,a,[i,z]).
uguaglianza(expr_14,aref_16,prodottomatriciale_versione_1,main).
scalar_var_inst(expr_15,appb,prodottomatriciale_versione_1,main).
array_elem_ref(aref_17,b,[z,j]).
uguaglianza(expr_15,aref_17,prodottomatriciale_versione_1,main).
scalar_var_inst(expr_16,appmul,prodottomatriciale_versione_1,main).
scalar_var_ref(vref_18,appa).
scalar_var_ref(vref_19,appb).
times(expr_16,vref_18,vref_19,prodottomatriciale_versione_1,main).
scalar_var_inst(expr_17,appc,prodottomatriciale_versione_1,main).
array_elem_ref(aref_20,c,[i,j]).
uguaglianza(expr_17,aref_20,prodottomatriciale_versione_1,main).
array_elem_inst(expr_18,c,[i,j],prodottomatriciale_versione_1,main).
scalar_var_ref(vref_21,appc).
scalar_var_ref(vref_22,appmul).
plus(expr_18,vref_21,vref_22,prodottomatriciale_versione_1,main).