/*
  This file is in public domain
*/

module framework.implementation.collections.algorithm;

template find(IteratorType) {
  static IteratorType find( IteratorType            first, 
                            IteratorType            last,
                            IteratorType.ValueType  value ) {
    for( IteratorType it = first; it != last; ++it ) {
      if( value == it.value() ) {
        return it;
      }
    }
    return last;
  }
}
/*
template min(T) {
  T min( T a, T b ) {
    return (a < b) ? a : b;
  }
}

template max(T) {
  T max( T a, T b ) {
    return (a > b) ? a : b;
  }
}
*/
struct min(T) {
  static T opCall( T a, T b ) {
    return (a < b) ? a : b;
  }
}

struct max(T) {
  static T opCall( T a, T b ) {
    return (a > b) ? a : b;
  }
}

template swap(T) {
  void swap( inout T a, inout T b ) {
    T temp = a;
    a = b;
    b = temp;
  }
}