%   for(i=0;i<10;i++) % questo il cilco for 23
%        {
%            for(j=0;j<8;j++) % questo � il cilco for 21 
	
%            {
%		for(z=0;z<5;z++) % questo � il ciclo for 19
	
%                {		
%                    appA=a[i][z]; %� expr_14 
	
%		    		 appB=b[z][j]; %� expr_15 
	
%                    appMul=appA*appB; %� expr_16 
	data_dependence(true, expr_14, expr_16, variabile, 0, prodottomatriciale_versione_1,main).
	data_dependence(true, expr_15, expr_16, variabile, 0, prodottomatriciale_versione_1,main).
%                    appC=c[i][j]; %� expr_17
	
%                    c[i][j]=appC+appMul; %� expr_18 
	data_dependence(true, expr_17, expr_18, variabile, 0, prodottomatriciale_versione_1,main).
	data_dependence(true, expr_16, expr_18, variabile, 0, prodottomatriciale_versione_1,main).
%                
%		}
%            }
%        }