/*
  This file is in public domain
*/

module framework.implementation.gui.eventargs;

import framework.implementation.gui.exceptions;
import framework.implementation.gui.position;
import framework.implementation.gui.size;
import framework.implementation.gui.graphics;
//import framework.implementation.gui.event;
import framework.implementation.gui.window;
//import framework.implementation.gui.menu;

auto class EventArgs {
  
  this( SystemEvent *pSystemEvent ) {
    mSystemEvent = pSystemEvent;
  }
  
  void result( LRESULT value ) {
    mSystemEvent.result = value;
  }
  
  LRESULT result( ) {
    return mSystemEvent.result;
  }
  
  SystemEvent systemEvent() {
    return *mSystemEvent;
  }
  
  uint message() {
    return mSystemEvent.msg.message;
  }
  
protected:
  SystemEvent     *mSystemEvent;
}

auto class PaintEventArgs : EventArgs {

  this( SystemEvent *pSystemEvent ) {
    super( pSystemEvent );
    mGraphics = new Graphics( BeginPaint( mSystemEvent.msg.hwnd, &mPaintStruct ) );
  }

  ~this() {
    EndPaint( mGraphics.handle(), &mPaintStruct );
  }

  Graphics graphics() {
    return mGraphics;
  }

protected:
  Graphics        mGraphics;
  PAINTSTRUCT     mPaintStruct;
}

auto class SizeEventArgs : EventArgs {

/*  enum Types {
    MaxHide   = SIZE_MAXHIDE,
    Maximized = SIZE_MAXIMIZED,
    MaxShow   = SIZE_MAXSHOW,
    Minimized = SIZE_MINIMIZED,
    Restored  = SIZE_RESTORED,
  }*/

  this( SystemEvent *pSystemEvent ) {
    super( pSystemEvent );
  }

  uint type() {
    return mSystemEvent.msg.wParam;
  }

  Size  size() {
    return new Size( width(), height() );
  }

  uint width() {
    return LOWORD( mSystemEvent.msg.lParam );
  }

  uint height() {
    return HIWORD( mSystemEvent.msg.lParam );
  }

}

auto class MouseEventArgs : EventArgs {

/*  enum Keys {
    Control       = MK_CONTROL,
    LeftButton    = MK_LBUTTON,
    MiddleButton  = MK_MBUTTON,
    RightButton   = MK_RBUTTON,
    Shift         = MK_SHIFT,
  }*/

  this( SystemEvent *pSystemEvent ) {
    super( pSystemEvent );
  }

  uint keys() {
    return mSystemEvent.msg.wParam;
  }

  Position  position() {
    return new Position( x() , y() );
  }

  uint x() {
    return LOWORD( mSystemEvent.msg.lParam );
  }
  
  uint y() {
    return HIWORD( mSystemEvent.msg.lParam );
  }
  
}

auto class CommandEventArgs : EventArgs {

  this( SystemEvent *pSystemEvent ) {
    super( pSystemEvent );
  }

  Window sender() {
    if( mSystemEvent.msg.lParam == 0 ) 
      throw new InvalidHandle("CommandEventArgs");
    // get sender window
    return cast( Window ) cast(void*) GetWindowLongW( cast(HWND) mSystemEvent.msg.lParam , GWL_USERDATA );
  }
  
  uint code() {
    return HIWORD( mSystemEvent.msg.wParam );
  }  

}

auto class NotifyEventArgs : EventArgs {

  this( SystemEvent *pSystemEvent ) {
    super( pSystemEvent );
  }

  Window sender() {
    if( mSystemEvent.msg.lParam == 0 ) 
      throw new InvalidHandle("NotifyEventArgs");
    return cast( Window ) cast(void*) GetWindowLongW( (cast(LPNMHDR) mSystemEvent.msg.lParam ).hwndFrom, GWL_USERDATA );
  }

  uint code() {
    if( mSystemEvent.msg.lParam == 0 ) 
      throw new InvalidHandle("NotifyEventArgs");
    return (cast(LPNMHDR) mSystemEvent.msg.lParam ).code;
  }

}


auto class ScrollEventArgs : EventArgs {

  this( SystemEvent *pSystemEvent ) {
    super( pSystemEvent );
  }

  Window sender() {
    if( mSystemEvent.msg.lParam ) {// SB_HORZ , SB_VERT
      return cast( Window ) cast(void*) GetWindowLongW( cast(HWND) mSystemEvent.msg.lParam, GWL_USERDATA );
    }
    return null;
  }

}


