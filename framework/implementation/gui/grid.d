/*
  This file is in public domain
*/

module framework.implementation.gui.grid;

import framework.implementation.gui.window;
import framework.implementation.gui.controls;

import framework.implementation.collections.array;
import framework.implementation.collections.algorithm;



class Grid : Window {
  
  static class Column {
    
    this( char[] n, int w, Formatter f ) {
      mName =      n;
      mText =      n;
      mWidth =     w;
      mFormatter=  f;
    }  
    
    char[] name() {
      return mName;
    }
    
    char[] text() {
      return mText;
    }
    
    void text( char[] value ) {
      mText = value;
    }
    
    int width() {
      return mWidth;
    }
    
    Formatter formatter() {
      return mFormatter;
    }
  
    void draw( Graphics pGraphics, Rectangle pRectangle ) {
      pGraphics.drawEdge( pRectangle, Graphics.Edges.Raised );
      pGraphics.textColor( RGB( 0, 0, 0 ) );
      pGraphics.backgroundMode( Graphics.BackgroundModes.Transparent );
      pGraphics.drawText( pRectangle, mText );
    }
  
  public:
    char[]        mName,
                  mText;
    int           mWidth;
    Formatter mFormatter;
  }
  
  static class Formatter {
    abstract void draw( Graphics , Rectangle, bool selected );
  }
  
  static class Adaptor { // abstract
  
    this( Grid pGrid ) {
      ownerGrid( pGrid );
      pGrid.adaptor( this );
      pGrid.adjustScrollBars();
      __selection = new Rectangle( -1, -1, -1, -1);
    }  
    
    void ownerGrid( Grid value ) {
      mOwnerGrid = value;      
    }  
    
    int calculateDocumentHeight() {
      return rowSize() * mOwnerGrid.rowHeight();
    }  

    int calculateDocumentWidth() {
      int   totalWidth;
      for( int a=0; a<mOwnerGrid.columns().size(); ++a ) {
        totalWidth += mOwnerGrid.columns()[ a ].width();
      }
      return totalWidth;
    }
    
    abstract Formatter opIndex( int row, int col );
    
    int firstVisibleRow() {
      return ( mOwnerGrid.position().y() / mOwnerGrid.rowHeight() );
    }
    
    int lastVisibleRow() {
      int lvr = mOwnerGrid.position().y() + mOwnerGrid.displayRectangle().height();
      if( mOwnerGrid.columnHeadersVisible() )
        lvr -= mOwnerGrid.rowHeight();
      lvr /= mOwnerGrid.rowHeight();
      lvr++;
      return ( lvr >= rowSize() ) ? rowSize()-1 : lvr;
    }
      
    int firstVisibleColumn() {
      int   totalWidth;
      int   a;
      for( a=0; ( a < colSize() ) && ( totalWidth < mOwnerGrid.position().x() ); a++ ) {
        totalWidth += mOwnerGrid.columns()[ a ].width();
      }
      return a--;
    };
    
    int lastVisibleColumn() {
      int   totalWidth;
      int   a;
      for( a=0; ( a < colSize() ) && totalWidth < ( mOwnerGrid.position().x() + mOwnerGrid.displayRectangle().width() ); a++ ) {
        totalWidth += mOwnerGrid.columns()[ a ].width();
      }
      return ( a >= colSize() ) ? colSize()-1 : a;
    }
      
    int  colSize() {
      return mOwnerGrid.columns().size();
    };

    void updateSelection( int left, int top, int right, int bottom ) {
      __selection( left, top, right, bottom );
    }
    
    Rectangle selection() {
      return __selection;
    }
    
    
    bool isSelectionValid() {
      return ((__selection.x() >=0) && 
              (__selection.y() >=0) && 
              (__selection.width() >=0) && 
              (__selection.height() >=0 ) && 
              (__selection.y() < rowSize() ) && 
              (__selection.x() < colSize() ) );
    }
    
    abstract int  rowSize();
    
    Rectangle         __selection;
    bool              mRowSelection;

    Grid              mOwnerGrid;
    
  }  
  
  this( Window parent, Rectangle r ) {

    super( parent, new Rectangle( 0, 0, 0, 0 ), null, WS_CHILD | WS_BORDER, 0 );

    mColumns = new Array!( Column );
    rowHeight( 16 );
    
    mFont = new Font();

    add( new EraseBackgroundEvent( &onEraseBackground ) );
    add( new SizeEvent( &onSize ) );
    add( new PaintEvent( &onPaint ) );
    add( new MouseMoveEvent( &onMouseMove ) );
    add( new LeftButtonDownEvent( &onLeftButtonDown ) );
    add( new LeftButtonDblClickedEvent( &onLeftButtonDblClicked ) );
    add( new LeftButtonUpEvent( &onLeftButtonUp ) );


    verticalScrollBar   = new ScrollBar( this, new Rectangle(0,0,0,0), ScrollBar.Types.Vertical );
    horizontalScrollBar = new ScrollBar( this, new Rectangle(0,0,0,0), ScrollBar.Types.Horizontal );

    verticalScrollBar.add( new ScrollBar.VerticalScrollEvent( &onVerticalScroll ) );
    horizontalScrollBar.add( new ScrollBar.HorizontalScrollEvent( &onHorizontalScroll ) );

    resize( r );
    show();
  }  
  
