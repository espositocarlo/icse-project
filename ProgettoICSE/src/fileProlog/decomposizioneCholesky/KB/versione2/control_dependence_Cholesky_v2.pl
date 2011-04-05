%#############################################################################################################
% DESCRIZIONE: rappresenta il fatto che il costrutto id_2 è control dependent dal costrutto id_1. 
% SINTASSI: control_dependence(id_1, id_2, classe, metodo).
% ARGOMENTI: 
%			- id_1 = identificativo del primo costrutto
%			- id_2 = identificativo del secontro costrutto
%			- classe = nome della classe
%			- metodo = nome del metodo
%#############################################################################################################

%        for (i = 0; i < N; i++)  { %for 24
%            for (j = 0; j <= i; j++) { %for 22 innestato nel ciclo for 24
		control_dependence(24, 22, decomposizionecholesky_ver2,main).
%                double sum = 0.0; % def_list_11 innestato nel ciclo for 22
		control_dependence(22,def_list_11,decomposizionecholesky_ver2,main).
%                for (k = 0; k < j; k++) { %for 15 innestato nel ciclo for 22
		control_dependence(22, 15, decomposizionecholesky_ver2,main).
%                    sum = sum + L[i][k] * L[j][k]; % expr_14 innestata nel ciclo for 15
		control_dependence(15,expr_14,decomposizionecholesky_ver2,main).
%                } %fine for 15
%                if (i == j) { %if_20 innestato nel ciclo for 22
		control_dependence(22,if_20,decomposizionecholesky_ver2,main).
%                    L[i][i] = Math.sqrt(A[i][i] - sum); %expr_17 innestato nel if_20
		control_dependence(if_20,expr_17,decomposizionecholesky_ver2,main).
	
%                } %fine if_20
%                else { % else_19 innestato nel if_20
		control_dependence(if_20,else_19,decomposizionecholesky_ver2,main).
%                       L[i][j] = 1.0 / L[j][j] * (A[i][j] - sum); % expr_19
		control_dependence(else_19,expr_19,decomposizionecholesky_ver2,main).
	
%                } %fine else_19
%            } %fine for 22
%            
%        } % fine for 24    


