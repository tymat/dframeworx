/*
  This file is in public domain
*/

module framework.implementation.gui.graphics;

import framework.implementation.gui.window;
import framework.implementation.image.image;

extern (C) void* memset(void*, int, uint);

class Color {

  enum {
    Black     = 0x000000,
    White     = 0xFFFFFF,
    LightGray = 0xC0C0C0,
    Gray      = 0x808080,
    DarkGray  = 0x404040,
    Blue      = 0x800000,
  }

  this( uint pRed, uint pGreen, uint pBlue ) {
    mColorValue = RGB( pRed, pGreen, pBlue );
  }

  COLORREF    mColorValue;
}

class Pen {
  this( int pStyle, int pWidth, uint pColor ) {
    mPenHandle = CreatePen( pStyle, pWidth, pColor );
  }

  HPEN      handle() {
    return mPenHandle;
  }

  HPEN      mPenHandle;
}

class SolidPen : Pen {
  this( int pWidth, uint pColor ) {
    super( PS_SOLID, pWidth, pColor );
  }
}

class DashPen : Pen {
  this( int pWidth, uint pColor ) {
    super( PS_DASH, pWidth, pColor );
  }
}

class DotPen : Pen {
  this( int pWidth, uint pColor ) {
    super( PS_DOT, pWidth, pColor );
  }
}

class DashDotPen : Pen {
  this( int pWidth, uint pColor ) {
    super( PS_DASHDOT, pWidth, pColor );
  }
}

class DashDotDotPen : Pen {
  this( int pWidth, uint pColor ) {
    super( PS_DASHDOTDOT, pWidth, pColor );
  }
}

class NullPen : Pen {
  this( int pWidth, uint pColor ) {
    super( PS_NULL, pWidth, pColor );
  }
}

class Brush {
  this( int pStyle, int pColor, int pHatch ) {
    LOGBRUSH    logBrush;
    logBrush.lbStyle = pStyle;
    logBrush.lbColor = pColor;
    logBrush.lbHatch = pHatch;
    mBrushHandle = CreateBrushIndirect( &logBrush );
  }
  
  HBRUSH  handle() {
    return mBrushHandle;
  }
  
  HBRUSH  mBrushHandle;
}

class SolidBrush : Brush {
  this(int pColor ) {
    super( BS_SOLID, pColor, 0 );
  }
}

class HatchedBrush : Brush {
  this(int pColor, int pHatch ) {
    super( BS_HATCHED, pColor, pHatch );
  }
}

class PatternBrush : Brush {
  this( int pColor, int pHatch ) {
    super( BS_PATTERN, pColor, pHatch );
  }
}

class NullBrush : Brush {
  this( ) {
    super( BS_NULL, 0, 0 );
  }
}

class Font {

  this() {
    mFontHandle = cast(HFONT) GetStockObject(ANSI_VAR_FONT);
  }

  this( Graphics g, char[] pFontName, int pSize ) {
    LOGFONTA   logFont;
    int a;
    for( a=0; a<pFontName.length && a < (logFont.lfFaceName.length-1); ++a ) {
      logFont.lfFaceName[ a ] = pFontName[ a ];
    }
    if( a < logFont.lfFaceName.length ) {
      logFont.lfFaceName[ a ] = 0;
    }
    logFont.lfHeight = -( ( pSize * GetDeviceCaps(g.handle(), LOGPIXELSY) ) / 72 );
    mFontHandle = CreateFontIndirectA( &logFont );//(HFONT) ::GetStockObject(SYSTEM_FIXED_FONT);
  }

  HFONT   handle() {
    return mFontHandle;
  }
  
  HFONT   mFontHandle;
}


class Graphics {


  this( HDC hdc ) {
    mHDC = hdc;
  }

  HDC handle() {
    return mHDC;
  }
  
  void fillRectangle( Rectangle r ) {
    FillRect( mHDC, r.ptr, cast(HBRUSH) COLOR_WINDOW );
  }
  
  void fillRectangle( Rectangle r, Brush b ) {
    FillRect( mHDC, r.ptr, b.mBrushHandle );
  }
  
  void drawRectangle( Rectangle r ) {
    drawLine( r.left(), r.top(), r.right(), r.top() );
    drawLine( r.right(), r.top(), r.right(), r.bottom() );
    drawLine( r.left(), r.bottom(), r.right(), r.bottom() );
    drawLine( r.left(), r.top(), r.left(), r.bottom() );
  }
  
