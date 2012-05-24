/*
  This file is in public domain
*/

module  framework.implementation.gui.rectangle;

import framework.implementation.gui.position;
import framework.implementation.gui.size;

class Rectangle {

  RECT    __r;
  
  this() {
    __r.left    = 0;
    __r.top     = 0;
    __r.right   = 0;
    __r.bottom  = 0;
  }
  
  this( int pLeft, int pTop, int pRight, int pBottom ) {
    opCall( pLeft, pTop, pRight, pBottom );
  }
  
  this( Position position, Size size ) {
    __r.left    = position.x;
    __r.top     = position.y;
    __r.right   = position.x + size.width();
    __r.bottom  = position.y + size.height();
//    opCall( pLeft, pTop, pRight, pBottom );
  }

  this( Rectangle r ) {
    __r = *r.ptr();
  }
  
  Rectangle inflate( int value ) {
    __r.left -= value;
    __r.top -= value;
    __r.right += value;
    __r.bottom += value;
    return this;
  }
  
  bool isPointIn( Position p ) {
//    printf( "rect l,t,r,b:(%d,%d,%d,%d), p x,y: %d,%d\n", __r.left, __r.top, __r.right, __r.bottom, p.getX(), p.getY() );
    return ( __r.left <= p.x ) && 
           ( __r.right >= p.x ) &&
           ( __r.top <= p.y ) &&
           ( __r.bottom >= p.y );
  }

  bool isPointIn( int pX, int pY ) {
//    printf( "rect l,t,r,b:(%d,%d,%d,%d), p x,y: %d,%d\n", __r.left, __r.top, __r.right, __r.bottom, p.getX(), p.getY() );
    return ( __r.left <=  pX ) && 
           ( __r.right >=  pX ) &&
           ( __r.top <= pY ) &&
           ( __r.bottom >= pY );
  }
  
  int left() { return __r.left; }
  int top() { return __r.top; }
  int right() { return __r.right; }
  int bottom() { return __r.bottom; }

  int left( int value ) { return __r.left = value; }
  int top( int value ) { return __r.top = value; }
  int right( int value ) { return __r.right = value; }
  int bottom( int value ) { return __r.bottom = value; }

  int x() { return __r.left;}
  int y() { return __r.top;}
  int width ( int value ) { return (__r.right = value + __r.left); }
  int height( int value ) { return (__r.bottom = value + __r.top); }
  int width () { return __r.right - __r.left; }
  int height() { return __r.bottom - __r.top; }
  
  Position  position() { return new Position( __r.left, __r.top ); }
  
  void position( Position value ) {
    __r.right = value.x() + width();
    __r.bottom = value.y() + height();
    __r.left = value.x();
    __r.top = value.y();
  }

  void position( int x , int y ) {
    __r.right = x + width();
    __r.bottom = y + height();
    __r.left = x;
    __r.top = y;
  }

  void opCall( int pLeft, int pTop, int pRight, int pBottom ) {
    __r.left    = pLeft;
    __r.top     = pTop;
    __r.right   = pRight;
    __r.bottom  = pBottom;
  }  

  Size      size() { return new Size(__r.right - __r.left, __r.bottom - __r.top); }
  
  RECT* ptr() { return &__r; }
  
}

