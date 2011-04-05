%#############################################################################################################
% DESCRIZIONE: rappresenta il fatto che l'espressione id_2 è data dependent dall'espressione id_1. 
% SINTASSI: data_dependence(true, id_1, id_2, variabile, ld, classe, metodo).
% ARGOMENTI: 
%			- true = esiste la data dependence
%			- id_1 = identificativo della prima espressione
%			- id_2 = identificativo della seconda espressione
%			- variabile = nome della variabile
%			- ld = livello dipendenza
%			- classe = nome della classe
%			- metodo = nome del metodo
%#############################################################################################################
   

%        for (i = 0; i < N; i++)  { %for 24
%            for (j = 0; j <= i; j++) { %for 22
%                double sum = 0.0; % def_list_11
%                for (k = 0; k < j; k++) { %for 15
%                    sum = sum + L[i][k] * L[j][k]; % expr_14
	data_dependence(true, def_list_11, expr_14, variabile, 0, decomposizionecholesky_ver2,main).
%                }
%                if (i == j) { %if_20
%                    L[i][i] = Math.sqrt(A[i][i] - sum); %expr_17
	data_dependence(true, expr_14, expr_17, variabile, 0, decomposizionecholesky_ver2,main).
%                }
%                else { 
%                       L[i][j] = 1.0 / L[j][j] * (A[i][j] - sum); %expr_19
	data_dependence(true, expr_14, expr_19, variabile, 0, decomposizionecholesky_ver2,main).
	data_dependence(true, expr_17, expr_19, variabile, 0, decomposizionecholesky_ver2,main).
%                }
%            }
%            
%        }
