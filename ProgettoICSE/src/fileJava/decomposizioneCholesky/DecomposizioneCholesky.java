/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package fileJava.decomposizioneCholesky;

/**
 *
 * @author Carlo
 */
public class DecomposizioneCholesky {


/** Cholesky Decomposition.

Data una matrice quadrata matriceA definita positiva
si puo' trovare una matrice triangolare superiore matriceU con diagonale positiva
tale che:
matriceA = Transposed(matriceU) * matriceU
Tale scrittura si chiama decomposizione di Cholesky.

 */

   /** Cholesky algorithm for symmetric and positive definite matrix.
   */

  public static void main(String[] args){


    //numero righe e colonne matrici
    int n = 3;
    //dichiarazione matriceA
  //  double[][] matriceA = new double[n][n];


   double[][] matriceA = {
        { 1, 3, 1 },
        { 3, 11, 1 },
        {1, 1, 6}
    };

    //dichiarazione matriceU
    double[][] matriceU = new double[n][n];
    //dichiarazione tempL
    double[] tempLrowj = new double[n];
    double[] tempLrowk = new double[n];
    //indici dei for
    int j;
    int k;
    int i;
    int m;

    //variabili temp
    double d;
    double s;

      // Main loop.
      for (j = 0; j < n; j++) {
         tempLrowj = matriceU[j];
         d = 0.0;
         for (k = 0; k < j; k++) {
             tempLrowk = matriceU[k];
            s = 0.0;
            for (i = 0; i < k; i++) {
               s = s + tempLrowk[i]*tempLrowj[i];
            }
            s = (matriceA[j][k] - s)/matriceU[k][k];
            tempLrowj[k] = s;
            d = d + s*s;
         }
         d = matriceA[j][j] - d;
         matriceU[j][j] = Math.sqrt(d);
         for (m = j+1; m < n; m++) {
            matriceU[j][m] = 0.0;
         }
      }

//     double[][] matriceX = new double[n][n];
//
//
//      // Risolve matriceU*Y = matriceX;
//      for (int k = 0; k < n; k++) {
//         for (int i = k+1; i < n; i++) {
//            for (int j = 0; j < n; j++) {
//               matriceX[i][j] = matriceX[i][j] - matriceX[k][j]*matriceU[i][k];
//            }
//         }
//         for (int j = 0; j < n; j++) {
//            matriceX[k][j] = matriceX[k][j] / matriceU[k][k];
//         }
//      }
//       for(int i = 0;i<n;i++){
//            System.out.println();
//                for(int j=0;j<n;j++){
//                    System.out.print(" " +matriceX[i][j]);
//                }
//            }
// System.out.println();
//
//      // risolve matriceU'*matriceX = Y;
//      for (int k = n-1; k >= 0; k--) {
//         for (int j = 0; j < n; j++) {
//            matriceX[k][j] = matriceX[k][j] / matriceU[k][k];
//         }
//         for (int i = 0; i < k; i++) {
//            for (int j = 0; j < n; j++) {
//               matriceX[i][j] = matriceX[i][j] - matriceX[k][j] * matriceU[k][i];
//            }
//         }
//      }
//
//  for(int i = 0;i<n;i++){
//            System.out.println();
//                for(int j=0;j<n;j++){
//                    System.out.print(" " +matriceX[i][j]);
//                }
//            }
// System.out.println();
//      //stampa matrice MATRICE:
       //Stampo la matrice A
//        for(int i = 0;i<n;i++){
//            System.out.println();
//                for(int j=0;j<n;j++){
//                    System.out.print(" " +matriceA[i][j]);
//                }
//            }
//    System.out.println();
//
//    for(int i = 0;i<n;i++){
//            System.out.println();
//                for(int j=0;j<n;j++){
//                    System.out.print(" " +matriceX[i][j]);
//                }
//            }
// System.out.println();
//

 // STAMPA matriceU
 for(i = 0;i<n;i++){
            System.out.println();
                for(j=0;j<n;j++){
                    System.out.print(" " +matriceU[i][j]);
                }
            }

 System.out.println();
   }
}

