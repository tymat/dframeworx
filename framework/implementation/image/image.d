/*
  This file is in public domain
*/

module framework.implementation.image.image;

import framework.c.windows;

class FeatureNotSupported : Exception {
  this( char[] text ) {
    super( text ~ ":Feature Not Supported" );
  }  
}  

class Image {

  this( uint w, uint h, uint planes, uint bitsPerPixel, bool allocate ) {
    __width   = w;
    __height  = h;
    __logicalWidth = __width + ( 4 - (__width & 0x03) ); // DWORD aligned width
    __bitsPerPixel = bitsPerPixel;
    __planes = planes;
    if( allocate ) {
      __data.length = __logicalWidth * __height * ( __bitsPerPixel >> 3 ) * __planes;
    }  
  }
  
  uint width() {
    return __width;
  }
  
  uint height() {
    return  __height;
  }
  
  uint logicalWidth() {
    return __logicalWidth;
  }  
  
  uint bitsPerPixel() {
    return __bitsPerPixel;
  }

  uint planes() {
    return __planes;
  }
  
  void data( ubyte[] value ) {
    __data = value;
  }
  
  ubyte[] data() {
    return __data;
  }  
protected:
  uint      __width, 
            __height, 
            __bitsPerPixel,
            __planes,
            __logicalWidth;
  ubyte[]   __data;
  // HBITMAP    __hbm;
}

class RGBImage : Image {
  
  this( uint X, uint Y, bool allocate ) {
    super( X, Y, 1, 24, allocate );
  }
  
  void swap() {
    
    ubyte   tmp;
    
    for( int a=0; a < (data.length); a+=3 ) {
      tmp = __data[ a ];
      __data[ a ] = __data[ a + 2 ];
      __data[ a + 2 ] = tmp;
    }
    
  }
  
}

class RGBAImage : Image {

  this( uint X, uint Y, bool allocate ) {
    super( X, Y, 1, 32, allocate );
  }
  
  void swap() {
    
    ubyte   tmp;
    
    for( int a=0; a < (data.length); a+=4 ) {
      tmp = __data[ a ];
      __data[ a ] = __data[ a + 3 ];
      __data[ a + 3 ] = tmp;

      tmp = __data[ a + 1];
      __data[ a + 1 ] = __data[ a + 2 ];
      __data[ a + 2 ] = tmp;
    }
    
  }
  
}

/*
  BGRImage and ABGRImage classes will propably be deprecated future. Byte ordering will be done
  by the methods of RGBImage class
*/

/*class BGRImage : Image {
  this( uint X, uint Y, bool allocate ) {
    super( X, Y, 1, 24, allocate );
  }
}  

class ABGRImage : Image {
  this( uint X, uint Y, bool allocate ) {
    super( X, Y, 1, 32, allocate );
  }
}*/

class GrayscaleImage : Image {
  this( uint X, uint Y, bool allocate ) {
    super( X, Y, 1, 8, allocate );
  }
}

