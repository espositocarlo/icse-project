% calcolo qr
control_dependence(48,def_list_4,qrdecomposition,qrdecomposition).
control_dependence(48,def_list_5,qrdecomposition,qrdecomposition).
control_dependence(48,19,qrdecomposition,qrdecomposition).
control_dependence(48,if_22,qrdecomposition,qrdecomposition).
control_dependence(48,27,qrdecomposition,qrdecomposition).
control_dependence(48,expr_29,qrdecomposition,qrdecomposition).
control_dependence(48,45,qrdecomposition,qrdecomposition).
control_dependence(48,expr_47,qrdecomposition,qrdecomposition).
control_dependence(19,if_16,qrdecomposition,qrdecomposition).
control_dependence(19,expr_18,qrdecomposition,qrdecomposition).
control_dependence(if_expr_116,expr_8,qrdecomposition,qrdecomposition).
control_dependence(if_expr_116,expr_9,qrdecomposition,qrdecomposition).
control_dependence(if_expr_115,expr_11,qrdecomposition,qrdecomposition).
control_dependence(if_expr_115,expr_12,qrdecomposition,qrdecomposition).
control_dependence(else_14,expr_14,qrdecomposition,qrdecomposition).        
control_dependence(if_expr_122,expr_21,qrdecomposition,qrdecomposition).
control_dependence(27,expr_26,qrdecomposition,qrdecomposition).
control_dependence(45,def_list_33,qrdecomposition,qrdecomposition).
control_dependence(45,37,qrdecomposition,qrdecomposition).
control_dependence(37,expr_36,qrdecomposition,qrdecomposition).
control_dependence(45,expr_39,qrdecomposition,qrdecomposition).
control_dependence(45,43,qrdecomposition,qrdecomposition).
control_dependence(43,expr_42,qrdecomposition,qrdecomposition).

% get r 
control_dependence(65,63,qrdecomposition, getr). 
control_dependence(63,if_61,qrdecomposition, getr). 
control_dependence(if_expr_161,expr_55, qrdecomposition, getr ). 
control_dependence(if_expr_160,expr_57, qrdecomposition, getr ). 
control_dependence(else_59,expr_59, qrdecomposition, getr ). 


control_dependence(95,74, qrdecomposition, getq ). 
control_dependence(74,expr_73, qrdecomposition, getq ). 
control_dependence(95,expr_76, qrdecomposition, getq ). 
control_dependence(95,93, qrdecomposition, getq ). 
control_dependence(93,if_91, qrdecomposition, getq ). 
control_dependence(if_expr_191,def_list_79, qrdecomposition, getq ). % IF --> EXPR_IN_IF
control_dependence(if_expr_191,83, qrdecomposition, getq ). 		 % IF --> CICLO FOR 4
control_dependence(if_expr_191,expr_85,qrdecomposition,getq).		 % IF --> EXPR DOPO CICLO FOR 4
control_dependence(if_expr_191,89, qrdecomposition, getq ). 		 % IF --> CICLO FOR 5
control_dependence(83,expr_82, qrdecomposition, getq ). 			 % CICLO FOR 4 -> EXPR IN CICLO FOR 4
control_dependence(89,expr_88,qrdecomposition, getq ). 				 % CICLO FOR 5 EXPR IN CICLO FOR 5



data_dependence(true,def_list_4,expr_8,a,0,qrdecomposition,qrdecomposition).
data_dependence(true,expr_8,expr_9,a,0,qrdecomposition,qrdecomposition).
data_dependence(true,def_list_4,expr_11,a,0,qrdecomposition,qrdecomposition).
data_dependence(true,expr_11,expr_12,a,0,qrdecomposition,qrdecomposition).
data_dependence(true,expr_14,expr_18,a,0,qrdecomposition,qrdecomposition).
data_dependence(true,expr_9,expr_18,a,0,qrdecomposition,qrdecomposition).
data_dependence(true,expr_12,expr_18,a,0,qrdecomposition,qrdecomposition).
data_dependence(true,expr_18,expr_21,a,0,qrdecomposition,qrdecomposition).
data_dependence(true,expr_21,expr_26,a,0,qrdecomposition,qrdecomposition).
data_dependence(true,expr_26,expr_29,a,0,qrdecomposition,qrdecomposition).
data_dependence(true,def_list_33,expr_36,a,0,qrdecomposition,qrdecomposition).
data_dependence(true,def_list_33,expr_39,a,0,qrdecomposition,qrdecomposition).
data_dependence(true,expr_39,expr_42,a,0,qrdecomposition,qrdecomposition).
data_dependence(true,expr_21,expr_47,a,0,qrdecomposition,qrdecomposition).
			   
data_dependence(true,expr_73,expr_76,a,0,qrdecomposition,getq).		% ESPRESSIONE NEL CICLO FOR 2 --> EXPR IN CICLO 1
data_dependence(true,expr_76,if_expr_191,a,0,qrdecomposition,getq). % EXPR IN CICLO FOR 1 --> E EXPR IN IF
data_dependence(true,def_list_79,expr_82,a,0,qrdecomposition,getq). %EXPR_IN_IF --> EXPR_IN_CICLO_FOR4
data_dependence(true,expr_82,expr_85,a,0,qrdecomposition,getq).     %s= nel ciclo for 4 e quello dopo
data_dependence(true,expr_85,expr_88,a,0,qrdecomposition,getq).     %s dopo il ciclo for e quello nel ciclo 5
