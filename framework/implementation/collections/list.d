/*
  This file is in public domain
*/

module framework.implementation.collections.list;

class List(T) {

  class Item {
    
    this( T value ) {
      __value = value;
    }  
    
    Item getNext() {
      return __next;
    }
    
    Item getPrev() {
      return __prev;
    }  

    void setNext( Item n ) {
      __next = n; 
    }  

    void setPrev( Item p ) {
      __prev = p; 
    }  
    
    void setValue( T value ) {
      __value = value;
    }  

    T getValue( ) {
      return __value;
    }  
    
  private:
    T       __value;
    Item    __prev, __next;
  }

  struct Iterator {
    alias T ValueType;
    
    T getValue() {
      return __current.getValue();
    }  
    
    void setValue( T value ) {
      __current.setValue( value );
    } 

    Iterator* opAddAssign( uint i ) {
      while( __current && i>0 ) {
        __current = __current.getNext();
        --i;
      }  
      return this;
    }

    Iterator* opSubAssign( uint i ) {
      while( __current && i>0 ) {
        __current = __current.getPrev();
        --i;
      }  
      return this;
    }
    
    int opEquals( Iterator it ) {
      if( !__current ) {
        return ( !it.__current ) ? true : false;
      } else {
        return ( __current == it.__current );
      }  
    }  
    
  private:
    List    __container;
    Item    __current;
  }; 

  
  void pushBack( T value ) {
    if( __first ) {
      __last.setNext( new Item( value ) );
      __last.getNext().setPrev( __last );
      __last = __last.getNext();
    } else {
      __first = __last = new Item( value ); 
    }  
    __size ++;
  }
  
  void pushFront( T value ) {
    Item  item = new Item( value );
    if( __first ) {
      __first.setPrev( item );
      item.setNext( __first );
      __first = item;
    } else {
      __first = __last = item; 
    }  
    __size ++;
  }
  
  Iterator begin() {
    Iterator  it;
    it.__container = this;
    it.__current = __first;
    return it;
  }
  
  Iterator end() {
    Iterator  it;
    it.__container = this;
    it.__current = null;
    return it;
  }  
  
  uint getSize() {
    return __size; 
  }  

private:
  Item    __first, __last;
  uint    __size;
}

version (unit_test)  {
  
int main() {
  printf("starting mintl.array unittest\n");

  List!(int)  list = new List!(int);
  
  list.pushBack(1);
  list.pushBack(5);
  list.pushBack(8);

  printf("%d\n", list.getSize() );
  
  for( List!(int).Iterator it = list.begin(); it != list.end(); ++it ) {
    printf("--> %d\n", it.getValue() );
  }  

//  version (MinTLVerboseUnittest) 
  printf("finished mintl.array unittest\n");
  return 0;
}

}