  void onEraseBackground( EventArgs e ) {
    e.result( 1 ); // If return value is 1 for WM_ERASEBKGND message, Windows does not erase background. This reduces flicker 
  }
  
  void onSize( SizeEventArgs e ) {
    printf("Grid on size\n");
    // resize the ScrollBars
    Rectangle   r = clientRectangle();
    r.top( r.bottom() - 16 );
    r.right( r.right() - 16 );
    horizontalScrollBar.resize( r );
    
    r = clientRectangle();
    r.bottom( r.bottom() - 16 );
    r.left( r.right() - 16 );
    verticalScrollBar.resize( r );
    // calculateDisplayRectangle;
    r = clientRectangle();
    r.bottom( r.bottom() - 16 );
    r.right( r.right() - 16 );
    __displayRectangle = r;

    if( (__displayRectangle.width() <= 1) || (__displayRectangle.height() <= 1 ) )
      return;

    // create memoryBitmap
    
    
    if( __memoryGraphics !is null ) {
      __memoryGraphics.unselectFont();
      __memoryGraphics.destroy();
    }
    
    auto WindowGraphics g = new WindowGraphics( this );
    __memoryGraphics = new MemoryGraphics( g, __displayRectangle );
    __memoryGraphics.selectFont( mFont );

    adjustScrollBars();
  }
  
  void onPaint( PaintEventArgs e ) {
  
//    printf("Grid on Paint\n");
  
//    if( __memoryGraphics is null ) return;
    
    __memoryGraphics.fillRectangle( __displayRectangle );

    if( mAdaptor !is null  ) {
      auto Rectangle cellRectangle = new Rectangle();
  
      int cellX, cellY;
      
      // __memoryGraphics.selectFont( "Courier New" );
      if( mColumnHeadersVisible ) {
        for( int j = mAdaptor.firstVisibleColumn(); j <= mAdaptor.lastVisibleColumn(); ++j ) {
    //        printf("cellY:%d", cellY);
          cellRectangle(  cellX, 
                          cellY, 
                          cellX + mColumns[ j ].width(), 
                          cellY + mRowHeight) ;
          mColumns[ j ].draw( __memoryGraphics, cellRectangle )  ;
          cellX += mColumns[ j ].width();
        }
        cellY += mRowHeight;
      }
      
      for( int i = mAdaptor.firstVisibleRow(); i <= mAdaptor.lastVisibleRow(); ++i ) {
        cellX = 0;
        for( int j = mAdaptor.firstVisibleColumn(); j <= mAdaptor.lastVisibleColumn(); ++j ) {
  //        printf("cellY:%d", cellY);
          cellRectangle(  cellX, 
                          cellY, 
                          cellX + mColumns[ j ].width(), 
                          cellY + mRowHeight) ;
          mAdaptor[ i , j ].draw( __memoryGraphics, cellRectangle, mAdaptor.selection().isPointIn( j, i ) );
          cellX += mColumns[ j ].width();
        }
        cellY += mRowHeight;
      }
    }
    // __memoryGraphics.selectPrevious();
    
    e.graphics().copy( __memoryGraphics, __displayRectangle );
  }
   
  void onLeftButtonDown( MouseEventArgs e ) {
    try {
      Position p = calculateCellFromPosition( e.position() );
      if( mRowSelection ) {
        mAdaptor.updateSelection( 0, p.y(), mColumns.size() - 1, p.y() );
      } else {
        mAdaptor.updateSelection( p.x(), p.y(), p.x(), p.y() );
      }
      repaint();
      mGrabbed = true;
    } catch( Exception e ) {
      printf( "%.*s\n", e.toString() );
    }
  }

  void onMouseMove(MouseEventArgs e) {
    if( mGrabbed ) {
      try {
        Position p = calculateCellFromPosition( e.position() );
        if( allowMultipleSelection ) {
          if( mRowSelection ) {
            mAdaptor.updateSelection( 0, mAdaptor.selection().y(), mColumns.size() - 1, p.y() );
          } else {
            mAdaptor.updateSelection( mAdaptor.selection().x(), mAdaptor.selection().y(), p.x(), p.y() );
          }
          repaint();
        }
      } catch( Exception ) {}
    }
  }
  
