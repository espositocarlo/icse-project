package fileJava.decomposizioneHouseholder;


public class QRDecomposition{

   public int m = 5,
              n = 3;
   public  double[][] r     = new double[n][n];
   public  double[][] a     = new double[m][n];
   private double[]   rdiag = new double[n];
   private double[][] qr    = new double[m][n];
   public  double[][] q 	= new double[m][n];
      
   public QRDecomposition () {
            
      qr=a;

      // concetto: loop sulle colonne
      for (int k = 0; k < n; k++) {									 //48
		
							
         double nrm = 0;											//def_list_4
         double v = 0;												//def_list_5
         // concetto : calcolo della norma di un vettore
         // (che è la colonna della matrice qr
         for (int i = k; i < m; i++) 								//19
         {
              if (Math.abs(nrm) > Math.abs(qr[i][k])) {				//if_16,if_expr_116
                 
				 v = qr[i][k]/nrm;									//expr_8
                 v = Math.abs(nrm) * Math.sqrt(1+v*v);				//expr_9
				 
              } else if (qr[i][k] != 0) {							//else_if_15,if_expr_115
				 v = nrm/qr[i][k];									//expr_11
                 v = Math.abs(qr[i][k]) * Math.sqrt(1+v*v);			//expr_12
				 
			  } else {												//else_14
				v = 0.0;											//expr_14
              }
               nrm= v;												//expr_18
			    
         }
			   
            // inversione condizionata della norma
            if (qr[k][k] < 0) 										//if_22,if_expr_122
            {
               nrm = -1 * nrm;										//expr_21
            }
            // normalizzazione della colonna
            for (int i = k; i < m; i++)								//27
            {
			       qr[i][k] = qr[i][k] / nrm;							//expr_26
            }
            // incremento dell elemento k sulla diagonale di qr
            qr[k][k] = qr[k][k] + 1.0;								//expr_29

            // trasformazione dalla colonna K+1
            int j;
			for (j = k+1; j < n; j++) {								//45
			
               double s = 0.0; 										//def_list_33
               for (int i = k; i < m; i++)							//37
               {
                  s = s + qr[i][k] * qr[i][j];						//expr_36
               }
               s = -s/qr[k][k];										//expr_39
               for (int i = k; i < m; i++)							//43
               {
                  qr[i][j] = qr[i][j] + s*qr[i][k];					//expr_42
               }
            }
         rdiag[k] = -1 * nrm;										//expr_47
      }
   }

   public void getR () {
     
      //concetto: creazione di output_r a partire da qr
      for (int i = 0; i < n; i++) {
         for (int j = 0; j < n; j++) {
            if (i < j) {
               r[i][j] = qr[i][j];
            } else if (i == j) {
               r[i][j] = rdiag[i];
            } else {
               r[i][j] = 0.0;
            }
         }
      }
     }

	 public void getQ ()
	 {
	 int k ;
      for (k = n-1; k >= 0; k--) 
	  {
         for (int i = 0; i < m; i++) 
		 {
            q[i][k] = 0;
         }
         
		 q[k][k] = 1;

         for (int j = k; j < n; j++) 
		 {
            if (qr[k][k] != 0) 
			{
               double s = 0;
               for (int i = k; i < m; i++) 
			   {
                  s = s + qr[i][k]*q[i][j];
               }
               s = s/qr[k][k];

               for (int i = k; i < m; i++) 
			   {
                  q[i][j] = q[i][j] - s*qr[i][k];
               }
            }
         }
      }
   }
   
}



