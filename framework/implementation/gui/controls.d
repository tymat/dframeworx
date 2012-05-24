/*
  This file is in public domain
*/

module framework.implementation.gui.controls;

import framework.implementation.gui.window;

import std.utf;

extern(Windows) {
  alias LRESULT function(HWND, UINT, WPARAM, LPARAM) WindowProcedure;
}

class Win32Control : Window {
  this( Window parent, Rectangle r, char[] className, DWORD style, DWORD exStyle ) {
    super();
  	__hwnd = CreateWindowExW( exStyle, 
                              toUTF16z(className), null, 
                              WS_CHILD | style,
                              r.x, r.y, r.width(), r.height(), parent.handle(),
                              cast(HMENU) null, 
                              GetModuleHandleW( null ), 
                              null );
    assert( __hwnd );
    SetWindowLongW( __hwnd, GWL_USERDATA, cast(LONG) cast(void*) this );
    oldProcedure = cast(WindowProcedure) SetWindowLongW( __hwnd, GWL_WNDPROC, cast(LPARAM) cast(WindowProcedure) &newProcedure );
  }
  
  void setANSIVarFont() {
    HFONT __hfnt = cast(HFONT) GetStockObject( ANSI_VAR_FONT );
    SendMessageW( __hwnd, WM_SETFONT, cast(WPARAM) __hfnt, cast(LPARAM) 0 );
  }
  
  void font( Font pFont )
  in {
    assert( pFont !is null );
  }
  body {
    SendMessageW( __hwnd, WM_SETFONT, cast(WPARAM) pFont.handle(), cast(LPARAM) 0 );
  }

  WindowProcedure oldProcedure;
}

extern (Windows) {
  LRESULT newProcedure(HWND hWnd, UINT uMsg, WPARAM wParam, LPARAM lParam ) {
    Win32Control w = cast(Win32Control) cast(void*) GetWindowLongW( hWnd, GWL_USERDATA );
    if( w !is null ) {
      SystemEvent   systemEvent;
      systemEvent( hWnd, uMsg, wParam, lParam, 0 );
      if( w.hasEvent( uMsg ) ) {
        w.callEvent( &systemEvent );
      }
      if( w.oldProcedure !is null ) {
        return w.oldProcedure( hWnd, uMsg, wParam, lParam );
      } else {
        assert( false );
      }
    } else {
      assert( false );
    }
  }
}

class Label : Win32Control {

  this( Window parent, Rectangle r, char[] pText ) {
    super( parent, r, "STATIC", WS_VISIBLE | SS_SIMPLE, 0 );
    setANSIVarFont();
    text( pText );
  }

}

class BaseButton : Win32Control {

  this( Window parent, Rectangle r, char[] pText, DWORD style ) {
    super( parent, r, "BUTTON", WS_VISIBLE | style, 0 );
    setANSIVarFont();
    text( pText );
  }

}


class Button : BaseButton {

  static class EventArgs : framework.implementation.gui.eventargs.EventArgs {

    this( SystemEvent *pSystemEvent ) {
      super( pSystemEvent );
      __button = cast( Button ) 
                 cast(void*) 
                 GetWindowLongW( cast(HWND) pSystemEvent.msg.lParam , GWL_USERDATA );
    }
    
    Button button() {
      return __button;
    }
    
  private:
    Button    __button;
  }

  alias Event!( BN_CLICKED, EventArgs )   ClickedEvent;

  this( Window parent, Rectangle r, char[] pText ) {
    super( parent, r, pText, BS_PUSHBUTTON );
  }
}

class CheckBox : BaseButton {
  this( Window parent, Rectangle r, char[] pText, bool push_like ) {
    super( parent, r, pText, BS_AUTOCHECKBOX | ((push_like) ? BS_PUSHLIKE : 0) );
  }
}

class RadioButton : BaseButton {

  this( Window parent, Rectangle r, char[] pText, bool push_like ) {
    super( parent, r, pText, BS_AUTORADIOBUTTON | ((push_like) ? BS_PUSHLIKE : 0) );
  }

}

