module framework.implementation.gui.systemevent;

private {
  import framework.c.windows;
}

struct SystemEvent {
  MSG         msg;
  LRESULT     result;
  
  void opCall( HWND hWnd, uint uMsg, WPARAM wParam, LPARAM lParam, LRESULT lResult ) {
    msg.hwnd = hWnd;
    msg.message = uMsg;
    msg.wParam = wParam;
    msg.lParam = lParam;
    result = lResult;
  }
}