/*

  Module: linear.d
  Description:  Linear Algebra Functions
*/

module  framework.implementation.math.linear;

import  framework.implementation.math.matrix;
import  std.math;

class MatrixIsNotSquareError : Exception {
  this() {
    super( "Matrix is not square\n" );
  }
}

class MatrixIsSingularError : Exception {
  this() {
    super( "Matrix is singular\n" );
  }
}

template transpose(T) {
  Matrix!(T) transpose( Matrix!(T) X ) {
    Matrix!(T)  Y = X.compliant();

    for( int i = 0; i < X.rowSize(); ++i ) {
      for( int j = 0; j < X.columnSize(); ++j ) {
        Y[ i, j ] = X[ j, i ];
      }
    }

    return Y;
  }
}

/**
  Determinant of a Matrix
  
  Determinant is calculated by the graph method. This will be replaced by more efficient algorithm
  
*/

template determinant(T) {
  T determinant( Matrix!(T) X ) {

    if( X.rowSize() != X.columnSize() )
      throw new MatrixIsNotSquareError();
    if( X.rowSize() == 0 )
      throw new InvalidMatrixDimensionsError();

    T  Y;
    if( X.rowSize() == 1 ) {
      return X[ 0 ];
    } else if( X.rowSize() == 2 ) {
      Y = X[ 0 ] * X[ 3 ] - X[ 1 ] * X[ 2 ];
    } else {
      Y = 0;
      for( int i=0; i < X.rowSize(); ++i ) {
        T mul = 1;
        for( int j=0; j < X.columnSize(); ++j ) {
          // Optimization for zero value is needed
          mul *= X[ (i + j)%X.columnSize(), j ];
        }
        Y += mul;
      }
      for( int i=0; i < X.rowSize(); ++i ) {
        T mul = 1;
        for( int j=0; j < X.columnSize(); ++j ) {
          // Optimization for zero value is needed
          mul *= X[ (i - j)%X.columnSize(), j ];
        }
        Y -= mul;
      }
    }
    return Y;
  }
}

template adjoint(T) {
  Matrix!(T) adjoint( Matrix!(T) X ) 
  in {
    throw new Exception("adjoint is not implemented yet");
  }
  body {
    Matrix!(T) Y = X.compliant();
    return Y;
  }  
}

template arrayProduct(T) {
  Matrix!(T) arrayProduct( Matrix!(T) X, Matrix!(T) Y ) {

    Matrix!(T) Y = X.compliant();

    int   minLength = ( X.length < Y.length ) ? X.length : Y.length;
    
    for( int a=0; a < minLength; ++a )    
      Y[ a ] = X[ a ] * Y[ a ];
    
    return Y;    
  }  
}

template sumRows(T) {
  Matrix!(T) sumRows( Matrix!(T) X ) {
    Matrix!(T) Y = new Matrix!(T)( 1, X.columnSize() );
    
    Y.zero();
    
    for( int i=0; i < X.rowSize(); ++i ) {
      for( int j=0; j < X.columnSize(); ++j ) {
        Y[ 0, j ] += X[ i, j ];
      }
    }  
    
    return Y;
  }  
}

template sumCols(T) {
  Matrix!(T) sumCols( Matrix!(T) X ) {
    Matrix!(T) Y = new Matrix!(T)( X.rowSize(), 1 );

    Y.zero();
    
    for( int i=0; i < X.rowSize(); ++i ) {
      for( int j=0; j < X.columnSize(); ++j ) {
        Y[ i, 0 ] += X[ i, j ];
      }
    }  
    
    return Y;    
  }  
}  

/**
  Matrix inverse is computed by partitioning method
  
  This routine is not tested yet
*/