class TextBox : Win32Control {

  this( Window parent, Rectangle r, char[] pText ) {
    super( parent, r, "EDIT", WS_VISIBLE | ES_AUTOHSCROLL , WS_EX_CLIENTEDGE );
    setANSIVarFont();
    Window.text( pText );
  }
  
  this( Window parent, Rectangle r, char[] pText, int pLimit, bool pMultiline ) {
    super( parent, r, "EDIT", WS_VISIBLE | ES_AUTOHSCROLL | ((pMultiline) ? ES_MULTILINE : 0), WS_EX_CLIENTEDGE );
    setANSIVarFont();
    text( pText );
    limit( pLimit );
  }

  void readOnly( bool value ) {
    SendMessageW( __hwnd, EM_SETREADONLY, cast(LPARAM) value, cast(LPARAM) 0 );
  }
  
  bool readOnly() {
    return ( ( GetWindowLongW( __hwnd, GWL_STYLE ) & ES_READONLY ) == ES_READONLY );
  }
  
  void limit( int pLimit ) {
    SendMessageW( __hwnd, EM_LIMITTEXT, cast(WPARAM) pLimit, cast(LPARAM) 0 );
  }

}

class ListBox : Win32Control {

  static class item { // This should be a proxy and a prototype not the item itself 

    this() {}
    this( char[] p_text ) { text = p_text; }

    char[] text() { return __text; }
    char[] text( char[] value ) { 
      __text = value ~ "\0";
      return __text;
    }

    int index() { return __index; }
    int index( int value ) { return __index = value; }

  protected:
    char[]    __text;
    int       __index;
  }

  this( Window parent, Rectangle r, DWORD style ) {
    super( parent, r, "LISTBOX", WS_VISIBLE | LBS_NOTIFY, WS_EX_CLIENTEDGE );
    setANSIVarFont();
  }

  void pushBack( item i ) {
    i.index = SendMessageW( __hwnd, LB_ADDSTRING, 0, cast(LPARAM) cast(char*) i.text );
    SendMessageW( __hwnd, LB_SETITEMDATA, cast(WPARAM) i.index, cast(LPARAM) cast(void*) i );
  }
  
  void erase( int index ) {
    SendMessageW( __hwnd, LB_DELETESTRING, index, cast(LPARAM) 0 );
  }

  int insert( int index, item i ) {
    i.index = index;
    SendMessageW( __hwnd, LB_INSERTSTRING, i.index, cast(LPARAM) cast(char*) i.text );
    SendMessageW( __hwnd, LB_SETITEMDATA, cast(WPARAM) i.index, cast(LPARAM) cast(void*) i );
    return index;
  }

//  alias Event!( LBN_SELCHANGE, EventArgs )   SelChangeEvent;

}

class ComboBox : Win32Control {

  static class Item { // This should be a proxy and a prototype not the item itself 

    this( char[] pText ) { 
      mText = pText; 
    }

    char[] text() { 
      return mText; 
    }
    
    char[] text( char[] value ) { 
      mText = value ~ "\0";
      return mText;
    }

    int index() { 
      return mIndex; 
    }
    
    int index( int value ) { 
      return mIndex = value; 
    }

  protected:
    char[]    mText;
    int       mIndex;
  }

  this( Window parent, Rectangle r, DWORD style ) {
    super( parent, r, "COMBOBOX", WS_VISIBLE | CBS_DROPDOWN, WS_EX_CLIENTEDGE );
    setANSIVarFont();
  }

  int size() {
    return SendMessageW( __hwnd, CB_GETCOUNT, 0, 0 );
  }

  void pushBack( Item i ) {
    i.index = SendMessageW( __hwnd, CB_ADDSTRING, 0, cast(LPARAM) cast(LPWSTR) toUTF16z( i.text() ) );
    SendMessageW( __hwnd, CB_SETITEMDATA, cast(WPARAM) i.index, cast(LPARAM) cast(void*) i );
  }
  
