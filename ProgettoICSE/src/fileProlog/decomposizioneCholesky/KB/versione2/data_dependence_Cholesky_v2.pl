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
    % for (j = 0; j < n; j++) {
        % tempLrowj = matriceU[j];  			-> expr_14
        % d = 0.0; 								-> expr_15
    % for (k = 0; k < j; k++) {
         % tempLrowk = matriceU[k]; 			-> expr_18
         % s = 0.0;  							-> expr_19
    % for (i = 0; i < k; i++) {
          % s = s + tempLrowk[i]*tempLrowj[i];  -> expr_22
	data_dependence(true, expr_19, expr_22, variabile, 0, choleskyDecomposition,main).
	data_dependence(true, expr_18, expr_22, variabile, 0, choleskyDecomposition,main).
	data_dependence(true, expr_14, expr_22, variabile, 0, choleskyDecomposition,main).
		% }
     % s = (matriceA[j][k] - s)/matriceU[k][k]; -> expr_25
	data_dependence(true, expr_22, expr_25, variabile, 0, choleskyDecomposition,main).
     
	 % tempLrowj[k] = s; 						-> expr_26
	data_dependence(true, expr_25, expr_26, variabile, 0, choleskyDecomposition,main).
     
	 % d = d + s*s;								-> expr_27
	data_dependence(true, expr_15, expr_27, variabile, 0, choleskyDecomposition,main).
	data_dependence(true, expr_25, expr_27, variabile, 0, choleskyDecomposition,main).	
     %    }
     % d = matriceA[j][j] - d;					-> expr_30
	data_dependence(true, expr_27, expr_30, variabile, 0, choleskyDecomposition,main).
     
	 %    matriceU[j][j] = Math.sqrt(d);		-> expr_31
	data_dependence(true, expr_30, expr_31, variabile, 0, choleskyDecomposition,main).
     %    for (m = j+1; m < n; m++) {
     %      matriceU[j][m] = 0.0;				-> expr_34
     %    }
     % }