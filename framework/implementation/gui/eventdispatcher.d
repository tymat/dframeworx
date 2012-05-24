module framework.implementation.gui.eventdispatcher;

private {
  import std.array;
  import framework.implementation.gui.ievent;
}

class EventDispatcher {

  void add( IEvent e ) {
    IEventArray aec;

    try {
      aec = mEventMap[ e.key() ];
    } catch( ArrayBoundsError ) {
      aec = e.createEventArray();
      mEventMap[ e.key() ] = aec;
    }
    
    aec.add( e );
  }

  bool hasEvent( uint code ) {
    int a;
    for( a=0; a<mEventMap.keys.length; ++a ) {
      if( mEventMap.keys[a] == code)
        break;
    }
    return ( a<mEventMap.keys.length );
  }
  
  void callEvent( SystemEvent *pSystemEvent )  {
    mEventMap[ pSystemEvent.msg.message ]( pSystemEvent );
  }
  
  EventDispatcher dup() {
    EventDispatcher e = new EventDispatcher;
    foreach( uint key; mEventMap.keys ) {
      e.mEventMap[ key ] = mEventMap[ key ].dup;
    }
    return e;
  }
  
private:
  IEventArray[ uint ]   mEventMap;
}
