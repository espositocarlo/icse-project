%   for(i=0;i<10;i++) % questo il cilco for 23
%        {
%            for(j=0;j<8;j++) % questo è il cilco for 21 innestato nel ciclo for 23
	control_dependence(23, 21, prodottomatriciale_versione_1,main).
%            {
%		for(z=0;z<5;z++) % questo è il ciclo for 19 innestato nel ciclo for 21
	control_dependence(21, 19, prodottomatriciale_versione_1,main).
%                {		
%                    appA=a[i][z]; %è expr_14 innestata nel ciclo for 19
	control_dependence(19, expr_14, prodottomatriciale_versione_1,main).
%		    		 appB=b[z][j]; %è expr_15 innestata nel ciclo for 19
	control_dependence(19, expr_15, prodottomatriciale_versione_1,main).
%                    appMul=appA*appB; %è expr_16 innestata nel cilco for 19
	control_dependence(19, expr_16, prodottomatriciale_versione_1,main).
%                    appC=c[i][j]; %è expr_17 innestata nel cilco for 19
	control_dependence(19, expr_17, prodottomatriciale_versione_1,main).
%                    c[i][j]=appC+appMul; %è expr_18 innestata nel ciclo 19
	control_dependence(19, expr_18, prodottomatriciale_versione_1,main).
%                
%		}
%            }
%        }