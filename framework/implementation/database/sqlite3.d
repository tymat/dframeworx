/*
  This file is in public domain
*/

module  framework.implementation.database.sqlite3;

private {
  import std.string;
  import framework.c.sqlite3_imp;
  import framework.collections;
}

class Column {
  
  this( char[] name ) {
    __name = name;
  }
  
  char[] name() {
    return __name;
  }
  
  void name( char[] value ) {
    __name = value;
  }    
  
  char[]    __name;
}  

class Field {
  
  this( char[] fieldName ) {
    name( fieldName );
  }  
  
  char[] value() {
    return __value;
  }  

  void value( char[] v ) {
    __value = v;
  }  

  char[] name() {
    return __name;
  }  

  void name( char[] v ) {
    __name = v;
  }  
  
  void isNull( bool v ) {
    __isNull = v;
  }  

  bool isNull() {
    return __isNull;
  }  
  
  char[]    __name;
  char[]    __value;
  bool      __isNull;
}  

class Row {
  
  this( Array!(Column) columns ) {

    __fields = new Array!( Field );
    
    for( int a=0; a < columns.size(); ++a ) {
      __fields.pushBack( new Field( columns[a].name() ) );
    }

  }  
  
  Field opIndex( int index ) {
    return __fields[ index ];
  }  
  
  Field opIndex( char[] fieldName ) {
    for( int a=0; a < __fields.size(); ++a ) {
      if( __fields[ a ].name() == fieldName ) {
        return __fields[ a ];
      }  
    }
    throw new Exception("Field name " ~ fieldName ~ " doesn't match");
  }
  
  uint size() {
    return __fields.size();
  }  

  Array!(Field)    __fields;

}

class Table {

  this() {
    __rows = new Array!( Row )(100);
    __columns = new Array!( Column );
  }
  
  void add( Row r ) {
    __rows.pushBack( r );
  }
  
  void add( Column c ) {
    __columns.pushBack( c );
  }  

  Column column( int index ) {
    return __columns[ index ];
  }

  Column column( char[] columnName ) {
    for( int a=0; a < __columns.size(); ++a ) {
      if( __columns[ a ].name() == columnName ) {
        return __columns[ a ];
      }  
    }
    throw new Exception("Column name " ~ columnName ~ " doesn't match");
  }
  
  Array!(Column) columns() {
    return __columns;
  }  
  
  Row opIndex( int index ) {
    return __rows[ index ];
  }

  int size() {
    return __rows.size();
  }  
/*  Row opIndex( int index ) {
    Row   r=    new Row( __columns );
    int   offset = index * __columns.size();
    for( int a=0; a < r.size(); ++a ) {
      r[a].value( __data[ offset + a ] );
    }  
    return r;
  }  */

private:
  
  Array!(Column)      __columns;
  Array!(Row)         __rows;
//  Array!(char[])      __data;
}  

class SQLite3Database {
  
  this() {
    
  }
  
  this( char[] fileName  ) {
    open( fileName );
  } 

  ~this() {
    close();
  }  
  
  void open( char[] fileName ) {
    fileName ~= "\0";
    int rc = sqlite3_open( fileName, &__db );
    if( rc ) {
      throw new Exception("Cannot open database:" ~ fileName );
    }
    __open = true;
  }
  
  void close() {
    if( __open ) {
      sqlite3_close( __db );
      __open = false;
    } // else throw new Exception(); ????
  }
  
  sqlite3* handle() {
    return __db;
  }  
  
private:
  sqlite3*    __db;
  bool        __open;
}  

extern (C) int sqlite3Callback(void *dataTablePtr, int argc, char** argv, char** colNames ) {
  Table  t = cast( Table ) dataTablePtr;
  if( t.size() == 0 ) {
    for( int a=0; a<argc; ++a ) {
      t.add( new Column( std.string.toString( colNames[a] ).dup ) );
    }  
  }

  Row r = new Row( t.columns() );
  for( int a=0; a<argc;++a) {
    if( argv[a] is null) { 
      r[ a ].isNull( true );
    } else {
      r[ a ].value( std.string.toString( argv[a] ).dup );
    }  
  }
  
  t.add( r );
  return 0;
}  

class SQLite3Command {
  
  this( SQLite3Database pDb/*, char[] pCommandString*/ ) {
    mDb = pDb;
//    __commandString = pCommandString ~ "\0";
  }
  
/*  void execute() {
    char  *errMsg = null;
    
    __results = new Table();
    
    int rc = sqlite3_exec(  __db.handle(), 
                            __commandString,
                            &sqlite3Callback,
                            cast(void*) __results,
                            &errMsg );
    if( rc != SQLITE_OK ) {
      throw new Exception("execute error");
//      printf( "Error:%s\n", errMsg );
    }
    
  }*/
  
  void execute( char[] pCommand ) {

    pCommand ~= "\0";
    
    printf("executing:%.*s\n" , pCommand );
    
    char  *errMsg = null;
    mResults = new Table();
    int rc = sqlite3_exec(  mDb.handle(), 
                            pCommand,
                            &sqlite3Callback,
                            cast(void*) mResults,
                            &errMsg );
                            
    if( rc != SQLITE_OK ) {
      throw new Exception( "execute error:" ~ std.string.toString( errMsg ) );
    }
    
  }

  Table results() {
    return mResults;
  }  
  
private:
  SQLite3Database   mDb;
//  char[]            __commandString;
  Table             mResults;
}  

