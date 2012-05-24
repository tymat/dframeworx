module framework.implementation.gui.statedwindow;

private {
  import framework.implementation.gui.window;
}

class StatedWindow : Window {

  this( Window    pParent, 
        Rectangle pRectangle, 
        char[]    pText, 
        DWORD     style, 
        DWORD     exStyle ) {
    super( pParent, pRectangle, pText, style, exStyle );
  }

  void registerState( uint pState ) {
    mDispatchers[ pState ] = new EventDispatcher;
  }
  
  void state( uint value ) {
    mState = value;
    currentDispatcher( mDispatchers[ mState ] );
  }
  
  uint state() {
    return mState;
  }
  
  override void add( IEvent pEvent ) {
    Window.add( pEvent );
  }
  
  void add( uint pState, IEvent pEvent ) {
    mDispatchers[ pState ].add( pEvent );
  }
  
  override bool hasEvent( uint uMsg ) {
    if( Window.hasEvent( uMsg ) )
      return true;
    if( mCurrentDispatcher !is null ) {
      if( mCurrentDispatcher.hasEvent( uMsg ) )
        return true;
    }
    return false;
  }
  
  override void callEvent( SystemEvent *pSystemEvent ) {
    if( Window.hasEvent( pSystemEvent.msg.message ) ) 
      Window.callEvent( pSystemEvent );
    if( mCurrentDispatcher !is null ) {
      if( mCurrentDispatcher.hasEvent( pSystemEvent.msg.message ) ) {
        mCurrentDispatcher.callEvent( pSystemEvent );
      }
    }
  }
  
  void currentDispatcher( EventDispatcher pCurrentDispatcher ) 
  in {
    assert( pCurrentDispatcher !is null );
  }
  body {
    mCurrentDispatcher = pCurrentDispatcher;
  }

  EventDispatcher currentDispatcher() 
  out( result ) {
    assert( result !is null );
  }
  body {
    return mCurrentDispatcher;
  }
  
  EventDispatcher[ uint ]   mDispatchers;
  EventDispatcher           mCurrentDispatcher;
  uint                      mState;
}
