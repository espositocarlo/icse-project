scalar_var_def(m,def_list_0,qrdecomposition,null).
scalar_var_inst(def_list_0,m,qrdecomposition,null).
constant_ref(cref_1,5).
uguaglianza(def_list_0,cref_1,qrdecomposition,null).
scalar_var_def(n,def_list_1,qrdecomposition,null).
scalar_var_inst(def_list_1,n,qrdecomposition,null).
constant_ref(cref_2,3).
uguaglianza(def_list_1,cref_2,qrdecomposition,null).
array_var_def(r,double,2,def_list_2,[n,n],qrdecomposition,null).
array_var_def(a,double,2,def_list_3,[m,n],qrdecomposition,null).
array_var_def(rdiag,double,1,def_list_4,[n],qrdecomposition,null).
array_var_def(qr,double,2,def_list_5,[m,n],qrdecomposition,null).
array_var_def(q,double,2,def_list_6,[m,n],qrdecomposition,null).
scalar_var_inst(def_list_6,qr,qrdecomposition,qrdecomposition).
scalar_var_ref(vref_3,a).
uguaglianza(def_list_6,vref_3,qrdecomposition,qrdecomposition).
for_r(48,for(48,exit_148),init_1,exit_148,incr_2,qrdecomposition,qrdecomposition).
scalar_var_def(k,init_1,qrdecomposition,qrdecomposition).
scalar_var_inst(init_1,k,qrdecomposition,qrdecomposition).
constant_ref(cref_4,0).
uguaglianza(init_1,cref_4,qrdecomposition,qrdecomposition).
scalar_var_ref(vref_5,k).
scalar_var_ref(vref_6,n).
less(exit_148,vref_5,vref_6,qrdecomposition,qrdecomposition).
scalar_var_ref(vref_7,k).
post_incr(incr_2,vref_7,qrdecomposition,qrdecomposition).
scalar_var_def(nrm,def_list_4,qrdecomposition,qrdecomposition).
scalar_var_inst(def_list_4,nrm,qrdecomposition,qrdecomposition).
constant_ref(cref_8,0).
uguaglianza(def_list_4,cref_8,qrdecomposition,qrdecomposition).
scalar_var_def(r,def_list_5,qrdecomposition,qrdecomposition).
scalar_var_inst(def_list_5,r,qrdecomposition,qrdecomposition).
constant_ref(cref_9,0).
uguaglianza(def_list_5,cref_9,qrdecomposition,qrdecomposition).
for_r(19,for(19,exit_119),init_5,exit_119,incr_6,qrdecomposition,qrdecomposition).
scalar_var_def(i,init_5,qrdecomposition,qrdecomposition).
scalar_var_inst(init_5,i,qrdecomposition,qrdecomposition).
scalar_var_ref(vref_10,k).
uguaglianza(init_5,vref_10,qrdecomposition,qrdecomposition).
scalar_var_ref(vref_11,i).
scalar_var_ref(vref_12,m).
less(exit_119,vref_11,vref_12,qrdecomposition,qrdecomposition).
scalar_var_ref(vref_13,i).
post_incr(incr_6,vref_13,qrdecomposition,qrdecomposition).
if_r(if_16,if_expr_116,qrdecomposition,qrdecomposition).
scalar_var_ref(vref_14,nrm).
chiamata(oref_1001,abs,[vref_14]).
array_elem_ref(aref_15,qr,[i,k]).
chiamata(oref_1002,abs,[aref_15]).
greater(if_expr_116,oref_1001,oref_1002,qrdecomposition,qrdecomposition).
scalar_var_inst(expr_8,r,qrdecomposition,qrdecomposition).
array_elem_ref(aref_16,qr,[i,k]).
scalar_var_ref(vref_17,nrm).
divide(expr_8,aref_16,vref_17,qrdecomposition,qrdecomposition).
scalar_var_inst(expr_9,r,qrdecomposition,qrdecomposition).
scalar_var_ref(vref_18,nrm).
chiamata(oref_1003,abs,[vref_18]).
constant_ref(cref_19,1).
scalar_var_ref(vref_20,r).
scalar_var_ref(vref_21,r).
times(oref_1006,vref_20,vref_21,qrdecomposition,qrdecomposition).
plus(oref_1005,cref_19,oref_1006,qrdecomposition,qrdecomposition).
chiamata(oref_1004,sqrt,[oref_1005]).
times(expr_9,oref_1003,oref_1004,qrdecomposition,qrdecomposition).
else_if_r(if_16,else_if_15,if_expr_115).
array_elem_ref(aref_22,qr,[i,k]).
constant_ref(cref_23,0).
not_equal(if_expr_115,aref_22,cref_23,qrdecomposition,qrdecomposition).
scalar_var_inst(expr_11,r,qrdecomposition,qrdecomposition).
scalar_var_ref(vref_24,nrm).
array_elem_ref(aref_25,qr,[i,k]).
divide(expr_11,vref_24,aref_25,qrdecomposition,qrdecomposition).
scalar_var_inst(expr_12,r,qrdecomposition,qrdecomposition).
array_elem_ref(aref_26,qr,[i,k]).
chiamata(oref_1007,abs,[aref_26]).
constant_ref(cref_27,1).
scalar_var_ref(vref_28,r).
scalar_var_ref(vref_29,r).
times(oref_1010,vref_28,vref_29,qrdecomposition,qrdecomposition).
plus(oref_1009,cref_27,oref_1010,qrdecomposition,qrdecomposition).
chiamata(oref_1008,sqrt,[oref_1009]).
times(expr_12,oref_1007,oref_1008,qrdecomposition,qrdecomposition).
else_r(if_16,else_14).
scalar_var_inst(expr_14,r,qrdecomposition,qrdecomposition).
constant_ref(cref_30,0).
uguaglianza(expr_14,cref_30,qrdecomposition,qrdecomposition).
scalar_var_inst(expr_18,nrm,qrdecomposition,qrdecomposition).
scalar_var_ref(vref_31,r).
uguaglianza(expr_18,vref_31,qrdecomposition,qrdecomposition).
if_r(if_22,if_expr_122,qrdecomposition,qrdecomposition).
array_elem_ref(aref_32,qr,[k,k]).
constant_ref(cref_33,0).
less(if_expr_122,aref_32,cref_33,qrdecomposition,qrdecomposition).
scalar_var_inst(expr_21,nrm,qrdecomposition,qrdecomposition).
constant_ref(cref_34,1).
negazione(oref_1011,cref_34,qrdecomposition,qrdecomposition).
scalar_var_ref(vref_35,nrm).
times(expr_21,oref_1011,vref_35,qrdecomposition,qrdecomposition).
for_r(27,for(27,exit_127),init_23,exit_127,incr_24,qrdecomposition,qrdecomposition).
scalar_var_def(i,init_23,qrdecomposition,qrdecomposition).
scalar_var_inst(init_23,i,qrdecomposition,qrdecomposition).
scalar_var_ref(vref_36,k).
uguaglianza(init_23,vref_36,qrdecomposition,qrdecomposition).
scalar_var_ref(vref_37,i).
scalar_var_ref(vref_38,m).
less(exit_127,vref_37,vref_38,qrdecomposition,qrdecomposition).
scalar_var_ref(vref_39,i).
post_incr(incr_24,vref_39,qrdecomposition,qrdecomposition).
array_elem_inst(expr_26,qr,[i,k],qrdecomposition,qrdecomposition).
array_elem_ref(aref_40,qr,[i,k]).
scalar_var_ref(vref_41,nrm).
divide(expr_26,aref_40,vref_41,qrdecomposition,qrdecomposition).

