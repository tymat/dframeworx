/*
  This file is in public domain
*/
module framework.implementation.collections.array;

class Array(T) {
  
  /*struct Iterator {
    
    alias T ValueType;
    
    Iterator* opAddAssign( uint i ) {
      current += i;
      return this;
    }

    Iterator* opSubAssign( uint i ) {
      current -= i;
      return this;
    }
    
    int opEquals( Iterator it ) {
      return ( current == it.current );
    }  
    
    T value() {
      return container[ current ];
    }
    
    void value( T value ) {
      container[ current ] = value;
    }  
    
    void dump() {
      printf( "position:%d\n", current );
    }  
    
    bool outOfRange() {
      return (( current >= last ) && 
              ( current < first ) && 
              ( current >= container.size() ));
    }
    
    Array     container;
    uint      current;
    uint      first;
    uint      last;
  } */
  
  this() {
    mData.length = 256;
  }  
  
  this( uint initialCapacity ) {
    mData.length = initialCapacity;
  }

  void pushBack(T t) {
    if( mSize >= mData.length )
      mData.length = mData.length * 2;
    mData[mSize++] = t;
  }
  
  void pushBackUnique( T t ) {
    uint a;
    for( a=0; a < mSize; ++a )
      if( mData[a] == t ) 
        break;
    if( a == mSize ) pushBack( t );
  }  
  
  void copy( Array src ) {
    mData = src.mData[ 0 .. src.mData.length ];
    mSize = src.mSize;
  }
  
  T front() {
    return mData[ 0 ];
  }  

  void front( T t ) {
    mData[0] = t;
  }
  
  T back() {
    return mData[mSize - 1];
  }  

  void back( T t ) {
    mData[mSize - 1] = t;
  }

  uint  size() {
    return mSize;
  }
  
  uint capacity() {
    return mData.length;
  }  

  T opIndex( int i ) {
    return mData[i];
  }  

  T opIndexAssign( T value, uint i ) {
    return mData[i] = value ;
  }  

/*  Iterator span( uint first, uint last ) {
    Iterator it;
    it.container = this;
    // validate first
    it.current = first;
    it.first = first;
    // validate last
    it.last = last;
    return it;
  }

  Iterator fullSpan() {
    return span( 0, size() );
  }*/
  
  void clear() {
    mSize = 0;
  }
  
protected:
  T[]   mData;
  uint  mSize;
}


