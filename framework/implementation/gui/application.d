/*
  This file is in public domain
*/

module framework.implementation.gui.application;

import framework.implementation.gui.form;
import framework.implementation.gui.graphics;

class Application {

  enum MessageLoop {
    Wait = true,
    NoWait = false
  }
  
  enum MessageBoxTypes {
    Ok =              MB_OK,
    OkCancel =        MB_OKCANCEL,
    YesNo =           MB_YESNO,
    YesNoCancel =     MB_YESNOCANCEL,
    AbortRetryIgnore =MB_ABORTRETRYIGNORE,
    RetryCancel =     MB_RETRYCANCEL
  }
  
  enum MessageBoxIcons {
    Warning =         MB_ICONWARNING,
    Question =        MB_ICONQUESTION,
    Error =           MB_ICONERROR,
    Information =     MB_ICONINFORMATION,
  }

  static this() {
  
    desktop = new Window;

    mBlackBrush = new SolidBrush( Color.Black );
    mWhiteBrush = new SolidBrush( Color.White );
    mLightGrayBrush = new SolidBrush( Color.LightGray );
    mGrayBrush = new SolidBrush( Color.Gray );
    mDarkGrayBrush = new SolidBrush( Color.DarkGray );
    mBlueBrush = new SolidBrush( Color.Blue );
  
    HINSTANCE hInst = GetModuleHandleA(null);
  
  /*	HINSTANCE hUser32Dll = GetModuleHandleA( "USER32.DLL" );
    assert( hUser32Dll );*/
  
    INITCOMMONCONTROLSEX icex;
  
    icex.dwSize = icex.sizeof;
    icex.dwICC = ICC_TREEVIEW_CLASSES | ICC_DATE_CLASSES;
  
    InitCommonControlsEx(&icex);
    
    WNDCLASSW wc;
    wc.lpszClassName = toUTF16z( "DWndClass" );
    wc.style = CS_DBLCLKS | CS_OWNDC | CS_VREDRAW | CS_HREDRAW;
    wc.lpfnWndProc = &WindowProc;
    wc.hInstance = hInst;
    wc.hIcon = LoadIconW(cast(HINSTANCE) null, cast(wchar*) IDI_APPLICATION);
    wc.hCursor = LoadCursorW( cast(HINSTANCE) null, cast(wchar*) IDC_ARROW);
    wc.hbrBackground = cast(HBRUSH) mLightGrayBrush.handle();
    wc.lpszMenuName = null;
    wc.cbClsExtra = wc.cbWndExtra = 0;
    assert( RegisterClassW(&wc) );
    
    
  }
   
  
  static void showMessage( char[] pText, char[] pTitle, MessageBoxTypes pType, MessageBoxIcons pIcon ) {
    MessageBoxW( 
      null,
      toUTF16z( pText ),
      toUTF16z( pTitle ),
      pType | pIcon
    );
  }
  
  static void showWarningMessage( char[] pText, MessageBoxTypes pType ) {
    showMessage( 
      pText,
      "Warning",
      pType,
      MessageBoxIcons.Warning
    );
  }
  
  static void showErrorMessage( char[] pText, MessageBoxTypes pType ) {
    showMessage( 
      pText,
      "Error",
      pType,
      MessageBoxIcons.Error
    );
  }
  
  static void showQuestionMessage( char[] pText, MessageBoxTypes pType ) {
    showMessage( 
      pText,
      "Question",
      pType,
      MessageBoxIcons.Question
    );
  }
  
  /*static int loop( Form f, MessageLoop wait ) {
    if( wait == MessageLoop.Wait ) {
      f.showModal();
    } else {
      //printf("No wait loop is not implemented yet\n");
    }
    
    return 1;
  }*/

  
  
  static int runEventLoop( Form f, bool wait ) {
  
    // The following code is adapted from Chris Becke's 
    // "Implementing Modal Message Loops" tutorial. 
    // You can find the original code at  www.mvps.org/user32

    HWND  hwndParent = GetParent( f.handle() ); 
    MSG   msg;

    f.show();
  
    while( !f.done() ) {
      while( PeekMessageW( &msg, null, 0, 0, PM_REMOVE) ) {
        if( msg.message == WM_QUIT ) {
          f.done( true );
          PostMessageW( hwndParent, WM_QUIT, 0, 0);
          break;
        } else {
          TranslateMessage( &msg );
          DispatchMessageW( &msg );
        }
      }
      
      if( wait ) {
        WaitMessage();
      } else {
      //  To Do : Idle
      }
    }
    
    return 1;
  }

  
  static Brush blackBrush() {
    return mBlackBrush;
  }

  static Brush whiteBrush() {
    return mWhiteBrush;
  }

  static Brush lightGrayBrush() {
    return mLightGrayBrush;
  }

  static Brush grayBrush() {
    return mGrayBrush;
  }

  static Brush darkGrayBrush() {
    return mDarkGrayBrush;
  }

  static Brush blueBrush() {
    return mBlueBrush;
  }
  
  static Pen blackPen() {
    return mBlackPen;
  }

  static Pen whitePen() {
    return mWhitePen;
  }

  static Pen lightGrayPen() {
    return mLightGrayPen;
  }

  static Pen grayPen() {
    return mGrayPen;
  }

  static Pen darkGrayPen() {
    return mDarkGrayPen;
  }

  static Pen bluePen() {
    return mBluePen;
  }

public:

  static Window          desktop;

private:
  static Brush  mBlackBrush,
                mWhiteBrush,
                mLightGrayBrush,
                mGrayBrush,
                mDarkGrayBrush,
                mBlueBrush;

  static Pen    mBlackPen,
                mWhitePen,
                mLightGrayPen,
                mGrayPen,
                mDarkGrayPen,
                mBluePen;
                
}

private {

  extern(Windows)
  int WindowProc(HWND hWnd, uint uMsg, WPARAM wParam, LPARAM lParam) {
  
    Window    w = null;
  	switch (uMsg) {
	  case WM_NCCREATE:
    	w = cast( Window ) (cast(CREATESTRUCTW*) lParam).lpCreateParams;
  	  w.handle( hWnd );
    	SetWindowLongW( hWnd, GWL_USERDATA, cast(LONG) cast(void*) w );
      break;
    default:
      w = cast(Window) cast(void*) GetWindowLongW( hWnd, GWL_USERDATA );
      break;
  	}
  	if( w !is null ) {
/*      try {
        // auto new Win32EventArgs( w, uMsg, wParam, lParam );
        return w.mapEvents( hWnd, uMsg, wParam, lParam );
      } catch( Exception e ) {
        Application.showErrorMessage( e.toString(), Application.MessageBoxTypes.Ok  );
        PostQuitMessage( 0 );
        return DefWindowProcW(hWnd, uMsg, wParam, lParam);
      }*/
      if( w.hasEvent( uMsg ) ) {
        try {
          SystemEvent systemEvent;
          systemEvent( hWnd, uMsg, wParam, lParam, 0 );
          w.callEvent( &systemEvent );
          return systemEvent.result;
        } catch( Exception e ) {
          Application.showErrorMessage( e.toString(), Application.MessageBoxTypes.Ok  );
          PostQuitMessage( 0 );
          return 0;
        }
      } else {
        return DefWindowProcW(hWnd, uMsg, wParam, lParam);
      }
    } else {
    	return DefWindowProcW(hWnd, uMsg, wParam, lParam);
  	}
  }

}

