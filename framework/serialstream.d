/*
  This file is in public domain
  
  SerialStream class is an implementaion of Stream class serial communication
*/

module dfa.serialstream;

import std.stream;
import framework.c.windows;

enum {
  NOPARITY =	0,
  ODDPARITY	= 1,
  EVENPARITY	= 2,
  MARKPARITY	= 3,
  SPACEPARITY	= 4,
}

enum {
  ONESTOPBIT	= 0,
  ONE5STOPBITS	= 1,
  TWOSTOPBITS	= 2,
}

enum {
  CBR_110	= 110,
  CBR_300	= 300,
  CBR_600	= 600,
  CBR_1200	= 1200,
  CBR_2400	= 2400,
  CBR_4800	= 4800,
  CBR_9600	= 9600,
  CBR_14400	= 14400,
  CBR_19200	= 19200,
  CBR_38400	= 38400,
  CBR_56000	= 56000,
  CBR_57600	= 57600,
  CBR_115200	= 115200,
  CBR_128000	= 128000,
  CBR_256000	= 256000
}

enum {
  CLRDTR = 6,
  CLRRTS = 4,
  SETDTR = 5,
  SETRTS = 3,
  SETXOFF = 1,
  SETXON = 2,
  SETBREAK = 8,
  CLRBREAK = 9
}

enum {
  DTR_CONTROL_DISABLE = 0,
  DTR_CONTROL_ENABLE = 1,
  DTR_CONTROL_HANDSHAKE = 2,
  RTS_CONTROL_DISABLE = 0,
  RTS_CONTROL_ENABLE = 1,
  RTS_CONTROL_HANDSHAKE = 2,
  RTS_CONTROL_TOGGLE = 3
}

struct DCB {
	DWORD DCBlength;
	DWORD BaudRate;
/*	DWORD fBinary:1;
	DWORD fParity:1;
	DWORD fOutxCtsFlow:1;
	DWORD fOutxDsrFlow:1;
	DWORD fDtrControl:2;
	DWORD fDsrSensitivity:1;
	DWORD fTXContinueOnXoff:1;
	DWORD fOutX:1;
	DWORD fInX:1;
	DWORD fErrorChar:1;
	DWORD fNull:1;
	DWORD fRtsControl:2;
	DWORD fAbortOnError:1;
	DWORD fDummy2:17;*/
//	union {
    align(4) bit[32]   flags;
/*    struct {    //This doesn't work 
      bit fBinary;
    	bit fParity;
    	bit fOutxCtsFlow;
     	bit fOutxDsrFlow;
     	bit[2] fDtrControl;
    	bit fDsrSensitivity;
    	bit fTXContinueOnXoff;
    	bit fOutX;
    	bit fInX;
    	bit fErrorChar;
    	bit fNull;
    	bit fRtsControl;
    	bit fAbortOnError;
    	bit[17] fDummy2;
 	  }*/
//	}
	WORD wReserved;
	WORD XonLim;
	WORD XoffLim;
	BYTE ByteSize;
	BYTE Parity;
	BYTE StopBits;
	char XonChar;
	char XoffChar;
	char ErrorChar;
	char EofChar;
	char EvtChar;
	WORD wReserved1;
} 

alias DCB*  LPDCB;

struct COMMCONFIG {
	DWORD    dwSize;
	WORD     wVersion;
	WORD     wReserved;
	DCB      dcb;
	DWORD    dwProviderSubType;
	DWORD    dwProviderOffset;
	DWORD    dwProviderSize;
	WCHAR    wcProviderData[1];
} 

alias COMMCONFIG* LPCOMMCONFIG;

struct COMMPROP {
	WORD	   wPacketLength;
	WORD	   wPacketVersion;
	DWORD	   dwServiceMask;
	DWORD	   dwReserved1;
	DWORD	   dwMaxTxQueue;
	DWORD	   dwMaxRxQueue;
	DWORD	   dwMaxBaud;
	DWORD	   dwProvSubType;
	DWORD	   dwProvCapabilities;
	DWORD	   dwSettableParams;
	DWORD	   dwSettableBaud;
	WORD	   wSettableData;
	WORD	   wSettableStopParity;
	DWORD	   dwCurrentTxQueue;
	DWORD	   dwCurrentRxQueue;
	DWORD	   dwProvSpec1;
	DWORD	   dwProvSpec2;
	WCHAR	   wcProvChar[1];
}

alias COMMPROP* LPCOMMPROP;

struct COMMTIMEOUTS {
	DWORD ReadIntervalTimeout;
	DWORD ReadTotalTimeoutMultiplier;
	DWORD ReadTotalTimeoutConstant;
	DWORD WriteTotalTimeoutMultiplier;
	DWORD WriteTotalTimeoutConstant;
} 

alias COMMTIMEOUTS* LPCOMMTIMEOUTS;

struct COMSTAT {
/*	DWORD fCtsHold:1;
	DWORD fDsrHold:1;
	DWORD fRlsdHold:1;
	DWORD fXoffHold:1;
	DWORD fXoffSent:1;
	DWORD fEof:1;
	DWORD fTxim:1;
	DWORD fReserved:25;*/
	DWORD  flags;
/*	bit fCtsHold;
	bit fDsrHold;
	bit fRlsdHold;
	bit fXoffHold;
	bit fXoffSent;
	bit fEof;
	bit fTxim;
	bit[25] fReserved;*/
	DWORD cbInQue;
	DWORD cbOutQue;
} 

alias COMSTAT* LPCOMSTAT;

