package fileJava.prodottoMatriciale;

/**
 *
 * @author Carlo
 */
public class ProdottoMatriciale_versione_2 {

     public static void main(String[] args) {
    /*
         //Dichiaro matrice B
	double[][] B = {
                    {1.0, 3.0, 1.0},
                    {0.0, Math.sqrt(2.0), -Math.sqrt(2.0)},
                    {0.0, 0.0, Math.sqrt(3.0) }
            };
     */

/*
        //Riempio la matrice A
        for(int i = 0;i<2;i++){
                for(int j=0;j<3;j++){
                    A[i][j] = i+j+1;
                }
            }
         //Stampo la matrice A
        for(int i = 0;i<2;i++){
                for(int j=0;j<3;j++){
                    System.out.println(A[i][j]);
                }
            }
*/
	//Dichiaro matrice B
	/*
         double[][] A = {
                    {1.0, 0.0, 0.0},
                    {3.0, Math.sqrt(2.0), 0.0},
                    {1.0, -Math.sqrt(2.0), Math.sqrt(3.0) }
                      };
       */
/*
   //Riempio la matrice B
   for(int i = 0;i<3;i++){
                for(int j=0;j<2;j++){
                    B[i][j] = i+j+1;
                }
            }

 //Stampo la matrice B
        for(int i = 0;i<3;i++){
                for(int j=0;j<2;j++){
                    System.out.println(B[i][j]);
                }
            }

 */
	//Dichiaro matrici
	double[][] A = new double [3][3];
        double[][] B = new double [3][3];
        double[][] R = new double [3][3];

        /*
        double[][] A = {
            { 1, 1, 3 },
            { 2, 1, 3 },
            {1, -2, 1}
            };
        double[][] B = {
            { 0, 1, 2 },
            { 2, 3, -2 },
            {3, -1, 1}
            };
          */
        int i;
        int j;
        int k;
	//primo ciclo for sulle righe di A
    for (i=0; i<3; i++)
		//secondo ciclo for sulle colonne di R
        for (j=0; j<3; j++) {
          //  R[i][j]=0;
            //terzo cilco for sulle colonne di B
			for (k=0; k<3; k++)
                R[i][j] = R[i][j] + A[i][k] * B[k][j];
        }


        //Stampo la matrice risultato
      /*
         for(i = 0;i<3;i++){
            
                for(j=0;j<3;j++){
                    System.out.print(R[i][j]+" ");
                }

                System.out.println();
            }
        */


}

}
