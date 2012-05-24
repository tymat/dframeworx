/*
  This file is in public domain
*/

module  framework.implementation.gui.size;

import framework.c.windows;

class Size {

  SIZE  __sz;

  this() {}
  
  this( int p_width, int p_height ) {  
    __sz.cx  = p_width;
    __sz.cy  = p_height;
  }
  
  int  width() { 
    return __sz.cx; 
  }
  
  int  height() { 
    return __sz.cy; 
  }


  int  width( int value ) { 
    return __sz.cx = value; 
  }
  
  int  height( int value ) { 
    return __sz.cy = value; 
  }
  
  SIZE* ptr() {
    return &__sz;
  }

}

