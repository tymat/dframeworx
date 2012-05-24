/*
  This file is in public domain
*/

module framework.implementation.gui.window;

import framework.implementation.gui.exceptions;
import framework.implementation.gui.rectangle;
import framework.implementation.gui.graphics;
import framework.implementation.gui.eventdispatcher;
import framework.implementation.gui.event;
import framework.implementation.gui.eventargs;

// import framework.implementation.gui.application; When this line is uncommented, The application will probably crash at line 50

import std.string;
import std.utf;

class Window {

  alias Event!(WM_CREATE,      EventArgs)        CreateEvent;
  alias Event!(WM_DESTROY,     EventArgs)        DestroyEvent;
  alias Event!(WM_PAINT,       PaintEventArgs)   PaintEvent;
  alias Event!(WM_SIZE,        SizeEventArgs)    SizeEvent;
  alias Event!(WM_LBUTTONDOWN, MouseEventArgs)   LeftButtonDownEvent;
  alias Event!(WM_LBUTTONDBLCLK, MouseEventArgs) LeftButtonDblClickedEvent;
  alias Event!(WM_LBUTTONUP,   MouseEventArgs)   LeftButtonUpEvent;
  alias Event!(WM_MBUTTONDOWN, MouseEventArgs)   MiddleButtonDownEvent;
  alias Event!(WM_MBUTTONDBLCLK, MouseEventArgs) MiddleButtonDblClickedEvent;
  alias Event!(WM_MBUTTONUP,   MouseEventArgs)   MiddleButtonUpEvent;
  alias Event!(WM_RBUTTONDOWN, MouseEventArgs)   RightButtonDownEvent;
  alias Event!(WM_RBUTTONDBLCLK, MouseEventArgs) RightButtonDblClickedEvent;
  alias Event!(WM_RBUTTONUP,   MouseEventArgs)   RightButtonUpEvent;
  alias Event!(WM_MOUSEHOVER, MouseEventArgs)    EnterEvent;
  alias Event!(WM_MOUSELEAVE,  EventArgs)        LeaveEvent;
  alias Event!(WM_MOUSEMOVE,   MouseEventArgs)   MouseMoveEvent;
  alias Event!(WM_COMMAND,     CommandEventArgs) CommandEvent;
  alias Event!(WM_NOTIFY,      NotifyEventArgs)  NotifyEvent;
  alias Event!(WM_SETFOCUS,    EventArgs)        SetFocusEvent;
  alias Event!(WM_VSCROLL,     ScrollEventArgs)  VerticalScrollEvent;
  alias Event!(WM_HSCROLL,     ScrollEventArgs)  HorizontalScrollEvent;  
  alias Event!(WM_KEYDOWN,     EventArgs)        KeyDownEvent;  
  alias Event!(WM_KEYUP,       EventArgs)        KeyUpEvent; 
  alias Event!(WM_ERASEBKGND,  EventArgs)        EraseBackgroundEvent; 

  this() {
    mDispatcher = new EventDispatcher();  
  }

  this( Window pParent, 
        Rectangle pRectangle, 
        char[] pText, 
        DWORD style, 
        DWORD exStyle ) {
    mDispatcher = new EventDispatcher();  
    
    add( new CommandEvent( &handleCommand ) );
    add( new NotifyEvent( &handleNotify ) );
    add( new VerticalScrollEvent( &handleScroll ) );
    add( new HorizontalScrollEvent( &handleScroll ) );

  	CreateWindowExW(exStyle, 
                    toUTF16z("DWndClass"), 
                    null, // toUTF16z( pText ), 
                    style,
               	 	  pRectangle.x, pRectangle.y, pRectangle.width(), pRectangle.height(), 
                    pParent.handle(),
              		  cast( HMENU ) null, 
                    GetModuleHandleW( null ), 
                    cast(void*) this );

    text( pText );
  }  
  
  HWND    handle() { return __hwnd; }
  
  HWND    handle( HWND value ) { return __hwnd = value; } // this should be only accessible from WindowProc
  
  void destroy() {
    DestroyWindow( __hwnd );
  }

  void parent( Window parent ) {
    SetParent( __hwnd, parent.handle() );
  }  

  Window parent() {
    HWND hwnd = GetParent( __hwnd );
    return ( hwnd ) ? ( cast(Window) cast(void*) GetWindowLongW( hwnd, GWL_USERDATA ) ) : null;
  }
    
  Window child() {
    HWND  hwnd = GetWindow( __hwnd, GW_CHILD );
    return ( hwnd ) ? ( cast(Window) cast(void*) GetWindowLongW( hwnd, GWL_USERDATA ) ) : null;
  }

  Window next() {
    HWND  hwnd = GetWindow( __hwnd, GW_HWNDNEXT );
    return ( hwnd ) ? ( cast(Window) cast(void*) GetWindowLongW( hwnd, GWL_USERDATA ) ) : null;
  }  

  void show() {
    ShowWindow( __hwnd, SW_SHOW );
  }
    
  void hide() {
    ShowWindow( __hwnd, SW_HIDE );
  }
  
  void enable() {
    EnableWindow( __hwnd, TRUE );
  }
  
  void disable() {
    EnableWindow( __hwnd, FALSE );
  }
  
  void reposition( Position p_pos ) {
    SetWindowPos( __hwnd, null, p_pos.x, p_pos.y, 0, 0, SWP_NOSIZE | SWP_NOZORDER	);
  }
    
  void resize( Rectangle p_rect ) {
    SetWindowPos( __hwnd, null, p_rect.x, p_rect.y, p_rect.width, p_rect.height, SWP_NOZORDER	);
  }
  