  enum BackgroundModes {
    Transparent = TRANSPARENT,
    Opaque      = OPAQUE  
  }

  void backgroundMode( BackgroundModes bm ) {
    SetBkMode( mHDC, cast(int) bm );
  }
  
  void textColor( uint color ) {
    SetTextColor( mHDC, color );
  }
  
  void textColor( uint pRed, uint pGreen, uint pBlue ) {
    SetTextColor( mHDC, RGB( pRed, pGreen, pBlue ) );
  }
  
  void backgroundColor( uint color ) {
    SetBkColor( mHDC, color );
  }
  
  void backgroundColor( uint pRed, uint pGreen, uint pBlue ) {
    SetBkColor( mHDC, RGB( pRed, pGreen, pBlue ) );

  }
  
  enum TextAlignment {
    Top = DT_TOP,
    Bottom = DT_BOTTOM,
    Left = DT_LEFT,
    Right = DT_RIGHT,
    HorizontalCenter = DT_CENTER,
    VerticalCenter = DT_VCENTER
  }

  void drawText( Rectangle pRectangle, char[] pText ) {
    wchar[] tmp = toUTF16( pText );
    DrawTextW(  mHDC, 
                cast(LPWSTR) tmp, 
                tmp.length, 
                pRectangle.ptr, 
                TextAlignment.HorizontalCenter | TextAlignment.VerticalCenter | DT_SINGLELINE );
  }
  
  void drawText( Rectangle pRectangle, char[] pText, uint pTextAlignment ) {
    wchar[] tmp = toUTF16( pText );
    DrawTextW( mHDC, 
               cast(LPWSTR) tmp, 
               tmp.length, 
               pRectangle.ptr, 
               pTextAlignment | DT_SINGLELINE );
  }
  
  void drawCircle( Position p_center, int p_radius ) {
    if( mHDC ) {
      Ellipse( mHDC, 
               p_center.x - p_radius, 
               p_center.y - p_radius,
               p_center.x + p_radius,
               p_center.y + p_radius );
    }
  }
  
  void drawButtonFrame( Rectangle r, bool pushed, bool inactive ) {
    DrawFrameControl( mHDC, r.ptr, DFC_BUTTON, 
                      DFCS_BUTTONPUSH | 
                      (( pushed == true ) ? DFCS_PUSHED : 0 ) | 
                      (( inactive == true ) ? DFCS_INACTIVE : 0 ) );
  }

  void drawRadioButtonFrame( Rectangle r, bool checked, bool inactive ) {
    DrawFrameControl( mHDC, r.ptr, DFC_BUTTON, 
                      DFCS_BUTTONRADIO | 
                      ( ( checked == true ) ? DFCS_CHECKED : 0 )  |
                      ( ( inactive == true ) ? DFCS_INACTIVE : 0 ) );
  }

  void drawCheckBoxFrame( Rectangle r, bool checked, bool inactive ) {
    DrawFrameControl( mHDC, r.ptr, DFC_BUTTON, 
                      DFCS_BUTTONCHECK | 
                      ( ( checked == true ) ? DFCS_CHECKED : 0 )  |
                      ( ( inactive == true ) ? DFCS_INACTIVE : 0 ) );
  }

  enum Edges {
    Sunken = EDGE_SUNKEN,
    Raised = EDGE_RAISED,
    Bump   = EDGE_BUMP,
    Etched = EDGE_ETCHED,
    SunkenInner = BDR_SUNKENINNER,
    SunkenOuter = BDR_SUNKENOUTER,
    RaisedInner = BDR_RAISEDINNER,
    RaisedOuter = BDR_RAISEDOUTER,
  }
  
  void drawEdge( Rectangle r, uint pEdges ) {
    DrawEdge( mHDC, r.ptr, cast(uint) pEdges, BF_ADJUST | BF_RECT );
  }
  
  void drawFocusRectangle( Rectangle r ) {
    DrawFocusRect( mHDC, r.ptr );
  }

