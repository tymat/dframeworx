module framework.implementation.gui.eventarray;

private {
  import framework.implementation.gui.ieventarray;
}

import framework.implementation.gui.event;

class EventArray( int Key, ArgsType ) : IEventArray {

  alias Event!( Key, ArgsType )     EventType;

  // override 
  uint key() {
    return Key;
  }

  // override 
  void opCall( SystemEvent *pSystemEvent ) {
    auto ArgsType eat = new ArgsType( pSystemEvent );
    for( int i=0; i < mEvents.length; i++ ) {
      if( mEvents[ i ] !is null ) 
        mEvents[ i ]( eat );
    }
  }
  
  // override 
  void add( IEvent d ) {
    mEvents ~= cast(EventType) d;
  }
  
  IEventArray dup() {
    EventArray e = new EventArray;
    e.mEvents = mEvents.dup;
    return e;
  }
  
private:
  EventType[]   mEvents;
}