  Rectangle clientRectangle() {
    Rectangle r = new Rectangle;
    GetClientRect( __hwnd, r.ptr );
    return r;
  }

  Rectangle windowRectangle() {
    Rectangle r = new Rectangle;
    GetWindowRect( __hwnd, r.ptr );
    return r;
  }

  char[] text() {
    wchar[] buffer;
    buffer.length = 256;
    GetWindowTextW( __hwnd, cast(LPWSTR) buffer, 256 );
    return std.string.toString( cast(char*) toUTF8(  buffer ) );
  }
  
  void text( char[] pText ) {
    pText ~= "\0";
    SendMessageW( __hwnd, WM_SETTEXT, cast(WPARAM) 0, cast(LPARAM) toUTF16z(pText) );
  }
  
  void bringToFront() {
    SetWindowPos( __hwnd, HWND_TOP, 0, 0, 0, 0, SWP_NOSIZE | SWP_NOMOVE );
  }
    
  void sendToBack() {
    SetWindowPos( __hwnd, HWND_BOTTOM, 0, 0, 0, 0, SWP_NOSIZE | SWP_NOMOVE);
  }

  BOOL update() {
    return UpdateWindow( __hwnd );
  }

  void repaint() {
    RECT    rect;
    GetClientRect( __hwnd, &rect );
    InvalidateRect( __hwnd, &rect, false );
  }

  void repaint( Rectangle r ) {
    InvalidateRect( __hwnd, r.ptr(), false );
  }

  void setFocus() {
    SetFocus( __hwnd );
  }
  
  Position screenToClient( Position p ) {
    if( __hwnd == null ) throw new InvalidHandle;
    ScreenToClient( __hwnd, p.ptr );
    return p;
  }
    
  Rectangle screenToClient( Rectangle r ) {
    if( __hwnd == null ) throw new InvalidHandle;
    Position    __p = r.position;
    ScreenToClient( __hwnd, __p.ptr );
    r.position( __p );
    return r;
  }

  Position clientToScreen( Position p ) {
    if( __hwnd == null ) throw new InvalidHandle;
    ClientToScreen( __hwnd, p.ptr );
    return p;
  }
    
  Rectangle clientToScreen( Rectangle r ) {
    if( __hwnd == null ) throw new InvalidHandle;
    Position    __p = r.position();
    ClientToScreen( __hwnd, __p.ptr );
    r.position( __p );
    return r;
  }
  
  Position clientToParent( Position p ) {
    Window __parent = parent();
    return __parent.screenToClient( clientToScreen( p ) );
  }

  Rectangle clientToParent( Rectangle r ) {
    Window __parent = parent();
    return __parent.screenToClient( clientToScreen( r ) );
  }
  
  void grabMouse() {
  // TODO: SetCapture returns the previous Window that got the capture
  // It should be used 
    SetCapture( __hwnd );
  }
  
  void releaseMouse() {
    ReleaseCapture();
  }
  
  void enableMouseTracking() {
    add( new MouseMoveEvent( &handleMouseTracking ) );
    add( new EnterEvent( &handleOnEnter ) );
  }

  private void handleMouseTracking( MouseEventArgs e ) {
    TRACKMOUSEEVENT    tme;
    
    tme.cbSize = tme.sizeof;
    tme.dwFlags = TME_HOVER;
    tme.hwndTrack = handle();
    tme.dwHoverTime = 1; // 100 mS

    TrackMouseEvent( &tme );
  }
  
  private void handleOnEnter( MouseEventArgs e ) {
    TRACKMOUSEEVENT    tme;
    
    tme.cbSize = tme.sizeof;
    tme.dwFlags = TME_LEAVE;
    tme.hwndTrack = handle();

    TrackMouseEvent( &tme );
  }

  private void handleScroll( ScrollEventArgs e ) 
  in {
    assert( e.sender() !is null );
  }
  body {
    if( e.sender().hasEvent( e.message() ) ) {
      SystemEvent systemEvent = e.systemEvent();
      e.sender().callEvent( &systemEvent );
    }
  }
  
  void handleCommand( CommandEventArgs e ) 
  in {
    assert( e.sender() !is null );
  }
  body {
    if( e.sender().hasEvent( e.code() ) ) {
      SystemEvent systemEvent;
      systemEvent(null, e.code(), 0, 0, 0 );
      e.sender().callEvent( &systemEvent );
    }
  }
  
  void handleNotify( NotifyEventArgs e )
  in {
    assert( e.sender() !is null );
  }
  body {
    if( e.sender().hasEvent( e.code() ) ) {
      SystemEvent systemEvent = e.systemEvent();
      systemEvent(null, e.code(), 0, systemEvent.msg.lParam, 0 );
      e.sender().callEvent( &systemEvent );
    }
  }

/*  LRESULT mapEvents( HWND hWnd, uint uMsg, WPARAM wParam, LPARAM lParam ) {
    return currentDispatcher().mapEvents( hWnd, uMsg, wParam, lParam );
  }*/

  void add( IEvent e ) {
    mDispatcher.add( e );
  }
  
  bool hasEvent( uint uMsg ) {
    return mDispatcher.hasEvent( uMsg );
  }
  
  void callEvent( SystemEvent *pSystemEvent ) {
    mDispatcher.callEvent( pSystemEvent );
  }

  // currentDispatcher will be deprecated
  
  /* 
  */
  
  EventDispatcher dispatcher() {
    return mDispatcher;
  }
  
protected:
  HWND              __hwnd; 
  EventDispatcher   mDispatcher;
}