  void erase( int index ) {
    SendMessageW( __hwnd, CB_DELETESTRING, index, cast(LPARAM) 0 );
  }

  int insert( int pIndex, Item i ) {
    i.index = pIndex;
    SendMessageW( __hwnd, CB_INSERTSTRING, i.index, cast(LPARAM) cast(LPWSTR) toUTF16z( i.text() ) );
    SendMessageW( __hwnd, CB_SETITEMDATA, cast(WPARAM) i.index, cast(LPARAM) cast(void*) i );
    return i.index;
  }
  
  Item opIndex( int pIndex ) {
    if( pIndex >= 0 ) {
      int result = SendMessageW( __hwnd, CB_GETITEMDATA, cast(WPARAM) pIndex, cast(LPARAM) 0 );
      if( result != CB_ERR ) {
        return cast(Item) cast(void**) result;
      } else {
        throw new Exception("No item found");
      }
    } else {
      throw new Exception("Invalid item index");
    }
  }
  
  Item selected() {
    int index = SendMessageW( __hwnd, CB_GETCURSEL, cast(WPARAM) 0, cast(LPARAM) 0 );
    return opIndex( index );
  }
  
  int find( char[] pText ) {
    pText ~= "\0";
    int index = SendMessageW( __hwnd, CB_GETCURSEL, cast(WPARAM) 0, cast(LPARAM) cast(LPWSTR) toUTF16z( pText ) );
    return index;
  }

  void select( int pIndex ) {
    SendMessageW( __hwnd, CB_SETCURSEL, cast(WPARAM) pIndex, cast(LPARAM) 0 );
  }
  
  //alias Event!( CBN_SELCHANGE, EventArgs )   SelChangeEvent;

}

class ScrollInfo {

  this( HWND  hwndScrollBar ) {

    __hwnd = hwndScrollBar;

    __si.cbSize = SCROLLINFO.sizeof; 
    __si.fMask = SIF_RANGE | SIF_POS | SIF_PAGE;
 
    GetScrollInfo( __hwnd, SB_CTL, &__si );
  
  }

  void increment( int value ) {
    __increment = value;
    if( __increment ) {
      __si.fMask = SIF_POS;
      __si.nPos += __increment;
      SetScrollInfo( __hwnd, SB_CTL, &__si, true);
    }  
  }  

  int increment() {
    return __increment;
  }

  int pos() {
    return __si.nPos;
  }
  
  int min() {
    return __si.nMin;
  }
  
  int max() {
    return __si.nMax;
  }    

  int page() {
    return __si.nPage;
  }

private:
  int           __increment = 0;
  SCROLLINFO    __si;
  HWND          __hwnd;
}

class ScrollBar : Win32Control {

  enum Types {
    Vertical   = SB_VERT,
    Horizontal = SB_HORZ,
  }

  static class EventArgs : framework.implementation.gui.eventargs.EventArgs {
  
    this( SystemEvent *pSystemEvent ) {
      super( pSystemEvent );
      
      __scrollInfo = new ScrollInfo( mSystemEvent.msg.hwnd );
      
      int scrollCode =  LOWORD( mSystemEvent.msg.wParam );
      int pos =         HIWORD( mSystemEvent.msg.wParam );
      
      switch( scrollCode ) {
      case SB_PAGEUP:
        __scrollInfo.increment( (__scrollInfo.pos() > __scrollInfo.min()) ? -1:0 );
        break;
      case SB_PAGEDOWN:
        __scrollInfo.increment( (__scrollInfo.pos() < (__scrollInfo.max() - __scrollInfo.page() )) ? 1:0 );
        break;
      case SB_LINEUP:
        __scrollInfo.increment( (__scrollInfo.pos() > __scrollInfo.min() ) ? -1:0);
        break;
      case SB_LINEDOWN:
        __scrollInfo.increment( (__scrollInfo.pos() < (__scrollInfo.max() - __scrollInfo.page() )) ? 1:0 );
        break;
      case SB_THUMBTRACK:
        __scrollInfo.increment( pos - __scrollInfo.pos() ); 
        break;
      default:
        break;
      }
  
    }
  