array_elem_inst(expr_29,qr,[k,k],qrdecomposition,qrdecomposition).
array_elem_ref(aref_42,qr,[k,k]).
constant_ref(cref_43,1).
plus(expr_29,aref_42,cref_43,qrdecomposition,qrdecomposition).
scalar_var_def(j,def_list_30,qrdecomposition,qrdecomposition).

for_r(45,for(45,exit_145),init_30,exit_145,incr_31,qrdecomposition,qrdecomposition).
scalar_var_inst(init_30,j,qrdecomposition,qrdecomposition).
scalar_var_ref(vref_44,k).
constant_ref(cref_45,1).
plus(init_30,vref_44,cref_45,qrdecomposition,qrdecomposition).
scalar_var_ref(vref_46,j).
scalar_var_ref(vref_47,n).
less(exit_145,vref_46,vref_47,qrdecomposition,qrdecomposition).
scalar_var_ref(vref_48,j).
post_incr(incr_31,vref_48,qrdecomposition,qrdecomposition).
scalar_var_def(s,def_list_33,qrdecomposition,qrdecomposition).

scalar_var_inst(def_list_33,s,qrdecomposition,qrdecomposition).
constant_ref(cref_49,0).
uguaglianza(def_list_33,cref_49,qrdecomposition,qrdecomposition).

for_r(37,for(37,exit_137),init_33,exit_137,incr_34,qrdecomposition,qrdecomposition).
scalar_var_def(i,init_33,qrdecomposition,qrdecomposition).
scalar_var_inst(init_33,i,qrdecomposition,qrdecomposition).
scalar_var_ref(vref_50,k).
uguaglianza(init_33,vref_50,qrdecomposition,qrdecomposition).
scalar_var_ref(vref_51,i).
scalar_var_ref(vref_52,m).
less(exit_137,vref_51,vref_52,qrdecomposition,qrdecomposition).
scalar_var_ref(vref_53,i).
post_incr(incr_34,vref_53,qrdecomposition,qrdecomposition).

