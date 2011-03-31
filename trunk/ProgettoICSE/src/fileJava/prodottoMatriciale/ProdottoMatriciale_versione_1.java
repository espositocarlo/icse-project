package fileJava.prodottoMatriciale;

//classe
class ProdottoMatriciale_versione_1
{
    public static void main(String[] args)
    {

        int i=0;
        int j=0;
	int z=0;
        int appMul, appA,appB,appC;
	
        int a[][]=new int [10][5];
        int b[][]=new int [5][8];
        int c[][]=new int [10][8];

/*
        for( i = 0; i<10; i++){
            for(j =0; j<5; j++){
                a[i][j]=i;
            }
        }

         for( i = 0; i<5; i++){
            for(j =0; j<8; j++){
               b[i][j]=j;
            }
        }
*/
        for(i=0;i<10;i++) // 10 = righe di A
        {
            for(j=0;j<8;j++) // 8 = colonne di B
            {
		for(z=0;z<5;z++) // 5 = righe di B
                {		
                    appA=a[i][z];
		    appB=b[z][j];
                    appMul=appA*appB;
                    appC=c[i][j];
                    c[i][j]=appC+appMul;
                
		}
            }
        }
/*
        for( i = 0; i<10; i++){
            for(j =0; j<8; j++){
                System.out.print(c[i][j]+" ");
            }
            System.out.println();
        }
*/
    }
}