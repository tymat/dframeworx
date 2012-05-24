/*
  This file is in public domain
*/

module framework.dll;

private {
  import      std.c.windows.windows;
  import      std.gc;
  
  HINSTANCE   g_hInst;

  extern (C)
  {
    void gc_init();
    void gc_term();
    void _minit();
    void _moduleCtor();
    void _moduleDtor();
    void _moduleUnitTests();
  }
  
}

extern(C)
export void initializeDLL( void *gc ) {

  std.gc.setGCHandle(gc);

  _minit();			        // initialize module list
  _moduleCtor();		    // run module constructors
  _moduleUnitTests();		// run module unit tests
}

extern(C)
export void terminateDLL() {
  _moduleDtor();			  // run module destructors
  std.gc.endGCHandle();
}

private {


  extern (Windows)
  BOOL DllMain(HINSTANCE hInstance, ULONG ulReason, LPVOID pvReserved)
  {
      switch (ulReason)
      {
    case DLL_PROCESS_ATTACH:
        printf("Dll Process Attach\n");
        break;
  
    case DLL_PROCESS_DETACH:
        printf("Dll Process Detach\n");
        break;
  
    case DLL_THREAD_ATTACH:
    case DLL_THREAD_DETACH:
        // Multiple threads not supported yet
        return false;
      }
      g_hInst=hInstance;
      return true;
  }

}