  void drawImage( Position p, Image i ) {
    
    HDC           hdcCompatible;
    HBITMAP       hbm;
    HGDIOBJ       hbmOld;
    BITMAPINFO    bi;
        
/*    printf("width:%d\n", i.width() );
    printf("height:%d\n", i.height() );
    printf("planes:%d\n", i.planes() );
    printf("bitPerPixel:%d\n", i.bitsPerPixel() );*/

    hdcCompatible = CreateCompatibleDC( mHDC );
    
    memset( &bi, 0, BITMAPINFO.sizeof );
    
    bi.bmiHeader.biSize   = BITMAPINFO.sizeof;
    bi.bmiHeader.biWidth  = i.logicalWidth();   // logicalWidth is needed for creating Section
    bi.bmiHeader.biHeight = i.height();
    bi.bmiHeader.biPlanes = i.planes();
    bi.bmiHeader.biBitCount = i.bitsPerPixel();
    bi.bmiHeader.biCompression = BI_RGB;
    
    ubyte* test;
    
    hbm = CreateDIBSection( hdcCompatible, 
                            &bi,
                            DIB_RGB_COLORS,
                            cast(void**) &test,
                            null,
                            0 );

    if( hbm is null )
      throw new Exception("CreateDIBSection failed");

    test[ 0 .. i.data().length ] = i.data();

    hbmOld = cast(HBITMAP) SelectObject( hdcCompatible, hbm );
    BitBlt( mHDC, p.x(), p.y(), i.width(), i.height(), hdcCompatible, 0, 0, SRCCOPY );
    SelectObject( hdcCompatible, hbmOld );

    DeleteObject( hbm );
    DeleteDC( hdcCompatible );
  }
  
  void copy( Graphics source, Rectangle r ) {
    BitBlt( mHDC, r.x(), r.y(), r.width(), r.height(), source.handle(), 0, 0, SRCCOPY );
  }  

  void drawXorBar( Rectangle r ) {
    /* ????
      Adapted from the code written by James Brown on his web page www.catch22.org
    */

  	static WORD[8] __dotPatternBmp = [ 
	 	  0x00aa, 0x0055, 0x00aa, 0x0055, 
  		0x00aa, 0x0055, 0x00aa, 0x0055
    ];

    HBITMAP __hbm;
    HBRUSH  __hbr, 
            __hbrushOld;

    __hbm = CreateBitmap( 8, 8, 1, 1, __dotPatternBmp);
    __hbr = CreatePatternBrush( __hbm );
	
	  SetBrushOrgEx( mHDC, r.x(),  r.y(), null );
  	__hbrushOld = cast(HBRUSH) SelectObject( mHDC, __hbr);
	
    PatBlt( mHDC, 
            r.x(), r.y(), 
            r.width(), r.height(), 
            PATINVERT );
	
    SelectObject( mHDC, __hbrushOld );
	
    DeleteObject( __hbr );
    DeleteObject( __hbm );
  }
  
  void drawPattern( Rectangle r, WORD[] pPatternData ) {
    HBITMAP __hbm;
    HBRUSH  __hbr, 
            __hbrushOld;

    __hbm = CreateBitmap( 8, 8, 1, 1, pPatternData.ptr );
    __hbr = CreatePatternBrush( __hbm );
	
	  SetBrushOrgEx( mHDC, r.x(),  r.y(), null );
  	__hbrushOld = cast(HBRUSH) SelectObject( mHDC, __hbr);
	
    PatBlt( mHDC, 
            r.x(), r.y(), 
            r.width(), r.height(), 
            PATINVERT );
	
    SelectObject( mHDC, __hbrushOld );
	
    DeleteObject( __hbr );
    DeleteObject( __hbm );
  }
  
  void selectPen( Pen pPen ) {
    mOldPenHandle = cast(HPEN) SelectObject( mHDC, pPen.mPenHandle );
  }
  
  void selectBrush( Brush pBrush) {
    mOldBrushHandle = cast(HBRUSH) SelectObject( mHDC, pBrush.mBrushHandle );
  }

  void selectFont( Font pFont ) {
    mOldFontHandle = cast(HFONT) SelectObject( mHDC, pFont.mFontHandle );
  }
  
  void unselectPen() {
    SelectObject( mHDC, cast(HGDIOBJ) mOldPenHandle );
  }
  
  void unselectBrush() {
    SelectObject( mHDC, cast(HGDIOBJ) mOldBrushHandle );
  }

  void unselectFont() {
    SelectObject( mHDC, cast(HGDIOBJ) mOldFontHandle );
  }
  
  void drawLine( int x1, int y1, int x2, int y2 ) {
    MoveToEx( mHDC, x1, y1, null );
    LineTo( mHDC, x2, y2 );
  }
  
  enum Directions {
    Left,
    Right,
    Up,
    Down
  }
  
