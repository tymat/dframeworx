/*
  This file is in public domain
*/

module framework.implementation.gui.form;

import framework.implementation.gui.menu;
import framework.implementation.gui.controls;
import framework.implementation.gui.window;
import framework.implementation.gui.application;

class Form : Window {

  enum ModalResult {
    Cancel,
    Ok,
  }

  alias Event!( WM_MENUCOMMAND, Menu.EventArgs) MenuCommandEvent;
  
  this( Window pParent, Rectangle r, char[] text ) {
  
    if( pParent.handle() ) {
      super( pParent, r, text, WS_POPUP | WS_CAPTION | WS_SYSMENU | WS_SIZEBOX, 0 );
    } else {
      super( pParent, r, text, WS_OVERLAPPEDWINDOW, 0 );
      add( new MenuCommandEvent( &handleMenuCommand ) );
    }  
    add( new DestroyEvent( &handleWindowDestroy ) );
  }
  
  
  private void handleMenuCommand( Menu.EventArgs e ) {
    SystemEvent systemEvent = e.systemEvent();
    e.sender()( &systemEvent );
  }
  
  private void handleWindowDestroy( EventArgs e ) {
    done( true );
  }  

  int showModal( ) {
  
    Window p = parent();
    
    if( p !is null ) {
      p.disable();
      Application.runEventLoop( this, true );
      p.bringToFront();
      p.enable();
    } else {
      Application.runEventLoop( this, true );
    }
    
    return 1;
  }
  
  
  void setMenu( Menu m ) {
    SetMenu( __hwnd, m.handle() );
  }

  
  void modalResult( ModalResult value ) {
    mModalResult = value;
  }

  ModalResult modalResult( ) {
    return mModalResult;
  }
  
  void close( ) {
    DestroyWindow( __hwnd );
  }
  
  bool done() {
    return mDone;
  }

  void done( bool value ) { /// Should be used only internally
    mDone = true;
  }
  
protected:
  bool                  mDone;
  ModalResult           mModalResult;
}

