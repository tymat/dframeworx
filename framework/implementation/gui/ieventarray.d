module framework.implementation.gui.ieventarray;

import framework.implementation.gui.systemevent;
import framework.implementation.gui.ievent;

/*class AbstractEventArray {
  abstract uint key();
  abstract void add( AbstractEvent );
  abstract void opCall( SystemEvent* pSystemEvent );
}*/


interface IEventArray {
  uint key();
  void add( IEvent );
  void opCall( SystemEvent* pSystemEvent );
  IEventArray dup();
}