  void drawArrow( Rectangle pRectangle, Directions pDirection ) {
    POINT[] p;
    p.length = 3;
    switch( pDirection ) {
    case Directions.Left:
      p[0].x = pRectangle.left + pRectangle.width()/4; p[0].y=pRectangle.top + pRectangle.height()/2;
      p[1].x = pRectangle.left + 3*pRectangle.width()/4; p[1].y=pRectangle.top + 3*pRectangle.height()/4;
      p[2].x = pRectangle.left + 3*pRectangle.width()/4; p[2].y=pRectangle.top + pRectangle.height()/4;
      break;
    case Directions.Right:
      p[0].x = pRectangle.left + 3*pRectangle.width()/4; p[0].y=pRectangle.top + 3*pRectangle.height()/2;
      p[1].x = pRectangle.left + pRectangle.width()/4; p[1].y=pRectangle.top + 3*pRectangle.height()/4;
      p[2].x = pRectangle.left + pRectangle.width()/4; p[2].y=pRectangle.top + pRectangle.height()/4;
      break;
    case Directions.Up:
      p[0].x = pRectangle.left + pRectangle.width()/2; p[0].y=pRectangle.top + pRectangle.height()/4;
      p[1].x = pRectangle.left + 3*pRectangle.width()/4; p[1].y=pRectangle.top + 3*pRectangle.height()/4;
      p[2].x = pRectangle.left + pRectangle.width()/4; p[2].y=pRectangle.top + 3*pRectangle.height()/4;
      break;
    case Directions.Down:
      p[0].x = pRectangle.left + pRectangle.width()/2; p[0].y=pRectangle.top + 3*pRectangle.height()/4;
      p[1].x = pRectangle.left + pRectangle.width()/4; p[1].y=pRectangle.top + pRectangle.height()/4;
      p[2].x = pRectangle.left + 3* pRectangle.width()/4; p[2].y=pRectangle.top + pRectangle.height()/4;
      break;
    default:
      break;
    }
    Polygon( mHDC, p.ptr, 3 );
    delete p;
  }
  
protected:
  HDC           mHDC;
  HPEN          mOldPenHandle;
  HBRUSH        mOldBrushHandle;
  HFONT         mOldFontHandle;
}

auto class WindowGraphics : Graphics {
  
  this( Window w ) {
    __hwnd = w.handle();
    super( GetDC( __hwnd ) );
    printf("WindowGraphics.this()\n");
  }

  ~this() {
    ReleaseDC( __hwnd, mHDC );
    printf("WindowGraphics.~this()\n");
  }

  HWND          __hwnd = null;
}  

class MemoryGraphics : Graphics {
  
/*  this() {
    
  }  */
  
  this( Graphics g, Rectangle r ) {
    BITMAPINFO    bi;
    super( CreateCompatibleDC( g.handle() ) );

    printf("g.handle():%p\n", g.handle() );
    printf("mHDC:%p\n", mHDC );
    
    printf("r.width():%d\n", r.width() );
    printf("r.height():%d\n", r.height() );    

    memset( &bi, 0, BITMAPINFO.sizeof );
    
    __image = new Image( r.width(), r.height(), 1, 24, false ); // plane ve bitsPerPixel should be obtained from Device Capabilities
    
    bi.bmiHeader.biSize   = BITMAPINFO.sizeof;
    bi.bmiHeader.biWidth  = __image.logicalWidth();   // logicalWidth is needed for creating Section
    bi.bmiHeader.biHeight = __image.height();
    bi.bmiHeader.biPlanes = __image.planes();
    bi.bmiHeader.biBitCount = __image.bitsPerPixel();
    bi.bmiHeader.biCompression = BI_RGB;
    
    ubyte* bufferPtr;
    
    __memoryBitmapHandle = CreateDIBSection( mHDC, 
                                             &bi,
                                             DIB_RGB_COLORS,
                                             cast(void**) &bufferPtr,
                                             null,
                                             0 );

    if( __memoryBitmapHandle is null )
      throw new Exception("CreateDIBSection failed");
    
    ubyte[] buffer = bufferPtr[0 .. __image.logicalWidth() * __image.height() * ( __image.bitsPerPixel() >> 3 ) ];
    
    __image.data( buffer );
    
    __oldGDIObject = SelectObject( mHDC, __memoryBitmapHandle );
  }
  
  ~this() {
    if( mHDC ) {
      destroy();
    }  
  }
  
  void destroy() {
    SelectObject( mHDC, __oldGDIObject );
    DeleteObject( __memoryBitmapHandle );
    DeleteDC( mHDC );
    mHDC = null;
  }  
  
protected:
  
  HBITMAP   __memoryBitmapHandle;
  HGDIOBJ   __oldGDIObject;
  
  Image     __image;
  
}