/*template inverse(T) {
  Matrix!(T) inverse( Matrix!(T) X ) {
/+
      COMPLEX B,A,C,R,DEL
      DIMENSION  A(N,N),B(N,N),R(100),C(100)

      DO 10 I=1,N
      DO 10 J=1,N
  10  A(I,J)=0       

      DO 40 L=1,N
      DEL=B(L,L)
      DO 30 I=1,L
      C(I)=0.
      R(I)=0.
      DO 20 J=1,L
      C(I)=C(I)+A(I,J)*B(J,L)
  20  R(I)=R(I)+B(L,J)*C(I)
  30  DEL=DEL-B(L,I)*C(I)
      C(L)=-1.
      R(L)=-1.
      DO 40 I=1,L
      C(I)=C(I)/DEL
      DO 40 J=1,L
  40  A(I,J)=A(I,J)+C(I)*R(J)
      RETURN
      END
+/
    // X : B
    // Y : A
    
    if( !X.isSquare() )
      throw new MatrixIsNotSquareError();

    Matrix!(T)  Y = X.compliant();
    T[]         C, R;
    T           DEL;
    uint        N = X.rowSize();
    
    
    
    C.length = N;
    R.length = N;
    
    Y.zero();

    // 
    
    uint k;
    
    if( fabs( X[ 0, 0 ] ) < 0.0000001 ) {
      for( k = 1; k < N; ++k ) {
        if( fabs( X[ k, 0 ] ) > 0.0000001 ) {
          X.swapRows( 0, k );
          printf("OK 1\n");
          break;
        }
      }
    }

    for( int l = 0; l < N; ++l ) {
      DEL = X[ l, l ]; // X[l,l] g'dir
      for( int i=0; i <= l; ++i ) { 
        C[i]=0;
        R[i]=0;
        for( int j=0; j <= l; ++j ) { 
          C[i] += Y[ i, j ] * X[ j, l ]; // X[ j, l ] f'tir C[i] 'de inv(A)  * f bulunur
          R[i] += X[ l, i ] * C[ i ];         // X[ l,j ] e'dir  R[i]  buradanda e * inv(A) * f
        }
        DEL -= X[ l, i ] * C[ i ]; // g-  e * inv(A) * f
      }
      C[l]=-1;
      R[l]=-1;
      for( int i=0; i <= l; ++i ) { 
        C[i] /= DEL;
        if( std.math.isinf( C[ i ] ) ) {
          throw new Exception("Matrix is singular");
        }
        for( int j=0; j <= l; ++j ) {
          Y[ i, j ] = Y[ i, j ] + C[ i ]*R[ j ];
        }  
      }  
    }

    if( k != 0 ) {
      Y.swapColumns( 0, k );
      X.swapRows( 0, k );
      printf("OK 2\n");
    }

    return Y;
  }
  
}*/

/*

  Matrix Inverse by partitioning method

  Not optimized for numerical stability
*/


template inverse(T) {
  Matrix!(T) inverse( Matrix!(T) X ) {
  
    Matrix!(T)  Y = X.compliant();
    T[]         Af, eA, R;
    T           DEL;
    uint        N = X.rowSize();
    
    Af.length = N;
    eA.length = N;
    R.length = N;
    
    Y.zero();

    
    uint k;
    
    if( std.math.isinf( 1 / X[ 0, 0 ] ) ) {
      // swap rows
      for( k=0; k<N; ++k ) {
        if( std.math.fabs( X[ k, 0 ] ) > 0.0000001 ) {
          X.swapRows( 0, k );
          break;
        }
        if( k == N ) {
          throw new MatrixIsSingularError();
        }
      }
    }

    Y[ 0, 0 ] = 1 / X[ 0, 0 ]; // Y[0,0] is inf then row or coulmn swap is needed
    
    for( uint l=1; l<N; ++l ) {
      
      DEL = X[ l, l ]; // g
      
      for( uint i=0; i<l; ++i ) {
        Af[ i ] = 0;
        eA[ i ] = 0;
        for( uint j=0; j<l; ++j ) {
          Af[ i ] += Y[ i, j ] * X[ j, l ];
          eA[ i ] += X[ l, j ] * Y[ j, i ];
        }
        DEL -= X[ l, i ] * Af[ i ]; // eAf
      }

      eA[ l ] = -1;
      Af[ l ] = -1;
      
      for( uint i=0; i<=l; ++i ) {
        eA[ i ] /= DEL;
        if( std.math.isinf( eA[i] ) ) {
          printf("Matrix is singular"); // ??? It may not enough to be singular
        }
        for( uint j=0; j<=l; ++j ) {
          Y[ j, i ] = Y[ j, i ] + Af[ j ] * eA[ i ];
        }
      }
     
    }
    
    if( k > 0 ) {
      X.swapRows( 0, k );
      Y.swapColumns( 0, k );
    }
    return Y;
  }
}

