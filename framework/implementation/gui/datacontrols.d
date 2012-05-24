/*
  This file is in public domain
*/

module framework.implementation.gui.datacontrols;

import framework.implementation.gui.grid;
import framework.implementation.gui.controls;
import framework.implementation.gui.application;
import framework.database;

/*!
  DataGrid class is a modified version grid to use with database components
*/

class DataGrid : Grid {
  
  static class Adaptor : Grid.Adaptor {
    
    this( Grid pGrid ) {
      super( pGrid );
      
      pGrid.allowMultipleSelection( true );
      pGrid.rowSelection( true );
      pGrid.columnHeadersVisible( true );
    }

  /*!
   *  table method is used to set current Table object to view. Previously set table is replaced by new one.
   *  After that grid is repainted.
  */
    
    void table( Table value ) {
      mTable = value;
      
      mOwnerGrid.columns().clear();
      if( mTable !is null ) {
        for( int a=0; a < mTable.columns().size(); ++a ) {
          mOwnerGrid.columns().pushBack( new Grid.Column( mTable.column( a ).name(), 100, new Formatter() ) );
        }
      }
      mOwnerGrid.repaint();
    }  

  /*!
   *  opIndex operator is an interface to the Grid. Adaptor returns Formatter object that contains the cell
   *  content, and drawing method.
  */
    
    override Grid.Formatter opIndex( int pRow, int pCol ) {
      ( cast( Formatter ) mOwnerGrid.columns()[ pCol ].formatter() ).format( mTable[pRow][pCol].value() );
      return mOwnerGrid.columns()[ pCol ].formatter();
    }
    
  /*!
   *  Overrided method rowSize(). It returns the total number of rows in the table
  */
    
    override int rowSize() {
      return (mTable is null) ? 0 : mTable.size();
    }   
    
  private:
    Table   mTable;
  }
  
/*!
  * Formatter class defines how to draw the cell and what is the content of the cell. Formatter objects are 
  * stored in Column object. Each column can have its own formatter.
*/
  
  static class Formatter : Grid.Formatter {

    override void draw( Graphics g, Rectangle cellRectangle, bool pSelected ) {
      g.backgroundMode( Graphics.BackgroundModes.Transparent );
      if( pSelected ) {
        g.fillRectangle( cellRectangle, mSelectedBrush );
        g.textColor( Color.White );
      } else {
        g.fillRectangle( cellRectangle, mUnselectedBrush );
        g.textColor( Color.Black );
      }
      g.drawRectangle( cellRectangle );
      g.drawText( cellRectangle,  mText ); 
    }
    
    void format( char[] text ) { // char[] text yerine template kullan
      mText = text;
    }
    
    char[] text() {
      return mText;
    }

    this()  {
      mSelectedBrush    = Application.blueBrush();
      mUnselectedBrush  = Application.whiteBrush();
    }
    
  private:
    char[]  mText;
    Brush   mSelectedBrush,
            mUnselectedBrush;
  }  
  
  this( Window parent, Rectangle r ) {
    super( parent, r );
    adaptor( new Adaptor( this ) );
  }
  
  void table( Table t ) 
  in {
    assert( mAdaptor !is null );
  }
  body {
    (cast(Adaptor) mAdaptor).table( t );
  }
 
/*  Adaptor adaptor() {
    return ( cast(Adaptor) Grid.adaptor() );
  }*/
 
}

