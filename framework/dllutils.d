/*
  This file is in public domain
  
  This library is for run time loading of dlls
*/

module framework.dllutils;

import framework.c.windows;
import std.string;
import std.utf;
import std.gc;

class Library {

  extern( C ) {
    alias void* function()      createInstanceFunctionType;
    alias void function(void*)  initializeDLLFunctionType;
    alias void function()       terminateDLLFunctionType;
  }

  this() {}
  
  this( char[] fileName ) {
    if( mHANDLE is null ) {
      load( fileName );
    } else {
      throw new Exception("Library overload");
    }
  }
  
  ~this() {
    if( mHANDLE !is null )
      free();
  }
  
  void load( char[] fileName ) {
    
    mHANDLE = LoadLibraryW( toUTF16z( fileName ) );
    
    if( mHANDLE is null )
      throw new Exception("Cannot Load Library:" ~ fileName );
  
    procedure( cast(void**) &initializeDLLFunction, "initializeDLL" );
    procedure( cast(void**) &terminateDLLFunction, "terminateDLL" );
    procedure( cast(void**) &createInstanceFunction, "createInstance" );
    
    initializeDLLFunction( std.gc.getGCHandle() );
  
  }
  
  void free() {
    terminateDLLFunction();
  
    if( FreeLibrary( mHANDLE ) == FALSE ) {
      throw new Exception("Cannot free library");
    }
    mHANDLE = null;
  }
  
  void* createInstance() {
    return createInstanceFunction();
  }
  
  HANDLE handle() {
    return mHANDLE;
  }
  
  void procedure( void** func, char[] symbolName ) {
    *func = GetProcAddress( mHANDLE, toStringz( symbolName ) );
    if( *func is null ) {
      throw new Exception("Couldn't find procedure " ~ symbolName );
    }  
  }

  createInstanceFunctionType    createInstanceFunction;
  initializeDLLFunctionType     initializeDLLFunction;
  terminateDLLFunctionType      terminateDLLFunction;
  HANDLE    mHANDLE;
}
