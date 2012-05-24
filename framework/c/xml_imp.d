/*
  This file is public domain.
  
  This import provides yet a limited functionality for expat XML library.
*/

private {
  import std.c.stdlib;
  import std.stream;

  import framework.c.windows;
  static HANDLE       __xmlParseDll;
}

void loadExpat() {
  
  if( __xmlParseDll !is null ) 
    return;
  
  __xmlParseDll = LoadLibraryW("xmlparse.dll");
  
  if( __xmlParseDll is null )
    throw new Exception( "Couldn't load expat" );
    

  *cast(void**) &XML_ParserCreate = GetProcAddress( __xmlParseDll, "XML_ParserCreate" );
  *cast(void**) &XML_ParserFree = GetProcAddress( __xmlParseDll, "XML_ParserFree" );
  *cast(void**) &XML_Parse = GetProcAddress( __xmlParseDll, "XML_Parse" );
  *cast(void**) &XML_SetUserData = GetProcAddress( __xmlParseDll, "XML_SetUserData" );
  *cast(void**) &XML_SetElementHandler = GetProcAddress( __xmlParseDll, "XML_SetElementHandler" );
  *cast(void**) &XML_SetCharacterDataHandler = GetProcAddress( __xmlParseDll, "XML_SetCharacterDataHandler" );
  *cast(void**) &XML_GetErrorCode = GetProcAddress( __xmlParseDll, "XML_GetErrorCode" );
  *cast(void**) &XML_GetCurrentLineNumber = GetProcAddress( __xmlParseDll, "XML_GetCurrentLineNumber" );
  *cast(void**) &XML_ErrorString = GetProcAddress( __xmlParseDll, "XML_ErrorString" );

}

void freeExpat() {
  // Free Library is missing should be implemented here
}

static ~this() {
  freeExpat();
}


// Types

alias void* XML_Parser;
alias char XML_Char;
alias wchar XML_LChar;

// enums

enum XML_Error {
  XML_ERROR_NONE,
  XML_ERROR_NO_MEMORY,
  XML_ERROR_SYNTAX,
  XML_ERROR_NO_ELEMENTS,
  XML_ERROR_INVALID_TOKEN,
  XML_ERROR_UNCLOSED_TOKEN,
  XML_ERROR_PARTIAL_CHAR,
  XML_ERROR_TAG_MISMATCH,
  XML_ERROR_DUPLICATE_ATTRIBUTE,
  XML_ERROR_JUNK_AFTER_DOC_ELEMENT,
  XML_ERROR_PARAM_ENTITY_REF,
  XML_ERROR_UNDEFINED_ENTITY,
  XML_ERROR_RECURSIVE_ENTITY_REF,
  XML_ERROR_ASYNC_ENTITY,
  XML_ERROR_BAD_CHAR_REF,
  XML_ERROR_BINARY_ENTITY_REF,
  XML_ERROR_ATTRIBUTE_EXTERNAL_ENTITY_REF,
  XML_ERROR_MISPLACED_XML_PI,
  XML_ERROR_UNKNOWN_ENCODING,
  XML_ERROR_INCORRECT_ENCODING,
  XML_ERROR_UNCLOSED_CDATA_SECTION,
  XML_ERROR_EXTERNAL_ENTITY_HANDLING,
  XML_ERROR_NOT_STANDALONE
};

extern (C):

alias void function(void *userData, XML_Char *name, XML_Char **atts) StartElementFuncType;
alias void function(void *userData, XML_Char *s, int len) CharacterDataFuncType;
alias void function(void *userData, XML_Char *name) EndElementFuncType;

BOOL (*XML_ParserCreate)( XML_Char* );
void (*XML_ParserFree)( XML_Parser );
int  (*XML_Parse)( XML_Parser, char*, int len, int isFinal );
BOOL (*XML_SetElementHandler)( XML_Parser, StartElementFuncType, EndElementFuncType );
BOOL (*XML_SetCharacterDataHandler)( XML_Parser, CharacterDataFuncType );
BOOL (*XML_SetUserData)( XML_Parser parser, void *userData);
XML_Error (*XML_GetErrorCode)(XML_Parser);
int  (*XML_GetCurrentLineNumber)(XML_Parser);
XML_LChar* (*XML_ErrorString)(int code);

/* Rest of this must be in another file */


