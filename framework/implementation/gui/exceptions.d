/*
  This file is in public domain
*/

module framework.implementation.gui.exceptions;

class InvalidHandle : Exception {
  this() {
    super("Invalid handle value");
  }

  this( char[] text ) {
    super(text ~ ":Invalid handle value");
  }

}

