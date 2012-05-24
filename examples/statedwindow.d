import framework.gui;

/*
  This is a demonstration StatedWindow class. It is an Experimental Feature.

  The code below implements a Button component build on StatedWindow. The main
benefits of using StatedWindow here is reducing the switch and if statements in
event handlers, that makes the code clearer.

  The Idea behind the StatedWindow is changing the Event Dispatcher in state 
transitions.

  It still an experimental feature

*/

class MyButton : StatedWindow {

  enum States { // Enumerate the available states
    Up,
    Entered,
    Down,
    DownLeft
  }
  
  private enum { // Declare the event codes of available events
    WM_BUTTONCLICKED = WM_USER,
  }
  
  // Declare the events of available events
  alias Event!(WM_BUTTONCLICKED, EventArgs )    ClickedEvent;

  this( Window pParent, Rectangle pRectangle, char[] pText ) {
  
    super( pParent, new Rectangle(), pText, WS_CHILD, 0 );
    enableMouseTracking(); // for WM_MOUSEHOVE and WM_MOUSELEAVE events
    
    mFont = new Font(); // For ANSI var font

    // Add events to base Event Dispatcher, which is unchangeable
    // Base Event Dispatcher can be used for common event handlers
    // Base Event Dispatcher is inherited from Window class
    add( new PaintEvent( &onPaint ) );
    add( new EraseBackgroundEvent( &onEraseBackground ) );
    
    // registering states creates corresponding Event Dispatchers
    registerState( States.Up );
    registerState( States.Entered );
    registerState( States.Down );
    registerState( States.DownLeft );

    // Define the events for states
    add( States.Up, new EnterEvent( &up_onEnter ) );
    add( States.Up, new LeftButtonUpEvent( &up_onLeftButtonUp ) );
  
    add( States.Entered, new LeftButtonDownEvent( &entered_onLeftButtonDown ) );
    add( States.Entered, new LeaveEvent( &entered_onLeave  ) );
    
    add( States.Down, new MouseMoveEvent( &down_onMouseMove ) );
    add( States.Down, new LeftButtonUpEvent( &down_onLeftButtonUp ) );

    add( States.DownLeft, new MouseMoveEvent( &downLeft_onMouseMove ) );
    add( States.DownLeft, new LeftButtonUpEvent( &downLeft_onLeftButtonUp ) );
    
    // set the initial state
    state( States.Up );
    
    resize( pRectangle );
    show();
  }

  // common events
  
  void onEraseBackground( EventArgs e ) {
    e.result( 1 );
  }
  
  void onPaint( PaintEventArgs e ) { // Actually this handler can be implemented in states too.
    drawButton( e.graphics() );
  }
  
  // Up State
  
  void up_onEnter( MouseEventArgs e ) {
    state( States.Entered );
  }

  void up_onLeftButtonUp( MouseEventArgs e ) {
    releaseMouse();
  }

  // Entered State
  
  void entered_onLeftButtonDown( MouseEventArgs e ) {
    grabMouse();
    state( States.Down );
  }
  
  void entered_onLeave( EventArgs e ) {
    state( States.Up );
  }

  // Down state
  
  void down_onLeftButtonUp( MouseEventArgs e ) {
    releaseMouse();
    state( States.Entered );
    if( Window.hasEvent( WM_BUTTONCLICKED ) ) {
      SystemEvent   se; // Create a new SystemEvent struct ( Actually this not necessary. 
                        // You can also pass e.systemEvent(). But in this is not secure )
      se( handle(), WM_BUTTONCLICKED, 0, 0, 0 ); // Fill new Information
      Window.callEvent( &se ); // or Window.callEvent( e.systemEvent() );
    }
  }
  
  void down_onMouseMove( MouseEventArgs e ) {
    Rectangle r = clientRectangle();
    if( !r.isPointIn( e.position() ) ) {
      state( States.DownLeft );
    }
  }
  
  // Down Left

  void downLeft_onLeftButtonUp( MouseEventArgs e ) {
    releaseMouse();
    state( States.Up );
  }
  
  void downLeft_onMouseMove( MouseEventArgs e ) {
    Rectangle r = clientRectangle();
    if( r.isPointIn( e.position() ) ) {
      state( States.Down );
    }
  }
  
  void drawButton( Graphics pGraphics ) {
    Rectangle r = clientRectangle();
    pGraphics.fillRectangle( r, ( (StatedWindow.state() == States.Up) || (mState == States.DownLeft) ) ? Application.lightGrayBrush() : Application.grayBrush() );
    if( StatedWindow.state() == States.Down ) {
      pGraphics.drawEdge( r, Graphics.Edges.Sunken );
      r.position( r.left() + 1, r.top() + 1 );
    } else {
      pGraphics.drawEdge( r, Graphics.Edges.Etched );
    }
    pGraphics.backgroundMode( Graphics.BackgroundModes.Transparent );
    pGraphics.selectFont( mFont );
    pGraphics.drawText( r, text() );
    pGraphics.unselectFont();
  }
  
  override void state( uint value ) {
    StatedWindow.state( value );
    repaint();
  }
  
  Font      mFont;
}

class MainForm : Form {
  
  this( Window pParent, Rectangle pRectangle ) {
    super( pParent, pRectangle, "Stated Window Example" );
    // Create controls
    button = new MyButton( this, 
                          new Rectangle( new Position( 10, 10) , new Size(  100, 50)),
                          "Button 1" );
    button.add( new MyButton.ClickedEvent( &button_onClick ) );
  }
  
  void button_onClick( EventArgs e ) {
    Application.showWarningMessage("Button clicked", Application.MessageBoxTypes.Ok );
  }
  
  MyButton    button;
}

int main() {
  MainForm mainForm = new MainForm( Application.desktop, new Rectangle( 0, 0, 320, 240 ) );
  return Application.runEventLoop( mainForm, true );
}

