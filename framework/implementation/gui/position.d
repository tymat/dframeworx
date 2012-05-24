/*
  This file is in public domain
*/

module  framework.implementation.gui.position;

import framework.c.windows;

class Position {
  
  POINT   __p;
  
  this() {}
  
  this( int p_x, int p_y ) {
    __p.x = p_x;
    __p.y = p_y;
  }
  
  this( POINT p ) {
    __p.x = p.x;
    __p.y = p.y;
  }

  int x() { return __p.x; }
  int y() { return __p.y; }
  int x( int value ) { return __p.x = value; }
  int y( int value ) { return __p.y = value; }

  POINT*  ptr() { return &__p; }
}

