/*
  This file is in public domain
*/

module framework.implementation.gui.treeview;

import framework.implementation.gui.controls;

class TreeView : Win32Control {

  class Item {
    
    enum States {
      Bold =            TVIS_BOLD,
      Cut =             TVIS_CUT,
      DropHilited =     TVIS_DROPHILITED,
      Expanded =        TVIS_EXPANDED,
      OverlayMask =     TVIS_EXPANDEDONCE,
      Selected =        TVIS_OVERLAYMASK	,
      StateImageMask =  TVIS_STATEIMAGEMASK,
      UserMask =        TVIS_USERMASK
    }  
    
    this() {
      __hTreeItem = null;
    }  
    
/*    this( HTREEITEM hTreeItem ) {
      __hTreeItem = hTreeItem;
    }*/
    
    void fill( TVITEMW* tvip ) {
      if( tvip is null )
        throw new InvalidHandle( this.toString() ~ ".fill" );
      tvip.mask   = TVIF_PARAM;
      tvip.lParam = cast(LPARAM) cast(void*) this;
    }  
    
    HTREEITEM   handle() {
      return    __hTreeItem;
    }
    
    void   handle( HTREEITEM value ) {
      __hTreeItem = value;
    }

    HTREEITEM   __hTreeItem;
  }
  
  class TextItem : Item {
    
    this( char[] pText ) {
      mText = pText ~ "\0";
    }  
    
    void fill( TVITEMW* tvip ) {
      Item.fill( tvip );
      tvip.mask     |= TVIF_TEXT;
      tvip.pszText  = toUTF16z(  mText );
    }  

    char[] mText;
  }  

  alias Event!( TVN_BEGINLABELEDITW, EventArgs ) BeginLabelEditEvent;
  alias Event!( TVN_BEGINRDRAGW, EventArgs )     BeginDragEvent;
//  alias Event!( TVN_DELETEITEM, EventArgs )     DeleteItemEvent,
  alias Event!( TVN_ENDLABELEDITW, EventArgs )   EndLabelEdit;
//  alias Event!( TVN_GETDISPINFO, EventArgs      GetDisplayInfoEvent;
  alias Event!( TVN_ITEMEXPANDEDW, EventArgs )   ItemExpandedEvent;
  alias Event!( TVN_ITEMEXPANDINGW, EventArgs )  ItemExpandingEvent;
  alias Event!( TVN_KEYDOWN, EventArgs )        KeyDownEvent;
  alias Event!( TVN_SELCHANGEDW, EventArgs )     SelectionChangedEvent;
  alias Event!( TVN_SELCHANGINGW, EventArgs )    SelectionChangingEvent;
  alias Event!( TVN_SETDISPINFOW, EventArgs )    SetDisplayInfoEvent;

  this( Window parent, Rectangle r ) {

  	/*__hwnd = CreateWindowExW(WS_EX_CLIENTEDGE, WC_TREEVIEWA, null, 
                             WS_CHILD | WS_VISIBLE | TVS_HASLINES | TVS_LINESATROOT | TVS_HASBUTTONS,
                         	 	 r.x, r.y, r.width(), r.height(), parent.handle(),
                        		 cast(HMENU) null, GetModuleHandleA( null ), 
                             null );
    assert( __hwnd );
    
    SetWindowLongW( __hwnd, GWL_USERDATA, cast(LONG) cast(void*) this );*/
    super( parent, r, "SysTreeView32", WS_VISIBLE | SS_SIMPLE, 0 );
    
    __root = new Item();
    __root.handle( TVI_ROOT );
  }  
  
  void insertChild( Item parent, Item i ) {
    TVINSERTSTRUCTW     tvins;
    i.fill( &tvins.item );
    tvins.hParent       = parent.handle();
    tvins.hInsertAfter  = TVI_LAST;
    i.handle( cast(HTREEITEM) SendMessageW( __hwnd, TVM_INSERTITEMA, cast(WPARAM) 0, cast(LPARAM) &tvins ) );
  }
  
  Item root() {
    return __root;
  }  
  
  Item      __root;

}  

