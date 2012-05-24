/*
  This file is in public domain
*/

module framework.implementation.gui.dockmanager;

import framework.implementation.collections.array;
import framework.implementation.gui.window;

import std.string;

interface DockType {
  void adjustRect(  Rectangle dockingRectangle, 
                    Rectangle windowRectangle, 
                    Rectangle itemRectangle,
                    bool      hasSplitter );
}  

class DockLeft : DockType {
  void adjustRect(  Rectangle dockingRectangle, 
                    Rectangle windowRectangle, 
                    Rectangle itemRectangle,
                    bool      hasSplitter ) {
    itemRectangle.left( dockingRectangle.left() );
    itemRectangle.top( dockingRectangle.top() );
    itemRectangle.width( windowRectangle.width() );
    itemRectangle.height( dockingRectangle.height() );
    dockingRectangle.left( dockingRectangle.left() + itemRectangle.width() + ((hasSplitter) ? 5 : 0) );
  }  
}

class DockTop : DockType {
  void adjustRect(  Rectangle dockingRectangle, 
                    Rectangle windowRectangle, 
                    Rectangle itemRectangle,
                    bool      hasSplitter ) {
    itemRectangle.left( dockingRectangle.left() );
    itemRectangle.top( dockingRectangle.top() );
    itemRectangle.width( dockingRectangle.width() );
    itemRectangle.height( windowRectangle.height() );
    dockingRectangle.top( dockingRectangle.top() + itemRectangle.height() + ((hasSplitter) ? 5 : 0) );
  }  
}    

class DockRight : DockType {
  void adjustRect(  Rectangle dockingRectangle, 
                    Rectangle windowRectangle, 
                    Rectangle itemRectangle,
                    bool      hasSplitter ) {
    itemRectangle.top( dockingRectangle.top() );
    itemRectangle.left( dockingRectangle.right() - windowRectangle.width() );
    itemRectangle.width( windowRectangle.width() );
    itemRectangle.height( dockingRectangle.height() );
    dockingRectangle.right( itemRectangle.left() - ((hasSplitter) ? 5 : 0) );
  }  
}

class DockBottom : DockType {
  void adjustRect(  Rectangle dockingRectangle, 
                    Rectangle windowRectangle, 
                    Rectangle itemRectangle,
                    bool      hasSplitter ) {
    itemRectangle.left( dockingRectangle.left() );
    itemRectangle.top( dockingRectangle.bottom() - windowRectangle.height() );
    itemRectangle.width( dockingRectangle.width() );
    itemRectangle.height( windowRectangle.height() );
    dockingRectangle.bottom( itemRectangle.top() - ((hasSplitter) ? 5 : 0) );
  }
}

class DockFill : DockType {
  void adjustRect(  Rectangle dockingRectangle, 
                    Rectangle windowRectangle, 
                    Rectangle itemRectangle,
                    bool      hasSplitter ) {
    itemRectangle.left( dockingRectangle.left() );
    itemRectangle.top( dockingRectangle.top() );
    itemRectangle.width( dockingRectangle.width() );
    itemRectangle.height( dockingRectangle.height() );
    dockingRectangle.right( dockingRectangle.left() ); // No more space left
    dockingRectangle.bottom( dockingRectangle.top() );
  }  
}  

/**
  DockInfo class
  
  DockFactory is recommended for creating DockTypes
*/

class DockInfo {
  
  this( DockType pDockType,   /// DockType derived classes
        Window pWindow,       /// Window to be docked
        bool pAdjustable ) {  /// Is docking adjustable. Adjustable docking means there is splitter on the opposite side of docking direction. 
                              /// Currently splitters are under development. This feature may change in future
    mDockType    = pDockType;
    mWindow      = pWindow;
    mAdjustable  = pAdjustable;
  }
  
  DockType dockType() {
    return mDockType;
  }  

  Window window() {
    return mWindow;
  }  
  
  bool adjustable() {
    return mAdjustable;
  }
protected:
  DockType      mDockType;
  Window        mWindow;
  bool          mAdjustable;
}  

class DockManager {
  
  this( Window pOwner ) {
    mDockInfos = new Array!( DockInfo );
    mOwner = pOwner;
  }  

  void add( DockInfo pDockInfo ) {
    mDockInfos.pushBack( pDockInfo );
  }  

  void resize( Rectangle r ) {
    mFreeRectangle = r;
    Rectangle itemRectangle = new Rectangle();

    for( int a=0; a<mDockInfos.size(); ++a ) {
      mDockInfos[a].dockType().adjustRect(  mFreeRectangle, 
                                            mDockInfos[a].window().windowRectangle(),
                                            itemRectangle,
                                            mDockInfos[a].adjustable() );
      mDockInfos[a].window().resize( itemRectangle );
    }  
        
  }
  
  Rectangle freeRectangle() {
    return mFreeRectangle;
  }  
protected:
  Rectangle         mFreeRectangle;
  Array!(DockInfo)  mDockInfos;
  Window            mOwner;
}  

class DockFactory {


  enum Types { /// String dockType parameters may be replaced with this. Still Thinking
    Left,
    Top,
    Right,
    Bottom,
    Fill
  }
  
  static this() {
    mDockLeft    = new DockLeft(); 
    mDockRight   = new DockRight(); 
    mDockTop     = new DockTop(); 
    mDockBottom  = new DockBottom(); 
    mDockFill    = new DockFill(); 
  }  
  
  static DockInfo create( char[] dockType, Window pWindow ) {
    return create( dockType, pWindow, false );
  }
  
  static DockInfo create( char[] dockType, Window pWindow, bool adjustable ) {
    switch( toupper( dockType ) ) {
    case "LEFT": return new DockInfo( mDockLeft,pWindow, adjustable );
    case "TOP": return new DockInfo( mDockTop, pWindow, adjustable );
    case "RIGHT": return new DockInfo( mDockRight, pWindow, adjustable );
    case "BOTTOM": return new DockInfo( mDockBottom, pWindow, adjustable );
    case "FILL": return new DockInfo( mDockFill, pWindow, adjustable );
    default: throw new Exception( "Unrecognized Docking Type" );
    }  
  }  
private:
  static DockLeft    mDockLeft;
  static DockRight   mDockRight;
  static DockTop     mDockTop;
  static DockBottom  mDockBottom;
  static DockFill    mDockFill;
}  

