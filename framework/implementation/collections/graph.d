/*
  This file is in public domain
*/

module framework.implementation.collections.graph;

import framework.implementation.collections.array;

class NoAssociatedTransitionException : Exception {

  this() {
    super("No associated transition");
  }
  
}  

class Graph(T) {

  class Node {
    
    class Transition {
  
      this( Condition condition, Node destination ) {
        __condition   = condition;
        __destination = destination;
      }  
  
      class Condition {
        abstract bool opCall( T input );
        abstract bit  opEqual( Condition c );
      }
      
      bit opEqual( Transition t ) {
        return ((__condition   == t.__condition ) && 
                (__destination == t.__destination ));
      }  
      
      Condition   __condition;
      Node        __destination;
    }
    
    alias Array!( Transition )            TransitionArray;
    alias Array!( Transition ).Iterator   TransitionArrayIterator;
    
    TransitionArray      __transitions;
    
    this() {
      __transitions = new Array!( Transition )(5);
    }  
    
    void addTransition( Transition transition ) {
      __transitions.pushBackUnique( transition );
    }
    
    void copyTransitions( Node n ) {
      __transitions.copy( n.__transitions );
    }
    
    void appendTransitions( Node n ) {
      for( int a=0; a < n.__transitions.getSize(); ++a ) {
        addTransition( n.__transitions[a] );
      }  
    }    
    
    Node getNext( T input ) {
      for( TransitionArrayIterator it = __transitions.begin();
           it != __transitions.end();
           ++it ) {
        if( it.value().__condition( input ) ) {
          return it.value().__destination;
        }
      }
      throw new NoAssociatedTransitionException();
    }  

  }

  Node getFirst() {
    return __first;
  }  

  Node      __first;
}


