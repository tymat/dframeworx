/*
  This file is in public domain
*/

module framework.implementation.gui.toolbox;

import framework.implementation.gui.window;

class ToolBox : Window {

  this( Window parent, Rectangle r ) {
    add( new SizeEvent( &onSize ) );
    super( parent, r, null, WS_CHILD | WS_VISIBLE | WS_BORDER, 0 );
  }
  
  void onSize( SizeEventArgs e ) {
    Window       currentChild = child();
    Rectangle    itemRectangle = new Rectangle;

    adjustRectToParent( clientRectangle(), itemRectangle ); // abstract

    while( currentChild !is null ) {
      adjustRectToChild( currentChild.windowRectangle(), itemRectangle ); // abstract
      currentChild.resize( itemRectangle );
      adjustRectToNextPosition( currentChild.windowRectangle(), itemRectangle ); // abstract
      currentChild = currentChild.next();
    }
  }
  
  abstract void adjustRectToParent( Rectangle source, inout Rectangle destination );
  abstract void adjustRectToChild( Rectangle source, inout Rectangle destination );
  abstract void adjustRectToNextPosition( Rectangle source, inout Rectangle destination );
  
}

class VerticalToolBox : ToolBox {
  
  this( Window parent, Rectangle r ) {
    super( parent, r );
  }
  
  override void adjustRectToParent( Rectangle source, inout Rectangle destination ) {
    destination.width( source.width() );
  }
  
  override void adjustRectToChild( Rectangle source, inout Rectangle destination ) {
    destination.height( source.height() );
  }
  
  override void adjustRectToNextPosition( Rectangle source, inout Rectangle destination  ) {
    destination.top( destination.top() + source.height() );
  }
  
}

class HorizontalToolBox : ToolBox {
  
  this( Window parent, Rectangle r ) {
    super( parent, r );
  }

  override void adjustRectToParent( Rectangle source, inout Rectangle destination ) {
    destination.height( source.height() );
  }
  
  override void adjustRectToChild( Rectangle source, inout Rectangle destination ) {
    destination.width( source.width() );
  }
  
  override void adjustRectToNextPosition(  Rectangle source, inout Rectangle destination  ) {
    destination.left( destination.left() + source.width() );
  }
  
}    

