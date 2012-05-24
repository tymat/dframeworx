/*
  This file is in public domain
*/

module framework.implementation.gui.menu;

import framework.implementation.gui.event;
import framework.implementation.gui.eventargs;
import framework.implementation.gui.eventarray;

alias EventArray!(0,EventArgs)                          MenuItemEvents;
alias EventArray!(0,EventArgs).EventType                MenuItemEventType;
alias EventArray!(0,EventArgs).EventType.DelegateType   MenuItemDelegateType;

class Menu {

  static auto class EventArgs : framework.implementation.gui.eventargs.EventArgs {
  
    this( SystemEvent *pSystemEvent ) {
      super( pSystemEvent );
    }
  
    BaseItem sender() {
  
      if( mSystemEvent.msg.lParam == 0 ) 
        throw new InvalidHandle("MenuCommandEventArgs(lParam)");
  
      MENUITEMINFOA    __miif;
      __miif.cbSize = MENUITEMINFOA.sizeof;
      __miif.fMask  = MIIM_DATA;
      GetMenuItemInfoA( cast (HMENU) mSystemEvent.msg.lParam, LOWORD( mSystemEvent.msg.wParam ), TRUE, &__miif );
      
      if( __miif.dwItemData == 0 )
        throw new InvalidHandle("MenuCommandEventArgs(dwItemData)");
      
      return cast( Menu.BaseItem ) cast(void*) __miif.dwItemData;
    }
  
  }


  static class BaseItem {
    this() 
    in {
      mMenuItemEvents = new MenuItemEvents();
    }
    body {}
    
    this( MenuItemDelegateType pDelegate ) 
    in {
      mMenuItemEvents = new MenuItemEvents();
    }
    body {
      mMenuItemEvents.add( new MenuItemEventType( pDelegate ) );
    }
  
    void fill(LPMENUITEMINFOA lpmiif) {
      lpmiif.cbSize = MENUITEMINFOA.sizeof;
      lpmiif.fMask = MIIM_DATA;
      lpmiif.dwItemData = cast(DWORD) cast(void*) this;
    }
  
  //    void delegate( Menu.BaseItem i )    clicked;
  
    void opCall( SystemEvent* pSystemEvent ) 
    in {
      assert( mMenuItemEvents !is null );
    }
    body {
      mMenuItemEvents( pSystemEvent );
    }
  
    void add() {
    
    }
/* 
    These declarations cause D compiler to crash and generate and assert error on line 630 in file glue.c 
     
    alias EventArray!(0,EventArgs)                          MenuItemEvents;
    alias EventArray!(0,EventArgs).EventType                MenuItemEventType;
    alias EventArray!(0,EventArgs).EventType.DelegateType   MenuItemDelegateType;

    This is fixed moving them outside the class definition
    
 */
    
    MenuItemEvents    mMenuItemEvents;
  }


/*  static class Item : BaseItem {
  
    
    this( char[] pText ) {
      super();
      text( pText );
    }
    
    this( char[] p_text, MenuItemDelegateType pDelegate  ) {
      super( pDelegate );
      text( pText );
    }

    void fill( LPMENUITEMINFOA lpmiif ) {
      Menu.BaseItem.fill( lpmiif );
      lpmiif.fMask |= MIIM_STRING | MIIM_ID;
      lpmiif.fType = 0;//MFT_STRING;
      lpmiif.dwTypeData = cast(char*) __text;
      lpmiif.wID = 0;
    }
  
    char[] text() { return __text; }
    char[] text( char[] value ) { return __text = value; }
  
  protected:
    char[] __text;
  }
  
  class SubMenuItem : Item {

    this( char[] pText, Menu pMenu ) {
      super( pText );
      __subMenu = pMenu;
    }

    void    fill( LPMENUITEMINFOA lpmiif ) {
      Item.fill( lpmiif );
      lpmiif.fMask |= MIIM_SUBMENU;
      lpmiif.hSubMenu = __subMenu.handle();
    }

    Menu subMenu() { return __subMenu; }
    Menu subMenu( Menu value ) { return __subMenu = value; }

  protected:
    Menu   __subMenu;
  }

  static class Separator : BaseItem {
  
    this() {
      super();
    }

    void    fill( LPMENUITEMINFOA lpmiif ) {
      BaseItem.fill( lpmiif );
      lpmiif.fMask |= MIIM_TYPE;
      lpmiif.fType = MFT_SEPARATOR;
    }
  
  }*/

  this() {

    __hMenu = CreateMenu();
      
    MENUINFO  __mi;

    __mi.cbSize = MENUINFO.sizeof;
    __mi.fMask  = MIM_MENUDATA | MIM_STYLE;
    __mi.dwStyle = MNS_NOTIFYBYPOS;
    __mi.dwMenuData = cast(DWORD*) cast(void*) this;

    SetMenuInfo( __hMenu, &__mi);

  }
  
/*  void add( BaseItem i ) {
    MENUITEMINFOA  __miif;
    i.fill( &__miif );
    InsertMenuItemA( __hMenu, size(),TRUE, &__miif );
  }  */
  
  int size() {
    return GetMenuItemCount( __hMenu );
  }
    
  HMENU handle() {
    return __hMenu; 
  }
  
private:
  HMENU   __hMenu;
}