template rank(T) {

  uint rank( Matrix!(T) X ) 
  in {
    throw new Exception("rank is not implemented yet");
  }
  body {
    return 0;
  }
  
}

template eigen(T) {
  
  void eigen( Matrix!(T) X, Matrix!(T) V, Matrix!(T) D ) {
  
  }
  
}  

// Decompositions 

/**
  LU

  Not numerical stable
  
Resource:
  http://csep10.phys.utk.edu/guidry/phys594/lectures/linear_algebra/lanotes/node3.html
  
*/

template LU(T) {

  void LU( Matrix!(T) X, Matrix!(T) L, Matrix!(T) U ) {

    L.zero();
    U.zero();

    uint  M = X.rowSize(),
          N = X.columnSize();
    
    for( int i=0; i<M; ++i ) {
      for( int j=0; j<N; ++j ) {
        if( j>=i ) {
          T temp = X[ i, j ];
          for( k=0; k<i; ++k ) {
            temp -= L[ i, k ] * U[ k, j ];
          }
          U[ i, j ] = temp;
        } else {
          T temp = X[ i, j ];
          for( k=0; k<j; ++k ) {
            temp -= L[ i, k ] * U[ k, j ];
          }
          L[ i, j ] = temp / U[ j, j ];
        }
      }
    }
  
  }

}

/**
cholesky

Not numerical stable.

Resource:
Rudolf K. Bock, 
  Resource http://rkb.home.cern.ch/rkb/AN16pp/node33.html
  
*/

template cholesky(T) {
  
  void cholesky( Matrix!(T) X, Matrix!(T) Y ) {
  
    Y.zero();
    
    uint N = X.rowSize();
    
    for( int i=0; i<N; ++i ) {
      for( int j=0; j<N; ++j ) {
        if( i==j ) {
          T temp = X[ i, j ];
          for( k=0; k<i; ++k ) {
            temp -= Y[ i, k ];
          }
          Y[ i, j ] = std.math.sqrt( temp );
        } else {
          T temp = X[ i, j ];
          for( k=0; k<j; ++k ) {
            temp -= Y[ i, k ]*Y[ j, k];
          }
          Y[ i, j ] = temp / Y[ j, j ];
        }
      }
    }
  }

  Matrix!(T) cholesky( Matrix!(T) X ) {
   
    Matrix!(T)  Y = X.compliant();
    
    cholesky( X, Y );
    
    return Y;
  }
  
}

/*
  QR decomposition is done by Householder Transformation
  
  Resources:
    http://en.wikipedia.org/wiki/QR_decomposition
    http://rkb.home.cern.ch/rkb/AN16pp/node123.html#122
*/

template QR(T) {
  
  void QR( Matrix!(T) X, Matrix!(T) Q, Matrix!(T) A ) {
  
  }
  
}

template eigenDecomposition(T) {

  void eigenDecomposition( Matrix!(T) X, Matrix!(T) R, Matrix!(T) D  ) { // ???
  
  }

}

template singularValueDecomposition(T) {
  
  void singularValueDecomposition( Matrix!(T) X ) {
  
  }
  
}

/*

*/

