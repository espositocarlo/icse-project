%	//primo ciclo for sulle righe di A
%    for (int i=0; i<3; i++) % � il ciclo for 14
%		//secondo ciclo for sulle colonne di R
%        for (int j=0; j<3; j++) { % � il cilco for 13
	control_dependence(14, 13, prodottomatriciale_versione_2,main).
%            //terzo cilco for sulle colonne di B
%			for (int k=0; k<3; k++) % � il ciclo for 11
	control_dependence(13, 11, prodottomatriciale_versione_2,main).
%                R[i][j] = R[i][j] + A[i][k] * B[k][j]; % � expr_11
	control_dependence(11, expr_11, prodottomatriciale_versione_2,main).
%        }
%