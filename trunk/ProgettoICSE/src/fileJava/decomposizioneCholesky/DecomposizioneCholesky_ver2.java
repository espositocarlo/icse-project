/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package fileJava.decomposizioneCholesky;

/**
 *
 * @author Carlo
 */
public class DecomposizioneCholesky_ver2 {
     public static void main(String[] args)
    {
     // return Cholesky factor L of psd matrix A = L L^T
        int N = 3;

      double[][] A = new double[N][N];
    /*
        double[][] A = {
        { 1, 3, 1 },
        { 3, 11, 1 },
        {1, 1, 6}
    };
     */

        double[][] L = new double[N][N];
        int i=0;
        int j=0;
        int k=0;


        for (i = 0; i < N; i++)  {
            for (j = 0; j <= i; j++) {
                double sum = 0.0;
                for (k = 0; k < j; k++) {
                    sum = sum + L[i][k] * L[j][k];
                }
                if (i == j) {
                    L[i][i] = Math.sqrt(A[i][i] - sum);
                }
                else {
                       L[i][j] = 1.0 / L[j][j] * (A[i][j] - sum);
                }
            }
            
        }
 /* Stampa matrice L
for(i = 0;i<N;i++){
            System.out.println();
                for(j=0;j<N;j++){
                    System.out.print(" " +L[i][j]);
                }
            }
  
  */
    }

}
