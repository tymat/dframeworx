import std.c.stdio;
import framework.serialstream;

/*
  SerialStream class is an Serial Communication implementation for std.stream.Stream class
  
  This example demonstrates how to use it.
  
  To build this file execute build-serialstream.bat
  
  Before executing dbsample be sure that the necessarey dll's are in the same directory. 
  Also you have to connect serial communication cable to Com1 and Com2. Otherwise the 
  application waits for a character forever.
  
  This file is in public domain

*/

int main( char[][] attrbs ) {

  SerialStream  s1 = new SerialStream( SerialStream.Port.Com1, 
                                        SerialStream.BaudRate.b4800,
                                        SerialStream.DataBits.D8,
                                        SerialStream.StopBits.One,
                                        SerialStream.Parity.None, 
                                        SerialStream.FlowControl.None );

  SerialStream  s2 = new SerialStream( SerialStream.Port.Com2, 
                                        SerialStream.BaudRate.b4800,
                                        SerialStream.DataBits.D8,
                                        SerialStream.StopBits.One, 
                                        SerialStream.Parity.None,                                        
                                        SerialStream.FlowControl.None );

  int   i=0;
  s1.write( cast(int) 5 );
  s2.read( i );
  printf("%d\n",i);
  
  return 0;
}