extern(Windows) {

  export BOOL SetCommBreak(HANDLE);
  export BOOL SetCommConfig(HANDLE,LPCOMMCONFIG,DWORD);
  export BOOL SetCommMask(HANDLE,DWORD);
  export BOOL SetCommState(HANDLE,LPDCB);
  export BOOL SetCommTimeouts(HANDLE,LPCOMMTIMEOUTS);

}

class OpenException : Exception {
  this() {
    super( "Cannot open COM port" );
  }
}

class DeviceException : Exception {
  this( uint errorCode ) {
    super("Device exception");
    __errorCode = errorCode;
  }
private:  
  uint __errorCode;
}

class SerialStream : Stream {

  enum Port {
    Com1,
    Com2,
    Com3,
    Com4 
  }; 
  
  enum DataBits {
    D4 = 4,
    D5 = 5,
    D6 = 6,
    D7 = 7,
    D8 = 8
  };  

  enum StopBits {
    One = 0,
    OneAndHalf = 1,
    Two = 2
  };  
  
  enum Parity {
    None = 0,
    Odd  = 1,
    Even = 2,
    Mark = 3,
    Space= 4
  };  
  
  enum FlowControl {
    None,
    Software,
    Hardware
  };

  enum BaudRate {
    b110    = CBR_110,
    b300    = CBR_300,
    b600    = CBR_600,
    b1200   = CBR_1200,
    b2400   = CBR_2400,
    b4800   = CBR_4800,
    b9600   = CBR_9600,
    b19200  = CBR_19200,
    b38400  = CBR_38400,
    b57600  = CBR_57600,
    b115200 = CBR_115200
  };

  this( Port port, BaudRate br, DataBits db, StopBits sb, Parity prt, FlowControl fc) {
    super();
    
  	DCB						__DCB;
     	
		__HANDLE = CreateFileA( comportString( port ),
                           GENERIC_READ | GENERIC_WRITE,
             		  		     0, // No Share
                  		     null, // Ignore Security Attrb
                    	     OPEN_EXISTING,
                   	       0,
                   		     null);

    if ( __HANDLE == null )
      throw new OpenException();

    memset(&__DCB, 0, DCB.sizeof );

    setMask( 0 );
    setTimeOuts( 0, 0, 0, 0, 0 );
    // Change the DCB structure settings.

    __DCB.DCBlength     = DCB.sizeof;
    __DCB.BaudRate      = br;         // Current baud 
  	__DCB.ByteSize      = db;         // Number of bits/bytes, 4-8 
  	__DCB.Parity        = prt;        // 0-4=no,odd,even,mark,space 
  	__DCB.StopBits      = sb;         // 0,1,2 = 1, 1.5, 2 

/*    __DCB.fBinary       = true;
  	__DCB.fNull         = false;
  	__DCB.fAbortOnError = false;*/
  	
  	__DCB.flags[0] = true;

    setState( &__DCB );
  }

  ~this() {
    CloseHandle( __HANDLE );
  }
  
  override uint readBlock( void* buffer, uint size ) {
    // read smthing
    DWORD   __totalCharsRead = 0;

    ReadFile( __HANDLE, buffer, 
                size , 
                &__totalCharsRead, 
                null );
    return  __totalCharsRead;

  }
  
  override uint writeBlock( void* buffer, uint size ) {
    // write smthing
    DWORD   __totalCharsWritten = 0;

    WriteFile( __HANDLE, buffer, 
               size , 
               &__totalCharsWritten, 
                null );
    return  __totalCharsWritten;
  }
  
  override ulong seek( long offset, SeekPos whence) {
    // ineffective
    return 0;
  } 

  override void close() {
    super.close();
  }
  
  void setTimeOuts( int readIntervalTO,
                    int readTotalTOMult, 
                    int readTotalTOConst, 
                    int writeTotalTOMult, 
                    int writeTotalTOConst ) {

    COMMTIMEOUTS	__COMMTIMEOUTS;
      
  	__COMMTIMEOUTS.ReadIntervalTimeout = readIntervalTO;  
  	__COMMTIMEOUTS.ReadTotalTimeoutMultiplier = readTotalTOMult;  
  	__COMMTIMEOUTS.ReadTotalTimeoutConstant = readTotalTOConst;    
  	__COMMTIMEOUTS.WriteTotalTimeoutMultiplier = writeTotalTOMult;  
  	__COMMTIMEOUTS.WriteTotalTimeoutConstant = writeTotalTOConst;    

 	  if (SetCommTimeouts( __HANDLE, &__COMMTIMEOUTS)==FALSE) {
      throw new DeviceException( GetLastError() ); //    	  __error = ::GetLastError ();
	  }
  	  
  }
    
  void setState( DCB*  DCB ) {
    if (SetCommState ( __HANDLE, DCB )==FALSE) {
//      printf("Set Comm State\n");
      throw new DeviceException( GetLastError () );//__error = ::GetLastError ();
  	}
  }  

  void setMask( DWORD p_mask ) {
    if (SetCommMask ( __HANDLE, p_mask )==FALSE ) {
  	  throw new DeviceException( GetLastError () );        //    	  __error = ::GetLastError ();
    }
  }
  
private:

  char[] comportString( Port port ) {

    switch( port ) {
    case Port.Com1: return "COM1:";
    case Port.Com2: return "COM2:";
    case Port.Com3: return "COM3:";
    case Port.Com4: return "COM4:";
    default: return "";
    }  

  }

private:
  HANDLE    __HANDLE;
}


