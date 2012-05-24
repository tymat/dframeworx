/*
  This file is in public domain
*/

module framework.implementation.collections.queue;

private {
  import framework.implementation.collections.array;
}


class Queue(T) : private Array!(T) {
  
//  private {

//  }

  this() {
    super();
  }
  
  void push( T t ) {
    pushBack( t );
  }

  void pop() {
    mFirst++;
  }
  
  void clear() {
    clear();
    mFirst = 0;
  }
  
  T front() {
    return mData[ mFirst ];
  }

  uint size() {
    return mSize - mFirst;
  }
  
private {
  uint  mFirst; 
}

}