scalar_var_inst(expr_36,s,qrdecomposition,qrdecomposition).
scalar_var_ref(vref_54,s).
array_elem_ref(aref_55,qr,[i,k]).
array_elem_ref(aref_56,qr,[i,j]).
times(oref_1012,aref_55,aref_56,qrdecomposition,qrdecomposition).
plus(expr_36,vref_54,oref_1012,qrdecomposition,qrdecomposition).

scalar_var_inst(expr_39,s,qrdecomposition,qrdecomposition).
scalar_var_ref(vref_57,s).
negazione(oref_1013,vref_57,qrdecomposition,qrdecomposition).
array_elem_ref(aref_58,qr,[k,k]).
divide(expr_39,oref_1013,aref_58,qrdecomposition,qrdecomposition).
for_r(43,for(43,exit_143),init_39,exit_143,incr_40,qrdecomposition,qrdecomposition).
scalar_var_def(i,init_39,qrdecomposition,qrdecomposition).
scalar_var_inst(init_39,i,qrdecomposition,qrdecomposition).
scalar_var_ref(vref_59,k).
uguaglianza(init_39,vref_59,qrdecomposition,qrdecomposition).
scalar_var_ref(vref_60,i).
scalar_var_ref(vref_61,m).
less(exit_143,vref_60,vref_61,qrdecomposition,qrdecomposition).
scalar_var_ref(vref_62,i).
post_incr(incr_40,vref_62,qrdecomposition,qrdecomposition).

array_elem_inst(expr_42,qr,[i,j],qrdecomposition,qrdecomposition).
array_elem_ref(aref_63,qr,[i,j]).
scalar_var_ref(vref_64,s).
array_elem_ref(aref_65,qr,[i,k]).
times(oref_1014,vref_64,aref_65,qrdecomposition,qrdecomposition).
plus(expr_42,aref_63,oref_1014,qrdecomposition,qrdecomposition).

