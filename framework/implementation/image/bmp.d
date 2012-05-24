/*
  This file is in public domain
  
  Only 24 Bit and 32 Bit formats are supported
*/

module framework.implementation.image.bmp;

import std.stream;
import framework.implementation.image.image;

class FileIsNotBMP : Exception {
  this() {
    super("File is not BMP");
  }  
}

Image loadBMP( char[] fileName ) {
  File  f = new File( fileName , FileMode.In );
  
  BITMAPFILEHEADER    bmfh;

//  f.readExact( &bmfh, 14 );

  f.read( bmfh.bfType );
  f.read( bmfh.bfSize );
  f.read( bmfh.bfReserved1 );
  f.read( bmfh.bfReserved2 );
  f.read( bmfh.bfOffBits );

  printf( "Type:%x\n", bmfh.bfType );
  printf( "Size:%x\n", bmfh.bfSize );
  printf( "OffBits:%x\n", bmfh.bfOffBits );

  BITMAPINFOHEADER    bmih;
//  f.readExact( &bmih, bmih.sizeof );
  
  f.read( bmih.biSize );
  f.read( bmih.biWidth );
  f.read( bmih.biHeight );
  f.read( bmih.biPlanes );
  f.read( bmih.biBitCount );
  f.read( bmih.biCompression ); 
  f.read( bmih.biSizeImage ); 
  f.read( bmih.biXPelsPerMeter );
  f.read( bmih.biYPelsPerMeter ); 
  f.read( bmih.biClrUsed ); 
  f.read( bmih.biClrImportant );

  printf( "Width:%d\n", bmih.biWidth );
  printf( "Height:%d\n", bmih.biHeight );
  printf( "Bit Count:%d\n", bmih.biBitCount );
  printf( "Size Image:%d\n", bmih.biSizeImage );
  
  if( (bmfh.bfType & 0xFF)!='B' || (bmfh.bfType >> 8)!='M' ) {
    throw new FileIsNotBMP();
  }  

  f.seek( bmfh.bfOffBits, SeekPos.Set );
  ubyte[]  data = cast(ubyte[]) f.readString( bmih.biSizeImage );

  Image   i;

  if( bmih.biBitCount == 24 ) {
     i = new RGBImage( bmih.biWidth, bmih.biHeight, false );
  } else if( bmih.biBitCount == 32 ) {
     i = new RGBAImage( bmih.biWidth, bmih.biHeight, false );
  } else {
    throw new FeatureNotSupported( "loadBMP" );
  }

  i.data( data );
  
  f.close();
  
  return i;
}

void saveBMP( char[] fileName, Image i ) {
  
}    