    ScrollInfo  scrollInfo() {
      return __scrollInfo;
    }
      
    ScrollBar sender() 
    in {
      assert( mSystemEvent.msg.lParam != 0 );
    }
    body {
      return cast( ScrollBar ) cast(void*) GetWindowLongW( cast(HWND) mSystemEvent.msg.lParam , GWL_USERDATA );
    }

  private:
    ScrollInfo __scrollInfo;
  }



  this( Window parent, Rectangle r, Types type ) {
    super( parent, r, "SCROLLBAR", WS_VISIBLE | type, 0 );
  }

  void range( int p_min, int p_max ) {
    SCROLLINFO  __si;
    __si.cbSize = SCROLLINFO.sizeof;   
    __si.fMask  = SIF_RANGE;
    __si.nMin   = p_min;
    __si.nMax   = p_max;
    SetScrollInfo( __hwnd, SB_CTL, &__si, true );
  };
  
  void page( int p_page ) {
    SCROLLINFO  __si;
    __si.cbSize = SCROLLINFO.sizeof; 
    __si.fMask = SIF_PAGE;
    __si.nPage = p_page;
    SetScrollInfo( __hwnd, SB_CTL, &__si, true );
  }
  
  void pos( int p_pos ) {
    SCROLLINFO  __si;
    __si.cbSize = SCROLLINFO.sizeof;
    __si.fMask  = SIF_POS;
    __si.nPos   = p_pos;
    SetScrollInfo( __hwnd, SB_CTL, &__si, true );
  }
  
  int pos() {
    SCROLLINFO  __si;
    __si.cbSize = SCROLLINFO.sizeof;
    __si.fMask  = SIF_POS;
    GetScrollInfo( __hwnd, SB_CTL, &__si );
    return __si.nPos;
  }  

  alias Event!( WM_VSCROLL, EventArgs )   VerticalScrollEvent;
  alias Event!( WM_HSCROLL, EventArgs )   HorizontalScrollEvent;
 
}

class MonthCalendar : Win32Control {
  this( Window parent, Rectangle r ) {
    super( parent, r, "SysMonthCal32", 0, WS_EX_CLIENTEDGE);
    RECT    rect;
    SendMessageW( __hwnd, MCM_GETMINREQRECT, cast(WPARAM) 0, cast(LPARAM) &rect );
    SetWindowPos( __hwnd, null, r.x(), r.y(), r.x() + rect.right, r.y() + rect.bottom, 0 );
    show();
  }
  
  void selected() {
    SYSTEMTIME    systemTime;
    SendMessageW( __hwnd, MCM_GETCURSEL, cast(WPARAM) 0, cast(LPARAM) &systemTime );
  }
  
  void select() {
    SYSTEMTIME    systemTime;
    SendMessageW( __hwnd, MCM_GETCURSEL, cast(WPARAM) 0, cast(LPARAM) &systemTime );
  }
  
  /*
  alias Event!( MCN_SELCHANGE, EventArgs )   SelChangeEvent;
  alias Event!( MCN_SELCHANGE, EventArgs )   SelChangeEvent;
  alias Event!( MCN_SELECT, EventArgs )   SelChangeEvent;
  */
  
}

class DateTimePicker : Win32Control {
  this( Window parent, Rectangle r ) {
    super( parent, r, "SysDateTimePick32", WS_VISIBLE, WS_EX_CLIENTEDGE);
  }
  
  void selected() {
    SYSTEMTIME    systemTime;
    SendMessageW( __hwnd, MCM_GETCURSEL, cast(WPARAM) 0, cast(LPARAM) &systemTime );
  }
  
  void select() {
    SYSTEMTIME    systemTime;
    SendMessageW( __hwnd, MCM_GETCURSEL, cast(WPARAM) 0, cast(LPARAM) &systemTime );
  }
  
}

