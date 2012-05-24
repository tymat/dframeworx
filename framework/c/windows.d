
/*
 *  Copyright (C) 2004-2005 by Digital Mars, www.digitalmars.com
 *  Written by Walter Bright
 *
 *  This software is provided 'as-is', without any express or implied
 *  warranty. In no event will the authors be held liable for any damages
 *  arising from the use of this software.
 *
 *  Permission is granted to anyone to use this software for any purpose,
 *  including commercial applications, and to alter it and redistribute it
 *  freely, in both source and binary form, subject to the following
 *  restrictions:
 *
 *  o  The origin of this software must not be misrepresented; you must not
 *     claim that you wrote the original software. If you use this software
 *     in a product, an acknowledgment in the product documentation would be
 *     appreciated but is not required.
 *  o  Altered source versions must be plainly marked as such, and must not
 *     be misrepresented as being the original software.
 *  o  This notice may not be removed or altered from any source
 *     distribution.
 */

/*
  Modified by Selcuk IYIKALENDER 

  Addition are from Win32 API header files distributed with mingw32
  
  www.mingw32.org
*/

 
module framework.c.windows;

version (Windows)
{
}
else
{
    static assert(0);		// Windows only
}

extern (Windows)
{
    alias uint ULONG;
    alias ULONG *PULONG;
    alias ushort USHORT;
    alias USHORT *PUSHORT;
    alias ubyte UCHAR;
    alias UCHAR *PUCHAR;
    alias char *PSZ;
    alias wchar WCHAR;

    alias void VOID;
    alias char CHAR;
    alias short SHORT;
    alias int LONG;
    alias CHAR *LPSTR;
    alias CHAR *PSTR;
    alias CHAR *LPCSTR;
    alias CHAR *PCSTR;
    alias LPSTR LPTCH, PTCH;
    alias LPSTR PTSTR, LPTSTR;
    alias LPCSTR LPCTSTR;

    alias WCHAR* LPWSTR, LPCWSTR, PCWSTR;

    alias uint DWORD;
    alias int BOOL;
    alias ubyte BYTE;
    alias ushort WORD;
    alias float FLOAT;
    alias FLOAT *PFLOAT;
    alias BOOL *PBOOL;
    alias BOOL *LPBOOL;
    alias BYTE *PBYTE;
    alias BYTE *LPBYTE;
    alias int *PINT;
    alias int *LPINT;
    alias WORD *PWORD;
    alias WORD *LPWORD;
    alias int *LPLONG;
    alias DWORD *PDWORD;
    alias DWORD *LPDWORD;
    alias void *LPVOID;
    alias void *LPCVOID;

    alias int INT;
    alias uint UINT;
    alias uint *PUINT;

    typedef void *HANDLE;
    alias void *PVOID;
    alias HANDLE HGLOBAL;
    alias HANDLE HLOCAL;
    alias LONG HRESULT;
    alias LONG SCODE;
    alias HANDLE HINSTANCE;
    alias HINSTANCE HMODULE;
    alias HANDLE HWND;

    alias HANDLE HGDIOBJ;
    alias HANDLE HACCEL;
    alias HANDLE HBITMAP;
    alias HANDLE HBRUSH;
    alias HANDLE HCOLORSPACE;
    alias HANDLE HDC;
    alias HANDLE HGLRC;
    alias HANDLE HDESK;
    alias HANDLE HENHMETAFILE;
    alias HANDLE HFONT;
    alias HANDLE HICON;
    alias HANDLE HMENU;
    alias HANDLE HMETAFILE;
    alias HANDLE HPALETTE;
    alias HANDLE HPEN;
    alias HANDLE HRGN;
    alias HANDLE HRSRC;
    alias HANDLE HSTR;
    alias HANDLE HTASK;
    alias HANDLE HWINSTA;
    alias HANDLE HKL;
    alias HICON HCURSOR;

    alias HANDLE HKEY;
    alias HKEY *PHKEY;
    alias DWORD ACCESS_MASK;
    alias ACCESS_MASK *PACCESS_MASK;
    alias ACCESS_MASK REGSAM;

    alias int (*FARPROC)();

    alias UINT WPARAM;
    alias LONG LPARAM;
    alias LONG LRESULT;

    alias DWORD   COLORREF;
    alias DWORD   *LPCOLORREF;
    alias WORD    ATOM;

version (0)
{   // Properly prototyped versions
    alias BOOL function(HWND, UINT, WPARAM, LPARAM) DLGPROC;
    alias VOID function(HWND, UINT, UINT, DWORD) TIMERPROC;
    alias BOOL function(HDC, LPARAM, int) GRAYSTRINGPROC;
    alias BOOL function(HWND, LPARAM) WNDENUMPROC;
    alias LRESULT function(int code, WPARAM wParam, LPARAM lParam) HOOKPROC;
    alias VOID function(HWND, UINT, DWORD, LRESULT) SENDASYNCPROC;
    alias BOOL function(HWND, LPCSTR, HANDLE) PROPENUMPROCA;
    alias BOOL function(HWND, LPCWSTR, HANDLE) PROPENUMPROCW;
    alias BOOL function(HWND, LPSTR, HANDLE, DWORD) PROPENUMPROCEXA;
    alias BOOL function(HWND, LPWSTR, HANDLE, DWORD) PROPENUMPROCEXW;
    alias int function(LPSTR lpch, int ichCurrent, int cch, int code)
       EDITWORDBREAKPROCA;
    alias int function(LPWSTR lpch, int ichCurrent, int cch, int code)
       EDITWORDBREAKPROCW;
    alias BOOL function(HDC hdc, LPARAM lData, WPARAM wData, int cx, int cy)
       DRAWSTATEPROC;
}
else
{
    alias FARPROC DLGPROC;
    alias FARPROC TIMERPROC;
    alias FARPROC GRAYSTRINGPROC;
    alias FARPROC WNDENUMPROC;
    alias FARPROC HOOKPROC;
    alias FARPROC SENDASYNCPROC;
    alias FARPROC EDITWORDBREAKPROCA;
    alias FARPROC EDITWORDBREAKPROCW;
    alias FARPROC PROPENUMPROCA;
    alias FARPROC PROPENUMPROCW;
    alias FARPROC PROPENUMPROCEXA;
    alias FARPROC PROPENUMPROCEXW;
    alias FARPROC DRAWSTATEPROC;
}

WORD HIWORD(int l) { return cast(WORD)((l >> 16) & 0xFFFF); }
WORD LOWORD(int l) { return cast(WORD)l; }
int FAILED(int status) { return status < 0; }
int SUCCEEDED(int Status) { return Status >= 0; }

enum : int
{
    FALSE = 0,
    TRUE = 1,
}

enum : uint
{
    MAX_PATH = 260,
    HINSTANCE_ERROR = 32,
}

enum
{
	ERROR_SUCCESS =                    0,
	ERROR_INVALID_FUNCTION =           1,
	ERROR_FILE_NOT_FOUND =             2,
	ERROR_PATH_NOT_FOUND =             3,
	ERROR_TOO_MANY_OPEN_FILES =        4,
	ERROR_ACCESS_DENIED =              5,
	ERROR_INVALID_HANDLE =             6,
	ERROR_NO_MORE_FILES =              18,
	ERROR_MORE_DATA =		   234,
	ERROR_NO_MORE_ITEMS =		   259,
}

enum
{
	DLL_PROCESS_ATTACH = 1,
	DLL_THREAD_ATTACH =  2,
	DLL_THREAD_DETACH =  3,
	DLL_PROCESS_DETACH = 0,
}

enum
{
    FILE_BEGIN           = 0,
    FILE_CURRENT         = 1,
    FILE_END             = 2,
}

enum : uint
{
    DELETE =                           0x00010000,
    READ_CONTROL =                     0x00020000,
    WRITE_DAC =                        0x00040000,
    WRITE_OWNER =                      0x00080000,
    SYNCHRONIZE =                      0x00100000,

    STANDARD_RIGHTS_REQUIRED =         0x000F0000,
    STANDARD_RIGHTS_READ =             READ_CONTROL,
    STANDARD_RIGHTS_WRITE =            READ_CONTROL,
    STANDARD_RIGHTS_EXECUTE =          READ_CONTROL,
    STANDARD_RIGHTS_ALL =              0x001F0000,
    SPECIFIC_RIGHTS_ALL =              0x0000FFFF,
    ACCESS_SYSTEM_SECURITY =           0x01000000,
    MAXIMUM_ALLOWED =                  0x02000000,

    GENERIC_READ                     = 0x80000000,
    GENERIC_WRITE                    = 0x40000000,
    GENERIC_EXECUTE                  = 0x20000000,
    GENERIC_ALL                      = 0x10000000,
}

enum
{
    FILE_SHARE_READ                 = 0x00000001,
    FILE_SHARE_WRITE                = 0x00000002,
    FILE_SHARE_DELETE               = 0x00000004,  
    FILE_ATTRIBUTE_READONLY         = 0x00000001,  
    FILE_ATTRIBUTE_HIDDEN           = 0x00000002,  
    FILE_ATTRIBUTE_SYSTEM           = 0x00000004,  
    FILE_ATTRIBUTE_DIRECTORY        = 0x00000010,  
    FILE_ATTRIBUTE_ARCHIVE          = 0x00000020,  
    FILE_ATTRIBUTE_NORMAL           = 0x00000080,  
    FILE_ATTRIBUTE_TEMPORARY        = 0x00000100,  
    FILE_ATTRIBUTE_COMPRESSED       = 0x00000800,  
    FILE_ATTRIBUTE_OFFLINE          = 0x00001000,  
    FILE_NOTIFY_CHANGE_FILE_NAME    = 0x00000001,   
    FILE_NOTIFY_CHANGE_DIR_NAME     = 0x00000002,   
    FILE_NOTIFY_CHANGE_ATTRIBUTES   = 0x00000004,   
    FILE_NOTIFY_CHANGE_SIZE         = 0x00000008,   
    FILE_NOTIFY_CHANGE_LAST_WRITE   = 0x00000010,   
    FILE_NOTIFY_CHANGE_LAST_ACCESS  = 0x00000020,   
    FILE_NOTIFY_CHANGE_CREATION     = 0x00000040,   
    FILE_NOTIFY_CHANGE_SECURITY     = 0x00000100,   
    FILE_ACTION_ADDED               = 0x00000001,   
    FILE_ACTION_REMOVED             = 0x00000002,   
    FILE_ACTION_MODIFIED            = 0x00000003,   
    FILE_ACTION_RENAMED_OLD_NAME    = 0x00000004,   
    FILE_ACTION_RENAMED_NEW_NAME    = 0x00000005,   
    FILE_CASE_SENSITIVE_SEARCH      = 0x00000001,  
    FILE_CASE_PRESERVED_NAMES       = 0x00000002,  
    FILE_UNICODE_ON_DISK            = 0x00000004,  
    FILE_PERSISTENT_ACLS            = 0x00000008,  
    FILE_FILE_COMPRESSION           = 0x00000010,  
    FILE_VOLUME_IS_COMPRESSED       = 0x00008000,  
}

const DWORD MAILSLOT_NO_MESSAGE = cast(DWORD)-1;
const DWORD MAILSLOT_WAIT_FOREVER = cast(DWORD)-1; 

enum : uint
{
    FILE_FLAG_WRITE_THROUGH         = 0x80000000,
    FILE_FLAG_OVERLAPPED            = 0x40000000,
    FILE_FLAG_NO_BUFFERING          = 0x20000000,
    FILE_FLAG_RANDOM_ACCESS         = 0x10000000,
    FILE_FLAG_SEQUENTIAL_SCAN       = 0x08000000,
    FILE_FLAG_DELETE_ON_CLOSE       = 0x04000000,
    FILE_FLAG_BACKUP_SEMANTICS      = 0x02000000,
    FILE_FLAG_POSIX_SEMANTICS       = 0x01000000,
}

enum
{
    CREATE_NEW          = 1,
    CREATE_ALWAYS       = 2,
    OPEN_EXISTING       = 3,
    OPEN_ALWAYS         = 4,
    TRUNCATE_EXISTING   = 5,
}

const HANDLE INVALID_HANDLE_VALUE = cast(HANDLE)-1;
const DWORD INVALID_SET_FILE_POINTER = cast(DWORD)-1;
const DWORD INVALID_FILE_SIZE = cast(DWORD)0xFFFFFFFF;

struct OVERLAPPED {
    DWORD   Internal;
    DWORD   InternalHigh;
    DWORD   Offset;
    DWORD   OffsetHigh;
    HANDLE  hEvent;
}

struct SECURITY_ATTRIBUTES {
    DWORD nLength;
    void *lpSecurityDescriptor;
    BOOL bInheritHandle;
}

alias SECURITY_ATTRIBUTES* PSECURITY_ATTRIBUTES, LPSECURITY_ATTRIBUTES;

struct FILETIME {
    DWORD dwLowDateTime;
    DWORD dwHighDateTime;
}
alias FILETIME* PFILETIME, LPFILETIME;

struct WIN32_FIND_DATA {
    DWORD dwFileAttributes;
    FILETIME ftCreationTime;
    FILETIME ftLastAccessTime;
    FILETIME ftLastWriteTime;
    DWORD nFileSizeHigh;
    DWORD nFileSizeLow;
    DWORD dwReserved0;
    DWORD dwReserved1;
    char   cFileName[MAX_PATH];
    char   cAlternateFileName[ 14 ];
}

struct WIN32_FIND_DATAW {
    DWORD dwFileAttributes;
    FILETIME ftCreationTime;
    FILETIME ftLastAccessTime;
    FILETIME ftLastWriteTime;
    DWORD nFileSizeHigh;
    DWORD nFileSizeLow;
    DWORD dwReserved0;
    DWORD dwReserved1;
    wchar  cFileName[ 260  ];
    wchar  cAlternateFileName[ 14 ];
}

export
{
BOOL SetCurrentDirectoryA(LPCSTR lpPathName);
BOOL SetCurrentDirectoryW(LPCWSTR lpPathName);
DWORD GetCurrentDirectoryA(DWORD nBufferLength, LPSTR lpBuffer);
DWORD GetCurrentDirectoryW(DWORD nBufferLength, LPWSTR lpBuffer);
BOOL CreateDirectoryA(LPCSTR lpPathName, LPSECURITY_ATTRIBUTES lpSecurityAttributes);
BOOL CreateDirectoryW(LPCWSTR lpPathName, LPSECURITY_ATTRIBUTES lpSecurityAttributes);
BOOL CreateDirectoryExA(LPCSTR lpTemplateDirectory, LPCSTR lpNewDirectory, LPSECURITY_ATTRIBUTES lpSecurityAttributes);
BOOL CreateDirectoryExW(LPCWSTR lpTemplateDirectory, LPCWSTR lpNewDirectory, LPSECURITY_ATTRIBUTES lpSecurityAttributes);
BOOL RemoveDirectoryA(LPCSTR lpPathName);
BOOL RemoveDirectoryW(LPCWSTR lpPathName);

BOOL   CloseHandle(HANDLE hObject);

HANDLE CreateFileA(char *lpFileName, DWORD dwDesiredAccess, DWORD dwShareMode,
	SECURITY_ATTRIBUTES *lpSecurityAttributes, DWORD dwCreationDisposition,
	DWORD dwFlagsAndAttributes, HANDLE hTemplateFile);
HANDLE CreateFileW(LPCWSTR lpFileName, DWORD dwDesiredAccess, DWORD dwShareMode,
	SECURITY_ATTRIBUTES *lpSecurityAttributes, DWORD dwCreationDisposition,
	DWORD dwFlagsAndAttributes, HANDLE hTemplateFile);

BOOL   DeleteFileA(char *lpFileName);
BOOL   DeleteFileW(LPCWSTR lpFileName);

BOOL   FindClose(HANDLE hFindFile);
HANDLE FindFirstFileA(char *lpFileName, WIN32_FIND_DATA* lpFindFileData);
HANDLE FindFirstFileW(LPCWSTR lpFileName, WIN32_FIND_DATAW* lpFindFileData);
BOOL   FindNextFileA(HANDLE hFindFile, WIN32_FIND_DATA* lpFindFileData);
BOOL   FindNextFileW(HANDLE hFindFile, WIN32_FIND_DATAW* lpFindFileData);
BOOL   GetExitCodeThread(HANDLE hThread, DWORD *lpExitCode);
DWORD  GetLastError();
DWORD  GetFileAttributesA(char *lpFileName);
DWORD  GetFileAttributesW(wchar *lpFileName);
DWORD  GetFileSize(HANDLE hFile, DWORD *lpFileSizeHigh);
BOOL   CopyFileA(LPCSTR lpExistingFileName, LPCSTR lpNewFileName, BOOL bFailIfExists);
BOOL   CopyFileW(LPCWSTR lpExistingFileName, LPCWSTR lpNewFileName, BOOL bFailIfExists);
BOOL   MoveFileA(char *from, char *to);
BOOL   MoveFileW(LPCWSTR lpExistingFileName, LPCWSTR lpNewFileName);
BOOL   ReadFile(HANDLE hFile, void *lpBuffer, DWORD nNumberOfBytesToRead,
	DWORD *lpNumberOfBytesRead, OVERLAPPED *lpOverlapped);
DWORD  SetFilePointer(HANDLE hFile, LONG lDistanceToMove,
	LONG *lpDistanceToMoveHigh, DWORD dwMoveMethod);
BOOL   WriteFile(HANDLE hFile, void *lpBuffer, DWORD nNumberOfBytesToWrite,
	DWORD *lpNumberOfBytesWritten, OVERLAPPED *lpOverlapped);
DWORD  GetModuleFileNameA(HMODULE hModule, LPSTR lpFilename, DWORD nSize);
}

struct MEMORYSTATUS {
    DWORD dwLength;
    DWORD dwMemoryLoad;
    DWORD dwTotalPhys;
    DWORD dwAvailPhys;
    DWORD dwTotalPageFile;
    DWORD dwAvailPageFile;
    DWORD dwTotalVirtual;
    DWORD dwAvailVirtual;
};
alias MEMORYSTATUS *LPMEMORYSTATUS;


export
{
 LONG  InterlockedIncrement(LPLONG lpAddend);
 LONG  InterlockedDecrement(LPLONG lpAddend);
 LONG  InterlockedExchange(LPLONG Target, LONG Value);
 LONG  InterlockedExchangeAdd(LPLONG Addend, LONG Value);
 PVOID InterlockedCompareExchange(PVOID *Destination, PVOID Exchange, PVOID Comperand);
 BOOL  FreeResource(HGLOBAL hResData);
 LPVOID LockResource(HGLOBAL hResData);
}

HMODULE LoadLibraryA(LPCSTR lpLibFileName);
HMODULE LoadLibraryW(LPWSTR lpLibFileName);
FARPROC GetProcAddress(HMODULE hModule, LPCSTR lpProcName);
DWORD GetVersion();
BOOL FreeLibrary(HMODULE hLibModule);
void FreeLibraryAndExitThread(HMODULE hLibModule, DWORD dwExitCode);
BOOL DisableThreadLibraryCalls(HMODULE hLibModule);

//
// Registry Specific Access Rights.
//

enum
{
	KEY_QUERY_VALUE =         0x0001,
	KEY_SET_VALUE =           0x0002,
	KEY_CREATE_SUB_KEY =      0x0004,
	KEY_ENUMERATE_SUB_KEYS =  0x0008,
	KEY_NOTIFY =              0x0010,
	KEY_CREATE_LINK =         0x0020,

	KEY_READ =       cast(int)((STANDARD_RIGHTS_READ | KEY_QUERY_VALUE | KEY_ENUMERATE_SUB_KEYS | KEY_NOTIFY)   & ~SYNCHRONIZE),
	KEY_WRITE =      cast(int)((STANDARD_RIGHTS_WRITE | KEY_SET_VALUE | KEY_CREATE_SUB_KEY) & ~SYNCHRONIZE),
	KEY_EXECUTE =    cast(int)(KEY_READ & ~SYNCHRONIZE),
	KEY_ALL_ACCESS = cast(int)((STANDARD_RIGHTS_ALL | KEY_QUERY_VALUE | KEY_SET_VALUE | KEY_CREATE_SUB_KEY | KEY_ENUMERATE_SUB_KEYS | KEY_NOTIFY | KEY_CREATE_LINK) & ~SYNCHRONIZE),
}

//
// Key creation/open disposition
//

const int REG_CREATED_NEW_KEY =         0x00000001;   // New Registry Key created
const int REG_OPENED_EXISTING_KEY =     0x00000002;   // Existing Key opened


//
//
// Predefined Value Types.
//
enum
{
	REG_NONE =                    0,   // No value type
	REG_SZ =                      1,   // Unicode nul terminated string
	REG_EXPAND_SZ =               2,   // Unicode nul terminated string
                                            // (with environment variable references)
	REG_BINARY =                  3,   // Free form binary
	REG_DWORD =                   4,   // 32-bit number
	REG_DWORD_LITTLE_ENDIAN =     4,   // 32-bit number (same as REG_DWORD)
	REG_DWORD_BIG_ENDIAN =        5,   // 32-bit number
	REG_LINK =                    6,   // Symbolic Link (unicode)
	REG_MULTI_SZ =                7,   // Multiple Unicode strings
	REG_RESOURCE_LIST =           8,   // Resource list in the resource map
	REG_FULL_RESOURCE_DESCRIPTOR = 9,  // Resource list in the hardware description
	REG_RESOURCE_REQUIREMENTS_LIST = 10,
	REG_QWORD =			11,
	REG_QWORD_LITTLE_ENDIAN =	11,
}

/*
 * MessageBox() Flags
 */
enum
{
	MB_OK =                       0x00000000,
	MB_OKCANCEL =                 0x00000001,
	MB_ABORTRETRYIGNORE =         0x00000002,
	MB_YESNOCANCEL =              0x00000003,
	MB_YESNO =                    0x00000004,
	MB_RETRYCANCEL =              0x00000005,


	MB_ICONHAND =                 0x00000010,
	MB_ICONQUESTION =             0x00000020,
	MB_ICONEXCLAMATION =          0x00000030,
	MB_ICONASTERISK =             0x00000040,


	MB_USERICON =                 0x00000080,
	MB_ICONWARNING =              MB_ICONEXCLAMATION,
	MB_ICONERROR =                MB_ICONHAND,


	MB_ICONINFORMATION =          MB_ICONASTERISK,
	MB_ICONSTOP =                 MB_ICONHAND,

	MB_DEFBUTTON1 =               0x00000000,
	MB_DEFBUTTON2 =               0x00000100,
	MB_DEFBUTTON3 =               0x00000200,

	MB_DEFBUTTON4 =               0x00000300,


	MB_APPLMODAL =                0x00000000,
	MB_SYSTEMMODAL =              0x00001000,
	MB_TASKMODAL =                0x00002000,

	MB_HELP =                     0x00004000, // Help Button


	MB_NOFOCUS =                  0x00008000,
	MB_SETFOREGROUND =            0x00010000,
	MB_DEFAULT_DESKTOP_ONLY =     0x00020000,


	MB_TOPMOST =                  0x00040000,
	MB_RIGHT =                    0x00080000,
	MB_RTLREADING =               0x00100000,


	MB_TYPEMASK =                 0x0000000F,
	MB_ICONMASK =                 0x000000F0,
	MB_DEFMASK =                  0x00000F00,
	MB_MODEMASK =                 0x00003000,
	MB_MISCMASK =                 0x0000C000,
}


int MessageBoxA(HWND hWnd, LPCSTR lpText, LPCSTR lpCaption, UINT uType);
int MessageBoxExA(HWND hWnd, LPCSTR lpText, LPCSTR lpCaption, UINT uType, WORD wLanguageId);
int MessageBoxW(HWND hWnd, LPWSTR lpText, LPWSTR lpCaption, UINT uType);
int MessageBoxExW(HWND hWnd, LPWSTR lpText, LPWSTR lpCaption, UINT uType, WORD wLanguageId);

const HKEY HKEY_CLASSES_ROOT =           cast(HKEY)(0x80000000);
const HKEY HKEY_CURRENT_USER =           cast(HKEY)(0x80000001);
const HKEY HKEY_LOCAL_MACHINE =          cast(HKEY)(0x80000002);
const HKEY HKEY_USERS =                  cast(HKEY)(0x80000003);
const HKEY HKEY_PERFORMANCE_DATA =       cast(HKEY)(0x80000004);

const HKEY HKEY_CURRENT_CONFIG =         cast(HKEY)(0x80000005);
const HKEY HKEY_DYN_DATA =               cast(HKEY)(0x80000006);

/*enum
{
	KEY_QUERY_VALUE =         (0x0001),
	KEY_SET_VALUE =           (0x0002),
	KEY_CREATE_SUB_KEY =      (0x0004),
	KEY_ENUMERATE_SUB_KEYS =  (0x0008),
	KEY_NOTIFY =              (0x0010),
	KEY_CREATE_LINK =         (0x0020),

	KEY_READ =                cast(int)((STANDARD_RIGHTS_READ | KEY_QUERY_VALUE | KEY_ENUMERATE_SUB_KEYS | KEY_NOTIFY) & (~SYNCHRONIZE)),
	KEY_WRITE =               cast(int)((STANDARD_RIGHTS_WRITE | KEY_SET_VALUE | KEY_CREATE_SUB_KEY) & (~SYNCHRONIZE)),
	KEY_EXECUTE =             cast(int)(KEY_READ & ~SYNCHRONIZE),
	KEY_ALL_ACCESS =          cast(int)((STANDARD_RIGHTS_ALL | KEY_QUERY_VALUE | KEY_SET_VALUE | KEY_CREATE_SUB_KEY | KEY_ENUMERATE_SUB_KEYS | KEY_NOTIFY | KEY_CREATE_LINK) & (~SYNCHRONIZE)),
}*/

enum
{
	REG_OPTION_RESERVED =         (0x00000000),   // Parameter is reserved

	REG_OPTION_NON_VOLATILE =     (0x00000000),   // Key is preserved
                                                    // when system is rebooted

	REG_OPTION_VOLATILE =         (0x00000001),   // Key is not preserved
                                                    // when system is rebooted

	REG_OPTION_CREATE_LINK =      (0x00000002),   // Created key is a
                                                    // symbolic link

	REG_OPTION_BACKUP_RESTORE =   (0x00000004),   // open for backup or restore
                                                    // special access rules
                                                    // privilege required

	REG_OPTION_OPEN_LINK =        (0x00000008),   // Open symbolic link

	REG_LEGAL_OPTION = (REG_OPTION_RESERVED | REG_OPTION_NON_VOLATILE | REG_OPTION_VOLATILE | REG_OPTION_CREATE_LINK | REG_OPTION_BACKUP_RESTORE | REG_OPTION_OPEN_LINK),
}

/*enum
{
	REG_NONE =                    ( 0 ),   // No value type
	REG_SZ =                      ( 1 ),   // Unicode nul terminated string
	REG_EXPAND_SZ =               ( 2 ),   // Unicode nul terminated string
                                            // (with environment variable references)
	REG_BINARY =                  ( 3 ),   // Free form binary
	REG_DWORD =                   ( 4 ),   // 32-bit number
	REG_DWORD_LITTLE_ENDIAN =     ( 4 ),   // 32-bit number (same as REG_DWORD)
	REG_DWORD_BIG_ENDIAN =        ( 5 ),   // 32-bit number
	REG_LINK =                    ( 6 ),   // Symbolic Link (unicode)
	REG_MULTI_SZ =                ( 7 ),   // Multiple Unicode strings
	REG_RESOURCE_LIST =           ( 8 ),   // Resource list in the resource map
	REG_FULL_RESOURCE_DESCRIPTOR = ( 9 ),  // Resource list in the hardware description
	REG_RESOURCE_REQUIREMENTS_LIST = ( 10 ),
}*/

export LONG RegDeleteKeyA(HKEY hKey, LPCSTR lpSubKey);
export LONG RegDeleteValueA(HKEY hKey, LPCSTR lpValueName);

export LONG  RegEnumKeyExA(HKEY hKey, DWORD dwIndex, LPSTR lpName, LPDWORD lpcbName, LPDWORD lpReserved, LPSTR lpClass, LPDWORD lpcbClass, FILETIME* lpftLastWriteTime);
export LONG RegEnumValueA(HKEY hKey, DWORD dwIndex, LPSTR lpValueName, LPDWORD lpcbValueName, LPDWORD lpReserved,
    LPDWORD lpType, LPBYTE lpData, LPDWORD lpcbData);

export LONG RegCloseKey(HKEY hKey);
export LONG RegFlushKey(HKEY hKey);

export LONG RegOpenKeyA(HKEY hKey, LPCSTR lpSubKey, PHKEY phkResult);
export LONG RegOpenKeyExA(HKEY hKey, LPCSTR lpSubKey, DWORD ulOptions, REGSAM samDesired, PHKEY phkResult);

export LONG RegQueryInfoKeyA(HKEY hKey, LPSTR lpClass, LPDWORD lpcbClass,
    LPDWORD lpReserved, LPDWORD lpcSubKeys, LPDWORD lpcbMaxSubKeyLen, LPDWORD lpcbMaxClassLen,
    LPDWORD lpcValues, LPDWORD lpcbMaxValueNameLen, LPDWORD lpcbMaxValueLen, LPDWORD lpcbSecurityDescriptor,
    PFILETIME lpftLastWriteTime);

export LONG RegQueryValueA(HKEY hKey, LPCSTR lpSubKey, LPSTR lpValue,
    LPLONG lpcbValue);

export LONG RegCreateKeyExA(HKEY hKey, LPCSTR lpSubKey, DWORD Reserved, LPSTR lpClass,
   DWORD dwOptions, REGSAM samDesired, SECURITY_ATTRIBUTES* lpSecurityAttributes,
    PHKEY phkResult, LPDWORD lpdwDisposition);

export LONG RegSetValueExA(HKEY hKey, LPCSTR lpValueName, DWORD Reserved, DWORD dwType, BYTE* lpData, DWORD cbData);

struct MEMORY_BASIC_INFORMATION {
    PVOID BaseAddress;
    PVOID AllocationBase;
    DWORD AllocationProtect;
    DWORD RegionSize;
    DWORD State;
    DWORD Protect;
    DWORD Type;
}
alias MEMORY_BASIC_INFORMATION* PMEMORY_BASIC_INFORMATION;

enum
{
	SECTION_QUERY       = 0x0001,
	SECTION_MAP_WRITE   = 0x0002,
	SECTION_MAP_READ    = 0x0004,
	SECTION_MAP_EXECUTE = 0x0008,
	SECTION_EXTEND_SIZE = 0x0010,

	SECTION_ALL_ACCESS = cast(int)(STANDARD_RIGHTS_REQUIRED|SECTION_QUERY| SECTION_MAP_WRITE | SECTION_MAP_READ | SECTION_MAP_EXECUTE | SECTION_EXTEND_SIZE),
	PAGE_NOACCESS          = 0x01,
	PAGE_READONLY          = 0x02,
	PAGE_READWRITE         = 0x04,
	PAGE_WRITECOPY         = 0x08,
	PAGE_EXECUTE           = 0x10,
	PAGE_EXECUTE_READ      = 0x20,
	PAGE_EXECUTE_READWRITE = 0x40,
	PAGE_EXECUTE_WRITECOPY = 0x80,
	PAGE_GUARD            = 0x100,
	PAGE_NOCACHE          = 0x200,
	MEM_COMMIT           = 0x1000,
	MEM_RESERVE          = 0x2000,
	MEM_DECOMMIT         = 0x4000,
	MEM_RELEASE          = 0x8000,
	MEM_FREE            = 0x10000,
	MEM_PRIVATE         = 0x20000,
	MEM_MAPPED          = 0x40000,
	MEM_RESET           = 0x80000,
	MEM_TOP_DOWN       = 0x100000,
	SEC_FILE           = 0x800000,
	SEC_IMAGE         = 0x1000000,
	SEC_RESERVE       = 0x4000000,
	SEC_COMMIT        = 0x8000000,
	SEC_NOCACHE      = 0x10000000,
	MEM_IMAGE        = SEC_IMAGE,
}

enum
{
	FILE_MAP_COPY =       SECTION_QUERY,
	FILE_MAP_WRITE =      SECTION_MAP_WRITE,
	FILE_MAP_READ =       SECTION_MAP_READ,
	FILE_MAP_ALL_ACCESS = SECTION_ALL_ACCESS,
}


//
// Define access rights to files and directories
//

//
// The FILE_READ_DATA and FILE_WRITE_DATA constants are also defined in
// devioctl.h as FILE_READ_ACCESS and FILE_WRITE_ACCESS. The values for these
// constants *MUST* always be in sync.
// The values are redefined in devioctl.h because they must be available to
// both DOS and NT.
//

enum
{
	FILE_READ_DATA =            ( 0x0001 ),   // file & pipe
	FILE_LIST_DIRECTORY =       ( 0x0001 ),    // directory

	FILE_WRITE_DATA =           ( 0x0002 ),    // file & pipe
	FILE_ADD_FILE =             ( 0x0002 ),    // directory

	FILE_APPEND_DATA =          ( 0x0004 ),    // file
	FILE_ADD_SUBDIRECTORY =     ( 0x0004 ),    // directory
	FILE_CREATE_PIPE_INSTANCE = ( 0x0004 ),    // named pipe

	FILE_READ_EA =              ( 0x0008 ),    // file & directory

	FILE_WRITE_EA =             ( 0x0010 ),    // file & directory

	FILE_EXECUTE =              ( 0x0020 ),    // file
	FILE_TRAVERSE =             ( 0x0020 ),    // directory

	FILE_DELETE_CHILD =         ( 0x0040 ),    // directory

	FILE_READ_ATTRIBUTES =      ( 0x0080 ),    // all

	FILE_WRITE_ATTRIBUTES =     ( 0x0100 ),    // all

	FILE_ALL_ACCESS =	    cast(int)(STANDARD_RIGHTS_REQUIRED | SYNCHRONIZE | 0x1FF),

	FILE_GENERIC_READ =         cast(int)(STANDARD_RIGHTS_READ  | FILE_READ_DATA |  FILE_READ_ATTRIBUTES |                 FILE_READ_EA |  SYNCHRONIZE),

	FILE_GENERIC_WRITE =        cast(int)(STANDARD_RIGHTS_WRITE | FILE_WRITE_DATA |  FILE_WRITE_ATTRIBUTES |                      FILE_WRITE_EA  |  FILE_APPEND_DATA |  SYNCHRONIZE),

	FILE_GENERIC_EXECUTE =      cast(int)(STANDARD_RIGHTS_EXECUTE | FILE_READ_ATTRIBUTES |                 FILE_EXECUTE |  SYNCHRONIZE),
}

export
{
 BOOL GlobalUnlock(HGLOBAL hMem);
 HGLOBAL GlobalFree(HGLOBAL hMem);
 UINT GlobalCompact(DWORD dwMinFree);
 void GlobalFix(HGLOBAL hMem);
 void GlobalUnfix(HGLOBAL hMem);
 LPVOID GlobalWire(HGLOBAL hMem);
 BOOL GlobalUnWire(HGLOBAL hMem);
 void GlobalMemoryStatus(LPMEMORYSTATUS lpBuffer);
 HLOCAL LocalAlloc(UINT uFlags, UINT uBytes);
 HLOCAL LocalReAlloc(HLOCAL hMem, UINT uBytes, UINT uFlags);
 LPVOID LocalLock(HLOCAL hMem);
 HLOCAL LocalHandle(LPCVOID pMem);
 BOOL LocalUnlock(HLOCAL hMem);
 UINT LocalSize(HLOCAL hMem);
 UINT LocalFlags(HLOCAL hMem);
 HLOCAL LocalFree(HLOCAL hMem);
 UINT LocalShrink(HLOCAL hMem, UINT cbNewSize);
 UINT LocalCompact(UINT uMinFree);
 BOOL FlushInstructionCache(HANDLE hProcess, LPCVOID lpBaseAddress, DWORD dwSize);
 LPVOID VirtualAlloc(LPVOID lpAddress, DWORD dwSize, DWORD flAllocationType, DWORD flProtect);
 BOOL VirtualFree(LPVOID lpAddress, DWORD dwSize, DWORD dwFreeType);
 BOOL VirtualProtect(LPVOID lpAddress, DWORD dwSize, DWORD flNewProtect, PDWORD lpflOldProtect);
 DWORD VirtualQuery(LPCVOID lpAddress, PMEMORY_BASIC_INFORMATION lpBuffer, DWORD dwLength);
 LPVOID VirtualAllocEx(HANDLE hProcess, LPVOID lpAddress, DWORD dwSize, DWORD flAllocationType, DWORD flProtect);
 BOOL VirtualFreeEx(HANDLE hProcess, LPVOID lpAddress, DWORD dwSize, DWORD dwFreeType);
 BOOL VirtualProtectEx(HANDLE hProcess, LPVOID lpAddress, DWORD dwSize, DWORD flNewProtect, PDWORD lpflOldProtect);
 DWORD VirtualQueryEx(HANDLE hProcess, LPCVOID lpAddress, PMEMORY_BASIC_INFORMATION lpBuffer, DWORD dwLength);
}

struct SYSTEMTIME
{
    WORD wYear;
    WORD wMonth;
    WORD wDayOfWeek;
    WORD wDay;
    WORD wHour;
    WORD wMinute;
    WORD wSecond;
    WORD wMilliseconds;
}

struct TIME_ZONE_INFORMATION {
    LONG Bias;
    WCHAR StandardName[ 32 ];
    SYSTEMTIME StandardDate;
    LONG StandardBias;
    WCHAR DaylightName[ 32 ];
    SYSTEMTIME DaylightDate;
    LONG DaylightBias;
}

enum
{
	TIME_ZONE_ID_UNKNOWN =  0,
	TIME_ZONE_ID_STANDARD = 1,
	TIME_ZONE_ID_DAYLIGHT = 2,
}

export void GetSystemTime(SYSTEMTIME* lpSystemTime);
export void GetSystemTimeAsFileTime(FILETIME* lpSystemTimeAsFileTime);
export BOOL SetSystemTime(SYSTEMTIME* lpSystemTime);
export void GetLocalTime(SYSTEMTIME* lpSystemTime);
export BOOL SetLocalTime(SYSTEMTIME* lpSystemTime);
export BOOL SystemTimeToTzSpecificLocalTime(TIME_ZONE_INFORMATION* lpTimeZoneInformation, SYSTEMTIME* lpUniversalTime, SYSTEMTIME* lpLocalTime);
export DWORD GetTimeZoneInformation(TIME_ZONE_INFORMATION* lpTimeZoneInformation);
export BOOL SetTimeZoneInformation(TIME_ZONE_INFORMATION* lpTimeZoneInformation);

export BOOL SystemTimeToFileTime(SYSTEMTIME *lpSystemTime, FILETIME* lpFileTime);
export BOOL FileTimeToLocalFileTime(FILETIME *lpFileTime, FILETIME* lpLocalFileTime);
export BOOL LocalFileTimeToFileTime(FILETIME *lpLocalFileTime, FILETIME* lpFileTime);
export BOOL FileTimeToSystemTime(FILETIME *lpFileTime, SYSTEMTIME* lpSystemTime);
export LONG CompareFileTime(FILETIME *lpFileTime1, FILETIME *lpFileTime2);
export BOOL FileTimeToDosDateTime(FILETIME *lpFileTime, WORD* lpFatDate, WORD* lpFatTime);
export BOOL DosDateTimeToFileTime(WORD wFatDate, WORD wFatTime, FILETIME* lpFileTime);
export DWORD GetTickCount();
export BOOL SetSystemTimeAdjustment(DWORD dwTimeAdjustment, BOOL bTimeAdjustmentDisabled);
export BOOL GetSystemTimeAdjustment(DWORD* lpTimeAdjustment, DWORD* lpTimeIncrement, BOOL* lpTimeAdjustmentDisabled);
export DWORD FormatMessageA(DWORD dwFlags, LPCVOID lpSource, DWORD dwMessageId, DWORD dwLanguageId, LPSTR lpBuffer, DWORD nSize, void* *Arguments);export DWORD FormatMessageW(DWORD dwFlags, LPCVOID lpSource, DWORD dwMessageId, DWORD dwLanguageId, LPWSTR lpBuffer, DWORD nSize, void* *Arguments);

enum
{
	FORMAT_MESSAGE_ALLOCATE_BUFFER = 0x00000100,
	FORMAT_MESSAGE_IGNORE_INSERTS =  0x00000200,
	FORMAT_MESSAGE_FROM_STRING =     0x00000400,
	FORMAT_MESSAGE_FROM_HMODULE =    0x00000800,
	FORMAT_MESSAGE_FROM_SYSTEM =     0x00001000,
	FORMAT_MESSAGE_ARGUMENT_ARRAY =  0x00002000,
	FORMAT_MESSAGE_MAX_WIDTH_MASK =  0x000000FF,
};


//
//  Language IDs.
//
//  The following two combinations of primary language ID and
//  sublanguage ID have special semantics:
//
//    Primary Language ID   Sublanguage ID      Result
//    -------------------   ---------------     ------------------------
//    LANG_NEUTRAL          SUBLANG_NEUTRAL     Language neutral
//    LANG_NEUTRAL          SUBLANG_DEFAULT     User default language
//    LANG_NEUTRAL          SUBLANG_SYS_DEFAULT System default language
//

//
//  Primary language IDs.
//

enum
{
	LANG_NEUTRAL                     = 0x00,

	LANG_AFRIKAANS                   = 0x36,
	LANG_ALBANIAN                    = 0x1c,
	LANG_ARABIC                      = 0x01,
	LANG_BASQUE                      = 0x2d,
	LANG_BELARUSIAN                  = 0x23,
	LANG_BULGARIAN                   = 0x02,
	LANG_CATALAN                     = 0x03,
	LANG_CHINESE                     = 0x04,
	LANG_CROATIAN                    = 0x1a,
	LANG_CZECH                       = 0x05,
	LANG_DANISH                      = 0x06,
	LANG_DUTCH                       = 0x13,
	LANG_ENGLISH                     = 0x09,
	LANG_ESTONIAN                    = 0x25,
	LANG_FAEROESE                    = 0x38,
	LANG_FARSI                       = 0x29,
	LANG_FINNISH                     = 0x0b,
	LANG_FRENCH                      = 0x0c,
	LANG_GERMAN                      = 0x07,
	LANG_GREEK                       = 0x08,
	LANG_HEBREW                      = 0x0d,
	LANG_HUNGARIAN                   = 0x0e,
	LANG_ICELANDIC                   = 0x0f,
	LANG_INDONESIAN                  = 0x21,
	LANG_ITALIAN                     = 0x10,
	LANG_JAPANESE                    = 0x11,
	LANG_KOREAN                      = 0x12,
	LANG_LATVIAN                     = 0x26,
	LANG_LITHUANIAN                  = 0x27,
	LANG_NORWEGIAN                   = 0x14,
	LANG_POLISH                      = 0x15,
	LANG_PORTUGUESE                  = 0x16,
	LANG_ROMANIAN                    = 0x18,
	LANG_RUSSIAN                     = 0x19,
	LANG_SERBIAN                     = 0x1a,
	LANG_SLOVAK                      = 0x1b,
	LANG_SLOVENIAN                   = 0x24,
	LANG_SPANISH                     = 0x0a,
	LANG_SWEDISH                     = 0x1d,
	LANG_THAI                        = 0x1e,
	LANG_TURKISH                     = 0x1f,
	LANG_UKRAINIAN                   = 0x22,
	LANG_VIETNAMESE                  = 0x2a,
}
//
//  Sublanguage IDs.
//
//  The name immediately following SUBLANG_ dictates which primary
//  language ID that sublanguage ID can be combined with to form a
//  valid language ID.
//
enum
{
	SUBLANG_NEUTRAL =                  0x00,    // language neutral
	SUBLANG_DEFAULT =                  0x01,    // user default
	SUBLANG_SYS_DEFAULT =              0x02,    // system default

	SUBLANG_ARABIC_SAUDI_ARABIA =      0x01,    // Arabic (Saudi Arabia)
	SUBLANG_ARABIC_IRAQ =              0x02,    // Arabic (Iraq)
	SUBLANG_ARABIC_EGYPT =             0x03,    // Arabic (Egypt)
	SUBLANG_ARABIC_LIBYA =             0x04,    // Arabic (Libya)
	SUBLANG_ARABIC_ALGERIA =           0x05,    // Arabic (Algeria)
	SUBLANG_ARABIC_MOROCCO =           0x06,    // Arabic (Morocco)
	SUBLANG_ARABIC_TUNISIA =           0x07,    // Arabic (Tunisia)
	SUBLANG_ARABIC_OMAN =              0x08,    // Arabic (Oman)
	SUBLANG_ARABIC_YEMEN =             0x09,    // Arabic (Yemen)
	SUBLANG_ARABIC_SYRIA =             0x0a,    // Arabic (Syria)
	SUBLANG_ARABIC_JORDAN =            0x0b,    // Arabic (Jordan)
	SUBLANG_ARABIC_LEBANON =           0x0c,    // Arabic (Lebanon)
	SUBLANG_ARABIC_KUWAIT =            0x0d,    // Arabic (Kuwait)
	SUBLANG_ARABIC_UAE =               0x0e,    // Arabic (U.A.E)
	SUBLANG_ARABIC_BAHRAIN =           0x0f,    // Arabic (Bahrain)
	SUBLANG_ARABIC_QATAR =             0x10,    // Arabic (Qatar)
	SUBLANG_CHINESE_TRADITIONAL =      0x01,    // Chinese (Taiwan)
	SUBLANG_CHINESE_SIMPLIFIED =       0x02,    // Chinese (PR China)
	SUBLANG_CHINESE_HONGKONG =         0x03,    // Chinese (Hong Kong)
	SUBLANG_CHINESE_SINGAPORE =        0x04,    // Chinese (Singapore)
	SUBLANG_DUTCH =                    0x01,    // Dutch
	SUBLANG_DUTCH_BELGIAN =            0x02,    // Dutch (Belgian)
	SUBLANG_ENGLISH_US =               0x01,    // English (USA)
	SUBLANG_ENGLISH_UK =               0x02,    // English (UK)
	SUBLANG_ENGLISH_AUS =              0x03,    // English (Australian)
	SUBLANG_ENGLISH_CAN =              0x04,    // English (Canadian)
	SUBLANG_ENGLISH_NZ =               0x05,    // English (New Zealand)
	SUBLANG_ENGLISH_EIRE =             0x06,    // English (Irish)
	SUBLANG_ENGLISH_SOUTH_AFRICA =     0x07,    // English (South Africa)
	SUBLANG_ENGLISH_JAMAICA =          0x08,    // English (Jamaica)
	SUBLANG_ENGLISH_CARIBBEAN =        0x09,    // English (Caribbean)
	SUBLANG_ENGLISH_BELIZE =           0x0a,    // English (Belize)
	SUBLANG_ENGLISH_TRINIDAD =         0x0b,    // English (Trinidad)
	SUBLANG_FRENCH =                   0x01,    // French
	SUBLANG_FRENCH_BELGIAN =           0x02,    // French (Belgian)
	SUBLANG_FRENCH_CANADIAN =          0x03,    // French (Canadian)
	SUBLANG_FRENCH_SWISS =             0x04,    // French (Swiss)
	SUBLANG_FRENCH_LUXEMBOURG =        0x05,    // French (Luxembourg)
	SUBLANG_GERMAN =                   0x01,    // German
	SUBLANG_GERMAN_SWISS =             0x02,    // German (Swiss)
	SUBLANG_GERMAN_AUSTRIAN =          0x03,    // German (Austrian)
	SUBLANG_GERMAN_LUXEMBOURG =        0x04,    // German (Luxembourg)
	SUBLANG_GERMAN_LIECHTENSTEIN =     0x05,    // German (Liechtenstein)
	SUBLANG_ITALIAN =                  0x01,    // Italian
	SUBLANG_ITALIAN_SWISS =            0x02,    // Italian (Swiss)
	SUBLANG_KOREAN =                   0x01,    // Korean (Extended Wansung)
	SUBLANG_KOREAN_JOHAB =             0x02,    // Korean (Johab)
	SUBLANG_NORWEGIAN_BOKMAL =         0x01,    // Norwegian (Bokmal)
	SUBLANG_NORWEGIAN_NYNORSK =        0x02,    // Norwegian (Nynorsk)
	SUBLANG_PORTUGUESE =               0x02,    // Portuguese
	SUBLANG_PORTUGUESE_BRAZILIAN =     0x01,    // Portuguese (Brazilian)
	SUBLANG_SERBIAN_LATIN =            0x02,    // Serbian (Latin)
	SUBLANG_SERBIAN_CYRILLIC =         0x03,    // Serbian (Cyrillic)
	SUBLANG_SPANISH =                  0x01,    // Spanish (Castilian)
	SUBLANG_SPANISH_MEXICAN =          0x02,    // Spanish (Mexican)
	SUBLANG_SPANISH_MODERN =           0x03,    // Spanish (Modern)
	SUBLANG_SPANISH_GUATEMALA =        0x04,    // Spanish (Guatemala)
	SUBLANG_SPANISH_COSTA_RICA =       0x05,    // Spanish (Costa Rica)
	SUBLANG_SPANISH_PANAMA =           0x06,    // Spanish (Panama)
	SUBLANG_SPANISH_DOMINICAN_REPUBLIC = 0x07,  // Spanish (Dominican Republic)
	SUBLANG_SPANISH_VENEZUELA =        0x08,    // Spanish (Venezuela)
	SUBLANG_SPANISH_COLOMBIA =         0x09,    // Spanish (Colombia)
	SUBLANG_SPANISH_PERU =             0x0a,    // Spanish (Peru)
	SUBLANG_SPANISH_ARGENTINA =        0x0b,    // Spanish (Argentina)
	SUBLANG_SPANISH_ECUADOR =          0x0c,    // Spanish (Ecuador)
	SUBLANG_SPANISH_CHILE =            0x0d,    // Spanish (Chile)
	SUBLANG_SPANISH_URUGUAY =          0x0e,    // Spanish (Uruguay)
	SUBLANG_SPANISH_PARAGUAY =         0x0f,    // Spanish (Paraguay)
	SUBLANG_SPANISH_BOLIVIA =          0x10,    // Spanish (Bolivia)
	SUBLANG_SPANISH_EL_SALVADOR =      0x11,    // Spanish (El Salvador)
	SUBLANG_SPANISH_HONDURAS =         0x12,    // Spanish (Honduras)
	SUBLANG_SPANISH_NICARAGUA =        0x13,    // Spanish (Nicaragua)
	SUBLANG_SPANISH_PUERTO_RICO =      0x14,    // Spanish (Puerto Rico)
	SUBLANG_SWEDISH =                  0x01,    // Swedish
	SUBLANG_SWEDISH_FINLAND =          0x02,    // Swedish (Finland)
}
//
//  Sorting IDs.
//

enum
{
	SORT_DEFAULT                   = 0x0,    // sorting default

	SORT_JAPANESE_XJIS             = 0x0,    // Japanese XJIS order
	SORT_JAPANESE_UNICODE          = 0x1,    // Japanese Unicode order

	SORT_CHINESE_BIG5              = 0x0,    // Chinese BIG5 order
	SORT_CHINESE_PRCP              = 0x0,    // PRC Chinese Phonetic order
	SORT_CHINESE_UNICODE           = 0x1,    // Chinese Unicode order
	SORT_CHINESE_PRC               = 0x2,    // PRC Chinese Stroke Count order

	SORT_KOREAN_KSC                = 0x0,    // Korean KSC order
	SORT_KOREAN_UNICODE            = 0x1,    // Korean Unicode order

	SORT_GERMAN_PHONE_BOOK         = 0x1,    // German Phone Book order
}

// end_r_winnt

//
//  A language ID is a 16 bit value which is the combination of a
//  primary language ID and a secondary language ID.  The bits are
//  allocated as follows:
//
//       +-----------------------+-------------------------+
//       |     Sublanguage ID    |   Primary Language ID   |
//       +-----------------------+-------------------------+
//        15                   10 9                       0   bit
//
//
//  Language ID creation/extraction macros:
//
//    MAKELANGID    - construct language id from a primary language id and
//                    a sublanguage id.
//    PRIMARYLANGID - extract primary language id from a language id.
//    SUBLANGID     - extract sublanguage id from a language id.
//

int MAKELANGID(int p, int s) { return ((cast(WORD)s) << 10) | cast(WORD)p; }
WORD PRIMARYLANGID(int lgid) { return cast(WORD)lgid & 0x3ff; }
WORD SUBLANGID(int lgid)     { return cast(WORD)lgid >> 10; }


struct FLOATING_SAVE_AREA {
    DWORD   ControlWord;
    DWORD   StatusWord;
    DWORD   TagWord;
    DWORD   ErrorOffset;
    DWORD   ErrorSelector;
    DWORD   DataOffset;
    DWORD   DataSelector;
    BYTE    RegisterArea[80 ];
    DWORD   Cr0NpxState;
}

enum
{
	SIZE_OF_80387_REGISTERS =      80,
//
// The following flags control the contents of the CONTEXT structure.
//
	CONTEXT_i386 =    0x00010000,    // this assumes that i386 and
	CONTEXT_i486 =    0x00010000,    // i486 have identical context records

	CONTEXT_CONTROL =         (CONTEXT_i386 | 0x00000001), // SS:SP, CS:IP, FLAGS, BP
	CONTEXT_INTEGER =         (CONTEXT_i386 | 0x00000002), // AX, BX, CX, DX, SI, DI
	CONTEXT_SEGMENTS =        (CONTEXT_i386 | 0x00000004), // DS, ES, FS, GS
	CONTEXT_FLOATING_POINT =  (CONTEXT_i386 | 0x00000008), // 387 state
	CONTEXT_DEBUG_REGISTERS = (CONTEXT_i386 | 0x00000010), // DB 0-3,6,7

	CONTEXT_FULL = (CONTEXT_CONTROL | CONTEXT_INTEGER | CONTEXT_SEGMENTS),
}

struct CONTEXT
{

    //
    // The flags values within this flag control the contents of
    // a CONTEXT record.
    //
    // If the context record is used as an input parameter, then
    // for each portion of the context record controlled by a flag
    // whose value is set, it is assumed that that portion of the
    // context record contains valid context. If the context record
    // is being used to modify a threads context, then only that
    // portion of the threads context will be modified.
    //
    // If the context record is used as an IN OUT parameter to capture
    // the context of a thread, then only those portions of the thread's
    // context corresponding to set flags will be returned.
    //
    // The context record is never used as an OUT only parameter.
    //

    DWORD ContextFlags;

    //
    // This section is specified/returned if CONTEXT_DEBUG_REGISTERS is
    // set in ContextFlags.  Note that CONTEXT_DEBUG_REGISTERS is NOT
    // included in CONTEXT_FULL.
    //

    DWORD   Dr0;
    DWORD   Dr1;
    DWORD   Dr2;
    DWORD   Dr3;
    DWORD   Dr6;
    DWORD   Dr7;

    //
    // This section is specified/returned if the
    // ContextFlags word contians the flag CONTEXT_FLOATING_POINT.
    //

    FLOATING_SAVE_AREA FloatSave;

    //
    // This section is specified/returned if the
    // ContextFlags word contians the flag CONTEXT_SEGMENTS.
    //

    DWORD   SegGs;
    DWORD   SegFs;
    DWORD   SegEs;
    DWORD   SegDs;

    //
    // This section is specified/returned if the
    // ContextFlags word contians the flag CONTEXT_INTEGER.
    //

    DWORD   Edi;
    DWORD   Esi;
    DWORD   Ebx;
    DWORD   Edx;
    DWORD   Ecx;
    DWORD   Eax;

    //
    // This section is specified/returned if the
    // ContextFlags word contians the flag CONTEXT_CONTROL.
    //

    DWORD   Ebp;
    DWORD   Eip;
    DWORD   SegCs;              // MUST BE SANITIZED
    DWORD   EFlags;             // MUST BE SANITIZED
    DWORD   Esp;
    DWORD   SegSs;
}

enum
{
	THREAD_BASE_PRIORITY_LOWRT =  15,  // value that gets a thread to LowRealtime-1
	THREAD_BASE_PRIORITY_MAX =    2,   // maximum thread base priority boost
	THREAD_BASE_PRIORITY_MIN =    -2,  // minimum thread base priority boost
	THREAD_BASE_PRIORITY_IDLE =   -15, // value that gets a thread to idle

	THREAD_PRIORITY_LOWEST =          THREAD_BASE_PRIORITY_MIN,
	THREAD_PRIORITY_BELOW_NORMAL =    (THREAD_PRIORITY_LOWEST+1),
	THREAD_PRIORITY_NORMAL =          0,
	THREAD_PRIORITY_HIGHEST =         THREAD_BASE_PRIORITY_MAX,
	THREAD_PRIORITY_ABOVE_NORMAL =    (THREAD_PRIORITY_HIGHEST-1),
	THREAD_PRIORITY_ERROR_RETURN =    int.max,

	THREAD_PRIORITY_TIME_CRITICAL =   THREAD_BASE_PRIORITY_LOWRT,
	THREAD_PRIORITY_IDLE =            THREAD_BASE_PRIORITY_IDLE,
}

export HANDLE GetCurrentThread();
export BOOL GetProcessTimes(HANDLE hProcess, LPFILETIME lpCreationTime, LPFILETIME lpExitTime, LPFILETIME lpKernelTime, LPFILETIME lpUserTime);
export HANDLE GetCurrentProcess();
export BOOL DuplicateHandle (HANDLE sourceProcess, HANDLE sourceThread,
        HANDLE targetProcessHandle, HANDLE *targetHandle, DWORD access, 
        BOOL inheritHandle, DWORD options);
export DWORD GetCurrentThreadId();
export BOOL SetThreadPriority(HANDLE hThread, int nPriority);
export BOOL SetThreadPriorityBoost(HANDLE hThread, BOOL bDisablePriorityBoost);
export BOOL GetThreadPriorityBoost(HANDLE hThread, PBOOL pDisablePriorityBoost);
export BOOL GetThreadTimes(HANDLE hThread, LPFILETIME lpCreationTime, LPFILETIME lpExitTime, LPFILETIME lpKernelTime, LPFILETIME lpUserTime);
export int GetThreadPriority(HANDLE hThread);
export BOOL GetThreadContext(HANDLE hThread, CONTEXT* lpContext);
export BOOL SetThreadContext(HANDLE hThread, CONTEXT* lpContext);
export DWORD SuspendThread(HANDLE hThread);
export DWORD ResumeThread(HANDLE hThread);
export DWORD WaitForSingleObject(HANDLE hHandle, DWORD dwMilliseconds);
export DWORD WaitForMultipleObjects(DWORD nCount, HANDLE *lpHandles, BOOL bWaitAll, DWORD dwMilliseconds);
export void Sleep(DWORD dwMilliseconds);

export BOOL QueryPerformanceCounter(long* lpPerformanceCount);
export BOOL QueryPerformanceFrequency(long* lpFrequency);


const char[] DRAGLISTMSGSTRING = "commctrl_DragListMsg";
const char[] HOTKEY_CLASSA = "msctls_hotkey32";
const char[] PROGRESS_CLASSA ="msctls_progress32";
const char[] STATUSCLASSNAMEA = "msctls_statusbar32";
const char[] TOOLBARCLASSNAMEA = "ToolbarWindow32";
const char[] TOOLTIPS_CLASSA = "tooltips_class32";
const char[] TRACKBAR_CLASSA = "msctls_trackbar32";
const char[] UPDOWN_CLASSA = "msctls_updown32";
const char[] ANIMATE_CLASSA = "SysAnimate32";
const char[] DATETIMEPICK_CLASSA = "SysDateTimePick32";
const char[] MONTHCAL_CLASSA = "SysMonthCal32";
const char[] REBARCLASSNAMEA = "ReBarWindow32";
const char[] WC_COMBOBOXEXA = "ComboBoxEx32";
const char[] WC_IPADDRESSA = "SysIPAddress32";
const char[] WC_LISTVIEWA = "SysListView32";
const char[] WC_TABCONTROLA = "SysTabControl32";
const char[] WC_TREEVIEWA	= "SysTreeView32";
const char[] WC_HEADERA	= "SysHeader32";
const char[] WC_PAGESCROLLERA	= "SysPager";
const char[] WC_NATIVEFONTCTLA="NativeFontCtl";
const char[] WC_BUTTONA="Button";
const char[] WC_STATICA="Static";
const char[] WC_EDITA="Edit";
const char[] WC_LISTBOXA="ListBox";
const char[] WC_COMBOBOXA="ComboBox";
const char[] WC_SCROLLBARA="ScrollBar";


enum
{
	WM_NOTIFY =                       0x004E,
	WM_INPUTLANGCHANGEREQUEST =       0x0050,
	WM_INPUTLANGCHANGE =              0x0051,
	WM_TCARD =                        0x0052,
	WM_HELP =                         0x0053,
	WM_USERCHANGED =                  0x0054,
	WM_NOTIFYFORMAT =                 0x0055,

	NFR_ANSI =                             1,
	NFR_UNICODE =                          2,
	NF_QUERY =                             3,
	NF_REQUERY =                           4,

	WM_CONTEXTMENU =                  0x007B,
	WM_STYLECHANGING =                0x007C,
	WM_STYLECHANGED =                 0x007D,
	WM_DISPLAYCHANGE =                0x007E,
	WM_GETICON =                      0x007F,
	WM_SETICON =                      0x0080,

  WM_SETCURSOR = 32,
  WM_SETFOCUS = 7,
  WM_SETFONT = 48,

	WM_NCCREATE =                     0x0081,
	WM_NCDESTROY =                    0x0082,
	WM_NCCALCSIZE =                   0x0083,
	WM_NCHITTEST =                    0x0084,
	WM_NCPAINT =                      0x0085,
	WM_NCACTIVATE =                   0x0086,
	WM_GETDLGCODE =                   0x0087,

	WM_NCMOUSEMOVE =                  0x00A0,
	WM_NCLBUTTONDOWN =                0x00A1,
	WM_NCLBUTTONUP =                  0x00A2,
	WM_NCLBUTTONDBLCLK =              0x00A3,
	WM_NCRBUTTONDOWN =                0x00A4,
	WM_NCRBUTTONUP =                  0x00A5,
	WM_NCRBUTTONDBLCLK =              0x00A6,
	WM_NCMBUTTONDOWN =                0x00A7,
	WM_NCMBUTTONUP =                  0x00A8,
	WM_NCMBUTTONDBLCLK =              0x00A9,

	WM_KEYFIRST =                     0x0100,
	WM_KEYDOWN =                      0x0100,
	WM_KEYUP =                        0x0101,
	WM_CHAR =                         0x0102,
	WM_DEADCHAR =                     0x0103,
	WM_SYSKEYDOWN =                   0x0104,
	WM_SYSKEYUP =                     0x0105,
	WM_SYSCHAR =                      0x0106,
	WM_SYSDEADCHAR =                  0x0107,
	WM_KEYLAST =                      0x0108,


	WM_IME_STARTCOMPOSITION =         0x010D,
	WM_IME_ENDCOMPOSITION =           0x010E,
	WM_IME_COMPOSITION =              0x010F,
	WM_IME_KEYLAST =                  0x010F,


	WM_INITDIALOG =                   0x0110,
	WM_COMMAND =                      0x0111,
	WM_SYSCOMMAND =                   0x0112,
	WM_TIMER =                        0x0113,
	WM_HSCROLL =                      0x0114,
	WM_VSCROLL =                      0x0115,
	WM_INITMENU =                     0x0116,
	WM_INITMENUPOPUP =                0x0117,
	WM_MENUSELECT =                   0x011F,
	WM_MENUCHAR =                     0x0120,
	WM_ENTERIDLE =                    0x0121,
  WM_MENUCOMMAND =                  0x0126,

	WM_CTLCOLORMSGBOX =               0x0132,
	WM_CTLCOLOREDIT =                 0x0133,
	WM_CTLCOLORLISTBOX =              0x0134,
	WM_CTLCOLORBTN =                  0x0135,
	WM_CTLCOLORDLG =                  0x0136,
	WM_CTLCOLORSCROLLBAR =            0x0137,
	WM_CTLCOLORSTATIC =               0x0138,



	WM_MOUSEFIRST =                   0x0200,
	WM_MOUSEMOVE =                    0x0200,
	WM_LBUTTONDOWN =                  0x0201,
	WM_LBUTTONUP =                    0x0202,
	WM_LBUTTONDBLCLK =                0x0203,
	WM_RBUTTONDOWN =                  0x0204,
	WM_RBUTTONUP =                    0x0205,
	WM_RBUTTONDBLCLK =                0x0206,
	WM_MBUTTONDOWN =                  0x0207,
	WM_MBUTTONUP =                    0x0208,
	WM_MBUTTONDBLCLK =                0x0209,
  
  WM_MOUSEHOVER =                   0x02A1,
  WM_MOUSELEAVE =                   0x02A3,

	WM_MOUSELAST =                    0x0209,

	WM_PARENTNOTIFY =                 0x0210,
	MENULOOP_WINDOW =                 0,
	MENULOOP_POPUP =                  1,
	WM_ENTERMENULOOP =                0x0211,
	WM_EXITMENULOOP =                 0x0212,


	WM_NEXTMENU =                     0x0213,
	
  WM_USER = 1024	
}

enum
{
/*
 * Dialog Box Command IDs
 */
	IDOK =                1,
	IDCANCEL =            2,
	IDABORT =             3,
	IDRETRY =             4,
	IDIGNORE =            5,
	IDYES =               6,
	IDNO =                7,

	IDCLOSE =         8,
	IDHELP =          9,


// end_r_winuser



/*
 * Control Manager Structures and Definitions
 */



// begin_r_winuser

/*
 * Edit Control Styles
 */
	ES_LEFT =             0x0000,
	ES_CENTER =           0x0001,
	ES_RIGHT =            0x0002,
	ES_MULTILINE =        0x0004,
	ES_UPPERCASE =        0x0008,
	ES_LOWERCASE =        0x0010,
	ES_PASSWORD =         0x0020,
	ES_AUTOVSCROLL =      0x0040,
	ES_AUTOHSCROLL =      0x0080,
	ES_NOHIDESEL =        0x0100,
	ES_OEMCONVERT =       0x0400,
	ES_READONLY =         0x0800,
	ES_WANTRETURN =       0x1000,

	ES_NUMBER =           0x2000,


// end_r_winuser



/*
 * Edit Control Notification Codes
 */
	EN_SETFOCUS =         0x0100,
	EN_KILLFOCUS =        0x0200,
	EN_CHANGE =           0x0300,
	EN_UPDATE =           0x0400,
	EN_ERRSPACE =         0x0500,
	EN_MAXTEXT =          0x0501,
	EN_HSCROLL =          0x0601,
	EN_VSCROLL =          0x0602,


/* Edit control EM_SETMARGIN parameters */
	EC_LEFTMARGIN =       0x0001,
	EC_RIGHTMARGIN =      0x0002,
	EC_USEFONTINFO =      0xffff,




// begin_r_winuser

/*
 * Edit Control Messages
 */
	EM_GETSEL =               0x00B0,
	EM_SETSEL =               0x00B1,
	EM_GETRECT =              0x00B2,
	EM_SETRECT =              0x00B3,
	EM_SETRECTNP =            0x00B4,
	EM_SCROLL =               0x00B5,
	EM_LINESCROLL =           0x00B6,
	EM_SCROLLCARET =          0x00B7,
	EM_GETMODIFY =            0x00B8,
	EM_SETMODIFY =            0x00B9,
	EM_GETLINECOUNT =         0x00BA,
	EM_LINEINDEX =            0x00BB,
	EM_SETHANDLE =            0x00BC,
	EM_GETHANDLE =            0x00BD,
	EM_GETTHUMB =             0x00BE,
	EM_LINELENGTH =           0x00C1,
	EM_REPLACESEL =           0x00C2,
	EM_GETLINE =              0x00C4,
	EM_LIMITTEXT =            0x00C5,
	EM_CANUNDO =              0x00C6,
	EM_UNDO =                 0x00C7,
	EM_FMTLINES =             0x00C8,
	EM_LINEFROMCHAR =         0x00C9,
	EM_SETTABSTOPS =          0x00CB,
	EM_SETPASSWORDCHAR =      0x00CC,
	EM_EMPTYUNDOBUFFER =      0x00CD,
	EM_GETFIRSTVISIBLELINE =  0x00CE,
	EM_SETREADONLY =          0x00CF,
	EM_SETWORDBREAKPROC =     0x00D0,
	EM_GETWORDBREAKPROC =     0x00D1,
	EM_GETPASSWORDCHAR =      0x00D2,

	EM_SETMARGINS =           0x00D3,
	EM_GETMARGINS =           0x00D4,
	EM_SETLIMITTEXT =         EM_LIMITTEXT, /* ;win40 Name change */
	EM_GETLIMITTEXT =         0x00D5,
	EM_POSFROMCHAR =          0x00D6,
	EM_CHARFROMPOS =          0x00D7,



// end_r_winuser


/*
 * EDITWORDBREAKPROC code values
 */
	WB_LEFT =            0,
	WB_RIGHT =           1,
	WB_ISDELIMITER =     2,

// begin_r_winuser

/*
 * Button Control Styles
 */
	BS_PUSHBUTTON =       0x00000000,
	BS_DEFPUSHBUTTON =    0x00000001,
	BS_CHECKBOX =         0x00000002,
	BS_AUTOCHECKBOX =     0x00000003,
	BS_RADIOBUTTON =      0x00000004,
	BS_3STATE =           0x00000005,
	BS_AUTO3STATE =       0x00000006,
	BS_GROUPBOX =         0x00000007,
	BS_USERBUTTON =       0x00000008,
	BS_AUTORADIOBUTTON =  0x00000009,
	BS_OWNERDRAW =        0x0000000B,
	BS_LEFTTEXT =         0x00000020,

	BS_TEXT =             0x00000000,
	BS_ICON =             0x00000040,
	BS_BITMAP =           0x00000080,
	BS_LEFT =             0x00000100,
	BS_RIGHT =            0x00000200,
	BS_CENTER =           0x00000300,
	BS_TOP =              0x00000400,
	BS_BOTTOM =           0x00000800,
	BS_VCENTER =          0x00000C00,
	BS_PUSHLIKE =         0x00001000,
	BS_MULTILINE =        0x00002000,
	BS_NOTIFY =           0x00004000,
	BS_FLAT =             0x00008000,
	BS_RIGHTBUTTON =      BS_LEFTTEXT,



/*
 * User Button Notification Codes
 */
	BN_CLICKED =          0,
	BN_PAINT =            1,
	BN_HILITE =           2,
	BN_UNHILITE =         3,
	BN_DISABLE =          4,
	BN_DOUBLECLICKED =    5,

	BN_PUSHED =           BN_HILITE,
	BN_UNPUSHED =         BN_UNHILITE,
	BN_DBLCLK =           BN_DOUBLECLICKED,
	BN_SETFOCUS =         6,
	BN_KILLFOCUS =        7,

/*
 * Button Control Messages
 */
	BM_GETCHECK =        0x00F0,
	BM_SETCHECK =        0x00F1,
	BM_GETSTATE =        0x00F2,
	BM_SETSTATE =        0x00F3,
	BM_SETSTYLE =        0x00F4,

	BM_CLICK =           0x00F5,
	BM_GETIMAGE =        0x00F6,
	BM_SETIMAGE =        0x00F7,

	BST_UNCHECKED =      0x0000,
	BST_CHECKED =        0x0001,
	BST_INDETERMINATE =  0x0002,
	BST_PUSHED =         0x0004,
	BST_FOCUS =          0x0008,


/*
 * Static Control Constants
 */
	SS_LEFT =             0x00000000,
	SS_CENTER =           0x00000001,
	SS_RIGHT =            0x00000002,
	SS_ICON =             0x00000003,
	SS_BLACKRECT =        0x00000004,
	SS_GRAYRECT =         0x00000005,
	SS_WHITERECT =        0x00000006,
	SS_BLACKFRAME =       0x00000007,
	SS_GRAYFRAME =        0x00000008,
	SS_WHITEFRAME =       0x00000009,
	SS_USERITEM =         0x0000000A,
	SS_SIMPLE =           0x0000000B,
	SS_LEFTNOWORDWRAP =   0x0000000C,

	SS_OWNERDRAW =        0x0000000D,
	SS_BITMAP =           0x0000000E,
	SS_ENHMETAFILE =      0x0000000F,
	SS_ETCHEDHORZ =       0x00000010,
	SS_ETCHEDVERT =       0x00000011,
	SS_ETCHEDFRAME =      0x00000012,
	SS_TYPEMASK =         0x0000001F,

	SS_NOPREFIX =         0x00000080, /* Don't do "&" character translation */

	SS_NOTIFY =           0x00000100,
	SS_CENTERIMAGE =      0x00000200,
	SS_RIGHTJUST =        0x00000400,
	SS_REALSIZEIMAGE =    0x00000800,
	SS_SUNKEN =           0x00001000,
	SS_ENDELLIPSIS =      0x00004000,
	SS_PATHELLIPSIS =     0x00008000,
	SS_WORDELLIPSIS =     0x0000C000,
	SS_ELLIPSISMASK =     0x0000C000,


// end_r_winuser


/*
 * Static Control Mesages
 */
	STM_SETICON =         0x0170,
	STM_GETICON =         0x0171,

	STM_SETIMAGE =        0x0172,
	STM_GETIMAGE =        0x0173,
	STN_CLICKED =         0,
	STN_DBLCLK =          1,
	STN_ENABLE =          2,
	STN_DISABLE =         3,

	STM_MSGMAX =          0x0174,
}


enum
{
/*
 * Window Messages
 */

	WM_NULL =                         0x0000,
	WM_CREATE =                       0x0001,
	WM_DESTROY =                      0x0002,
	WM_MOVE =                         0x0003,
	WM_SIZE =                         0x0005,

	WM_ACTIVATE =                     0x0006,
/*
 * WM_ACTIVATE state values
 */
	WA_INACTIVE =     0,
	WA_ACTIVE =       1,
	WA_CLICKACTIVE =  2,

//	WM_SETFOCUS =                     0x0007,
	WM_KILLFOCUS =                    0x0008,
	WM_ENABLE =                       0x000A,
	WM_SETREDRAW =                    0x000B,
	WM_SETTEXT =                      0x000C,
	WM_GETTEXT =                      0x000D,
	WM_GETTEXTLENGTH =                0x000E,
	WM_PAINT =                        0x000F,
	WM_CLOSE =                        0x0010,
	WM_QUERYENDSESSION =              0x0011,
	WM_QUIT =                         0x0012,
	WM_QUERYOPEN =                    0x0013,
	WM_ERASEBKGND =                   0x0014,
	WM_SYSCOLORCHANGE =               0x0015,
	WM_ENDSESSION =                   0x0016,
	WM_SHOWWINDOW =                   0x0018,
	WM_WININICHANGE =                 0x001A,

	WM_SETTINGCHANGE =                WM_WININICHANGE,



	WM_DEVMODECHANGE =                0x001B,
	WM_ACTIVATEAPP =                  0x001C,
	WM_FONTCHANGE =                   0x001D,
	WM_TIMECHANGE =                   0x001E,
	WM_CANCELMODE =                   0x001F,
//	WM_SETCURSOR =                    0x0020,
	WM_MOUSEACTIVATE =                0x0021,
	WM_CHILDACTIVATE =                0x0022,
	WM_QUEUESYNC =                    0x0023,

	WM_GETMINMAXINFO =                0x0024,
}

struct RECT
{
    LONG    left;
    LONG    top;
    LONG    right;
    LONG    bottom;
}
alias RECT* PRECT, NPRECT, LPRECT, LPCRECT;

struct PAINTSTRUCT {
    HDC         hdc;
    BOOL        fErase;
    RECT        rcPaint;
    BOOL        fRestore;
    BOOL        fIncUpdate;
    BYTE        rgbReserved[32];
}
alias PAINTSTRUCT* PPAINTSTRUCT, NPPAINTSTRUCT, LPPAINTSTRUCT;

// flags for GetDCEx()

enum
{
	DCX_WINDOW =           0x00000001,
	DCX_CACHE =            0x00000002,
	DCX_NORESETATTRS =     0x00000004,
	DCX_CLIPCHILDREN =     0x00000008,
	DCX_CLIPSIBLINGS =     0x00000010,
	DCX_PARENTCLIP =       0x00000020,
	DCX_EXCLUDERGN =       0x00000040,
	DCX_INTERSECTRGN =     0x00000080,
	DCX_EXCLUDEUPDATE =    0x00000100,
	DCX_INTERSECTUPDATE =  0x00000200,
	DCX_LOCKWINDOWUPDATE = 0x00000400,
	DCX_VALIDATE =         0x00200000,
}

export
{
 BOOL UpdateWindow(HWND hWnd);
 HWND SetActiveWindow(HWND hWnd);
 HWND GetForegroundWindow();
 BOOL PaintDesktop(HDC hdc);
 BOOL SetForegroundWindow(HWND hWnd);
 HWND WindowFromDC(HDC hDC);
 HDC GetDC(HWND hWnd);
 HDC GetDCEx(HWND hWnd, HRGN hrgnClip, DWORD flags);
 HDC GetWindowDC(HWND hWnd);
 int ReleaseDC(HWND hWnd, HDC hDC);
 HDC BeginPaint(HWND hWnd, LPPAINTSTRUCT lpPaint);
 BOOL EndPaint(HWND hWnd, PAINTSTRUCT *lpPaint);
 BOOL GetUpdateRect(HWND hWnd, LPRECT lpRect, BOOL bErase);
 int GetUpdateRgn(HWND hWnd, HRGN hRgn, BOOL bErase);
 int SetWindowRgn(HWND hWnd, HRGN hRgn, BOOL bRedraw);
 int GetWindowRgn(HWND hWnd, HRGN hRgn);
 int ExcludeUpdateRgn(HDC hDC, HWND hWnd);
 BOOL InvalidateRect(HWND hWnd, RECT *lpRect, BOOL bErase);
 BOOL ValidateRect(HWND hWnd, RECT *lpRect);
 BOOL InvalidateRgn(HWND hWnd, HRGN hRgn, BOOL bErase);
 BOOL ValidateRgn(HWND hWnd, HRGN hRgn);
 BOOL RedrawWindow(HWND hWnd, RECT *lprcUpdate, HRGN hrgnUpdate, UINT flags);
}

// flags for RedrawWindow()
enum
{
	RDW_INVALIDATE =          0x0001,
	RDW_INTERNALPAINT =       0x0002,
	RDW_ERASE =               0x0004,
	RDW_VALIDATE =            0x0008,
	RDW_NOINTERNALPAINT =     0x0010,
	RDW_NOERASE =             0x0020,
	RDW_NOCHILDREN =          0x0040,
	RDW_ALLCHILDREN =         0x0080,
	RDW_UPDATENOW =           0x0100,
	RDW_ERASENOW =            0x0200,
	RDW_FRAME =               0x0400,
	RDW_NOFRAME =             0x0800,
}

export
{
 BOOL GetClientRect(HWND hWnd, LPRECT lpRect);
 BOOL GetWindowRect(HWND hWnd, LPRECT lpRect);
 BOOL AdjustWindowRect(LPRECT lpRect, DWORD dwStyle, BOOL bMenu);
 BOOL AdjustWindowRectEx(LPRECT lpRect, DWORD dwStyle, BOOL bMenu, DWORD dwExStyle);
 HFONT CreateFontA(int, int, int, int, int, DWORD,
                             DWORD, DWORD, DWORD, DWORD, DWORD,
                             DWORD, DWORD, LPCSTR);
 HFONT CreateFontW(int, int, int, int, int, DWORD,
                             DWORD, DWORD, DWORD, DWORD, DWORD,
                             DWORD, DWORD, LPCWSTR);
}

enum
{
	OUT_DEFAULT_PRECIS =          0,
	OUT_STRING_PRECIS =           1,
	OUT_CHARACTER_PRECIS =        2,
	OUT_STROKE_PRECIS =           3,
	OUT_TT_PRECIS =               4,
	OUT_DEVICE_PRECIS =           5,
	OUT_RASTER_PRECIS =           6,
	OUT_TT_ONLY_PRECIS =          7,
	OUT_OUTLINE_PRECIS =          8,
	OUT_SCREEN_OUTLINE_PRECIS =   9,

	CLIP_DEFAULT_PRECIS =     0,
	CLIP_CHARACTER_PRECIS =   1,
	CLIP_STROKE_PRECIS =      2,
	CLIP_MASK =               0xf,
	CLIP_LH_ANGLES =          (1<<4),
	CLIP_TT_ALWAYS =          (2<<4),
	CLIP_EMBEDDED =           (8<<4),

	DEFAULT_QUALITY =         0,
	DRAFT_QUALITY =           1,
	PROOF_QUALITY =           2,

	NONANTIALIASED_QUALITY =  3,
	ANTIALIASED_QUALITY =     4,


	DEFAULT_PITCH =           0,
	FIXED_PITCH =             1,
	VARIABLE_PITCH =          2,

	MONO_FONT =               8,


	ANSI_CHARSET =            0,
	DEFAULT_CHARSET =         1,
	SYMBOL_CHARSET =          2,
	SHIFTJIS_CHARSET =        128,
	HANGEUL_CHARSET =         129,
	GB2312_CHARSET =          134,
	CHINESEBIG5_CHARSET =     136,
	OEM_CHARSET =             255,

	JOHAB_CHARSET =           130,
	HEBREW_CHARSET =          177,
	ARABIC_CHARSET =          178,
	GREEK_CHARSET =           161,
	TURKISH_CHARSET =         162,
	VIETNAMESE_CHARSET =      163,
	THAI_CHARSET =            222,
	EASTEUROPE_CHARSET =      238,
	RUSSIAN_CHARSET =         204,

	MAC_CHARSET =             77,
	BALTIC_CHARSET =          186,

	FS_LATIN1 =               0x00000001L,
	FS_LATIN2 =               0x00000002L,
	FS_CYRILLIC =             0x00000004L,
	FS_GREEK =                0x00000008L,
	FS_TURKISH =              0x00000010L,
	FS_HEBREW =               0x00000020L,
	FS_ARABIC =               0x00000040L,
	FS_BALTIC =               0x00000080L,
	FS_VIETNAMESE =           0x00000100L,
	FS_THAI =                 0x00010000L,
	FS_JISJAPAN =             0x00020000L,
	FS_CHINESESIMP =          0x00040000L,
	FS_WANSUNG =              0x00080000L,
	FS_CHINESETRAD =          0x00100000L,
	FS_JOHAB =                0x00200000L,
	FS_SYMBOL =               cast(int)0x80000000L,


/* Font Families */
	FF_DONTCARE =         (0<<4), /* Don't care or don't know. */
	FF_ROMAN =            (1<<4), /* Variable stroke width, serifed. */
                                    /* Times Roman, Century Schoolbook, etc. */
	FF_SWISS =            (2<<4), /* Variable stroke width, sans-serifed. */
                                    /* Helvetica, Swiss, etc. */
	FF_MODERN =           (3<<4), /* Constant stroke width, serifed or sans-serifed. */
                                    /* Pica, Elite, Courier, etc. */
	FF_SCRIPT =           (4<<4), /* Cursive, etc. */
	FF_DECORATIVE =       (5<<4), /* Old English, etc. */

/* Font Weights */
	FW_DONTCARE =         0,
	FW_THIN =             100,
	FW_EXTRALIGHT =       200,
	FW_LIGHT =            300,
	FW_NORMAL =           400,
	FW_MEDIUM =           500,
	FW_SEMIBOLD =         600,
	FW_BOLD =             700,
	FW_EXTRABOLD =        800,
	FW_HEAVY =            900,

	FW_ULTRALIGHT =       FW_EXTRALIGHT,
	FW_REGULAR =          FW_NORMAL,
	FW_DEMIBOLD =         FW_SEMIBOLD,
	FW_ULTRABOLD =        FW_EXTRABOLD,
	FW_BLACK =            FW_HEAVY,

	PANOSE_COUNT =               10,
	PAN_FAMILYTYPE_INDEX =        0,
	PAN_SERIFSTYLE_INDEX =        1,
	PAN_WEIGHT_INDEX =            2,
	PAN_PROPORTION_INDEX =        3,
	PAN_CONTRAST_INDEX =          4,
	PAN_STROKEVARIATION_INDEX =   5,
	PAN_ARMSTYLE_INDEX =          6,
	PAN_LETTERFORM_INDEX =        7,
	PAN_MIDLINE_INDEX =           8,
	PAN_XHEIGHT_INDEX =           9,

	PAN_CULTURE_LATIN =           0,
}

struct RGBQUAD {
        BYTE    rgbBlue;
        BYTE    rgbGreen;
        BYTE    rgbRed;
        BYTE    rgbReserved;
}
alias RGBQUAD* LPRGBQUAD;

struct BITMAPFILEHEADER {
        WORD    bfType;
        DWORD	  bfSize;
        WORD    bfReserved1;
        WORD    bfReserved2;
        DWORD   bfOffBits;
} 

alias BITMAPFILEHEADER* LPBITMAPFILEHEADER, PBITMAPFILEHEADER;

struct BITMAPINFOHEADER {
        DWORD      biSize;
        LONG       biWidth;
        LONG       biHeight;
        WORD       biPlanes;
        WORD       biBitCount;
        DWORD      biCompression;
        DWORD      biSizeImage;
        LONG       biXPelsPerMeter;
        LONG       biYPelsPerMeter;
        DWORD      biClrUsed;
        DWORD      biClrImportant;
}
alias BITMAPINFOHEADER* LPBITMAPINFOHEADER, PBITMAPINFOHEADER;

struct BITMAPINFO {
    BITMAPINFOHEADER    bmiHeader;
//    RGBQUAD             bmiColors[1];
    RGBQUAD             bmiColors;
}
alias BITMAPINFO* LPBITMAPINFO, PBITMAPINFO;

struct PALETTEENTRY {
    BYTE        peRed;
    BYTE        peGreen;
    BYTE        peBlue;
    BYTE        peFlags;
}
alias PALETTEENTRY* PPALETTEENTRY, LPPALETTEENTRY;

struct LOGPALETTE {
    WORD        palVersion;
    WORD        palNumEntries;
    PALETTEENTRY        palPalEntry[1];
}
alias LOGPALETTE* PLOGPALETTE, NPLOGPALETTE, LPLOGPALETTE;

/* Pixel format descriptor */
struct PIXELFORMATDESCRIPTOR
{
    WORD  nSize;
    WORD  nVersion;
    DWORD dwFlags;
    BYTE  iPixelType;
    BYTE  cColorBits;
    BYTE  cRedBits;
    BYTE  cRedShift;
    BYTE  cGreenBits;
    BYTE  cGreenShift;
    BYTE  cBlueBits;
    BYTE  cBlueShift;
    BYTE  cAlphaBits;
    BYTE  cAlphaShift;
    BYTE  cAccumBits;
    BYTE  cAccumRedBits;
    BYTE  cAccumGreenBits;
    BYTE  cAccumBlueBits;
    BYTE  cAccumAlphaBits;
    BYTE  cDepthBits;
    BYTE  cStencilBits;
    BYTE  cAuxBuffers;
    BYTE  iLayerType;
    BYTE  bReserved;
    DWORD dwLayerMask;
    DWORD dwVisibleMask;
    DWORD dwDamageMask;
}
alias PIXELFORMATDESCRIPTOR* PPIXELFORMATDESCRIPTOR, LPPIXELFORMATDESCRIPTOR;


export
{
 BOOL   RoundRect(HDC, int, int, int, int, int, int);
 BOOL   ResizePalette(HPALETTE, UINT);
 int    SaveDC(HDC);
 int    SelectClipRgn(HDC, HRGN);
 int    ExtSelectClipRgn(HDC, HRGN, int);
 int    SetMetaRgn(HDC);
 HGDIOBJ   SelectObject(HDC, HGDIOBJ);
 HPALETTE   SelectPalette(HDC, HPALETTE, BOOL);
 COLORREF   SetBkColor(HDC, COLORREF);
 int     SetBkMode(HDC, int);
 LONG    SetBitmapBits(HBITMAP, DWORD, void *);
 UINT    SetBoundsRect(HDC,   RECT *, UINT);
 int     SetDIBits(HDC, HBITMAP, UINT, UINT, void *, BITMAPINFO *, UINT);
 int     SetDIBitsToDevice(HDC, int, int, DWORD, DWORD, int,
        int, UINT, UINT, void *, BITMAPINFO *, UINT);
 DWORD   SetMapperFlags(HDC, DWORD);
 int     SetGraphicsMode(HDC hdc, int iMode);
 int     SetMapMode(HDC, int);
 HMETAFILE     SetMetaFileBitsEx(UINT, BYTE *);
 UINT    SetPaletteEntries(HPALETTE, UINT, UINT, PALETTEENTRY *);
 COLORREF   SetPixel(HDC, int, int, COLORREF);
 BOOL     SetPixelV(HDC, int, int, COLORREF);
 BOOL    SetPixelFormat(HDC, int, PIXELFORMATDESCRIPTOR *);
 int     SetPolyFillMode(HDC, int);
 BOOL    StretchBlt(HDC, int, int, int, int, HDC, int, int, int, int, DWORD);
 BOOL    SetRectRgn(HRGN, int, int, int, int);
 int     StretchDIBits(HDC, int, int, int, int, int, int, int, int,
         void *, BITMAPINFO *, UINT, DWORD);
 int     SetROP2(HDC, int);
 int     SetStretchBltMode(HDC, int);
 UINT    SetSystemPaletteUse(HDC, UINT);
 int     SetTextCharacterExtra(HDC, int);
 COLORREF   SetTextColor(HDC, COLORREF);
 UINT    SetTextAlign(HDC, UINT);
 BOOL    SetTextJustification(HDC, int, int);
 BOOL    UpdateColors(HDC);
}

/* Text Alignment Options */
enum
{
	TA_NOUPDATECP =                0,
	TA_UPDATECP =                  1,

	TA_LEFT =                      0,
	TA_RIGHT =                     2,
	TA_CENTER =                    6,

	TA_TOP =                       0,
	TA_BOTTOM =                    8,
	TA_BASELINE =                  24,

	TA_RTLREADING =                256,
	TA_MASK =       (TA_BASELINE+TA_CENTER+TA_UPDATECP+TA_RTLREADING),
}

struct POINT
{
    LONG  x;
    LONG  y;
}
alias POINT* PPOINT, NPPOINT, LPPOINT;


export
{
 BOOL    MoveToEx(HDC, int, int, LPPOINT);
 BOOL    TextOutA(HDC, int, int, LPCSTR, int);
 BOOL    TextOutW(HDC, int, int, LPCWSTR, int);
}

export void PostQuitMessage(int nExitCode);
export LRESULT DefWindowProcA(HWND hWnd, UINT Msg, WPARAM wParam, LPARAM lParam);
export LRESULT DefWindowProcW(HWND hWnd, UINT Msg, WPARAM wParam, LPARAM lParam);
export HMODULE GetModuleHandleA(LPCSTR lpModuleName);
export HMODULE GetModuleHandleW(LPWSTR lpModuleName);

alias LRESULT (* WNDPROC)(HWND, UINT, WPARAM, LPARAM);

struct WNDCLASSEXA {
    UINT        cbSize;
    UINT        style;
    WNDPROC     lpfnWndProc;
    int         cbClsExtra;
    int         cbWndExtra;
    HINSTANCE   hInstance;
    HICON       hIcon;
    HCURSOR     hCursor;
    HBRUSH      hbrBackground;
    LPCSTR      lpszMenuName;
    LPCSTR      lpszClassName;
    HICON       hIconSm;
}
alias WNDCLASSEXA* PWNDCLASSEXA, NPWNDCLASSEXA, LPWNDCLASSEXA;

struct WNDCLASSEXW {
    UINT        cbSize;
    UINT        style;
    WNDPROC     lpfnWndProc;
    int         cbClsExtra;
    int         cbWndExtra;
    HINSTANCE   hInstance;
    HICON       hIcon;
    HCURSOR     hCursor;
    HBRUSH      hbrBackground;
    LPWSTR      lpszMenuName;
    LPWSTR      lpszClassName;
    HICON       hIconSm;
}
alias WNDCLASSEXW* PWNDCLASSEXW, NPWNDCLASSEXW, LPWNDCLASSEXW;


struct WNDCLASSA {
    UINT        style;
    WNDPROC     lpfnWndProc;
    int         cbClsExtra;
    int         cbWndExtra;
    HINSTANCE   hInstance;
    HICON       hIcon;
    HCURSOR     hCursor;
    HBRUSH      hbrBackground;
    LPCSTR      lpszMenuName;
    LPCSTR      lpszClassName;
}
alias WNDCLASSA* PWNDCLASSA, NPWNDCLASSA, LPWNDCLASSA;
alias WNDCLASSA WNDCLASS;

struct WNDCLASSW {
    UINT        style;
    WNDPROC     lpfnWndProc;
    int         cbClsExtra;
    int         cbWndExtra;
    HINSTANCE   hInstance;
    HICON       hIcon;
    HCURSOR     hCursor;
    HBRUSH      hbrBackground;
    LPWSTR      lpszMenuName;
    LPWSTR      lpszClassName;
}
alias WNDCLASSW* PWNDCLASSW, NPWNDCLASSW, LPWNDCLASSW;
//alias WNDCLASSW WNDCLASS;

/*
 * Window Styles
 */
enum : uint
{
	WS_OVERLAPPED =       0x00000000,
	WS_POPUP =            0x80000000,
	WS_CHILD =            0x40000000,
	WS_MINIMIZE =         0x20000000,
	WS_VISIBLE =          0x10000000,
	WS_DISABLED =         0x08000000,
	WS_CLIPSIBLINGS =     0x04000000,
	WS_CLIPCHILDREN =     0x02000000,
	WS_MAXIMIZE =         0x01000000,
	WS_CAPTION =          0x00C00000,  /* WS_BORDER | WS_DLGFRAME  */
	WS_BORDER =           0x00800000,
	WS_DLGFRAME =         0x00400000,
	WS_VSCROLL =          0x00200000,
	WS_HSCROLL =          0x00100000,
	WS_SYSMENU =          0x00080000,
	WS_THICKFRAME =       0x00040000,
	WS_GROUP =            0x00020000,
	WS_TABSTOP =          0x00010000,

	WS_MINIMIZEBOX =      0x00020000,
	WS_MAXIMIZEBOX =      0x00010000,

	WS_TILED =            WS_OVERLAPPED,
	WS_ICONIC =           WS_MINIMIZE,
	WS_SIZEBOX =          WS_THICKFRAME,

/*
 * Common Window Styles
 */
	WS_OVERLAPPEDWINDOW = (WS_OVERLAPPED |            WS_CAPTION |  WS_SYSMENU |  WS_THICKFRAME |            WS_MINIMIZEBOX |                 WS_MAXIMIZEBOX),
	WS_TILEDWINDOW =      WS_OVERLAPPEDWINDOW,
	WS_POPUPWINDOW =      (WS_POPUP |  WS_BORDER |  WS_SYSMENU),
	WS_CHILDWINDOW =      (WS_CHILD),
}


/*
 * Class styles
 */
enum
{
	CS_VREDRAW =          0x0001,
	CS_HREDRAW =          0x0002,
	CS_KEYCVTWINDOW =     0x0004,
	CS_DBLCLKS =          0x0008,
	CS_OWNDC =            0x0020,
	CS_CLASSDC =          0x0040,
	CS_PARENTDC =         0x0080,
	CS_NOKEYCVT =         0x0100,
	CS_NOCLOSE =          0x0200,
	CS_SAVEBITS =         0x0800,
	CS_BYTEALIGNCLIENT =  0x1000,
	CS_BYTEALIGNWINDOW =  0x2000,
	CS_GLOBALCLASS =      0x4000,


	CS_IME =              0x00010000,
}

export
{
 HICON LoadIconA(HINSTANCE hInstance, LPCSTR lpIconName);
 HICON LoadIconW(HINSTANCE hInstance, LPCWSTR lpIconName);
 HCURSOR LoadCursorA(HINSTANCE hInstance, LPCSTR lpCursorName);
 HCURSOR LoadCursorW(HINSTANCE hInstance, LPCWSTR lpCursorName);
}

const LPSTR IDI_APPLICATION =     cast(LPSTR)(32512);

const LPSTR IDC_ARROW = cast(LPSTR) 32512;
const LPSTR IDC_IBEAM =cast(LPSTR) 232513;
const LPSTR IDC_WAIT =cast(LPSTR) 232514;
const LPSTR IDC_CROSS = cast(LPSTR) 232515;
const LPSTR IDC_UPARROW =cast(LPSTR) 232516;
const LPSTR IDC_SIZENWSE =cast(LPSTR) 232642;
const LPSTR IDC_SIZENESW =cast(LPSTR) 232643;
const LPSTR IDC_SIZEWE =cast(LPSTR) 232644;
const LPSTR IDC_SIZENS =cast(LPSTR) 232645;
const LPSTR IDC_SIZEALL =cast(LPSTR) 232646;
const LPSTR IDC_NO =cast(LPSTR) 232648;
const LPSTR IDC_HAND =cast(LPSTR) 232649;
const LPSTR IDC_APPSTARTING =cast(LPSTR) 232650;
const LPSTR IDC_HELP =cast(LPSTR) 232651;
const LPSTR IDC_ICON =cast(LPSTR) 232641;
const LPSTR IDC_SIZE =cast(LPSTR) 232640;

/*
 * Color Types
 */
enum
{
	CTLCOLOR_MSGBOX =         0,
	CTLCOLOR_EDIT =           1,
	CTLCOLOR_LISTBOX =        2,
	CTLCOLOR_BTN =            3,
	CTLCOLOR_DLG =            4,
	CTLCOLOR_SCROLLBAR =      5,
	CTLCOLOR_STATIC =         6,
	CTLCOLOR_MAX =            7,

	COLOR_SCROLLBAR =         0,
	COLOR_BACKGROUND =        1,
	COLOR_ACTIVECAPTION =     2,
	COLOR_INACTIVECAPTION =   3,
	COLOR_MENU =              4,
	COLOR_WINDOW =            5,
	COLOR_WINDOWFRAME =       6,
	COLOR_MENUTEXT =          7,
	COLOR_WINDOWTEXT =        8,
	COLOR_CAPTIONTEXT =       9,
	COLOR_ACTIVEBORDER =      10,
	COLOR_INACTIVEBORDER =    11,
	COLOR_APPWORKSPACE =      12,
	COLOR_HIGHLIGHT =         13,
	COLOR_HIGHLIGHTTEXT =     14,
	COLOR_BTNFACE =           15,
	COLOR_BTNSHADOW =         16,
	COLOR_GRAYTEXT =          17,
	COLOR_BTNTEXT =           18,
	COLOR_INACTIVECAPTIONTEXT = 19,
	COLOR_BTNHIGHLIGHT =      20,


	COLOR_3DDKSHADOW =        21,
	COLOR_3DLIGHT =           22,
	COLOR_INFOTEXT =          23,
	COLOR_INFOBK =            24,

	COLOR_DESKTOP =           COLOR_BACKGROUND,
	COLOR_3DFACE =            COLOR_BTNFACE,
	COLOR_3DSHADOW =          COLOR_BTNSHADOW,
	COLOR_3DHIGHLIGHT =       COLOR_BTNHIGHLIGHT,
	COLOR_3DHILIGHT =         COLOR_BTNHIGHLIGHT,
	COLOR_BTNHILIGHT =        COLOR_BTNHIGHLIGHT,
}

const int CW_USEDEFAULT = cast(int)0x80000000;
/*
 * Special value for CreateWindow, et al.
 */
const HWND HWND_DESKTOP = (cast(HWND)0);


export ATOM RegisterClassA(WNDCLASSA *lpWndClass);
export ATOM RegisterClassW(WNDCLASSW *lpWndClass);

export HWND CreateWindowExA(
    DWORD dwExStyle,
    LPCSTR lpClassName,
    LPCSTR lpWindowName,
    DWORD dwStyle,
    int X,
    int Y,
    int nWidth,
    int nHeight,
    HWND hWndParent ,
    HMENU hMenu,
    HINSTANCE hInstance,
    LPVOID lpParam);

export HWND CreateWindowExW(
    DWORD dwExStyle,
    LPWSTR lpClassName,
    LPWSTR lpWindowName,
    DWORD dwStyle,
    int X,
    int Y,
    int nWidth,
    int nHeight,
    HWND hWndParent ,
    HMENU hMenu,
    HINSTANCE hInstance,
    LPVOID lpParam);


HWND CreateWindowA(
    LPCSTR lpClassName,
    LPCSTR lpWindowName,
    DWORD dwStyle,
    int X,
    int Y,
    int nWidth,
    int nHeight,
    HWND hWndParent ,
    HMENU hMenu,
    HINSTANCE hInstance,
    LPVOID lpParam)
{
    return CreateWindowExA(0, lpClassName, lpWindowName, dwStyle, X, Y, nWidth, nHeight, hWndParent, hMenu, hInstance, lpParam);
}

/*
 * Message structure
 */
struct MSG {
    HWND        hwnd;
    UINT        message;
    WPARAM      wParam;
    LPARAM      lParam;
    DWORD       time;
    POINT       pt;
}
alias MSG* PMSG, NPMSG, LPMSG;

export
{
 BOOL GetMessageA(LPMSG lpMsg, HWND hWnd, UINT wMsgFilterMin, UINT wMsgFilterMax);
 BOOL GetMessageW(LPMSG lpMsg, HWND hWnd, UINT wMsgFilterMin, UINT wMsgFilterMax);
 BOOL TranslateMessage(MSG *lpMsg);
 LONG DispatchMessageA(MSG *lpMsg);
 LONG DispatchMessageW(MSG *lpMsg);
 BOOL PeekMessageA(MSG *lpMsg, HWND hWnd, UINT wMsgFilterMin, UINT wMsgFilterMax, UINT wRemoveMsg);
 BOOL PeekMessageW(MSG *lpMsg, HWND hWnd, UINT wMsgFilterMin, UINT wMsgFilterMax, UINT wRemoveMsg);
 HWND GetFocus();
}

export DWORD ExpandEnvironmentStringsA(LPCSTR lpSrc, LPSTR lpDst, DWORD nSize);

export
{
 BOOL IsValidCodePage(UINT CodePage);
 UINT GetACP();
 UINT GetOEMCP();
 //BOOL GetCPInfo(UINT CodePage, LPCPINFO lpCPInfo);
 BOOL IsDBCSLeadByte(BYTE TestChar);
 BOOL IsDBCSLeadByteEx(UINT CodePage, BYTE TestChar);
 int MultiByteToWideChar(UINT CodePage, DWORD dwFlags, LPCSTR lpMultiByteStr, int cchMultiByte, LPWSTR lpWideCharStr, int cchWideChar);
 int WideCharToMultiByte(UINT CodePage, DWORD dwFlags, LPCWSTR lpWideCharStr, int cchWideChar, LPSTR lpMultiByteStr, int cchMultiByte, LPCSTR lpDefaultChar, LPBOOL lpUsedDefaultChar);
}

export HANDLE CreateFileMappingA(HANDLE hFile, LPSECURITY_ATTRIBUTES lpFileMappingAttributes, DWORD flProtect, DWORD dwMaximumSizeHigh, DWORD dwMaximumSizeLow, LPCSTR lpName);
export HANDLE CreateFileMappingW(HANDLE hFile, LPSECURITY_ATTRIBUTES lpFileMappingAttributes, DWORD flProtect, DWORD dwMaximumSizeHigh, DWORD dwMaximumSizeLow, LPCWSTR lpName);

export BOOL GetMailslotInfo(HANDLE hMailslot, LPDWORD lpMaxMessageSize, LPDWORD lpNextSize, LPDWORD lpMessageCount, LPDWORD lpReadTimeout);
export BOOL SetMailslotInfo(HANDLE hMailslot, DWORD lReadTimeout);
export LPVOID MapViewOfFile(HANDLE hFileMappingObject, DWORD dwDesiredAccess, DWORD dwFileOffsetHigh, DWORD dwFileOffsetLow, DWORD dwNumberOfBytesToMap);
export LPVOID MapViewOfFileEx(HANDLE hFileMappingObject, DWORD dwDesiredAccess, DWORD dwFileOffsetHigh, DWORD dwFileOffsetLow, DWORD dwNumberOfBytesToMap, LPVOID lpBaseAddress);
export BOOL FlushViewOfFile(LPCVOID lpBaseAddress, DWORD dwNumberOfBytesToFlush);
export BOOL UnmapViewOfFile(LPCVOID lpBaseAddress);

export  HGDIOBJ   GetStockObject(int);
export BOOL ShowWindow(HWND hWnd, int nCmdShow);

/* Stock Logical Objects */
enum
{	WHITE_BRUSH =         0,
	LTGRAY_BRUSH =        1,
	GRAY_BRUSH =          2,
	DKGRAY_BRUSH =        3,
	BLACK_BRUSH =         4,
	NULL_BRUSH =          5,
	HOLLOW_BRUSH =        NULL_BRUSH,
	WHITE_PEN =           6,
	BLACK_PEN =           7,
	NULL_PEN =            8,
	OEM_FIXED_FONT =      10,
	ANSI_FIXED_FONT =     11,
	ANSI_VAR_FONT =       12,
	SYSTEM_FONT =         13,
	DEVICE_DEFAULT_FONT = 14,
	DEFAULT_PALETTE =     15,
	SYSTEM_FIXED_FONT =   16,
	DEFAULT_GUI_FONT =    17,
	STOCK_LAST =          17,
}

/*
 * ShowWindow() Commands
 */
enum
{	SW_HIDE =             0,
	SW_SHOWNORMAL =       1,
	SW_NORMAL =           1,
	SW_SHOWMINIMIZED =    2,
	SW_SHOWMAXIMIZED =    3,
	SW_MAXIMIZE =         3,
	SW_SHOWNOACTIVATE =   4,
	SW_SHOW =             5,
	SW_MINIMIZE =         6,
	SW_SHOWMINNOACTIVE =  7,
	SW_SHOWNA =           8,
	SW_RESTORE =          9,
	SW_SHOWDEFAULT =      10,
	SW_MAX =              10,
}

struct TEXTMETRICA
{
    LONG        tmHeight;
    LONG        tmAscent;
    LONG        tmDescent;
    LONG        tmInternalLeading;
    LONG        tmExternalLeading;
    LONG        tmAveCharWidth;
    LONG        tmMaxCharWidth;
    LONG        tmWeight;
    LONG        tmOverhang;
    LONG        tmDigitizedAspectX;
    LONG        tmDigitizedAspectY;
    BYTE        tmFirstChar;
    BYTE        tmLastChar;
    BYTE        tmDefaultChar;
    BYTE        tmBreakChar;
    BYTE        tmItalic;
    BYTE        tmUnderlined;
    BYTE        tmStruckOut;
    BYTE        tmPitchAndFamily;
    BYTE        tmCharSet;
}

export  BOOL   GetTextMetricsA(HDC, TEXTMETRICA*);

/*
 * Scroll Bar Constants
 */
enum
{	SB_HORZ =             0,
	SB_VERT =             1,
	SB_CTL =              2,
	SB_BOTH =             3,
}

/*
 * Scroll Bar Commands
 */
enum
{	SB_LINEUP =           0,
	SB_LINELEFT =         0,
	SB_LINEDOWN =         1,
	SB_LINERIGHT =        1,
	SB_PAGEUP =           2,
	SB_PAGELEFT =         2,
	SB_PAGEDOWN =         3,
	SB_PAGERIGHT =        3,
	SB_THUMBPOSITION =    4,
	SB_THUMBTRACK =       5,
	SB_TOP =              6,
	SB_LEFT =             6,
	SB_BOTTOM =           7,
	SB_RIGHT =            7,
	SB_ENDSCROLL =        8,
}

export int SetScrollPos(HWND hWnd, int nBar, int nPos, BOOL bRedraw);
export int GetScrollPos(HWND hWnd, int nBar);
export BOOL SetScrollRange(HWND hWnd, int nBar, int nMinPos, int nMaxPos, BOOL bRedraw);
export BOOL GetScrollRange(HWND hWnd, int nBar, LPINT lpMinPos, LPINT lpMaxPos);
export BOOL ShowScrollBar(HWND hWnd, int wBar, BOOL bShow);
export BOOL EnableScrollBar(HWND hWnd, UINT wSBflags, UINT wArrows);

/*
 * LockWindowUpdate API
 */

export BOOL LockWindowUpdate(HWND hWndLock);
export BOOL ScrollWindow(HWND hWnd, int XAmount, int YAmount, RECT* lpRect, RECT* lpClipRect);
export BOOL ScrollDC(HDC hDC, int dx, int dy, RECT* lprcScroll, RECT* lprcClip, HRGN hrgnUpdate, LPRECT lprcUpdate);
export int ScrollWindowEx(HWND hWnd, int dx, int dy, RECT* prcScroll, RECT* prcClip, HRGN hrgnUpdate, LPRECT prcUpdate, UINT flags);

/*
 * Virtual Keys, Standard Set
 */
enum
{	VK_LBUTTON =        0x01,
	VK_RBUTTON =        0x02,
	VK_CANCEL =         0x03,
	VK_MBUTTON =        0x04, /* NOT contiguous with L & RBUTTON */

	VK_BACK =           0x08,
	VK_TAB =            0x09,

	VK_CLEAR =          0x0C,
	VK_RETURN =         0x0D,

	VK_SHIFT =          0x10,
	VK_CONTROL =        0x11,
	VK_MENU =           0x12,
	VK_PAUSE =          0x13,
	VK_CAPITAL =        0x14,


	VK_ESCAPE =         0x1B,

	VK_SPACE =          0x20,
	VK_PRIOR =          0x21,
	VK_NEXT =           0x22,
	VK_END =            0x23,
	VK_HOME =           0x24,
	VK_LEFT =           0x25,
	VK_UP =             0x26,
	VK_RIGHT =          0x27,
	VK_DOWN =           0x28,
	VK_SELECT =         0x29,
	VK_PRINT =          0x2A,
	VK_EXECUTE =        0x2B,
	VK_SNAPSHOT =       0x2C,
	VK_INSERT =         0x2D,
	VK_DELETE =         0x2E,
	VK_HELP =           0x2F,

/* VK_0 thru VK_9 are the same as ASCII '0' thru '9' (0x30 - 0x39) */
/* VK_A thru VK_Z are the same as ASCII 'A' thru 'Z' (0x41 - 0x5A) */

	VK_LWIN =           0x5B,
	VK_RWIN =           0x5C,
	VK_APPS =           0x5D,

	VK_NUMPAD0 =        0x60,
	VK_NUMPAD1 =        0x61,
	VK_NUMPAD2 =        0x62,
	VK_NUMPAD3 =        0x63,
	VK_NUMPAD4 =        0x64,
	VK_NUMPAD5 =        0x65,
	VK_NUMPAD6 =        0x66,
	VK_NUMPAD7 =        0x67,
	VK_NUMPAD8 =        0x68,
	VK_NUMPAD9 =        0x69,
	VK_MULTIPLY =       0x6A,
	VK_ADD =            0x6B,
	VK_SEPARATOR =      0x6C,
	VK_SUBTRACT =       0x6D,
	VK_DECIMAL =        0x6E,
	VK_DIVIDE =         0x6F,
	VK_F1 =             0x70,
	VK_F2 =             0x71,
	VK_F3 =             0x72,
	VK_F4 =             0x73,
	VK_F5 =             0x74,
	VK_F6 =             0x75,
	VK_F7 =             0x76,
	VK_F8 =             0x77,
	VK_F9 =             0x78,
	VK_F10 =            0x79,
	VK_F11 =            0x7A,
	VK_F12 =            0x7B,
	VK_F13 =            0x7C,
	VK_F14 =            0x7D,
	VK_F15 =            0x7E,
	VK_F16 =            0x7F,
	VK_F17 =            0x80,
	VK_F18 =            0x81,
	VK_F19 =            0x82,
	VK_F20 =            0x83,
	VK_F21 =            0x84,
	VK_F22 =            0x85,
	VK_F23 =            0x86,
	VK_F24 =            0x87,

	VK_NUMLOCK =        0x90,
	VK_SCROLL =         0x91,

/*
 * VK_L* & VK_R* - left and right Alt, Ctrl and Shift virtual keys.
 * Used only as parameters to GetAsyncKeyState() and GetKeyState().
 * No other API or message will distinguish left and right keys in this way.
 */
	VK_LSHIFT =         0xA0,
	VK_RSHIFT =         0xA1,
	VK_LCONTROL =       0xA2,
	VK_RCONTROL =       0xA3,
	VK_LMENU =          0xA4,
	VK_RMENU =          0xA5,


	VK_PROCESSKEY =     0xE5,


	VK_ATTN =           0xF6,
	VK_CRSEL =          0xF7,
	VK_EXSEL =          0xF8,
	VK_EREOF =          0xF9,
	VK_PLAY =           0xFA,
	VK_ZOOM =           0xFB,
	VK_NONAME =         0xFC,
	VK_PA1 =            0xFD,
	VK_OEM_CLEAR =      0xFE,
}

export LRESULT SendMessageA(HWND hWnd, UINT Msg, WPARAM wParam, LPARAM lParam);
export LRESULT SendMessageW(HWND hWnd, UINT Msg, WPARAM wParam, LPARAM lParam);

alias UINT (*LPOFNHOOKPROC) (HWND, UINT, WPARAM, LPARAM);

struct OPENFILENAMEA {
   DWORD        lStructSize;
   HWND         hwndOwner;
   HINSTANCE    hInstance;
   LPCSTR       lpstrFilter;
   LPSTR        lpstrCustomFilter;
   DWORD        nMaxCustFilter;
   DWORD        nFilterIndex;
   LPSTR        lpstrFile;
   DWORD        nMaxFile;
   LPSTR        lpstrFileTitle;
   DWORD        nMaxFileTitle;
   LPCSTR       lpstrInitialDir;
   LPCSTR       lpstrTitle;
   DWORD        Flags;
   WORD         nFileOffset;
   WORD         nFileExtension;
   LPCSTR       lpstrDefExt;
   LPARAM       lCustData;
   LPOFNHOOKPROC lpfnHook;
   LPCSTR       lpTemplateName;
}
alias OPENFILENAMEA *LPOPENFILENAMEA;

struct OPENFILENAMEW {
   DWORD        lStructSize;
   HWND         hwndOwner;
   HINSTANCE    hInstance;
   LPCWSTR      lpstrFilter;
   LPWSTR       lpstrCustomFilter;
   DWORD        nMaxCustFilter;
   DWORD        nFilterIndex;
   LPWSTR       lpstrFile;
   DWORD        nMaxFile;
   LPWSTR       lpstrFileTitle;
   DWORD        nMaxFileTitle;
   LPCWSTR      lpstrInitialDir;
   LPCWSTR      lpstrTitle;
   DWORD        Flags;
   WORD         nFileOffset;
   WORD         nFileExtension;
   LPCWSTR      lpstrDefExt;
   LPARAM       lCustData;
   LPOFNHOOKPROC lpfnHook;
   LPCWSTR      lpTemplateName;
}
alias OPENFILENAMEW *LPOPENFILENAMEW;

BOOL          GetOpenFileNameA(LPOPENFILENAMEA);
BOOL          GetOpenFileNameW(LPOPENFILENAMEW);

BOOL          GetSaveFileNameA(LPOPENFILENAMEA);
BOOL          GetSaveFileNameW(LPOPENFILENAMEW);

short         GetFileTitleA(LPCSTR, LPSTR, WORD);
short         GetFileTitleW(LPCWSTR, LPWSTR, WORD);

enum
{
	PM_NOREMOVE =         0x0000,
	PM_REMOVE =           0x0001,
	PM_NOYIELD =          0x0002,
}

/* Bitmap Header Definition */
struct BITMAP
{
    LONG        bmType;
    LONG        bmWidth;
    LONG        bmHeight;
    LONG        bmWidthBytes;
    WORD        bmPlanes;
    WORD        bmBitsPixel;
    LPVOID      bmBits;
}
alias BITMAP* PBITMAP, NPBITMAP, LPBITMAP;


export  HDC       CreateCompatibleDC(HDC);

export  int     GetObjectA(HGDIOBJ, int, LPVOID);
export  int     GetObjectW(HGDIOBJ, int, LPVOID);
export  BOOL   DeleteDC(HDC);

struct LOGFONTA
{
    LONG      lfHeight;
    LONG      lfWidth;
    LONG      lfEscapement;
    LONG      lfOrientation;
    LONG      lfWeight;
    BYTE      lfItalic;
    BYTE      lfUnderline;
    BYTE      lfStrikeOut;
    BYTE      lfCharSet;
    BYTE      lfOutPrecision;
    BYTE      lfClipPrecision;
    BYTE      lfQuality;
    BYTE      lfPitchAndFamily;
    CHAR      lfFaceName[32 ];
}
alias LOGFONTA* PLOGFONTA, NPLOGFONTA, LPLOGFONTA;

export HMENU LoadMenuA(HINSTANCE hInstance, LPCSTR lpMenuName);
export HMENU LoadMenuW(HINSTANCE hInstance, LPCWSTR lpMenuName);

export HMENU GetSubMenu(HMENU hMenu, int nPos);

export HBITMAP LoadBitmapA(HINSTANCE hInstance, LPCSTR lpBitmapName);
export HBITMAP LoadBitmapW(HINSTANCE hInstance, LPCWSTR lpBitmapName);

LPSTR MAKEINTRESOURCEA(int i) { return cast(LPSTR)(cast(DWORD)(cast(WORD)(i))); }

export  HFONT     CreateFontIndirectA(LOGFONTA *);

export BOOL MessageBeep(UINT uType);
export int ShowCursor(BOOL bShow);
export BOOL SetCursorPos(int X, int Y);
export HCURSOR SetCursor(HCURSOR hCursor);
export BOOL GetCursorPos(LPPOINT lpPoint);
export BOOL ClipCursor( RECT *lpRect);
export BOOL GetClipCursor(LPRECT lpRect);
export HCURSOR GetCursor();
export BOOL CreateCaret(HWND hWnd, HBITMAP hBitmap , int nWidth, int nHeight);
export UINT GetCaretBlinkTime();
export BOOL SetCaretBlinkTime(UINT uMSeconds);
export BOOL DestroyCaret();
export BOOL HideCaret(HWND hWnd);
export BOOL ShowCaret(HWND hWnd);
export BOOL SetCaretPos(int X, int Y);
export BOOL GetCaretPos(LPPOINT lpPoint);
export BOOL ClientToScreen(HWND hWnd, LPPOINT lpPoint);
export BOOL ScreenToClient(HWND hWnd, LPPOINT lpPoint);
export int MapWindowPoints(HWND hWndFrom, HWND hWndTo, LPPOINT lpPoints, UINT cPoints);
export HWND WindowFromPoint(POINT Point);
export HWND ChildWindowFromPoint(HWND hWndParent, POINT Point);


export BOOL TrackPopupMenu(HMENU hMenu, UINT uFlags, int x, int y,
	int nReserved, HWND hWnd, RECT *prcRect);

align (2) struct DLGTEMPLATE {
    DWORD style;
    DWORD dwExtendedStyle;
    WORD cdit;
    short x;
    short y;
    short cx;
    short cy;
}
alias DLGTEMPLATE *LPDLGTEMPLATEA;
alias DLGTEMPLATE *LPDLGTEMPLATEW;


alias LPDLGTEMPLATEA LPDLGTEMPLATE;

alias  DLGTEMPLATE *LPCDLGTEMPLATEA;
alias  DLGTEMPLATE *LPCDLGTEMPLATEW;


alias LPCDLGTEMPLATEA LPCDLGTEMPLATE;


export int DialogBoxParamA(HINSTANCE hInstance, LPCSTR lpTemplateName,
	HWND hWndParent, DLGPROC lpDialogFunc, LPARAM dwInitParam);
export int DialogBoxIndirectParamA(HINSTANCE hInstance,
	LPCDLGTEMPLATEA hDialogTemplate, HWND hWndParent, DLGPROC lpDialogFunc,
	LPARAM dwInitParam);

enum : DWORD
{
	SRCCOPY =             cast(DWORD)0x00CC0020, /* dest = source                   */
	SRCPAINT =            cast(DWORD)0x00EE0086, /* dest = source OR dest           */
	SRCAND =              cast(DWORD)0x008800C6, /* dest = source AND dest          */
	SRCINVERT =           cast(DWORD)0x00660046, /* dest = source XOR dest          */
	SRCERASE =            cast(DWORD)0x00440328, /* dest = source AND (NOT dest)   */
	NOTSRCCOPY =          cast(DWORD)0x00330008, /* dest = (NOT source)             */
	NOTSRCERASE =         cast(DWORD)0x001100A6, /* dest = (NOT src) AND (NOT dest) */
	MERGECOPY =           cast(DWORD)0x00C000CA, /* dest = (source AND pattern)     */
	MERGEPAINT =          cast(DWORD)0x00BB0226, /* dest = (NOT source) OR dest     */
	PATCOPY =             cast(DWORD)0x00F00021, /* dest = pattern                  */
	PATPAINT =            cast(DWORD)0x00FB0A09, /* dest = DPSnoo                   */
	PATINVERT =           cast(DWORD)0x005A0049, /* dest = pattern XOR dest         */
	DSTINVERT =           cast(DWORD)0x00550009, /* dest = (NOT dest)               */
	BLACKNESS =           cast(DWORD)0x00000042, /* dest = BLACK                    */
	WHITENESS =           cast(DWORD)0x00FF0062, /* dest = WHITE                    */
}

enum
{
	SND_SYNC =            0x0000, /* play synchronously (default) */
	SND_ASYNC =           0x0001, /* play asynchronously */
	SND_NODEFAULT =       0x0002, /* silence (!default) if sound not found */
	SND_MEMORY =          0x0004, /* pszSound points to a memory file */
	SND_LOOP =            0x0008, /* loop the sound until next sndPlaySound */
	SND_NOSTOP =          0x0010, /* don't stop any currently playing sound */

	SND_NOWAIT =	0x00002000, /* don't wait if the driver is busy */
	SND_ALIAS =       0x00010000, /* name is a registry alias */
	SND_ALIAS_ID =	0x00110000, /* alias is a predefined ID */
	SND_FILENAME =    0x00020000, /* name is file name */
	SND_RESOURCE =    0x00040004, /* name is resource name or atom */

	SND_PURGE =           0x0040, /* purge non-static events for task */
	SND_APPLICATION =     0x0080, /* look for application specific association */


	SND_ALIAS_START =	0,     /* alias base */
}

export  BOOL   PlaySoundA(LPCSTR pszSound, HMODULE hmod, DWORD fdwSound);
export  BOOL   PlaySoundW(LPCWSTR pszSound, HMODULE hmod, DWORD fdwSound);

export  int     GetClipBox(HDC, LPRECT);
export  int     GetClipRgn(HDC, HRGN);
export  int     GetMetaRgn(HDC, HRGN);
export  HGDIOBJ   GetCurrentObject(HDC, UINT);
export  BOOL    GetCurrentPositionEx(HDC, LPPOINT);
export  int     GetDeviceCaps(HDC, int);

struct LOGPEN
  {
    UINT        lopnStyle;
    POINT       lopnWidth;
    COLORREF    lopnColor;
}
alias LOGPEN* PLOGPEN, NPLOGPEN, LPLOGPEN;

enum
{
	PS_SOLID =            0,
	PS_DASH =             1, /* -------  */
	PS_DOT =              2, /* .......  */
	PS_DASHDOT =          3, /* _._._._  */
	PS_DASHDOTDOT =       4, /* _.._.._  */
	PS_NULL =             5,
	PS_INSIDEFRAME =      6,
	PS_USERSTYLE =        7,
	PS_ALTERNATE =        8,
	PS_STYLE_MASK =       0x0000000F,

	PS_ENDCAP_ROUND =     0x00000000,
	PS_ENDCAP_SQUARE =    0x00000100,
	PS_ENDCAP_FLAT =      0x00000200,
	PS_ENDCAP_MASK =      0x00000F00,

	PS_JOIN_ROUND =       0x00000000,
	PS_JOIN_BEVEL =       0x00001000,
	PS_JOIN_MITER =       0x00002000,
	PS_JOIN_MASK =        0x0000F000,

	PS_COSMETIC =         0x00000000,
	PS_GEOMETRIC =        0x00010000,
	PS_TYPE_MASK =        0x000F0000,
}

export  HPALETTE   CreatePalette(LOGPALETTE *);
export  HPEN      CreatePen(int, int, COLORREF);
export  HPEN      CreatePenIndirect(LOGPEN *);
export  HRGN      CreatePolyPolygonRgn(POINT *, INT *, int, int);
export  HBRUSH    CreatePatternBrush(HBITMAP);
export  HRGN      CreateRectRgn(int, int, int, int);
export  HRGN      CreateRectRgnIndirect(RECT *);
export  HRGN      CreateRoundRectRgn(int, int, int, int, int, int);
export  BOOL      CreateScalableFontResourceA(DWORD, LPCSTR, LPCSTR, LPCSTR);
export  BOOL      CreateScalableFontResourceW(DWORD, LPCWSTR, LPCWSTR, LPCWSTR);

COLORREF RGB(int r, int g, int b)
{
    return cast(COLORREF)
	((cast(BYTE)r|(cast(WORD)(cast(BYTE)g)<<8))|((cast(DWORD)cast(BYTE)b)<<16));
}

export  BOOL   LineTo(HDC, int, int);
export  BOOL   DeleteObject(HGDIOBJ);
export int FillRect(HDC hDC,  RECT *lprc, HBRUSH hbr);


export BOOL EndDialog(HWND hDlg, int nResult);
export HWND GetDlgItem(HWND hDlg, int nIDDlgItem);

export BOOL SetDlgItemInt(HWND hDlg, int nIDDlgItem, UINT uValue, BOOL bSigned);
export UINT GetDlgItemInt(HWND hDlg, int nIDDlgItem, BOOL *lpTranslated,
    BOOL bSigned);

export BOOL SetDlgItemTextA(HWND hDlg, int nIDDlgItem, LPCSTR lpString);
export BOOL SetDlgItemTextW(HWND hDlg, int nIDDlgItem, LPCWSTR lpString);

export UINT GetDlgItemTextA(HWND hDlg, int nIDDlgItem, LPSTR lpString, int nMaxCount);
export UINT GetDlgItemTextW(HWND hDlg, int nIDDlgItem, LPWSTR lpString, int nMaxCount);

export BOOL CheckDlgButton(HWND hDlg, int nIDButton, UINT uCheck);
export BOOL CheckRadioButton(HWND hDlg, int nIDFirstButton, int nIDLastButton,
    int nIDCheckButton);

export UINT IsDlgButtonChecked(HWND hDlg, int nIDButton);

export HWND SetFocus(HWND hWnd);

export int wsprintfA(LPSTR, LPCSTR, ...);
export int wsprintfW(LPWSTR, LPCWSTR, ...);

struct SIZE {
  LONG cx; 
  LONG cy;
}

alias SIZE*   PSIZE, NPSIZE, LPSIZE;

struct MENUITEMINFOA {
	UINT cbSize;
	UINT fMask;
	UINT fType;
	UINT fState;
	UINT wID;
	HMENU hSubMenu;
	HBITMAP hbmpChecked;
	HBITMAP hbmpUnchecked;
	DWORD dwItemData;
	LPSTR dwTypeData;
	UINT cch;
// #if (_WIN32_WINNT >= 0x0500)
	HBITMAP hbmpItem;
// #endif
}

alias MENUITEMINFOA* LPMENUITEMINFOA, LPCMENUITEMINFOA;

struct MENUITEMINFOW {
	UINT cbSize;
	UINT fMask;
	UINT fType;
	UINT fState;
	UINT wID;
	HMENU hSubMenu;
	HBITMAP hbmpChecked;
	HBITMAP hbmpUnchecked;
	DWORD dwItemData;
	LPWSTR dwTypeData;
	UINT cch;
// #if (_WIN32_WINNT >= 0x0500)
	HBITMAP hbmpItem;
// #endif
}

alias MENUITEMINFOW* LPMENUITEMINFOW, LPCMENUITEMINFOW;

struct NMHDR {
	HWND hwndFrom;
	UINT idFrom;
	UINT code;
} 

alias NMHDR* LPNMHDR, LPCNMHDR;

struct CREATESTRUCTA {
	LPVOID	lpCreateParams;
	HINSTANCE	hInstance;
	HMENU	hMenu;
	HWND	hwndParent;
	int	cy;
	int	cx;
	int	y;
	int	x;
	LONG	style;
	LPCSTR	lpszName;
	LPCSTR	lpszClass;
	DWORD	dwExStyle;
} 

//alias CREATESTRUCTA  CREATESTRUCT;
alias CREATESTRUCTA* LPCREATESTRUCTA;

struct CREATESTRUCTW {
	LPVOID	lpCreateParams;
	HINSTANCE	hInstance;
	HMENU	hMenu;
	HWND	hwndParent;
	int	cy;
	int	cx;
	int	y;
	int	x;
	LONG	style;
	LPWSTR	lpszName;
	LPWSTR	lpszClass;
	DWORD	dwExStyle;
} 

alias CREATESTRUCTW  CREATESTRUCT;
alias CREATESTRUCTW* LPCREATESTRUCTW;

struct SCROLLINFO {
	UINT cbSize;
	UINT fMask;
	int nMin;
	int nMax;
	UINT nPage;
	int nPos;
	int nTrackPos;
} 

alias SCROLLINFO* LPSCROLLINFO, LPCSCROLLINFO;

alias PULONG    ULONG_PTR;

struct MENUINFO {
	DWORD      cbSize;
	DWORD      fMask;
	DWORD      dwStyle;
	UINT       cyMax;
	HBRUSH     hbrBack;
	DWORD      dwContextHelpID;
	ULONG_PTR  dwMenuData;
} 

alias MENUINFO* LPMENUINFO, LPCMENUINFO;

enum {
  CCHILDREN_SCROLLBAR = 5
}

struct SCROLLBARINFO {
	DWORD cbSize;
	RECT  rcScrollBar;
	int   dxyLineButton;
	int   xyThumbTop;
	int   xyThumbBottom;
	int   reserved;
	DWORD rgstate[CCHILDREN_SCROLLBAR+1];
} 

alias SCROLLBARINFO* PSCROLLBARINFO, LPSCROLLBARINFO, LPCSCROLLBARINFO;

enum {
  CCHILDREN_TITLEBAR = 5
}

struct TITLEBARINFO {
	DWORD cbSize;
	RECT  rcTitleBar;
	DWORD rgstate[CCHILDREN_TITLEBAR+1];
} 

alias TITLEBARINFO* PTITLEBARINFO, LPTITLEBARINFO, LPCTITLEBARINFO;

struct WINDOWINFO {
	DWORD cbSize;
	RECT  rcWindow;
	RECT  rcClient;
	DWORD dwStyle;
	DWORD dwExStyle;
	DWORD dwWindowStatus;
	UINT  cxWindowBorders;
	UINT  cyWindowBorders;
	ATOM  atomWindowType;
	WORD  wCreatorVersion;
} 

alias WINDOWINFO* PWINDOWINFO, LPWINDOWINFO, LPCWINDOWINFO;

struct LASTINPUTINFO {
	UINT cbSize;
	DWORD dwTime;
}

alias LASTINPUTINFO* PLASTINPUTINFO, LPLASTINPUTINFO, LPCLASTINPUTINFO;

struct MONITORINFO {
	DWORD cbSize;
	RECT rcMonitor;
	RECT rcWork;
	DWORD dwFlags;
} 

alias MONITORINFO* LPMONITORINFO, LPCMONITORINFO;

enum {
 CCHDEVICENAME = 32
}

struct MONITORINFOEXA {
	DWORD	cbSize;
	RECT	rcMonitor;
	RECT	rcWork;
	DWORD	dwFlags;
	CHAR	szDevice[CCHDEVICENAME];
} 

alias MONITORINFOEXA* LPMONITORINFOEXA, LPCMONITORINFOEXA;

struct MONITORINFOEXW {
	DWORD	cbSize;
	RECT	rcMonitor;
	RECT	rcWork;
	DWORD	dwFlags;
	WCHAR	szDevice[CCHDEVICENAME];
}

alias MONITORINFOEXW* LPMONITORINFOEXW, LPCMONITORINFOEXW;

struct KBDLLHOOKSTRUCT {
	DWORD vkCode;
	DWORD scanCode;
	DWORD flags;
	DWORD time;
	DWORD dwExtraInfo;
} 

alias KBDLLHOOKSTRUCT* LPKBDLLHOOKSTRUCT, PKBDLLHOOKSTRUCT, LPCKBDLLHOOKSTRUCT;
//#if (_WIN32_WINNT >= 0x0500 || _WIN32_WINDOWS >= 0x0410)
struct FLASHWINFO {
  UINT  cbSize;
  HWND  hwnd;
  DWORD dwFlags;
  UINT  uCount;
  DWORD dwTimeout;
} 

alias FLASHWINFO* PFLASHWINFO, LPFLASHWINFO, LPCFLASHWINFO;
//#endif /* (WINVER >= 0x0500 || _WIN32_WINDOWS >= 0x0410) */
//#if (_WIN32_WINNT >= 0x0500 || _WIN32_WINDOWS >= 0x0490)
struct MOUSEMOVEPOINT {
  int x;
  int y;
  DWORD time;
  ULONG_PTR dwExtraInfo;
} 

alias MOUSEMOVEPOINT* PMOUSEMOVEPOINT, LPMOUSEMOVEPOINT, LPCMOUSEMOVEPOINT;
//#endif
//#if (_WIN32_WINNT >= 0x0403)
struct MOUSEINPUT {
  LONG dx;
  LONG dy;
  DWORD mouseData;
  DWORD dwFlags;
  DWORD time;
  ULONG_PTR dwExtraInfo;
} 

alias MOUSEINPUT* PMOUSEINPUT, LPMOUSEINPUT, LPCMOUSEINPUT;

struct KEYBDINPUT {
  WORD wVk;
  WORD wScan;
  DWORD dwFlags;
  DWORD time;
  ULONG_PTR dwExtraInfo;
}

alias KEYBDINPUT* PKEYBDINPUT, LPKEYBDINPUT, LPCKEYBDINPUT;

struct HARDWAREINPUT {
  DWORD uMsg;
  WORD wParamL;
  WORD wParamH;
}

alias HARDWAREINPUT* PHARDWAREINPUT, LPHARDWAREINPUT, LPCHARDWAREINPUT;

struct INPUT {
  DWORD type;
  union {
		MOUSEINPUT mi;
		KEYBDINPUT ki;
		HARDWAREINPUT hi;
  };
} 

alias INPUT* PINPUT, LPINPUT, LPCINPUT;

enum {
 OPAQUE = 2,
 TRANSPARENT = 1,
 BLACKONWHITE = 1,
 WHITEONBLACK =2,
 COLORONCOLOR =3,
 HALFTONE =4,
 MAXSTRETCHBLTMODE = 4,
 STRETCH_ANDSCANS  = 1,
 STRETCH_DELETESCANS = 3,
 STRETCH_HALFTONE = 4,
 STRETCH_ORSCANS =2,
 TCI_SRCCHARSET = 1,
 TCI_SRCCODEPAGE =2,
 TCI_SRCFONTSIG = 3,
 ICM_ON =2,
 ICM_OFF =1,
 ICM_QUERY =3,

 BDR_RAISEDOUTER	= 1,
 BDR_SUNKENOUTER	= 2,
 BDR_RAISEDINNER	= 4,
 BDR_SUNKENINNER	= 8,
 BDR_OUTER	= 3,
 BDR_INNER	= 0xc,
 BDR_RAISED	= 5,
 BDR_SUNKEN	= 10,
 EDGE_RAISED	= 5,
 EDGE_SUNKEN	= 10,
 EDGE_ETCHED	= 6,
 EDGE_BUMP	= 9,

}

enum {

/* BM_CLICK=245,
 BM_GETCHECK=240,
 BM_GETIMAGE=246,
 BM_GETSTATE=242,
 BM_SETCHECK=241,
 BM_SETIMAGE=247,
 BM_SETSTATE=243,
 BM_SETSTYLE=244,
 BN_CLICKED=0,
 BN_DBLCLK=5,
 BN_DISABLE=4,
 BN_DOUBLECLICKED=5,
 BN_HILITE=2,
 BN_KILLFOCUS=7,
 BN_PAINT=1,
 BN_PUSHED=2,
 BN_SETFOCUS=6,
 BN_UNHILITE=3,
 BN_UNPUSHED=3,*/
 CB_ERR=(-1),
 CB_ADDSTRING=323,
 CB_DELETESTRING=324,
 CB_DIR=325,
 CB_FINDSTRING=332,
 CB_FINDSTRINGEXACT=344,
 CB_GETCOUNT=326,
 CB_GETCURSEL=327,
 CB_GETDROPPEDCONTROLRECT=338,
 CB_GETDROPPEDSTATE=343,
 CB_GETDROPPEDWIDTH=351,
 CB_GETEDITSEL=320,
 CB_GETEXTENDEDUI=342,
 CB_GETHORIZONTALEXTENT=349,
 CB_GETITEMDATA=336,
 CB_GETITEMHEIGHT=340,
 CB_GETLBTEXT=328,
 CB_GETLBTEXTLEN=329,
 CB_GETLOCALE=346,
 CB_GETTOPINDEX=347,
 CB_INITSTORAGE=353,
 CB_INSERTSTRING=330,
 CB_LIMITTEXT=321,
 CB_RESETCONTENT=331,
 CB_SELECTSTRING=333,
 CB_SETCURSEL=334,
 CB_SETDROPPEDWIDTH=352,
 CB_SETEDITSEL=322,
 CB_SETEXTENDEDUI=341,
 CB_SETHORIZONTALEXTENT=350,
 CB_SETITEMDATA=337,
 CB_SETITEMHEIGHT=339,
 CB_SETLOCALE=345,
 CB_SETTOPINDEX=348,
 CB_SHOWDROPDOWN=335,
 CBN_CLOSEUP=8,
 CBN_DBLCLK=2,
 CBN_DROPDOWN=7,
 CBN_EDITCHANGE=5,
 CBN_EDITUPDATE=6,
 CBN_ERRSPACE = (-1),
 CBN_KILLFOCUS=4,
 CBN_SELCHANGE=1,
 CBN_SELENDCANCEL=10,
 CBN_SELENDOK=9,
 CBN_SETFOCUS=3,
 /*EM_CANUNDO=198,
 EM_CHARFROMPOS=215,
 EM_EMPTYUNDOBUFFER=205,
 EM_FMTLINES=200,
 EM_GETFIRSTVISIBLELINE=206,
 EM_GETHANDLE=189,
 EM_GETLIMITTEXT=213,
 EM_GETLINE=196,
 EM_GETLINECOUNT=186,
 EM_GETMARGINS=212,
 EM_GETMODIFY=184,
 EM_GETPASSWORDCHAR=210,
 EM_GETRECT=178,
 EM_GETSEL=176,
 EM_GETTHUMB=190,
 EM_GETWORDBREAKPROC=209,
 EM_LIMITTEXT=197,
 EM_LINEFROMCHAR=201,
 EM_LINEINDEX=187,
 EM_LINELENGTH=193,
 EM_LINESCROLL=182,
 EM_POSFROMCHAR=214,
 EM_REPLACESEL=194,
 EM_SCROLL=181,
 EM_SCROLLCARET=183,
 EM_SETHANDLE=188,
 EM_SETLIMITTEXT=197,
 EM_SETMARGINS=211,
 EM_SETMODIFY=185,
 EM_SETPASSWORDCHAR=204,
 EM_SETREADONLY=207,
 EM_SETRECT=179,
 EM_SETRECTNP=180,
 EM_SETSEL=177,
 EM_SETTABSTOPS=203,
 EM_SETWORDBREAKPROC=208,
 EM_UNDO=199,
 EN_CHANGE=768,
 EN_ERRSPACE=1280,
 EN_HSCROLL=1537,
 EN_KILLFOCUS=512,
 EN_MAXTEXT=1281,
 EN_SETFOCUS=256,
 EN_UPDATE=1024,
 EN_VSCROLL=1538,*/
 LB_ERR=(-1),
 LB_ADDFILE=406,
 LB_ADDSTRING=384,
 LB_DELETESTRING=386,
 LB_DIR=397,
 LB_FINDSTRING=399,
 LB_FINDSTRINGEXACT=418,
 LB_GETANCHORINDEX=413,
 LB_GETCARETINDEX=415,
 LB_GETCOUNT=395,
 LB_GETCURSEL=392,
 LB_GETHORIZONTALEXTENT=403,
 LB_GETITEMDATA=409,
 LB_GETITEMHEIGHT=417,
 LB_GETITEMRECT=408,
 LB_GETLOCALE=422,
 LB_GETSEL=391,
 LB_GETSELCOUNT=400,
 LB_GETSELITEMS=401,
 LB_GETTEXT=393,
 LB_GETTEXTLEN=394,
 LB_GETTOPINDEX=398,
 LB_INITSTORAGE=424,
 LB_INSERTSTRING=385,
 LB_ITEMFROMPOINT=425,
 LB_RESETCONTENT=388,
 LB_SELECTSTRING=396,
 LB_SELITEMRANGE=411,
 LB_SELITEMRANGEEX=387,
 LB_SETANCHORINDEX=412,
 LB_SETCARETINDEX=414,
 LB_SETCOLUMNWIDTH=405,
 LB_SETCOUNT=423,
 LB_SETCURSEL=390,
 LB_SETHORIZONTALEXTENT=404,
 LB_SETITEMDATA=410,
 LB_SETITEMHEIGHT=416,
 LB_SETLOCALE=421,
 LB_SETSEL=389,
 LB_SETTABSTOPS=402,
 LB_SETTOPINDEX=407,
 LBN_DBLCLK=2,
 LBN_ERRSPACE =(-2),
 LBN_KILLFOCUS=5,
 LBN_SELCANCEL=3,
 LBN_SELCHANGE=1,
 LBN_SETFOCUS=4,
/* SBM_ENABLE_ARROWS=228,
 SBM_GETPOS=225,
 SBM_GETRANGE=227,
 SBM_GETSCROLLINFO=234,
 SBM_SETPOS=224,
 SBM_SETRANGE=226,
 SBM_SETRANGEREDRAW=230,
 SBM_SETSCROLLINFO=233,
 STM_GETICON=369,
 STM_GETIMAGE=371,
 STM_SETICON=368,
 STM_SETIMAGE=370,
 STN_CLICKED=0,
 STN_DBLCLK=1,
 STN_DISABLE=3,
 STN_ENABLE=2,*/
 DM_GETDEFID = WM_USER,
 DM_SETDEFID = (WM_USER+1),
 DM_REPOSITION = (WM_USER+2),
 PSM_PAGEINFO = (WM_USER+100),
 PSM_SHEETINFO = (WM_USER+101),
 PSI_SETACTIVE=1,
 PSI_KILLACTIVE=2,
 PSI_APPLY=3,
 PSI_RESET=4,
 PSI_HASHELP=5,
 PSI_HELP=6,
 PSI_CHANGED=1,
 PSI_GUISTART=2,
 PSI_REBOOT=3,
 PSI_GETSIBLINGS=4,
 /*DCX_WINDOW=1,
 DCX_CACHE=2,
 DCX_PARENTCLIP=32,
 DCX_CLIPSIBLINGS=16,
 DCX_CLIPCHILDREN=8,
 DCX_NORESETATTRS=4,
 DCX_LOCKWINDOWUPDATE=0x400,
 DCX_EXCLUDERGN=64,
 DCX_INTERSECTRGN=128,
 DCX_VALIDATE=0x200000,*/
 GMDI_GOINTOPOPUPS=2,
 GMDI_USEDISABLED=1,
 FKF_AVAILABLE=2,
 FKF_CLICKON=64,
 FKF_FILTERKEYSON=1,
 FKF_HOTKEYACTIVE=4,
 FKF_HOTKEYSOUND=16,
 FKF_CONFIRMHOTKEY=8,
 FKF_INDICATOR=32,
 HCF_HIGHCONTRASTON=1,
 HCF_AVAILABLE=2,
 HCF_HOTKEYACTIVE=4,
 HCF_CONFIRMHOTKEY=8,
 HCF_HOTKEYSOUND=16,
 HCF_INDICATOR=32,
 HCF_HOTKEYAVAILABLE=64,
 MKF_AVAILABLE=2,
 MKF_CONFIRMHOTKEY=8,
 MKF_HOTKEYACTIVE=4,
 MKF_HOTKEYSOUND=16,
 MKF_INDICATOR=32,
 MKF_MOUSEKEYSON=1,
 MKF_MODIFIERS=64,
 MKF_REPLACENUMBERS=128,
 SERKF_ACTIVE=8, /* May be obsolete. Not in recent MS docs. */
 SERKF_AVAILABLE=2,
 SERKF_INDICATOR=4,
 SERKF_SERIALKEYSON=1,
 SSF_AVAILABLE=2,
 SSF_SOUNDSENTRYON=1,
 SSTF_BORDER=2,
 SSTF_CHARS=1,
 SSTF_DISPLAY=3,
 SSTF_NONE=0,
 SSGF_DISPLAY=3,
 SSGF_NONE=0,
 SSWF_CUSTOM=4,
 SSWF_DISPLAY=3,
 SSWF_NONE=0,
 SSWF_TITLE=1,
 SSWF_WINDOW=2,
 SKF_AUDIBLEFEEDBACK=64,
 SKF_AVAILABLE=2,
 SKF_CONFIRMHOTKEY=8,
 SKF_HOTKEYACTIVE=4,
 SKF_HOTKEYSOUND=16,
 SKF_INDICATOR=32,
 SKF_STICKYKEYSON=1,
 SKF_TRISTATE=128,
 SKF_TWOKEYSOFF=256,
 TKF_AVAILABLE=2,
 TKF_CONFIRMHOTKEY=8,
 TKF_HOTKEYACTIVE=4,
 TKF_HOTKEYSOUND=16,
 TKF_TOGGLEKEYSON=1,
 MDITILE_SKIPDISABLED=2,
 MDITILE_HORIZONTAL=1,
 MDITILE_VERTICAL=0,
}

enum {
  MIIM_STATE=1,
  MIIM_ID=2,
  MIIM_SUBMENU=4,
  MIIM_CHECKMARKS=8,
  MIIM_TYPE=16,
  MIIM_DATA=32,
  MIIM_STRING=64,
  MIIM_BITMAP=128,
  MIIM_FTYPE=256,
  MIM_MAXHEIGHT=1,
  MIM_BACKGROUND=2,
  MIM_HELPID=4,
  MIM_MENUDATA=8,
  MIM_STYLE=16,
  MIM_APPLYTOSUBMENUS=0x80000000,
  MFT_BITMAP=4,
  MFT_MENUBARBREAK=32,
  MFT_MENUBREAK=64,
  MFT_OWNERDRAW=256,
  MFT_RADIOCHECK=512,
  MFT_RIGHTJUSTIFY=0x4000,
  MFT_SEPARATOR=0x800,
  MFT_RIGHTORDER=0x2000L,
  MFT_STRING=0,
  MFS_CHECKED=8,
  MFS_DEFAULT=4096,
  MFS_DISABLED=3,
  MFS_ENABLED=0,
  MFS_GRAYED=3,
  MFS_HILITE=128,
  MFS_UNCHECKED=0,
  MFS_UNHILITE=0,
  MNS_NOTIFYBYPOS=0x8000000,
}

//#ifndef WM_MENUCOMMAND


enum : uint {
WS_EX_ACCEPTFILES=16,
WS_EX_APPWINDOW=0x40000,
WS_EX_CLIENTEDGE=512,
WS_EX_COMPOSITED=0x2000000, /*=XP=*/
WS_EX_CONTEXTHELP=0x400,
WS_EX_CONTROLPARENT=0x10000,
WS_EX_DLGMODALFRAME=1,
WS_EX_LAYERED=0x80000, /*=w2k=*/
WS_EX_LAYOUTRTL=0x400000, /*=w98,=w2k=*/
WS_EX_LEFT=0,
WS_EX_LEFTSCROLLBAR=0x4000,
WS_EX_LTRREADING=0,
WS_EX_MDICHILD=64,
WS_EX_NOACTIVATE=0x8000000, /*=w2k=*/
WS_EX_NOINHERITLAYOUT=0x100000, /*=w2k=*/
WS_EX_NOPARENTNOTIFY=4,
WS_EX_OVERLAPPEDWINDOW=0x300,
WS_EX_PALETTEWINDOW=0x188,
WS_EX_RIGHT=0x1000,
WS_EX_RIGHTSCROLLBAR=0,
WS_EX_RTLREADING=0x2000,
WS_EX_STATICEDGE=0x20000,
WS_EX_TOOLWINDOW=128,
WS_EX_TOPMOST=8,
WS_EX_TRANSPARENT=32,
WS_EX_WINDOWEDGE=256
}


enum {
  GWL_EXSTYLE=(-20),
  GWL_STYLE=(-16),
  GWL_WNDPROC=(-4),
  GWLP_WNDPROC=(-4),
  GWL_HINSTANCE=(-6),
  GWLP_HINSTANCE=(-6),
  GWL_HWNDPARENT=(-8),
  GWLP_HWNDPARENT=(-8),
  GWL_ID=(-12),
  GWLP_ID=(-12),
  GWL_USERDATA=(-21),
  GWLP_USERDATA=(-21),
}

enum{
  SIF_ALL=23,
  SIF_PAGE=2,
  SIF_POS=4,
  SIF_RANGE=1,
  SIF_DISABLENOSCROLL=8,
  SIF_TRACKPOS=16,
}

enum : uint {
  SWP_DRAWFRAME=32,
  SWP_FRAMECHANGED=32,
  SWP_HIDEWINDOW=128,
  SWP_NOACTIVATE=16,
  SWP_NOCOPYBITS=256,
  SWP_NOMOVE=2,
  SWP_NOSIZE=1,
  SWP_NOREDRAW=8,
  SWP_NOZORDER=4,
  SWP_SHOWWINDOW=64,
  SWP_NOOWNERZORDER=512,
  SWP_NOREPOSITION=512,
  SWP_NOSENDCHANGING=1024,
  SWP_DEFERERASE=8192,
  SWP_ASYNCWINDOWPOS=16384,
}

enum {
  BF_LEFT=1,
  BF_TOP=2,
  BF_RIGHT=4,
  BF_BOTTOM=8,
  BF_TOPLEFT=(BF_TOP|BF_LEFT),
  BF_TOPRIGHT=(BF_TOP|BF_RIGHT),
  BF_BOTTOMLEFT=(BF_BOTTOM|BF_LEFT),
  BF_BOTTOMRIGHT=(BF_BOTTOM|BF_RIGHT),
  BF_RECT=(BF_LEFT|BF_TOP|BF_RIGHT|BF_BOTTOM),
  BF_DIAGONAL=16,
  BF_DIAGONAL_ENDTOPRIGHT=(BF_DIAGONAL|BF_TOP|BF_RIGHT),
  BF_DIAGONAL_ENDTOPLEFT=(BF_DIAGONAL|BF_TOP|BF_LEFT),
  BF_DIAGONAL_ENDBOTTOMLEFT=(BF_DIAGONAL|BF_BOTTOM|BF_LEFT),
  BF_DIAGONAL_ENDBOTTOMRIGHT=(BF_DIAGONAL|BF_BOTTOM|BF_RIGHT),
  BF_MIDDLE=0x800,
  BF_SOFT=0x1000,
  BF_ADJUST=0x2000,
  BF_FLAT=0x4000,
  BF_MONO=0x8000
}

enum {
  GW_HWNDNEXT=2,
  GW_HWNDPREV=3,
  GW_CHILD=5,
  GW_HWNDFIRST=0,
  GW_HWNDLAST=1,
  GW_OWNER=4,
}

export {
HWND  SetActiveWindow(HWND);
HWND  SetCapture(HWND hWnd);
BOOL  SetCaretBlinkTime(UINT);
//BOOL  SetCaretPos(int,int);
DWORD  SetClassLongA(HWND,int,LONG);
DWORD  SetClassLongW(HWND,int,LONG);
WORD  SetClassWord(HWND,int,WORD);
HANDLE  SetClipboardData(UINT,HANDLE);
HWND  SetClipboardViewer(HWND);
HCURSOR  SetCursor(HCURSOR);
//BOOL  SetCursorPos(int,int);
VOID  SetDebugErrorLevel(DWORD);
BOOL  SetDlgItemInt(HWND,int,UINT,BOOL);
BOOL  SetDlgItemTextA(HWND,int,LPCSTR);
//BOOL  SetDlgItemTextW(HWND,int,LPCWSTR);
BOOL  SetDoubleClickTime(UINT);
//HWND  SetFocus(HWND);
BOOL  SetForegroundWindow(HWND);
BOOL  SetKeyboardState(PBYTE);
BOOL  SetMenu(HWND,HMENU);
BOOL  SetMenuContextHelpId(HMENU,DWORD);
BOOL  SetMenuDefaultItem(HMENU,UINT,UINT);
BOOL  SetMenuInfo(HMENU,LPCMENUINFO);
BOOL  SetMenuItemBitmaps(HMENU,UINT,UINT,HBITMAP,HBITMAP);
BOOL  SetMenuItemInfoA(HMENU,UINT,BOOL,LPCMENUITEMINFOA);
// BOOL  SetMenuItemInfoW( HMENU,UINT,BOOL,LPCMENUITEMINFOW);
LPARAM  SetMessageExtraInfo(LPARAM);
BOOL  SetMessageQueue(int);
HWND  SetParent(HWND,HWND);
// //#if (_WIN32_WINNT >= 0x0500)
BOOL  SetProcessDefaultLayout(DWORD);
// //#endif /* (_WIN32_WINNT >= 0x0500) */
//BOOL  SetProcessWindowStation(HWINSTA);
BOOL  SetPropA(HWND,LPCSTR,HANDLE);
//BOOL  SetPropW(HWND,LPCWSTR,HANDLE);
BOOL  SetRect(LPRECT,int,int,int,int);
BOOL  SetRectEmpty(LPRECT);
int  SetScrollInfo(HWND,int,LPCSCROLLINFO,BOOL);
int  SetScrollPos(HWND,int,int,BOOL);
BOOL  SetScrollRange(HWND,int,int,int,BOOL);
BOOL  SetSysColors(int, INT *, COLORREF *);
// //const char[] SetSysModalWindow(h) (NULL)
BOOL  SetSystemCursor(HCURSOR,DWORD);
BOOL  SetThreadDesktop(HDESK);
UINT  SetTimer(HWND,UINT,UINT,TIMERPROC);
BOOL  SetUserObjectInformationA(HANDLE,int,PVOID,DWORD);
BOOL  SetUserObjectInformationW(HANDLE,int,PVOID,DWORD);
// BOOL  SetUserObjectSecurity(HANDLE,PSECURITY_INFORMATION,PSECURITY_DESCRIPTOR);
////#if (WINVER >= 0x0500)
//HWINEVENTHOOK  SetWinEventHook(UINT,UINT,HMODULE,WINEVENTPROC,DWORD,DWORD,UINT);
////#endif
BOOL  SetWindowContextHelpId(HWND,DWORD);
LONG  SetWindowLongA(HWND,int,LONG);
LONG  SetWindowLongW(HWND,int,LONG);
/*//#ifdef _WIN64
LONG_PTR  SetWindowLongPtrA(HWND,int,LONG_PTR);
LONG_PTR  SetWindowLongPtrW(HWND,int,LONG_PTR);
//#else
//const char[] SetWindowLongPtrA SetWindowLongA
//const char[] SetWindowLongPtrW SetWindowLongW
//#endif*/
//BOOL  SetWindowPlacement(HWND hWnd,const WINDOWPLACEMENT*);
BOOL  SetWindowPos(HWND,HWND,int,int,int,int,UINT);
int  SetWindowRgn(HWND,HRGN,BOOL);
//HOOKPROC  SetWindowsHookA(int,HOOKPROC);
// HHOOK  SetWindowsHookExA(int,HOOKPROC,HINSTANCE,DWORD);
// HHOOK  SetWindowsHookExW(int,HOOKPROC,HINSTANCE,DWORD);
BOOL  SetWindowTextA(HWND,LPCSTR);
BOOL  SetWindowTextW(HWND,LPCWSTR);
WORD  SetWindowWord(HWND,int,WORD);
BOOL  ShowCaret(HWND);
int  ShowCursor(BOOL);
BOOL  ShowOwnedPopups(HWND,BOOL);
BOOL  ShowScrollBar(HWND,int,BOOL);
//BOOL  ShowWindow(HWND,int);
BOOL  ShowWindowAsync(HWND,int);
BOOL  SubtractRect(LPRECT,LPCRECT,LPCRECT);
BOOL  SwapMouseButton(BOOL);
//BOOL  SwitchDesktop(HDESK);


HWND GetActiveWindow();
HWND GetAncestor(HWND,UINT);
SHORT GetAsyncKeyState(int);
HWND GetCapture();
//UINT GetCaretBlinkTime();
BOOL GetCaretPos(LPPOINT);
BOOL GetClassInfoA(HINSTANCE,LPCSTR,LPWNDCLASSA);
BOOL GetClassInfoExA(HINSTANCE,LPCSTR,LPWNDCLASSEXA);
BOOL GetClassInfoW(HINSTANCE,LPCWSTR,LPWNDCLASSW);
BOOL GetClassInfoExW(HINSTANCE,LPCWSTR,LPWNDCLASSEXW);
DWORD GetClassLongA(HWND,int);
DWORD GetClassLongW(HWND,int);
int GetClassNameA(HWND,LPSTR,int);
int GetClassNameW(HWND,LPWSTR,int);
WORD GetClassWord(HWND,int);
//BOOL GetClientRect(HWND,LPRECT);
HANDLE GetClipboardData(UINT);
int GetClipboardFormatNameA(UINT,LPSTR,int);
int GetClipboardFormatNameW(UINT,LPWSTR,int);
HWND GetClipboardOwner();
////#if (_WIN32_WINNT >= 0x0500 || _WIN32_WINDOWS >= 0x0410)
DWORD GetClipboardSequenceNumber();
////#endif
HWND GetClipboardViewer();
BOOL GetClipCursor(LPRECT);
BOOL GetCursorPos(LPPOINT);
//HDC GetDC(HWND);
HDC GetDCEx(HWND,HRGN,DWORD);
HWND GetDesktopWindow();
long GetDialogBaseUnits();
int GetDlgCtrlID(HWND);
HWND GetDlgItem(HWND,int);
UINT GetDlgItemInt(HWND,int,PBOOL,BOOL);
UINT GetDlgItemTextA(HWND,int,LPSTR,int);
//UINT GetDlgItemTextW(HWND,int,LPWSTR,int);
UINT GetDoubleClickTime();
//HWND GetFocus();
//HWND GetForegroundWindow();
////#if (_WIN32_WINNT >= 0x0500)
DWORD GetGuiResources(HANDLE,DWORD);
////#endif
//BOOL GetIconInfo(HICON,PICONINFO);
BOOL GetInputState();
UINT GetKBCodePage();
HKL GetKeyboardLayout(DWORD);
UINT GetKeyboardLayoutList(int,HKL*);
BOOL GetKeyboardLayoutNameA(LPSTR);
//BOOL GetKeyboardLayoutNameW(LPWSTR);
BOOL GetKeyboardState(PBYTE);
int GetKeyboardType(int);
int GetKeyNameTextA(LONG,LPSTR,int);
//int GetKeyNameTextW(LONG,LPWSTR,int);
SHORT GetKeyState(int);
HWND GetLastActivePopup(HWND);
//DWORD GetLastError();
HMENU GetMenu(HWND);
LONG GetMenuCheckMarkDimensions();
DWORD GetMenuContextHelpId(HMENU);
UINT GetMenuDefaultItem(HMENU,UINT,UINT);
int GetMenuItemCount(HMENU);
UINT GetMenuItemID(HMENU,int);
BOOL GetMenuItemInfoA(HMENU,UINT,BOOL,LPMENUITEMINFOA);
// BOOL GetMenuItemInfoW(HMENU,UINT,BOOL,LPMENUITEMINFOW);
BOOL GetMenuItemRect(HWND,HMENU,UINT,LPRECT);
UINT GetMenuState(HMENU,UINT,UINT);
int GetMenuStringA(HMENU,UINT,LPSTR,int,UINT);
// int GetMenuStringW(HMENU,UINT,LPWSTR,int,UINT);
/*BOOL GetMessageA(LPMSG,HWND,UINT,UINT);
BOOL GetMessageW(LPMSG,HWND,UINT,UINT);*/
LONG GetMessageExtraInfo();
DWORD GetMessagePos();
LONG GetMessageTime();
////#if (_WIN32_WINNT >= 0x0500 || _WIN32_WINDOWS >= 0x0490)
//int GetMouseMovePointsEx(UINT,LPMOUSEMOVEPOINT,LPMOUSEMOVEPOINT,int,DWORD);
////#endif
HWND GetNextDlgGroupItem(HWND,HWND,BOOL);
HWND GetNextDlgTabItem(HWND,HWND,BOOL);
////const char[] GetNextWindow(h,c) GetWindow(h,c)
HWND GetOpenClipboardWindow();
HWND GetParent(HWND);
int GetPriorityClipboardFormat(UINT*,int);
HANDLE GetPropA(HWND,LPCSTR);
//HANDLE GetPropW(HWND,LPCWSTR);
////#if (_WIN32_WINNT >= 0x0501)
/*UINT GetRawInputBuffer(PRAWINPUT,PUINT,UINT);
UINT GetRawInputData(HRAWINPUT,UINT,LPVOID,PUINT,UINT);
UINT GetRawInputDeviceInfoA(HANDLE,UINT,LPVOID,PUINT);
UINT GetRawInputDeviceInfoW(HANDLE,UINT,LPVOID,PUINT);
UINT GetRawInputDeviceList(PRAWINPUTDEVICELIST,PUINT,UINT);
UINT GetRegisteredRawInputDevices(PRAWINPUTDEVICE,PUINT,UINT);*/
////#endif
DWORD GetQueueStatus(UINT);
BOOL GetScrollInfo(HWND,int,LPSCROLLINFO);
int GetScrollPos(HWND,int);
BOOL GetScrollRange(HWND,int,LPINT,LPINT);
////#if (_WIN32_WINNT >= 0x0500)
HWND GetShellWindow();
////#endif
HMENU GetSubMenu(HMENU,int);
DWORD GetSysColor(int);
HBRUSH GetSysColorBrush(int);
////const char[] GetSysModalWindow() (NULL)
HMENU GetSystemMenu(HWND,BOOL);
int GetSystemMetrics(int);
DWORD GetTabbedTextExtentA(HDC,LPCSTR,int,int,LPINT);
// DWORD GetTabbedTextExtentW(HDC,LPCWSTR,int,int,LPINT);
LONG GetWindowLongA(HWND,int);
LONG GetWindowLongW(HWND,int);
////#ifdef _WIN64
//LONG_PTR GetWindowLongPtrA(HWND,int);
//LONG_PTR GetWindowLongPtrW(HWND,int);
////#else
////const char[] GetWindowLongPtrA GetWindowLongA
////const char[] GetWindowLongPtrW GetWindowLongW
////#endif
HDESK GetThreadDesktop(DWORD);
HWND GetTopWindow(HWND);
BOOL GetUpdateRect(HWND,LPRECT,BOOL);
int GetUpdateRgn(HWND,HRGN,BOOL);
BOOL GetUserObjectInformationA(HANDLE,int,PVOID,DWORD,PDWORD);
BOOL GetUserObjectInformationW(HANDLE,int,PVOID,DWORD,PDWORD);
//BOOL GetUserObjectSecurity(HANDLE,PSECURITY_INFORMATION,PSECURITY_DESCRIPTOR,DWORD,PDWORD);
HWND GetWindow(HWND,UINT);
DWORD GetWindowContextHelpId(HWND);
//HDC GetWindowDC(HWND);
BOOL GetWindowExtEx(HDC,LPSIZE);
// BOOL GetWindowPlacement(HWND,WINDOWPLACEMENT*);
//BOOL GetWindowRect(HWND,LPRECT);
int GetWindowRgn(HWND,HRGN);
////const char[] GetWindowTask(hWnd) ((HANDLE)GetWindowThreadProcessId(hWnd, NULL))
int GetWindowTextA(HWND,LPSTR,int);
int GetWindowTextW(HWND,LPWSTR,int);
int GetWindowTextLengthA(HWND);
int GetWindowTextLengthW(HWND);
WORD GetWindowWord(HWND,int);
/*BOOL GetAltTabInfoA(HWND,int,PALTTABINFO,LPSTR,UINT);
BOOL GetAltTabInfoW(HWND,int,PALTTABINFO,LPWSTR,UINT);*/
// BOOL GetComboBoxInfo(HWND,PCOMBOBOXINFO);
//BOOL GetCursorInfo(PCURSORINFO);
////#if (WINVER >= 0x0500)
// BOOL GetGUIThreadInfo(DWORD,LPGUITHREADINFO);
////#endif
BOOL GetLastInputInfo(PLASTINPUTINFO);
DWORD GetListBoxInfo(HWND);
// BOOL GetMenuBarInfo(HWND,LONG,LONG,PMENUBARINFO);
BOOL GetMenuInfo(HMENU,LPMENUINFO);
////#if (_WIN32_WINNT >= 0x0500)
BOOL GetProcessDefaultLayout(DWORD*);
////#endif
BOOL GetScrollBarInfo(HWND,LONG,PSCROLLBARINFO);
//BOOL GetTitleBarInfo(HWND,PTITLEBARINFO);
BOOL GetWindowInfo(HWND,PWINDOWINFO);
/*BOOL GetMonitorInfoA(HMONITOR,LPMONITORINFO);
BOOL GetMonitorInfoW(HMONITOR,LPMONITORINFO);*/
UINT GetWindowModuleFileNameA(HWND,LPSTR,UINT);
// UINT GetWindowModuleFileNameW(HWND,LPWSTR,UINT);
/*BOOL GrayStringA(HDC,HBRUSH,GRAYSTRINGPROC,LPARAM,int,int,int,int,int);
BOOL GrayStringW(HDC,HBRUSH,GRAYSTRINGPROC,LPARAM,int,int,int,int,int);*/
BOOL HideCaret(HWND);
BOOL HiliteMenuItem(HWND,HMENU,UINT,UINT);
BOOL InflateRect(LPRECT,int,int);
BOOL InSendMessage();

}

enum : uint {
/*BS_3STATE=5,
BS_AUTO3STATE=6,
BS_AUTOCHECKBOX=3,
BS_AUTORADIOBUTTON=9,
BS_BITMAP=128,
BS_BOTTOM=0x800,
BS_CENTER=0x300,
BS_CHECKBOX=2,
BS_DEFPUSHBUTTON=1,
BS_GROUPBOX=7,
BS_ICON=64,
BS_LEFT=256,
BS_LEFTTEXT=32,
BS_MULTILINE=0x2000,
BS_NOTIFY=0x4000,
BS_OWNERDRAW=0xb,
BS_PUSHBUTTON=0,
BS_PUSHLIKE=4096,
BS_RADIOBUTTON=4,
BS_RIGHT=512,
BS_RIGHTBUTTON=32,
BS_TEXT=0,
BS_TOP=0x400,
BS_USERBUTTON=8,
BS_VCENTER=0xc00,
BS_FLAT=0x8000,*/
CBS_AUTOHSCROLL=64,
CBS_DISABLENOSCROLL=0x800,
CBS_DROPDOWN=2,
CBS_DROPDOWNLIST=3,
CBS_HASSTRINGS=512,
CBS_LOWERCASE=0x4000,
CBS_NOINTEGRALHEIGHT=0x400,
CBS_OEMCONVERT=128,
CBS_OWNERDRAWFIXED=16,
CBS_OWNERDRAWVARIABLE=32,
CBS_SIMPLE=1,
CBS_SORT=256,
CBS_UPPERCASE=0x2000,
/*ES_AUTOHSCROLL=128,
ES_AUTOVSCROLL=64,
ES_CENTER=1,
ES_LEFT=0,
ES_LOWERCASE=16,
ES_MULTILINE=4,
ES_NOHIDESEL=256,
ES_NUMBER=0x2000,
ES_OEMCONVERT=0x400,
ES_PASSWORD=32,
ES_READONLY=0x800,
ES_RIGHT=2,
ES_UPPERCASE=8,
ES_WANTRETURN=4096,*/
LBS_DISABLENOSCROLL=4096,
LBS_EXTENDEDSEL=0x800,
LBS_HASSTRINGS=64,
LBS_MULTICOLUMN=512,
LBS_MULTIPLESEL=8,
LBS_NODATA=0x2000,
LBS_NOINTEGRALHEIGHT=256,
LBS_NOREDRAW=4,
LBS_NOSEL=0x4000,
LBS_NOTIFY=1,
LBS_OWNERDRAWFIXED=16,
LBS_OWNERDRAWVARIABLE=32,
LBS_SORT=2,
LBS_STANDARD=0xa00003,
LBS_USETABSTOPS=128,
LBS_WANTKEYBOARDINPUT=0x400,
SBS_BOTTOMALIGN=4,
SBS_HORZ=0,
SBS_LEFTALIGN=2,
SBS_RIGHTALIGN=4,
SBS_SIZEBOX=8,
SBS_SIZEBOXBOTTOMRIGHTALIGN=4,
SBS_SIZEBOXTOPLEFTALIGN=2,
SBS_SIZEGRIP=16,
SBS_TOPALIGN=2,
SBS_VERT=1,
/*SS_BITMAP=14,
SS_BLACKFRAME=7,
SS_BLACKRECT=4,
SS_CENTER=1,
SS_CENTERIMAGE=512,
SS_ENHMETAFILE=15,
SS_ETCHEDFRAME=18,
SS_ETCHEDHORZ=16,
SS_ETCHEDVERT=17,
SS_GRAYFRAME=8,
SS_GRAYRECT=5,
SS_ICON=3,
SS_LEFT=0,
SS_LEFTNOWORDWRAP=0xc,
SS_NOPREFIX=128,
SS_NOTIFY=256,
SS_OWNERDRAW=0xd,
SS_REALSIZEIMAGE=0x800,
SS_RIGHT=2,
SS_RIGHTJUST=0x400,
SS_SIMPLE=11,
SS_SUNKEN=4096,
SS_WHITEFRAME=9,
SS_WHITERECT=6,
SS_USERITEM=10,
SS_TYPEMASK=0x0000001FL,
SS_ENDELLIPSIS=0x00004000L,
SS_PATHELLIPSIS=0x00008000L,
SS_WORDELLIPSIS=0x0000C000L,
SS_ELLIPSISMASK=0x0000C000L,*/
DS_3DLOOK=4,
DS_ABSALIGN=1,
DS_CENTER=0x800,
DS_CENTERMOUSE=4096,
DS_CONTEXTHELP=0x2000,
DS_CONTROL=0x400,
DS_FIXEDSYS=8,
DS_LOCALEDIT=32,
DS_MODALFRAME=128,
DS_NOFAILCREATE=16,
DS_NOIDLEMSG=256,
DS_SETFONT=64,
DS_SETFOREGROUND=512,
DS_SYSMODAL=2,
DS_SHELLFONT=(DS_SETFONT|DS_FIXEDSYS)
}

   

//enum : DWORD {
//}
/*7
*/
export {
BOOL  EnableMenuItem(HMENU,UINT,UINT);
BOOL  EnableScrollBar(HWND,UINT,UINT);
BOOL  EnableWindow(HWND,BOOL);
//BOOL  EndDeferWindowPos(HDWP);
BOOL  EndDialog(HWND,int);
BOOL  EndMenu();
//BOOL  EndPaint(HWND,PAINTSTRUCT*);

BOOL  ValidateRect(HWND,LPCRECT);
BOOL  ValidateRgn(HWND,HRGN);
SHORT  VkKeyScanA(CHAR);
/*SHORT  VkKeyScanExA(CHAR,HKL);
SHORT  VkKeyScanExW(WCHAR,HKL);*/
SHORT  VkKeyScanW(WCHAR);
DWORD  WaitForInputIdle(HANDLE,DWORD);
BOOL  WaitMessage();
HWND  WindowFromDC(HDC hDC);
HWND  WindowFromPoint(POINT);
UINT  WinExec(LPCSTR,UINT);

BOOL  PostMessageA(HWND,UINT,WPARAM,LPARAM);
BOOL  PostMessageW(HWND,UINT,WPARAM,LPARAM);
//void  PostQuitMessage(int);
BOOL  PostThreadMessageA(DWORD,UINT,WPARAM,LPARAM);
BOOL  PostThreadMessageW(DWORD,UINT,WPARAM,LPARAM);
BOOL  PrintWindow(HWND,HDC,UINT);
BOOL  PtInRect(LPCRECT,POINT);
HWND  RealChildWindowFromPoint(HWND,POINT);
UINT  RealGetWindowClassA(HWND,LPSTR,UINT);
UINT  RealGetWindowClassW(HWND,LPWSTR,UINT);
BOOL  RedrawWindow(HWND,LPCRECT,HRGN,UINT);

HMENU CreateMenu();
HMENU CreatePopupMenu();

BOOL DestroyAcceleratorTable(HACCEL);
BOOL DestroyCursor(HCURSOR);
BOOL DestroyIcon(HICON);
BOOL DestroyMenu(HMENU);
BOOL DestroyWindow(HWND);

BOOL InsertMenuA(HMENU,UINT,UINT,UINT,LPCSTR);
BOOL InsertMenuW(HMENU,UINT,UINT,UINT,LPCWSTR);
BOOL InsertMenuItemA(HMENU,UINT,BOOL,LPCMENUITEMINFOA);
BOOL InsertMenuItemW(HMENU,UINT,BOOL,LPCMENUITEMINFOW);
BOOL IntersectRect(LPRECT,LPCRECT,LPCRECT);
//BOOL InvalidateRect(HWND,LPCRECT,BOOL);
BOOL InvalidateRgn(HWND,HRGN,BOOL);
BOOL InvertRect(HDC,LPCRECT);

}

const HWND HWND_BROADCAST=(cast(HWND)0xffff);
const HWND HWND_BOTTOM=(cast(HWND)1);
const HWND HWND_NOTOPMOST=(cast(HWND)(-2));
const HWND HWND_TOP=(cast(HWND)0);
const HWND HWND_TOPMOST=(cast(HWND)(-1));
const HWND HWND_MESSAGE=(cast(HWND)(-3)); /* w2k */

export {
  HBITMAP CreateBitmap(int,int,UINT,UINT,PVOID);
  HBITMAP CreateBitmapIndirect(BITMAP*);
  BOOL    Ellipse(HDC,int,int,int,int);

//  BOOL    Rectangle(HDC,int,int,int,int);

  BOOL    Polyline( HDC, LPPOINT, int );

  BOOL    PatBlt(HDC,int,int,int,int,DWORD);
  BOOL    SetBrushOrgEx(HDC,int,int,LPPOINT);  
  
  BOOL DrawCaption(HWND,HDC,LPCRECT,UINT);
  BOOL DrawEdge(HDC,LPRECT,UINT,UINT);
  BOOL DrawFocusRect(HDC,LPCRECT);
  BOOL DrawFrameControl(HDC,LPRECT,UINT,UINT);
  BOOL DrawIcon(HDC,int,int,HICON);
  BOOL DrawIconEx(HDC,int,int,HICON,int,int,UINT,HBRUSH,UINT);
  BOOL DrawMenuBar(HWND);
  BOOL ReleaseCapture();
}


enum {
  PFD_TYPE_RGBA=0,
  PFD_TYPE_COLORINDEX=1,
  PFD_MAIN_PLANE=0,
  PFD_OVERLAY_PLANE=1,
  PFD_UNDERLAY_PLANE=(-1),
  PFD_DOUBLEBUFFER=1,
  PFD_STEREO=2,
  PFD_DRAW_TO_WINDOW=4,
  PFD_DRAW_TO_BITMAP=8,
  PFD_SUPPORT_GDI=16,
  PFD_SUPPORT_OPENGL=32,
  PFD_GENERIC_FORMAT=64,
  PFD_NEED_PALETTE=128,
  PFD_NEED_SYSTEM_PALETTE=0x00000100,
  PFD_SWAP_EXCHANGE=0x00000200,
  PFD_SWAP_COPY=0x00000400,
  PFD_SWAP_LAYER_BUFFERS=0x00000800,
  PFD_GENERIC_ACCELERATED=0x00001000,
  PFD_DEPTH_DONTCARE=0x20000000,
  PFD_DOUBLEBUFFER_DONTCARE=0x40000000,
  PFD_STEREO_DONTCARE=0x80000000
}

export {
  int ChoosePixelFormat( HDC, LPPIXELFORMATDESCRIPTOR );
//  int  DescribePixelFormat( HDC, int, UINT, LPPIXELFORMATDESCRIPTOR );
  int  GetPixelFormat( HDC );
//  BOOL  SetPixelFormat( HDC, int, LPPIXELFORMATDESCRIPTOR );
  
  BOOL  wglCopyContext( HGLRC, HGLRC, UINT);
  HGLRC  wglCreateContext( HDC);
  HGLRC  wglCreateLayerContext(HDC,int);
  BOOL  wglDeleteContext( HGLRC);
//  BOOL  wglDescribeLayerPlane(HDC,int,int,UINT,LPLAYERPLANEDESCRIPTOR);
  HGLRC  wglGetCurrentContext();
  HDC  wglGetCurrentDC();
  int  wglGetLayerPaletteEntries( HDC, int, int, int, COLORREF*);
//  PROC  wglGetProcAddress(LPCSTR);
  BOOL  wglMakeCurrent( HDC, HGLRC);
  BOOL  wglRealizeLayerPalette( HDC, int, BOOL);
  int  wglSetLayerPaletteEntries( HDC, int, int, int, COLORREF*);
  BOOL  wglShareLists( HGLRC, HGLRC);
  BOOL  wglSwapLayerBuffers(HDC,UINT);
  BOOL  wglUseFontBitmapsA( HDC, DWORD, DWORD, DWORD);
  BOOL  wglUseFontBitmapsW( HDC, DWORD, DWORD, DWORD);
//  BOOL  wglUseFontOutlinesA(HDC,DWORD,DWORD,DWORD,FLOAT,FLOAT,int,LPGLYPHMETRICSFLOAT);
//  BOOL  wglUseFontOutlinesW(HDC,DWORD,DWORD,DWORD,FLOAT,FLOAT,int,LPGLYPHMETRICSFLOAT);
  
  BOOL SwapBuffers(HDC);
}  

enum {
  LVM_FIRST=0x1000,
  TVM_FIRST=0x1100,
  HDM_FIRST=0x1200,
}

enum {
 LVN_FIRST=(-100),
 LVN_LAST=(-199),
 HDN_FIRST=(-300),
 HDN_LAST=(-399),
 TVN_FIRST=(-400),
 TVN_LAST=(-499),
 TTN_FIRST=(-520),
 TTN_LAST=(-549),
 TCN_FIRST=(-550),
 TCN_LAST=(-580),
 CDN_FIRST=(-601), /* also in commdlg.h */
 CDN_LAST=(-699),
 TBN_FIRST=(-700),
 TBN_LAST=(-720),
}  


enum {
  TVS_HASBUTTONS=1,
  TVS_HASLINES=2,
  TVS_LINESATROOT=4,
  TVS_EDITLABELS=8,
  TVS_DISABLEDRAGDROP=16,
  TVS_SHOWSELALWAYS=32,
  TVS_CHECKBOXES=256,
  TVS_NOTOOLTIPS=128,
  TVS_RTLREADING=64,
  TVS_TRACKSELECT=512,
  TVS_FULLROWSELECT=4096,
  TVS_INFOTIP=2048,
  TVS_NONEVENHEIGHT=16384,
  TVS_NOSCROLL=8192,
  TVS_SINGLEEXPAND=1024,
  TVS_NOHSCROLL=0x8000,
  TVIF_TEXT=1,
  TVIF_IMAGE=2,
  TVIF_PARAM=4,
  TVIF_STATE=8,
  TVIF_HANDLE=16,
  TVIF_SELECTEDIMAGE=32,
  TVIF_CHILDREN=64,
  TVIF_INTEGRAL=0x0080,
  TVIS_FOCUSED=1,
  TVIS_SELECTED=2,
  TVIS_CUT=4,
  TVIS_DROPHILITED=8,
  TVIS_BOLD=16,
  TVIS_EXPANDED=32,
  TVIS_EXPANDEDONCE=64,
  TVIS_OVERLAYMASK=0xF00,
  TVIS_STATEIMAGEMASK=0xF000,
  TVIS_USERMASK=0xF000,
  I_CHILDRENCALLBACK=(-1),
  TVSIL_NORMAL=0,
  TVSIL_STATE=2,
  TVM_INSERTITEMA=TVM_FIRST,
  TVM_INSERTITEMW=(TVM_FIRST+50),
  TVM_DELETEITEM=(TVM_FIRST+1),
  TVM_EXPAND=(TVM_FIRST+2),
  TVM_GETITEMRECT=(TVM_FIRST+4),
  TVM_GETCOUNT=(TVM_FIRST+5),
  TVM_GETINDENT=(TVM_FIRST+6),
  TVM_SETINDENT=(TVM_FIRST+7),
  TVM_GETIMAGELIST=(TVM_FIRST+8),
  TVM_SETIMAGELIST=(TVM_FIRST+9),
  TVM_GETNEXTITEM=(TVM_FIRST+10),
  TVM_SELECTITEM=(TVM_FIRST+11),
  TVM_GETITEMA=(TVM_FIRST+12),
  TVM_GETITEMW=(TVM_FIRST+62),
  TVM_SETITEMA=(TVM_FIRST+13),
  TVM_SETITEMW=(TVM_FIRST+63),
  TVM_EDITLABELA=(TVM_FIRST+14),
  TVM_EDITLABELW=(TVM_FIRST+65),
  TVM_GETEDITCONTROL=(TVM_FIRST+15),
  TVM_GETVISIBLECOUNT=(TVM_FIRST+16),
  TVM_HITTEST=(TVM_FIRST+17),
  TVM_CREATEDRAGIMAGE=(TVM_FIRST+18),
  TVM_SORTCHILDREN=(TVM_FIRST+19),
  TVM_ENSUREVISIBLE=(TVM_FIRST+20),
  TVM_SORTCHILDRENCB=(TVM_FIRST+21),
  TVM_ENDEDITLABELNOW=(TVM_FIRST+22),
  TVM_GETISEARCHSTRINGA=(TVM_FIRST+23),
  TVM_GETISEARCHSTRINGW=(TVM_FIRST+64),
  TVM_GETTOOLTIPS=(TVM_FIRST+25),
  TVM_SETTOOLTIPS=(TVM_FIRST+24),
  TVM_GETBKCOLOR=(TVM_FIRST+31),
  TVM_GETINSERTMARKCOLOR=(TVM_FIRST+38),
  TVM_GETITEMHEIGHT=(TVM_FIRST+28),
  TVM_GETSCROLLTIME=(TVM_FIRST+34),
  TVM_GETTEXTCOLOR=(TVM_FIRST+32),
  TVM_SETBKCOLOR=(TVM_FIRST+29),
  TVM_SETINSERTMARK=(TVM_FIRST+26),
  TVM_SETINSERTMARKCOLOR=(TVM_FIRST+37),
  TVM_SETITEMHEIGHT=(TVM_FIRST+27),
  TVM_SETSCROLLTIME=(TVM_FIRST+33),
  TVM_SETTEXTCOLOR=(TVM_FIRST+30),
//  TVM_SETUNICODEFORMAT=CCM_SETUNICODEFORMAT,
//  TVM_GETUNICODEFORMAT=CCM_GETUNICODEFORMAT,
  TVM_GETITEMSTATE=(TVM_FIRST+39),
  TVM_SETLINECOLOR=(TVM_FIRST+40),
  TVM_GETLINECOLOR=(TVM_FIRST+41),
  TVE_COLLAPSE=1,
  TVE_EXPAND=2,
  TVE_TOGGLE=3,
  TVE_COLLAPSERESET=0x8000,
  TVE_EXPANDPARTIAL=0x4000,
  TVC_UNKNOWN=0,
  TVC_BYMOUSE=1,
  TVC_BYKEYBOARD=2,
  TVGN_ROOT=0,
  TVGN_NEXT=1,
  TVGN_PREVIOUS=2,
  TVGN_PARENT=3,
  TVGN_CHILD=4,
  TVGN_FIRSTVISIBLE=5,
  TVGN_NEXTVISIBLE=6,
  TVGN_PREVIOUSVISIBLE=7,
  TVGN_DROPHILITE=8,
  TVGN_CARET=9,
  TVGN_LASTVISIBLE=10,
  TVN_SELCHANGINGA=(TVN_FIRST-1),
  TVN_SELCHANGINGW=(TVN_FIRST-50),
  TVN_SELCHANGEDA=(TVN_FIRST-2),
  TVN_SELCHANGEDW=(TVN_FIRST-51),
  TVN_GETDISPINFOA=(TVN_FIRST-3),
  TVN_GETDISPINFOW=(TVN_FIRST-52),
  TVN_SETDISPINFOA=(TVN_FIRST-4),
  TVN_SETDISPINFOW=(TVN_FIRST-53),
  TVN_ITEMEXPANDINGA=(TVN_FIRST-5),
  TVN_ITEMEXPANDINGW=(TVN_FIRST-54),
  TVN_ITEMEXPANDEDA=(TVN_FIRST-6),
  TVN_ITEMEXPANDEDW=(TVN_FIRST-55),
  TVN_BEGINDRAGA=(TVN_FIRST-7),
  TVN_BEGINDRAGW=(TVN_FIRST-56),
  TVN_BEGINRDRAGA=(TVN_FIRST-8),
  TVN_BEGINRDRAGW=(TVN_FIRST-57),
  TVN_DELETEITEMA=(TVN_FIRST-9),
  TVN_DELETEITEMW=(TVN_FIRST-58),
  TVN_BEGINLABELEDITA=(TVN_FIRST-10),
  TVN_BEGINLABELEDITW=(TVN_FIRST-59),
  TVN_ENDLABELEDITA=(TVN_FIRST-11),
  TVN_ENDLABELEDITW=(TVN_FIRST-60),
  TVN_KEYDOWN=(TVN_FIRST-12),
  TVN_GETINFOTIPA=(TVN_FIRST-13),
  TVN_GETINFOTIPW=(TVN_FIRST-14),
  TVN_SINGLEEXPAND=(TVN_FIRST-15),
  TVNRET_DEFAULT=0,
  TVNRET_SKIPOLD=1,
  TVNRET_SKIPNEW=2,
  TVIF_DI_SETITEM=0x1000,
  TVHT_NOWHERE=1,
  TVHT_ONITEMICON=2,
  TVHT_ONITEMLABEL=4,
  TVHT_ONITEMINDENT=8,
  TVHT_ONITEMBUTTON=16,
  TVHT_ONITEMRIGHT=32,
  TVHT_ONITEMSTATEICON=64,
  TVHT_ONITEM=( TVHT_ONITEMICON | TVHT_ONITEMLABEL | TVHT_ONITEMSTATEICON),
  TVHT_ABOVE=256,
  TVHT_BELOW=512,
  TVHT_TORIGHT=1024,
  TVHT_TOLEFT=2048,
}

alias HANDLE  HTREEITEM;

const HTREEITEM TVI_ROOT  = (cast(HTREEITEM)0xFFFF0000);
const HTREEITEM TVI_FIRST = (cast(HTREEITEM)0xFFFF0001);
const HTREEITEM TVI_LAST  = (cast(HTREEITEM)0xFFFF0002);
const HTREEITEM TVI_SORT  = (cast(HTREEITEM)0xFFFF0003);

//typedef struct _TREEITEM *HTREEITEM;

struct TVITEMA {
	UINT mask;
	HTREEITEM hItem;
	UINT state;
	UINT stateMask;
	LPSTR pszText;
	int cchTextMax;
	int iImage;
	int iSelectedImage;
	int cChildren;
	LPARAM lParam;
}

alias TVITEMA*  LPTVITEMA;
alias TVITEMA   _TV_ITEMA, TV_ITEMA;
alias LPTVITEMA LPTV_ITEMA;

struct TVITEMW {
	UINT mask;
	HTREEITEM hItem;
	UINT state;
	UINT stateMask;
	LPWSTR pszText;
	int cchTextMax;
	int iImage;
	int iSelectedImage;
	int cChildren;
	LPARAM lParam;
} 

alias TVITEMW*    LPTVITEMW;
alias TVITEMW     _TV_ITEMW, TV_ITEMW;
alias LPTVITEMW   LPTV_ITEMW;

// #if (_WIN32_IE >= 0x0400)
struct TVITEMEXA {
	UINT mask;
	HTREEITEM hItem;
	UINT state;
	UINT stateMask;
	LPSTR pszText;
	int cchTextMax;
	int iImage;
	int iSelectedImage;
	int cChildren;
	LPARAM lParam;
	int iIntegral;
}

alias TVITEMEXA* LPTVITEMEXA;

struct TVITEMEXW {
	UINT mask;
	HTREEITEM hItem;
	UINT state;
	UINT stateMask;
	LPWSTR pszText;
	int cchTextMax;
	int iImage;
	int iSelectedImage;
	int cChildren;
	LPARAM lParam;
	int iIntegral;
}

alias TVITEMEXW* LPTVITEMEXW;

struct TVINSERTSTRUCTA {
	HTREEITEM hParent;
	HTREEITEM hInsertAfter;
	union {
  	TVITEMEXA itemex;
    TVITEMA item;
	}
} 

alias TVINSERTSTRUCTA*    LPTVINSERTSTRUCTA;
alias TVINSERTSTRUCTA     _TV_INSERTSTRUCTA, TV_INSERTSTRUCTA;
alias LPTVINSERTSTRUCTA   LPTV_INSERTSTRUCTA;

struct TVINSERTSTRUCTW {
	HTREEITEM hParent;
	HTREEITEM hInsertAfter;
	union {
	  TVITEMEXW itemex;
	  TV_ITEMW  item;
	}
}

alias TVINSERTSTRUCTW*    LPTVINSERTSTRUCTW;
alias TVINSERTSTRUCTW     _TV_INSERTSTRUCTW;
alias TVINSERTSTRUCTW     TV_INSERTSTRUCTW;
alias LPTVINSERTSTRUCTW   LPTV_INSERTSTRUCTW;

struct TVHITTESTINFO {
	POINT pt;
 	UINT flags;
	HTREEITEM hItem;
} 

alias TVHITTESTINFO* LPTVHITTESTINFO;

alias int function(LPARAM,LPARAM,LPARAM) PFNTVCOMPARE;

struct TVSORTCB {
	HTREEITEM    hParent;
	PFNTVCOMPARE lpfnCompare;
	LPARAM       lParam;
} 

alias TVSORTCB* LPTVSORTCB;

struct NMTREEVIEWA {
	NMHDR hdr;
	UINT action;
	TV_ITEMA itemOld;
	TV_ITEMA itemNew;
	POINT ptDrag;
} 

alias NMTREEVIEWA* LPNMTREEVIEWA;

struct NMTREEVIEWW {
	NMHDR hdr;
	UINT action;
	TV_ITEMW itemOld;
	TV_ITEMW itemNew;
	POINT ptDrag;
} 

alias NMTREEVIEWW* LPNMTREEVIEWW;

struct NMTVDISPINFOA {
	NMHDR hdr;
	TVITEMA item;
}

alias NMTVDISPINFOA* LPNMTVDISPINFOA;

struct NMTVDISPINFOW {
	NMHDR hdr;
	TVITEMW item;
}

alias NMTVDISPINFOW* LPNMTVDISPINFOW;

struct NMTVGETINFOTIPA {
	NMHDR hdr;
	LPSTR pszText;
	int cchTextMax;
	HTREEITEM hItem;
	LPARAM lParam;
}

alias NMTVGETINFOTIPA* LPNMTVGETINFOTIPA;

struct NMTVGETINFOTIPW {
	NMHDR hdr;
	LPWSTR pszText;
	int cchTextMax;
	HTREEITEM hItem;
	LPARAM lParam;
}

alias NMTVGETINFOTIPW* LPNMTVGETINFOTIPW;

struct TV_KEYDOWN {
	NMHDR hdr;
	WORD wVKey;
	UINT flags;
};

export BOOL BitBlt(HDC,int,int,int,int,HDC,int,int,DWORD);
export HBITMAP CreateCompatibleBitmap(HDC,int,int);
export HBITMAP CreateDIBSection(HDC, BITMAPINFO*,UINT,void**,HANDLE,DWORD);

enum {
  DIB_PAL_COLORS=1,
  DIB_RGB_COLORS=0,
}

enum {
  BI_RGB=0,
  BI_RLE8=1,
  BI_RLE4=2,
  BI_BITFIELDS=3,
  BI_JPEG=4,
  BI_PNG=5,
}

//export HDC CreateDCA(LPCSTR,LPCSTR,LPCSTR,const DEVMODEA*);
export HDC CreateDCA(LPCSTR,LPCSTR,LPCSTR, void* );

struct LVITEMA {
	UINT   mask;
	int    iItem;
	int    iSubItem;
	UINT   state;
	UINT   stateMask;
	LPSTR  pszText;
	int    cchTextMax;
	int    iImage;
	LPARAM lParam;
	int    iIndent;
	int    iGroupId;
	UINT   cColumns;
	PUINT  puColumns;
} 

alias LVITEMA*  LPLVITEMA;

struct LVITEMW {
	UINT mask;
	int iItem;
	int iSubItem;
	UINT state;
	UINT stateMask;
	LPWSTR pszText;
	int cchTextMax;
	int iImage;
	LPARAM lParam;
	int iIndent;
	int iGroupId;
	UINT cColumns;
	PUINT puColumns;
} 

alias LVITEMW *LPLVITEMW;

struct LVFINDINFOA {
	UINT flags;
	LPCSTR psz;
	LPARAM lParam;
	POINT pt;
	UINT vkDirection;
} 

alias LVFINDINFOA* LPFINDINFOA;

struct LVFINDINFOW {
	UINT flags;
	LPCWSTR psz;
	LPARAM lParam;
	POINT pt;
	UINT vkDirection;
} 

alias LVFINDINFOW*  LPFINDINFOW;

struct LVHITTESTINFO {
	POINT pt;
	UINT flags;
	int iItem;
	int iSubItem;
} 

alias LVHITTESTINFO*  LPLVHITTESTINFO;

struct LVCOLUMNA {
	UINT mask;
	int fmt;
	int cx;
	LPSTR pszText;
	int cchTextMax;
	int iSubItem;
	int iImage;
	int iOrder;
}

alias LVCOLUMNA*  LPLVCOLUMNA;
alias LVCOLUMNA   LV_COLUMNA;

struct LVCOLUMNW {
	UINT mask;
	int fmt;
	int cx;
	LPWSTR pszText;
	int cchTextMax;
	int iSubItem;
	int iImage;
	int iOrder;
} 

alias LVCOLUMNW*  LPLVCOLUMNW;

alias int function(LPARAM,LPARAM,LPARAM) PFNLVCOMPARE;

struct NMLISTVIEW {
	NMHDR hdr;
	int iItem;
	int iSubItem;
	UINT uNewState;
	UINT uOldState;
	UINT uChanged;
	POINT ptAction;
	LPARAM lParam;
} 

alias NMLISTVIEW* LPNMLISTVIEW;

struct NMLVDISPINFOA {
	NMHDR hdr;
	LVITEMA item;
} 

alias NMLVDISPINFOA*  LPNMLVDISPINFOA;

struct NMLVDISPINFOW {
	NMHDR hdr;
	LVITEMW item;
} 

alias NMLVDISPINFOW*    LPNMLVDISPINFOW;

struct LV_KEYDOWN {
	NMHDR hdr;
	WORD wVKey;
	UINT flags;
}

struct NMLVCACHEHINT {
	NMHDR hdr;
	int iFrom;
	int iTo;
} 

alias NMLVCACHEHINT*  PNMLVCACHEHINT;

enum {    // ListView Styles
  LVS_ICON=0,
  LVS_REPORT=1,
  LVS_SMALLICON=2,
  LVS_LIST=3,
  LVS_TYPEMASK=3,
  LVS_SINGLESEL=4,
  LVS_SHOWSELALWAYS=8,
  LVS_SORTASCENDING=16,
  LVS_SORTDESCENDING=32,
  LVS_SHAREIMAGELISTS=64,
  LVS_NOLABELWRAP=128,
  LVS_AUTOARRANGE=256,
  LVS_EDITLABELS=512,
  LVS_NOSCROLL=0x2000,
  LVS_TYPESTYLEMASK=0xfc00,
  LVS_ALIGNTOP=0,
  LVS_ALIGNLEFT=0x800,
  LVS_ALIGNMASK=0xc00,
  LVS_OWNERDRAWFIXED=0x400,
  LVS_NOCOLUMNHEADER=0x4000,
  LVS_NOSORTHEADER=0x8000,
}

enum {  // ListView Extended Styles
  LVS_EX_CHECKBOXES=        4,
  LVS_EX_FULLROWSELECT=     32,
  LVS_EX_GRIDLINES=         1,
  LVS_EX_HEADERDRAGDROP=    16,
  LVS_EX_ONECLICKACTIVATE=  64,
  LVS_EX_SUBITEMIMAGES=     2,
  LVS_EX_TRACKSELECT=       8,
  LVS_EX_TWOCLICKACTIVATE=  128,
  LVS_EX_FLATSB	=           0x00000100,
  LVS_EX_REGIONAL=          0x00000200,
  LVS_EX_INFOTIP=           0x00000400,
  LVS_EX_UNDERLINEHOT=      0x00000800,
  LVS_EX_UNDERLINECOLD=     0x00001000,
  LVS_EX_MULTIWORKAREAS=    0x00002000,
  LVS_EX_LABELTIP=          0x00004000,
  LVS_EX_BORDERSELECT=      0x00008000,
}

enum {
  LVSIL_NORMAL=0,
  LVSIL_SMALL=1,
  LVSIL_STATE=2,
}

enum {
  LVM_GETBKCOLOR=LVM_FIRST,
  LVM_SETBKCOLOR	=(LVM_FIRST+1),
  LVM_GETIMAGELIST	=(LVM_FIRST+2),
  LVM_SETIMAGELIST	=(LVM_FIRST+3),
  LVM_GETITEMCOUNT	=(LVM_FIRST+4),
  LVM_GETITEMA	=(LVM_FIRST+5),
  LVM_GETITEMW	=(LVM_FIRST+75),
  LVM_SETITEMA	=(LVM_FIRST+6),
  LVM_SETITEMW	=(LVM_FIRST+76),
  LVM_INSERTITEMA	=(LVM_FIRST+7),
  LVM_INSERTITEMW	=(LVM_FIRST+77),
  LVM_DELETEITEM	=(LVM_FIRST+8),
  LVM_DELETEALLITEMS	=(LVM_FIRST+9),
  LVM_GETCALLBACKMASK	=(LVM_FIRST+10),
  LVM_SETCALLBACKMASK	=(LVM_FIRST+11),
  LVM_SETBKIMAGEA	=(LVM_FIRST + 68),
  LVM_SETBKIMAGEW	=(LVM_FIRST + 138),
  LVM_GETBKIMAGEA	=(LVM_FIRST + 69),
  LVM_GETBKIMAGEW	=(LVM_FIRST + 139),
  LVM_SETWORKAREAS	=(LVM_FIRST+65),
  LVM_GETWORKAREAS	=(LVM_FIRST+70),
  LVM_GETNUMBEROFWORKAREAS	=(LVM_FIRST+73),
  LVM_GETSELECTIONMARK	=(LVM_FIRST+66),
  LVM_SETSELECTIONMARK	=(LVM_FIRST+67),
  LVM_SETHOVERTIME	=(LVM_FIRST+71),
  LVM_GETHOVERTIME	=(LVM_FIRST+72),
  LVM_SETTOOLTIPS	=(LVM_FIRST+74),
  LVM_GETTOOLTIPS	=(LVM_FIRST+78),
  LVM_GETITEMRECT	=(LVM_FIRST+14),
  LVM_SETITEMPOSITION	=(LVM_FIRST+15),
  LVM_GETITEMPOSITION	=(LVM_FIRST+16),
  LVM_GETSTRINGWIDTHA	=(LVM_FIRST+17),
  LVM_GETSTRINGWIDTHW	=(LVM_FIRST+87),
  LVM_FINDITEMA	=(LVM_FIRST+13),
  LVM_FINDITEMW	=(LVM_FIRST+83),
  LVM_HITTEST	=(LVM_FIRST+18),
  LVM_ENSUREVISIBLE	=(LVM_FIRST+19),
  LVM_SCROLL	=(LVM_FIRST+20),
  LVM_REDRAWITEMS	=(LVM_FIRST+21),
  LVM_ARRANGE	=(LVM_FIRST+22),
  LVM_EDITLABELA	=(LVM_FIRST+23),
  LVM_EDITLABELW	=(LVM_FIRST+118),
  LVM_GETEDITCONTROL	=(LVM_FIRST+24),
  LVM_GETCOLUMNA	=(LVM_FIRST+25),
  LVM_GETCOLUMNW	=(LVM_FIRST+95),
  LVM_SETCOLUMNA	=(LVM_FIRST+26),
  LVM_SETCOLUMNW	=(LVM_FIRST+96),
  LVM_INSERTCOLUMNA	=(LVM_FIRST+27),
  LVM_INSERTCOLUMNW	=(LVM_FIRST+97),
  LVM_DELETECOLUMN	=(LVM_FIRST+28),
  LVM_GETCOLUMNWIDTH	=(LVM_FIRST+29),
  LVM_SETCOLUMNWIDTH	=(LVM_FIRST+30),
  LVM_CREATEDRAGIMAGE	=(LVM_FIRST+33),
  LVM_GETVIEWRECT	=(LVM_FIRST+34),
  LVM_GETTEXTCOLOR	=(LVM_FIRST+35),
  LVM_SETTEXTCOLOR	=(LVM_FIRST+36),
  LVM_GETTEXTBKCOLOR	=(LVM_FIRST+37),
  LVM_SETTEXTBKCOLOR	=(LVM_FIRST+38),
  LVM_GETTOPINDEX	=(LVM_FIRST+39),
  LVM_GETCOUNTPERPAGE	=(LVM_FIRST+40),
  LVM_GETORIGIN	=(LVM_FIRST+41),
  LVM_UPDATE	=(LVM_FIRST+42),
  LVM_SETITEMSTATE	=(LVM_FIRST+43),
  LVM_GETITEMSTATE	=(LVM_FIRST+44),
  LVM_GETITEMTEXTA	=(LVM_FIRST+45),
  LVM_GETITEMTEXTW	=(LVM_FIRST+115),
  LVM_SETITEMTEXTA	=(LVM_FIRST+46),
  LVM_SETITEMTEXTW	=(LVM_FIRST+116),
  LVM_SETITEMCOUNT	=(LVM_FIRST+47),
  LVM_SORTITEMS	=(LVM_FIRST+48),
  LVM_SETITEMPOSITION32	=(LVM_FIRST+49),
  LVM_GETSELECTEDCOUNT	=(LVM_FIRST+50),
  LVM_GETITEMSPACING	=(LVM_FIRST+51),
  LVM_GETISEARCHSTRINGA	=(LVM_FIRST+52),
  LVM_GETISEARCHSTRINGW	=(LVM_FIRST+117),
  LVM_APPROXIMATEVIEWRECT =(LVM_FIRST+64),
  LVM_SETEXTENDEDLISTVIEWSTYLE =(LVM_FIRST+54),
  LVM_GETEXTENDEDLISTVIEWSTYLE =(LVM_FIRST+55),
  LVM_SETCOLUMNORDERARRAY =(LVM_FIRST+58),
  LVM_GETCOLUMNORDERARRAY =(LVM_FIRST+59),
  LVM_GETHEADER =(LVM_FIRST+31),
  LVM_GETHOTCURSOR =(LVM_FIRST+63),
  LVM_GETHOTITEM =(LVM_FIRST+61),
  LVM_GETSUBITEMRECT =(LVM_FIRST+56),
  LVM_SETHOTCURSOR =(LVM_FIRST+62),
  LVM_SETHOTITEM =(LVM_FIRST+60),
  LVM_SETICONSPACING =(LVM_FIRST+53),
  LVM_SUBITEMHITTEST =(LVM_FIRST+57),
  LVM_GETNEXTITEM	=(LVM_FIRST+12),
}


/*enum {
  LPSTR_TEXTCALLBACKW	=((LPWSTR)-1)
  LPSTR_TEXTCALLBACKA	=((LPSTR)-1)
  I_IMAGECALLBACK	=(-1)
} */ 

enum { // ListView Item Flags
  LVIF_TEXT=        1,
  LVIF_IMAGE=       2,
  LVIF_PARAM=       4,
  LVIF_STATE=       8,
  LVIF_INDENT=      16,
  LVIF_NORECOMPUTE= 2048,
  LVIF_GROUPID=     128,
  LVIF_COLUMNS=     256,
  LVIF_DI_SETITEM=  0x1000,

}

enum {
  LVIS_FOCUSED=         1,
  LVIS_SELECTED=        2,
  LVIS_CUT=             4,
  LVIS_DROPHILITED=     8,
  LVIS_OVERLAYMASK=     0xF00,
  LVIS_STATEIMAGEMASK=  0xF000,
}

enum {
  LVSCW_AUTOSIZE=(-1),
  LVSCW_AUTOSIZE_USEHEADER=(-2),
}

enum {
  LVNI_ALL=         0,
  LVNI_FOCUSED=     1,
  LVNI_SELECTED=    2,
  LVNI_CUT=         4,
  LVNI_DROPHILITED= 8,
  LVNI_ABOVE=       256,
  LVNI_BELOW=       512,
  LVNI_TOLEFT=      1024,
  LVNI_TORIGHT=     2048,
}

enum {
  LVFI_PARAM=       1,
  LVFI_STRING=      2,
  LVFI_PARTIAL=     8,
  LVFI_WRAP=        32,
  LVFI_NEARESTXY=   64,
}

enum {
  LVIR_BOUNDS=          0,
  LVIR_ICON=            1,
  LVIR_LABEL=           2,
  LVIR_SELECTBOUNDS=    3,
  LVHT_NOWHERE=         1,
  LVHT_ONITEMICON=      2,
  LVHT_ONITEMLABEL=     4,
  LVHT_ONITEMSTATEICON= 8,
  LVHT_ONITEM	=         (LVHT_ONITEMICON|LVHT_ONITEMLABEL|LVHT_ONITEMSTATEICON),
  LVHT_ABOVE=           8,
  LVHT_BELOW=           16,
  LVHT_TORIGHT=         32,
  LVHT_TOLEFT=          64,
  LVA_DEFAULT=          0,
  LVA_ALIGNLEFT=        1,
  LVA_ALIGNTOP=         2,
  LVA_SNAPTOGRID=       5,
  LVGIT_UNFOLDED=       1,
  LV_MAX_WORKAREAS=     16,
}

enum {
  LVCF_FMT=     1,
  LVCF_WIDTH=   2,
  LVCF_TEXT=    4,
  LVCF_SUBITEM= 8,
  LVCF_IMAGE=   16,
  LVCF_ORDER=   32,
}

enum {
  LVCFMT_LEFT=            0,
  LVCFMT_RIGHT=           1,
  LVCFMT_CENTER=          2,
  LVCFMT_JUSTIFYMASK=     3,
  LVCFMT_IMAGE=           2048,
  LVCFMT_BITMAP_ON_RIGHT= 4096,
  LVCFMT_COL_HAS_IMAGES=  32768,
}

enum {
  LVN_ITEMCHANGING=LVN_FIRST,
  LVN_ITEMCHANGED	=(LVN_FIRST-1),
  LVN_INSERTITEM	=(LVN_FIRST-2),
  LVN_DELETEITEM	=(LVN_FIRST-3),
  LVN_DELETEALLITEMS	=(LVN_FIRST-4),
  LVN_BEGINLABELEDITA	=(LVN_FIRST-5),
  LVN_BEGINLABELEDITW	=(LVN_FIRST-75),
  LVN_ENDLABELEDITA	=(LVN_FIRST-6),
  LVN_ENDLABELEDITW	=(LVN_FIRST-76),
  LVN_COLUMNCLICK	=(LVN_FIRST-8),
  LVN_BEGINDRAG	=(LVN_FIRST-9),
  LVN_BEGINRDRAG	=(LVN_FIRST-11),
  LVN_GETDISPINFOA	=(LVN_FIRST-50),
  LVN_GETDISPINFOW	=(LVN_FIRST-77),
  LVN_SETDISPINFOA	=(LVN_FIRST-51),
  LVN_SETDISPINFOW	=(LVN_FIRST-78),
  LVN_KEYDOWN	=(LVN_FIRST-55),
  LVN_GETINFOTIPA	=(LVN_FIRST-57),
  LVN_GETINFOTIPW	=(LVN_FIRST-58),
}

enum {
  LVKF_ALT=     0x0001,
  LVKF_CONTROL= 0x0002,
  LVKF_SHIFT=   0x0004,
}

enum {
 BS_SOLID	= 0,
 BS_NULL	= 1,
 BS_HOLLOW	= 1,
 BS_HATCHED	= 2,
 BS_PATTERN	= 3,
 BS_INDEXED	= 4,
 BS_DIBPATTERN	= 5,
 BS_DIBPATTERNPT	= 6,
 BS_PATTERN8X8	= 7,
 BS_DIBPATTERN8X8	= 8,
}

struct LOGBRUSH {
	UINT      lbStyle;
	COLORREF  lbColor;
	LONG      lbHatch;
}

alias LOGBRUSH* PLOGBRUSH,LPLOGBRUSH;

export HBRUSH CreateBrushIndirect(PLOGBRUSH);

struct LOGFONTW {
	LONG	lfHeight;
	LONG	lfWidth;
	LONG	lfEscapement;
	LONG	lfOrientation;
	LONG	lfWeight;
	BYTE	lfItalic;
	BYTE	lfUnderline;
	BYTE	lfStrikeOut;
	BYTE	lfCharSet;
	BYTE	lfOutPrecision;
	BYTE	lfClipPrecision;
	BYTE	lfQuality;
	BYTE	lfPitchAndFamily;
	WCHAR	lfFaceName[32];
} 

alias LOGFONTW* PLOGFONTW, LPLOGFONTW;

export HFONT CreateFontIndirectW(PLOGFONTW);

enum {
DRIVERVERSION=0,
TECHNOLOGY=2,
HORZSIZE=4,
VERTSIZE=6,
HORZRES=8,
VERTRES=10,
LOGPIXELSX=88,
LOGPIXELSY=90,
BITSPIXEL=12,
PLANES=14,
NUMBRUSHES=16,
NUMPENS=18,
NUMFONTS=22,
NUMCOLORS=24,
NUMMARKERS=20,
ASPECTX=40,
ASPECTY=42,
ASPECTXY=44,
PDEVICESIZE=26,
CLIPCAPS=36,
SIZEPALETTE=104,
NUMRESERVED=106,
COLORRES=108,
PHYSICALWIDTH=110,
PHYSICALHEIGHT=111,
PHYSICALOFFSETX=112,
PHYSICALOFFSETY=113,
SCALINGFACTORX=114,
SCALINGFACTORY=115,
VREFRESH=116,
DESKTOPHORZRES=118,
DESKTOPVERTRES=117,
BLTALIGNMENT=119,
RASTERCAPS=38,
/*RC_BANDING=2,
RC_BITBLT=1,
RC_BITMAP64=8,
RC_DI_BITMAP=128,
RC_DIBTODEV=512,
RC_FLOODFILL=4096,
RC_GDI20_OUTPUT=16,
RC_PALETTE=256,
RC_SCALING=4,
RC_STRETCHBLT=2048,
RC_STRETCHDIB=8192,
RC_DEVBITS=0x8000,
RC_OP_DX_OUTPUT=0x4000,*/
CURVECAPS=28,
CC_NONE=0,
CC_CIRCLES=1,
CC_PIE=2,
CC_CHORD=4,
CC_ELLIPSES=8,
CC_WIDE=16,
CC_STYLED=32,
CC_WIDESTYLED=64,
CC_INTERIORS=128,
CC_ROUNDRECT=256,
LINECAPS=30,
LC_NONE=0,
LC_POLYLINE=2,
LC_MARKER=4,
LC_POLYMARKER=8,
LC_WIDE=16,
LC_STYLED=32,
LC_WIDESTYLED=64,
LC_INTERIORS=128,
POLYGONALCAPS=32,
RC_BANDING=2,
RC_BIGFONT=1024,
RC_BITBLT=1,
RC_BITMAP64=8,
RC_DEVBITS=0x8000,
RC_DI_BITMAP=128,
RC_GDI20_OUTPUT=16,
RC_GDI20_STATE=32,
RC_NONE=0,
RC_OP_DX_OUTPUT=0x4000,
RC_PALETTE=256,
RC_SAVEBITMAP=64,
RC_SCALING=4,
PC_NONE=0,
PC_POLYGON=1,
PC_POLYPOLYGON=256,
PC_PATHS=512,
PC_RECTANGLE=2,
PC_WINDPOLYGON=4,
PC_SCANLINE=8,
PC_TRAPEZOID=4,
PC_WIDE=16,
PC_STYLED=32,
PC_WIDESTYLED=64,
PC_INTERIORS=128,
//PC_PATHS=512,
TEXTCAPS=34,
TC_OP_CHARACTER=1,
TC_OP_STROKE=2,
TC_CP_STROKE=4,
TC_CR_90=8,
TC_CR_ANY=16,
TC_SF_X_YINDEP=32,
TC_SA_DOUBLE=64,
TC_SA_INTEGER=128,
TC_SA_CONTIN=256,
TC_EA_DOUBLE=512,
TC_IA_ABLE=1024,
TC_UA_ABLE=2048,
TC_SO_ABLE=4096,
TC_RA_ABLE=8192,
TC_VA_ABLE=16384,
TC_RESERVED=32768,
TC_SCROLLBLT=65536,
}

enum {
  DT_BOTTOM=8,
  DT_CALCRECT=1024,
  DT_CENTER=1,
  DT_EDITCONTROL=8192,
  DT_END_ELLIPSIS=32768,
  DT_PATH_ELLIPSIS=16384,
  DT_WORD_ELLIPSIS=0x40000,
  DT_EXPANDTABS=64,
  DT_EXTERNALLEADING=512,
  DT_LEFT=0,
  DT_MODIFYSTRING=65536,
  DT_NOCLIP=256,
  DT_NOPREFIX=2048,
  DT_RIGHT=2,
  DT_RTLREADING=131072,
  DT_SINGLELINE=32,
  DT_TABSTOP=128,
  DT_TOP=0,
  DT_VCENTER=4,
  DT_WORDBREAK=16,
  DT_INTERNAL=4096,
}

export int DrawTextA(HDC,LPSTR, int, LPRECT,UINT);
export int DrawTextW(HDC,LPWSTR, int, LPRECT,UINT);

enum {
 ICC_LISTVIEW_CLASSES=1,
 ICC_TREEVIEW_CLASSES=2,
 ICC_BAR_CLASSES=4,
 ICC_TAB_CLASSES=8,
 ICC_UPDOWN_CLASS=16,
 ICC_PROGRESS_CLASS=32,
 ICC_HOTKEY_CLASS=64,
 ICC_ANIMATE_CLASS=128,
 ICC_WIN95_CLASSES=255,
 ICC_DATE_CLASSES=256,
 ICC_USEREX_CLASSES=512,
 ICC_COOL_CLASSES=1024,
 ICC_INTERNET_CLASSES=2048,
 ICC_PAGESCROLLER_CLASS=4096,
 ICC_NATIVEFNTCTL_CLASS=8192,
 ICC_STANDARD_CLASSES=0x00004000,
 ICC_LINK_CLASS=0x00008000,
}

enum {
  MCM_GETCURSEL=0x1001,
  MCM_SETCURSEL=0x1002,
  MCM_GETMAXSELCOUNT=0x1003,
  MCM_SETMAXSELCOUNT=0x1004,
  MCM_GETSELRANGE=0x1005,
  MCM_SETSELRANGE=0x1006,
  MCM_GETMONTHRANGE=0x1007,
  MCM_SETDAYSTATE=0x1008,
  MCM_GETMINREQRECT=0x1009,
  MCM_SETCOLOR=0x100a,
  MCM_GETCOLOR=0x100b,
  MCM_SETTODAY=0x100c,
  MCM_GETTODAY=0x100d,
  MCM_HITTEST=0x100e,
  MCM_SETFIRSTDAYOFWEEK=0x100f,
  MCM_GETFIRSTDAYOFWEEK=0x1010,
  MCM_GETRANGE=0x1011,
  MCM_SETRANGE=0x1012,
  MCM_GETMONTHDELTA=0x1013,
  MCM_SETMONTHDELTA=0x1014,
  MCM_GETMAXTODAYWIDTH=0x1015,
  MCN_SELCHANGE=(cast(UINT)-749),
  MCN_GETDAYSTATE=(cast(UINT)-747),
  MCN_SELECT=(cast(UINT)-746),
  MCS_DAYSTATE=1,
  MCS_MULTISELECT=2,
  MCS_WEEKNUMBERS=4,
  MCS_NOTODAYCIRCLE=0x0008,
  MCS_NOTODAY=0x0010,
  MCSC_BACKGROUND=0,
  MCSC_TEXT=1,
  MCSC_TITLEBK=2,
  MCSC_TITLETEXT=3,
  MCSC_MONTHBK=4,
  MCSC_TRAILINGTEXT=5,
  MCHT_TITLE=0x10000,
  MCHT_CALENDAR=0x20000,
  MCHT_TODAYLINK=0x30000,
  MCHT_NEXT=0x1000000,
  MCHT_PREV=0x2000000,
  MCHT_NOWHERE=0x00,
  MCHT_TITLEBK=(MCHT_TITLE),
  MCHT_TITLEMONTH=(MCHT_TITLE | 0x0001),
  MCHT_TITLEYEAR=(MCHT_TITLE | 0x0002),
  MCHT_TITLEBTNNEXT=(MCHT_TITLE | MCHT_NEXT | 0x0003),
  MCHT_TITLEBTNPREV=(MCHT_TITLE | MCHT_PREV | 0x0003),
  MCHT_CALENDARBK=(MCHT_CALENDAR),
  MCHT_CALENDARDATE=(MCHT_CALENDAR | 0x0001),
  MCHT_CALENDARDATENEXT=(MCHT_CALENDARDATE | MCHT_NEXT),
  MCHT_CALENDARDATEPREV=(MCHT_CALENDARDATE | MCHT_PREV),
  MCHT_CALENDARDAY=(MCHT_CALENDAR | 0x0002),
  MCHT_CALENDARWEEKNUM=(MCHT_CALENDAR | 0x0003)
}
  
export BOOL IsDialogMessageA(HWND, LPMSG);
export BOOL IsDialogMessageW(HWND, LPMSG);

struct INITCOMMONCONTROLSEX {
	DWORD dwSize;
	DWORD dwICC;
} 

alias INITCOMMONCONTROLSEX* LPINITCOMMONCONTROLSEX;

export BOOL InitCommonControlsEx(LPINITCOMMONCONTROLSEX);

enum {
  DFC_CAPTION=1,
  DFC_MENU=2,
  DFC_SCROLL=3,
  DFC_BUTTON=4,
  DFC_POPUPMENU=5
}

enum {
  DFCS_CAPTIONCLOSE=0,
  DFCS_CAPTIONMIN=1,
  DFCS_CAPTIONMAX=2,
  DFCS_CAPTIONRESTORE=3,
  DFCS_CAPTIONHELP=4,
  DFCS_MENUARROW=0,
  DFCS_MENUCHECK=1,
  DFCS_MENUBULLET=2,
  DFCS_MENUARROWRIGHT=4,
  DFCS_SCROLLUP=0,
  DFCS_SCROLLDOWN=1,
  DFCS_SCROLLLEFT=2,
  DFCS_SCROLLRIGHT=3,
  DFCS_SCROLLCOMBOBOX=5,
  DFCS_SCROLLSIZEGRIP=8,
  DFCS_SCROLLSIZEGRIPRIGHT=16,
  DFCS_BUTTONCHECK=0,
  DFCS_BUTTONRADIOIMAGE=1,
  DFCS_BUTTONRADIOMASK=2,
  DFCS_BUTTONRADIO=4,
  DFCS_BUTTON3STATE=8,
  DFCS_BUTTONPUSH=16,
  DFCS_INACTIVE=256,
  DFCS_PUSHED=512,
  DFCS_CHECKED=1024,
  DFCS_TRANSPARENT=0x800,
  DFCS_HOT=0x1000,
}

enum {
  TME_HOVER=	1,
  TME_LEAVE=	2,
  TME_QUERY=	0x40000000,
  TME_CANCEL=	0x80000000,
}

struct TRACKMOUSEEVENT {
	DWORD cbSize;
	DWORD dwFlags;
	HWND  hwndTrack;
	DWORD dwHoverTime;
} 

alias TRACKMOUSEEVENT*  LPTRACKMOUSEEVENT;

export BOOL TrackMouseEvent(LPTRACKMOUSEEVENT);

export BOOL Polygon( HDC, LPPOINT, int );

}

