/*
  This file is in public domain
*/

module framework.xml;

import framework.c.xml_imp;
import std.stream;
import std.string;

private {
  uint xmlStringLength( XML_Char* str ) {
    int i=0;
    for( ; str[i]; i++ ) {};
    return i;
  }
}

extern (C) void startElementFunc( void *userData, XML_Char *name, XML_Char **attrbs ) {
  int   __length = xmlStringLength( name );
  char[]   __name = name[ 0 .. __length ];
  char[][ char[] ] __attrbs;
  if( attrbs ) {
    for( int i=0; attrbs[i] && attrbs[i+1]; i+=2 ) {
      int __keyLength = xmlStringLength( attrbs[i] );
      int __valueLength = xmlStringLength( attrbs[i+1] );
      __attrbs[ attrbs[i][ 0 .. __keyLength ] ] = attrbs[i+1][ 0 .. __valueLength ];
    }
  }
  if( ( cast( XmlReader ) userData ).__startElement ) 
    ( cast( XmlReader ) userData ).__startElement( __name, __attrbs );
}

extern (C) void characterDataFunc( void *userData, XML_Char *s, int len  ){
  if( ( cast( XmlReader ) userData ).__characterData ) 
    ( cast( XmlReader ) userData ).__characterData( s[ 0 .. len ] );
}

extern (C) void endElementFunc( void *userData, XML_Char  *name ){
  int __length = xmlStringLength( name );
  if( ( cast( XmlReader ) userData ).__endElement ) 
    ( cast( XmlReader ) userData ).__endElement( name[ 0 .. __length ] );
}

class XmlReader {

  alias void delegate( char[] name, char[][ char[] ] attrbs ) StartElementDelegate;
  alias void delegate( char[] data ) CharacterDataDelegate;
  alias void delegate( char[] name ) EndElementDelegate;

  this() {
    loadExpat();
    __parser = cast(XML_Parser) XML_ParserCreate( null );
    XML_SetUserData( __parser, cast(void*) this );
    XML_SetElementHandler( __parser, &startElementFunc, &endElementFunc);
    XML_SetCharacterDataHandler( __parser, &characterDataFunc );
  }
  
  ~this() {
    XML_ParserFree( __parser );

  }

  void read( Stream s ) {
 
    if( !s.readable )
      throw new Exception( "File is not readable" );
 
    while( !s.eof() ) {
      char[] __line = s.readLine();
      
      if( !XML_Parse( __parser, cast(char*) __line, __line.length, s.eof() ) ) {
        printf( "Parse Error:%s at line %d\n", XML_ErrorString(XML_GetErrorCode(__parser)),
                                               XML_GetCurrentLineNumber(__parser) );
//        throw new XMLParseError( ErrorString, line );
      }
    }
  }

  void startElement( StartElementDelegate sed ) {
    __startElement = sed;
  }

  void endElement( EndElementDelegate eed ) { 
    __endElement = eed;
  }  

  void characterData( CharacterDataDelegate cdd ) {
    __characterData = cdd;
  }

private:

  StartElementDelegate    __startElement;
  EndElementDelegate      __endElement;
  CharacterDataDelegate   __characterData;

  XML_Parser          __parser;
}