array_elem_inst(expr_47,rdiag,[k],qrdecomposition,qrdecomposition).
constant_ref(cref_66,1).
negazione(oref_1015,cref_66,qrdecomposition,qrdecomposition).
scalar_var_ref(vref_67,nrm).
times(expr_47,oref_1015,vref_67,qrdecomposition,qrdecomposition).
for_r(65,for(65,exit_165),init_50,exit_165,incr_51,qrdecomposition,getr).
scalar_var_def(i,init_50,qrdecomposition,getr).
scalar_var_inst(init_50,i,qrdecomposition,getr).
constant_ref(cref_68,0).
uguaglianza(init_50,cref_68,qrdecomposition,getr).
scalar_var_ref(vref_69,i).
scalar_var_ref(vref_70,n).
less(exit_165,vref_69,vref_70,qrdecomposition,getr).
scalar_var_ref(vref_71,i).
post_incr(incr_51,vref_71,qrdecomposition,getr).
for_r(63,for(63,exit_163),init_52,exit_163,incr_53,qrdecomposition,getr).
scalar_var_def(j,init_52,qrdecomposition,getr).
scalar_var_inst(init_52,j,qrdecomposition,getr).
constant_ref(cref_72,0).
uguaglianza(init_52,cref_72,qrdecomposition,getr).
scalar_var_ref(vref_73,j).
scalar_var_ref(vref_74,n).
less(exit_163,vref_73,vref_74,qrdecomposition,getr).
scalar_var_ref(vref_75,j).
post_incr(incr_53,vref_75,qrdecomposition,getr).
if_r(if_61,if_expr_161,qrdecomposition,getr).
scalar_var_ref(vref_76,i).
scalar_var_ref(vref_77,j).
less(if_expr_161,vref_76,vref_77,qrdecomposition,getr).
array_elem_inst(expr_55,r,[i,j],qrdecomposition,getr).
array_elem_ref(aref_78,qr,[i,j]).
uguaglianza(expr_55,aref_78,qrdecomposition,getr).
else_if_r(if_61,else_if_60,if_expr_160).
scalar_var_ref(vref_79,i).
scalar_var_ref(vref_80,j).
equal(if_expr_160,vref_79,vref_80,qrdecomposition,getr).
array_elem_inst(expr_57,r,[i,j],qrdecomposition,getr).
array_elem_ref(aref_81,rdiag,[i]).
uguaglianza(expr_57,aref_81,qrdecomposition,getr).
else_r(if_61,else_59).
array_elem_inst(expr_59,r,[i,j],qrdecomposition,getr).
constant_ref(cref_82,0).
uguaglianza(expr_59,cref_82,qrdecomposition,getr).
scalar_var_def(k,def_list_68,qrdecomposition,getq).
for_r(95,for(95,exit_195),init_68,exit_195,incr_69,qrdecomposition,getq).
scalar_var_inst(init_68,k,qrdecomposition,getq).
scalar_var_ref(vref_83,n).
constant_ref(cref_84,1).
minus(init_68,vref_83,cref_84,qrdecomposition,getq).
scalar_var_ref(vref_85,k).
constant_ref(cref_86,0).
greater_equal(exit_195,vref_85,cref_86,qrdecomposition,getq).
scalar_var_ref(vref_87,k).
post_decr(incr_69,vref_87,qrdecomposition,getq).
for_r(74,for(74,exit_174),init_70,exit_174,incr_71,qrdecomposition,getq).
scalar_var_def(i,init_70,qrdecomposition,getq).
scalar_var_inst(init_70,i,qrdecomposition,getq).
constant_ref(cref_88,0).
uguaglianza(init_70,cref_88,qrdecomposition,getq).
scalar_var_ref(vref_89,i).
scalar_var_ref(vref_90,m).
less(exit_174,vref_89,vref_90,qrdecomposition,getq).
scalar_var_ref(vref_91,i).
post_incr(incr_71,vref_91,qrdecomposition,getq).
array_elem_inst(expr_73,q,[i,k],qrdecomposition,getq).
constant_ref(cref_92,0).
uguaglianza(expr_73,cref_92,qrdecomposition,getq).
array_elem_inst(expr_76,q,[k,k],qrdecomposition,getq).
constant_ref(cref_93,1).
uguaglianza(expr_76,cref_93,qrdecomposition,getq).
for_r(93,for(93,exit_193),init_76,exit_193,incr_77,qrdecomposition,getq).
scalar_var_def(j,init_76,qrdecomposition,getq).
scalar_var_inst(init_76,j,qrdecomposition,getq).
scalar_var_ref(vref_94,k).
uguaglianza(init_76,vref_94,qrdecomposition,getq).
scalar_var_ref(vref_95,j).
scalar_var_ref(vref_96,n).
less(exit_193,vref_95,vref_96,qrdecomposition,getq).
scalar_var_ref(vref_97,j).
post_incr(incr_77,vref_97,qrdecomposition,getq).
if_r(if_91,if_expr_191,qrdecomposition,getq).
array_elem_ref(aref_98,qr,[k,k]).
constant_ref(cref_99,0).
not_equal(if_expr_191,aref_98,cref_99,qrdecomposition,getq).
scalar_var_def(s,def_list_79,qrdecomposition,getq).
scalar_var_inst(def_list_79,s,qrdecomposition,getq).
constant_ref(cref_100,0).
uguaglianza(def_list_79,cref_100,qrdecomposition,getq).
for_r(83,for(83,exit_183),init_79,exit_183,incr_80,qrdecomposition,getq).
scalar_var_def(i,init_79,qrdecomposition,getq).
scalar_var_inst(init_79,i,qrdecomposition,getq).
scalar_var_ref(vref_101,k).
uguaglianza(init_79,vref_101,qrdecomposition,getq).
scalar_var_ref(vref_102,i).
scalar_var_ref(vref_103,m).
less(exit_183,vref_102,vref_103,qrdecomposition,getq).
scalar_var_ref(vref_104,i).
post_incr(incr_80,vref_104,qrdecomposition,getq).
scalar_var_inst(expr_82,s,qrdecomposition,getq).
scalar_var_ref(vref_105,s).
array_elem_ref(aref_106,qr,[i,k]).
array_elem_ref(aref_107,q,[i,j]).
times(oref_1016,aref_106,aref_107,qrdecomposition,getq).
plus(expr_82,vref_105,oref_1016,qrdecomposition,getq).
scalar_var_inst(expr_85,s,qrdecomposition,getq).
scalar_var_ref(vref_108,s).
array_elem_ref(aref_109,qr,[k,k]).
divide(expr_85,vref_108,aref_109,qrdecomposition,getq).
for_r(89,for(89,exit_189),init_85,exit_189,incr_86,qrdecomposition,getq).
scalar_var_def(i,init_85,qrdecomposition,getq).
scalar_var_inst(init_85,i,qrdecomposition,getq).
scalar_var_ref(vref_110,k).
uguaglianza(init_85,vref_110,qrdecomposition,getq).
scalar_var_ref(vref_111,i).
scalar_var_ref(vref_112,m).
less(exit_189,vref_111,vref_112,qrdecomposition,getq).
scalar_var_ref(vref_113,i).
post_incr(incr_86,vref_113,qrdecomposition,getq).
array_elem_inst(expr_88,q,[i,j],qrdecomposition,getq).
array_elem_ref(aref_114,q,[i,j]).
scalar_var_ref(vref_115,s).
array_elem_ref(aref_116,qr,[i,k]).
times(oref_1017,vref_115,aref_116,qrdecomposition,getq).
minus(expr_88,aref_114,oref_1017,qrdecomposition,getq).