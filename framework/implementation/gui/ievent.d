module framework.implementation.gui.ievent;

import framework.implementation.gui.ieventarray;

/*class AbstractEvent {
  abstract uint  key();
  abstract AbstractEventArray createEventArray();
}*/

interface IEvent {
  uint  key();
  IEventArray createEventArray();
}