  void onLeftButtonUp( MouseEventArgs e ) {
    try {
      if( mGrabbed ) {
        mGrabbed = false;
        if ( hasEvent( WM_GRIDCELLCLICKED ) ) {
          SystemEvent   systemEvent;
          systemEvent( handle(), WM_GRIDCELLCLICKED, 0, 0, 0 );
          callEvent( &systemEvent );
        }
      }
    } catch( Exception ) {}
  }  

  void onLeftButtonDblClicked( MouseEventArgs e ) {
    try {
      Position p = calculateCellFromPosition( e.position() );
      if ( hasEvent( WM_GRIDCELLDBLCLICKED ) ) {
        SystemEvent   systemEvent;
        systemEvent( handle(), WM_GRIDCELLDBLCLICKED, 0, 0, 0 );
        callEvent( &systemEvent );
      }
    } catch( Exception ) {}
  }  

  void onVerticalScroll( ScrollBar.EventArgs e ) {
    repaint();
  }  

  void onHorizontalScroll( ScrollBar.EventArgs e ) {
    repaint();
  }
  
  void onDestroy( EventArgs e ) {
    if( __memoryGraphics ) 
      __memoryGraphics.destroy();
  }  

  Position position() {
    return new Position(  horizontalScrollBar.pos(), 
                          verticalScrollBar.pos() );
  }
  
  void repaint() {
    adjustScrollBars();
    Window.repaint( clientRectangle() );
  }  
  
  Rectangle displayRectangle() {
    return __displayRectangle;
  }  
  
  int rowHeight() {
    return mRowHeight;
  }
    
  void rowHeight( int value ) {
    mRowHeight = value;
  }  
  
  Array!( Column ) columns() {
    return mColumns;
  }
  
  Adaptor adaptor( ) {
    return mAdaptor;
  }  

  void adaptor( Adaptor value ) {
    mAdaptor = value;
    adjustScrollBars();
    // repaint should be called after this method, If adaptor is lately changed
  }
  
  void adjustScrollBars() {
    if( mAdaptor ) {
      verticalScrollBar.range( 0, mAdaptor.calculateDocumentHeight() );
      verticalScrollBar.page( min!(uint)( mAdaptor.calculateDocumentHeight(), __displayRectangle.height() ) );
  
      horizontalScrollBar.range( 0, mAdaptor.calculateDocumentWidth() );
      horizontalScrollBar.page( min!(uint)( mAdaptor.calculateDocumentWidth(), __displayRectangle.width() ) );
    }
  }

  Position calculateCellFromPosition( Position pPosition ) {
    Position p = position();
    p.x( p.x() + pPosition.x() );
    p.y( p.y() + pPosition.y() );
    int totalWidth, a;

    for( a=0; (a<mColumns.size()) && (totalWidth < p.x()) ; ++a ) {
      totalWidth += mColumns[ a ].width();
    }

    if( p.y() > ( (mAdaptor.lastVisibleRow() + ( (mColumnHeadersVisible) ? 2 : 1) ) * mRowHeight ) ) {
      throw new Exception("No cell found");
    }
    
    if( a<mColumns.size() ) {
      p.x( a-1 );
      p.y( p.y() / mRowHeight );
      if( mColumnHeadersVisible ) {
        if( p.y() == 0 )
          throw new Exception("Column Header Clicked");
        p.y( p.y() - 1 );
      }
    } else {
      throw new Exception("No cell found");
    }

    return  p;
  }

  void allowMultipleSelection( bool value ) {
    mAllowMultipleSelection = value;
  }

  bool allowMultipleSelection( ) {
    return mAllowMultipleSelection;
  }

  void rowSelection( bool value ) {
    mRowSelection = value;
  }

  bool rowSelection( ) {
    return mRowSelection;
  }
  
  void columnHeadersVisible( bool value ) {
    mColumnHeadersVisible = value;
  }

  bool columnHeadersVisible( ) {
    return mColumnHeadersVisible;
  }

  enum {
    WM_GRIDCELLCLICKED = WM_USER,
    WM_GRIDCELLDBLCLICKED = WM_USER + 1,
  }  
  
  alias Event!( WM_GRIDCELLDBLCLICKED, EventArgs )   CellDblClickedEvent;
  
  ScrollBar         verticalScrollBar,
                    horizontalScrollBar;
  
  Adaptor           mAdaptor;
  
  MemoryGraphics    __memoryGraphics;

  Rectangle         __displayRectangle;
  
  bool              mGrabbed,
                    mRowSelection,
                    mAllowMultipleSelection,
                    mColumnHeadersVisible;
  
  int               mRowHeight;
  Array!( Column )  mColumns;
  
  Font              mFont;

}
