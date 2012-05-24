/*
  This file is in public domain
*/

module framework.implementation.collections.tree;

class Tree(T) {
  
  class Node {
  
    this( Tree pContainer, T pValue, Node pParent ) {
      mContainer  = pContainer;
      mValue      = pValue;
      mParent     = pParent;
    }
  
    T         mValue;
    Tree      mContainer;
    Node      mNext, mChild, mParent;
  }
  
  Node root() {
    return  mRoot;
  }
  
  void root( T pValue ) {
    mRoot = new Node( this, pValue, null );
  }
  
  void insertChild( Node pParent, T pValue )
  in {
    assert( !(pParent is null) );
  }
  body {
  
    Node newNode = new Node( this, pValue, pParent );
  
    if( pParent->mChild ) {
      Node currentChild = pParent.mChild;
      while( currentChild.mNext  ) {
        currentChild = currentChild.mNext;
      }
      currentChild.mNext = newNode;
    } else {
      pParent.mChild = newNode;
    }

  }
  
  void insertAfter( Node pPrevious, T pValue ) {
    Node newNode = new Node( this, pValue, pPrevious.mParent );
    
    newNode.mNext = pPrevious.mNext;
    pPrevious.mNext = newNode;
    
  }
  
  struct Iterator {
    
    Iterator* opAddAssign( int i ) {
    
    }
  
  }
  
  
  uint    mSize;
  
  Node    mRoot,

}