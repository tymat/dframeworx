module framework.implementation.math.matrix;
/*
  Module : matrix
*/
private {
  import framework.implementation.collections.algorithm;
  import framework.implementation.math.matrixerrors;
}

class Matrix( T ) {
  
  private this() {
  
  }
  
  this( uint rows, uint cols ) {

    if( rows == 0 )
      throw new InvalidRowLength;

    if( cols == 0 )
      throw new InvalidColLength;
    
    mRowSize = rows;
    mColumnSize = cols;
    
    mData.length = mRowSize * mColumnSize;
    
  }
  
  Matrix opAdd( Matrix m ) {
    if( (mColumnSize != m.mColumnSize) || (mRowSize != m.mRowSize ) )
      throw new IncompatibleMatrices;
      
    Matrix result = new Matrix( mRowSize, mColumnSize );
    
    for( int a=0; a<mData.length; ++a ) {
      result[ a ] = mData[ a ] + m.mData[ a ];
    }
    
    return result;
  }

  Matrix opSub( Matrix m ) {
    if( (mColumnSize != m.mColumnSize) || (mRowSize != m.mRowSize ) )
      throw new IncompatibleMatrices;
      
    Matrix result = new Matrix( mRowSize, mColumnSize );
    
    for( int a=0; a<mData.length; ++a ) {
      result[ a ] = mData[ a ] - m.mData[ a ];
    }
    
    return result;
  }

  Matrix opMul( Matrix m ) {

    if( mColumnSize != m.mRowSize ) 
      throw new IncompatibleMatrices;

    Matrix  result = new Matrix( mRowSize, m.mColumnSize );
    
    for( int k=0; k < m.mColumnSize ; ++k ) {
      for( int i=0; i < mRowSize ; ++i ) {
        T   sum = 0;
        for( int j=0; j < mColumnSize; ++j ) {
          sum += this[ i, j ] * m[ j , k ];
        }
        result[ i, k ] = sum;
      }
    }
    return result;
  }

  Matrix opAddAssign( Matrix m ) {
    if( (mColumnSize != m.mColumnSize) || (mRowSize == m.mRowSize ) )
      throw new IncompatibleMatrices;
      
    for( int a=0; a<mData.length; ++a ) {
      mData[ a ] += m.mData[ a ];
    }
    return this;
  }

  Matrix opSubAssign( Matrix m ) {
    if( (mColumnSize != m.mColumnSize) || (mRowSize == m.mRowSize ) )
      throw new IncompatibleMatrices;
      
    for( int a=0; a<mData.length; ++a ) {
      mData[ a ] -= m.mData[ a ];
    }
    return this;
  }

  Matrix opMulAssign( Matrix m ) {
  
    if( mColumnSize != m.mRowSize ) 
      throw new IncompatibleMatrices;

    T[]  tmp;
    
    tmp.length = mData.length;
    
    for( int k=0; k<mColumnSize; ++k ) {
      for( int i=0; i<mRowSize; ++i ) {
        T   sum = 0;
        for( int j=0; j<mColumnSize; ++j ) {
          sum += this[ i, j ] * m[ j , k ];
        }
        tmp[ k * mRowSize + i ] = sum;
      }
    }
    
    delete mData;
    mData = tmp;

    return this;
  }

  Matrix opMulAssign( T pScalar ) {
    
    for( int a=0; a<mData.length; ++a ) {
      mData[ a ] *= pScalar;
    }
    
    return this;
  }
  
  
  Matrix column( uint colIndex ) {
    Matrix result = new Matrix( mRowSize, 1 );
    for( int i=0; i < mRowSize; ++i ) {
      result[ i, 0 ] = this[ i, colIndex ];
    }  
    return result;
  }
  
  Matrix row( uint rowIndex ) {
    Matrix result = new Matrix( 1, mColumnSize );
    for( int j=0; j < mColumnSize; ++j ) {
      result[ 0, j ] = this[ rowIndex, j ];
    }  
    return result;
  }  

  Matrix compliant() {
    return new Matrix( mRowSize, mColumnSize );
  }
  
  Matrix dup() {
    Matrix result = compliant(); 
    result.mData[] = mData[ 0 .. mData.length ];
    return result;
  }
  
/*  Matrix sub( uint pLeft, uint pTop, uint pRight, uint pBottom ) {
    Matrix m = new Matrix;
    m.mRowSize = ( pRight - pLeft );
    m.mColumnSize = ( pBottom - pTop );
    m.mData = mData; // ???
    return 
  }*/
  
  void fill( T value ) {
    for( uint a=0; a < mData.length; ++a ) {
      mData[ a ] = value;
    }
  }  

  void copy( Matrix src ) {
    for( uint a=0; a < mData.length; ++a ) {
      mData[ a ] = src.mData[ a ];
    }
  }  

  
  void zero() {
    fill( 0 );
  }  

  void identity() {
    fill( 0 );
    mixin min!(T); // It is better to define the template as mixin this prevents sysmbol undefined error
    for( int i=0; i < min( mRowSize, mColumnSize ) ; ++i ) {
      this[ i, i ] = 1;
    }
  }
  
  T opIndex( int idx ) {
    return mData[ idx ];
  }  

  T opIndexAssign( T value, int idx ) {
    return mData[ idx ] = value;
  }  

  T opIndex( int i, int j ) {
    return mData[ mRowSize * j + i ];
  }

  T opIndexAssign( T value, int i, int j ) {
    return mData[ mRowSize * j + i ] = value;
  }

  void swapRows( uint a, uint b ) {
    uint    offsetA = a,
            offsetB = b;
    mixin swap!(T);
    for( int j = 0; j < mColumnSize; ++j, offsetA += mRowSize, offsetB += mRowSize ) {
      swap( mData[ offsetA ], mData[ offsetB ] );//  when framework.implementation.collections.algorithm's swap is used linker generates an error. It is due to the inout attribute of the function parameters
//      swap( mData[ offsetA ], mData[ offsetB ] );
    }
  }

  void swapColumns( uint a, uint b ) {
    uint    offsetA = a * mRowSize,
            offsetB = b * mRowSize;
    for( int j = 0; j < mRowSize; ++j, ++offsetA, ++offsetB ) {
      mixin swap!(T);
      swap( mData[ offsetA ], mData[ offsetB ] ); // when framework.implementation.collections.algorithm's swap is used linker generates an error. 
//      swap( mData[ offsetA ], mData[ offsetB ] );
    }
  }
  
/*  void swap( inout T a, inout T b ) {
    T temp;
    temp = a;
    a = b;
    b = temp;
  }*/

  
  int rowSize() {
    return mRowSize;
  }

  int columnSize() {
    return mColumnSize;
  }
  
  bool isSquare() {
    return cast(bool) ( mRowSize == mColumnSize );
  }
  
  T* ptr() {
    return mData.ptr;
  }
  
  void dump() {
    for( int i=0; i<rowSize(); ++i ) {
      for( int j=0; j<columnSize(); ++j ) {
        printf("%f ", this[ i, j ] );
      }
      printf("\n");
    }
  }
  
protected:
  T[]               mData;
  uint              mRowSize, 
                    mColumnSize;
}

/*void dump( Matrix!(float) m ) {
  for( int i=0; i<m.rowSize(); ++i ) {
    for( int j=0; j<m.columnSize(); ++j ) {
      printf("%f ", m[ i, j ] );
    }
    printf("\n");
  }
}*/