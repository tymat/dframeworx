import framework.xml; 
import std.stream;
import std.utf;
 
// To use the XmlReader you should derive  
// a class first. Although this is not 
// necessary, it is a nice way 
 
class CustomReader : XmlReader { 
 
  this() { 
    super(); 
  // set delegates 
    startElement( &onStartElement ); 
    characterData( &onCharacterData ); 
    endElement( &onEndElement );  
  } 
 
  // the delegates 
  void onStartElement( char[] name, char[][ char[]] attrbs ) { 
    printf( "length:%d\n", name.length ); 
    printf( "Start Element:%.*s\n", name ); 
    // attributes are provided as associated array 
  } 
 
  void onCharacterData( char[] data ) { 
    printf( "Character Data:%.*s\n", data); 
  } 
 
  void onEndElement( char[] name) { 
    printf( "End Element:%.*s\n", name ); 
  } 
} 
 
 
int main( char[][] args ) { 
  // Open the file 
  File f = new File("test.xml", FileMode.In ); 
  // Create your reader instance 
  CustomReader cr = new CustomReader; 
  // then read 
  cr.read( f ); 
  return 0; 
} 