/*
  This file is in public domain
*/

module framework.implementation.gui.event;

private {
  import framework.c.windows;
  import framework.implementation.gui.systemevent;
}

import framework.implementation.gui.ievent;
import framework.implementation.gui.eventarray;

class Event( int Key, ArgsType ) : IEvent {

  alias void delegate( ArgsType )           DelegateType;
  alias EventArray!( Key, ArgsType )        EventArrayType;
  
  this( DelegateType pDelegate ) 
  in {
    assert( pDelegate !is null );
  }
  body {
    mDelegate = pDelegate;
  }  
  
  //override 
  uint key() {
    return Key;
  }  
  
  void opCall( ArgsType pArgsType ) {
    mDelegate( pArgsType );
  }  
  
  //override 
  IEventArray createEventArray() {
    return new EventArrayType();
  }  
  
  DelegateType    mDelegate;
  
}
