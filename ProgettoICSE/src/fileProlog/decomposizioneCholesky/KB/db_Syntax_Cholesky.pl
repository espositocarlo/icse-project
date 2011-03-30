scalar_var_def(n,def_list_1,choleskyDecomposition,main).
scalar_var_inst(def_list_1,n,choleskyDecomposition,main).
uguaglianza(def_list_1,cref_1,choleskyDecomposition,main).
constant_ref(cref_1,3).

array_var_def(matricea,double,2,def_list_2,[n,n],choleskyDecomposition,main).
array_var_def(matriceu,double,2,def_list_3,[n,n],choleskyDecomposition,main).
array_var_def(templrowj,double,1,def_list_4,[n],choleskyDecomposition,main).
array_var_def(templrowk,double,1,def_list_5,[n],choleskyDecomposition,main).
scalar_var_def(j,def_list_6,choleskyDecomposition,main).
scalar_var_def(k,def_list_7,choleskyDecomposition,main).
scalar_var_def(i,def_list_8,choleskyDecomposition,main).
scalar_var_def(m,def_list_9,choleskyDecomposition,main).
scalar_var_def(d,def_list_10,choleskyDecomposition,main).
scalar_var_def(s,def_list_11,choleskyDecomposition,main).
for_r(37,for(37,exit_137),init_11,exit_137,incr_12,choleskyDecomposition,main).
scalar_var_inst(init_11,j,choleskyDecomposition,main).
uguaglianza(init_11,cref_2,choleskyDecomposition,main).
constant_ref(cref_2,0).
less(exit_137,vref_3,vref_4,choleskyDecomposition,main).

scalar_var_ref(vref_3,j).
scalar_var_ref(vref_4,n).
post_incr(incr_12,vref_5,choleskyDecomposition,main).

scalar_var_ref(vref_5,j).

scalar_var_inst(expr_14,templrowj,choleskyDecomposition,main).
array_elem_ref(aref_6,matriceu,[j]).
uguaglianza(expr_14,aref_6,choleskyDecomposition,main).
scalar_var_inst(expr_15,d,choleskyDecomposition,main).
constant_ref(cref_7,0.0).
uguaglianza(expr_15,cref_7,choleskyDecomposition,main).
for_r(28,for(28,exit_128),init_15,exit_128,incr_16,choleskyDecomposition,main).
scalar_var_inst(init_15,k,choleskyDecomposition,main).
uguaglianza(init_15,cref_8,choleskyDecomposition,main).
constant_ref(cref_8,0).
less(exit_128,vref_9,vref_10,choleskyDecomposition,main).

scalar_var_ref(vref_9,k).
scalar_var_ref(vref_10,j).
post_incr(incr_16,vref_11,choleskyDecomposition,main).

scalar_var_ref(vref_11,k).

scalar_var_inst(expr_18,templrowk,choleskyDecomposition,main).
array_elem_ref(aref_12,matriceu,[k]).
uguaglianza(expr_18,aref_12,choleskyDecomposition,main).
scalar_var_inst(expr_19,s,choleskyDecomposition,main).
constant_ref(cref_13,0.0).
uguaglianza(expr_19,cref_13,choleskyDecomposition,main).
for_r(23,for(23,exit_123),init_19,exit_123,incr_20,choleskyDecomposition,main).
scalar_var_inst(init_19,i,choleskyDecomposition,main).
uguaglianza(init_19,cref_14,choleskyDecomposition,main).
constant_ref(cref_14,0).
less(exit_123,vref_15,vref_16,choleskyDecomposition,main).

scalar_var_ref(vref_15,i).
scalar_var_ref(vref_16,k).
post_incr(incr_20,vref_17,choleskyDecomposition,main).

scalar_var_ref(vref_17,i).

scalar_var_inst(expr_22,s,choleskyDecomposition,main).
scalar_var_ref(vref_18,s).
array_elem_ref(aref_19,templrowk,[i]).
array_elem_ref(aref_20,templrowj,[i]).
times(oref_1001,aref_19,aref_20,choleskyDecomposition,main).
plus(expr_22,vref_18,oref_1001,choleskyDecomposition,main).
scalar_var_inst(expr_25,s,choleskyDecomposition,main).
array_elem_ref(aref_21,matricea,[j,k]).
scalar_var_ref(vref_22,s).
minus(oref_1002,aref_21,vref_22,choleskyDecomposition,main).
array_elem_ref(aref_23,matriceu,[k,k]).
divide(expr_25,oref_1002,aref_23,choleskyDecomposition,main).
array_elem_inst(expr_26,templrowj,[k],choleskyDecomposition,main).
scalar_var_ref(vref_24,s).
uguaglianza(expr_26,vref_24,choleskyDecomposition,main).
scalar_var_inst(expr_27,d,choleskyDecomposition,main).
scalar_var_ref(vref_25,d).
scalar_var_ref(vref_26,s).
scalar_var_ref(vref_27,s).
times(oref_1003,vref_26,vref_27,choleskyDecomposition,main).
plus(expr_27,vref_25,oref_1003,choleskyDecomposition,main).
scalar_var_inst(expr_30,d,choleskyDecomposition,main).
array_elem_ref(aref_28,matricea,[j,j]).
scalar_var_ref(vref_29,d).
minus(expr_30,aref_28,vref_29,choleskyDecomposition,main).
array_elem_inst(expr_31,matriceu,[j,j],choleskyDecomposition,main).
scalar_var_ref(vref_30,d).
chiamata(expr_31,sqrt,[vref_30]).
for_r(35,for(35,exit_135),init_31,exit_135,incr_32,choleskyDecomposition,main).
scalar_var_inst(init_31,m,choleskyDecomposition,main).
scalar_var_ref(vref_31,j).
constant_ref(cref_32,1).
plus(init_31,vref_31,cref_32,choleskyDecomposition,main).
scalar_var_ref(vref_33,m).
scalar_var_ref(vref_34,n).
less(exit_135,vref_33,vref_34,choleskyDecomposition,main).
scalar_var_ref(vref_35,m).
post_incr(incr_32,vref_35,choleskyDecomposition,main).
array_elem_inst(expr_34,matriceu,[j,m],choleskyDecomposition,main).
constant_ref(cref_36,0.0).
uguaglianza(expr_34,cref_36,choleskyDecomposition,main).
