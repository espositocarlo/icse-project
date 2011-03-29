%#############################################################################################################
% DESCRIZIONE: rappresenta il fatto che il costrutto id_2 è control dependent dal costrutto id_1. 
% SINTASSI: control_dependence(id_1, id_2, classe, metodo).
% ARGOMENTI: 
%			- id_1 = identificativo del primo costrutto
%			- id_2 = identificativo del secontro costrutto
%			- classe = nome della classe
%			- metodo = nome del metodo
%#############################################################################################################

     % for (j = 0; j < n; j++) { % questo è il cilco for 37
	  
	  % tempLrowj = matriceU[j] è innestata in ciclo for 37
	  control_dependence(37,expr_14,choleskyDecomposition,main).
      
	  % d = 0.0 è innestata in ciclo for 37
	  control_dependence(37,expr_15,choleskyDecomposition,main).
      
	  %  	for (k = 0; k < j; k++) { questo è il cilco for 28 ed è innestato nel ciclo for 37
	  control_dependence(37, 28, choleskyDecomposition,main).
      
	  %       tempLrowk = matriceU[k] è innestata nel ciclo for 28
	  control_dependence(28,expr_18,choleskyDecomposition,main).
	  
      %      s = 0.0; è innestata nel cilco for 28
	  control_dependence(28,expr_19,choleskyDecomposition,main).
	  
      %      for (i = 0; i < k; i++) { questo è il cilco for 23 ed è innestato nel ciclo for 28
	  control_dependence(28, 23, choleskyDecomposition,main).
	  
      %         s = s + tempLrowk[i]*tempLrowj[i]; questo è innestato nel cilco for 23
	  control_dependence(23,expr_22,choleskyDecomposition,main).
	  
      %      } fine ciclo for 23
	
      %      s = (matriceA[j][k] - s)/matriceU[k][k]; è innestato nel ciclo for 28
	  control_dependence(28,expr_25,choleskyDecomposition,main).
	  
      %      tempLrowj[k] = s; è innestato nel ciclo for 28
	  control_dependence(28,expr_26,choleskyDecomposition,main).
	  
      %      d = d + s*s; è innestato nel cilco for 28
	  control_dependence(28,expr_27,choleskyDecomposition,main).
	  
      %  } fine cilco for 28
	  
	  
      %   d = matriceA[j][j] - d; è innestato nel ciclo for 37
	  control_dependence(37,expr_30,choleskyDecomposition,main).
	  
      %   matriceU[j][j] = Math.sqrt(d); è innestato nel cilco for 37
	  control_dependence(37,expr_31,choleskyDecomposition,main).
	  
      %   for (m = j+1; m < n; m++) { questo è il ciclo for 35 è innestato nel ciclo for 37
	  control_dependence(37, 35, choleskyDecomposition,main).
	  
      %      matriceU[j][m] = 0.0; è innestato nel cilco for 35
	  control_dependence(35,expr_34,choleskyDecomposition,main).
	  
      %   } fine ciclo for 35
	  
      % } fine ciclo for 37



