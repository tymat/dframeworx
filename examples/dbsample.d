import framework.gui;
import framework.database;

/*

  dbsample application v0.1.1
  
  This example demonstrates how to use data objects and the GUI.
  
  To build this file execute build-dbsample.bat
  
  Before executing dbsample be sure that friends.db and the necessarey dll's are in the same directory.
  
  This file is in public domain

*/


import framework.collections;

import std.string;
import std.conv;

/*
  FriendDatabase class is an interface for the application database.
*/

class FriendDatabase {
  
  static this() {
    db =  new SQLite3Database( "friends.db" );
    cmd = new SQLite3Command( db );
  }

  static Table searchFriend( char[] name,
                             char[] surname ) {
    char[]  sqlString;
    
    sqlString ~= "select * from FRIENDS ";
    sqlString ~= "where NAME like '" ~ name ~ "%' ";
    sqlString ~= "and SURNAME like '" ~ surname ~ "%';";
    
    cmd.execute( sqlString );
    return cmd.results();
  }

  static Table getFriendDetails( int friendId ) {

    char[]  sqlString;

    sqlString = "select * from FRIENDS ";
    sqlString ~= "where FRIEND_ID=" ~ std.string.toString( friendId ) ~ ";";

    cmd.execute( sqlString );

    return cmd.results();
  }
  
  
  static void editFriend( int friendId,
                          char[] name,
                          char[] surname ) {
    char[]  sqlString;

    sqlString ~= "update FRIENDS set ";
    sqlString ~= "NAME='" ~ name ~ "',";
    sqlString ~= "SURNAME='" ~ surname ~ "' ";
    sqlString ~= "where FRIEND_ID=" ~ std.string.toString( friendId ) ~ ";";

    cmd.execute( sqlString );
    
  }
  
  static int addFriend( char[] name,
                        char[] surname ) {
    char[]  sqlString;
    
    sqlString ~= "insert into FRIENDS( NAME, SURNAME ) values ('";
    sqlString ~= name ~ "','";
    sqlString ~= surname ~ "');";

    cmd.execute( sqlString );
    
    cmd.execute( "select MAX(FRIEND_ID) from FRIENDS;" );
    
    return std.conv.toInt( cmd.results()[0][0].value() );
  }
 
  static void removeFriend( int friendId ) { // Remove from the database , remove from my heart
    char[]  sqlString;
    
    sqlString = "delete from FRIENDS where ";
    sqlString ~= "FRIEND_ID=" ~ std.string.toString( friendId ) ~ ";";

    cmd.execute( sqlString );
  }
  
  private static SQLite3Database    db;
  private static SQLite3Command     cmd;
}  

/*
  Friend Detail Form allows user to edit or add new records to the database
*/

class FriendDetailForm : Form {

  this( Window pParent, Table pFriend, char[] pMode ) {
    
    if( pFriend !is null ) {
      mFriend  = pFriend;
    }
    
    if( pMode == "ADD" || pMode=="EDIT" ) {
      __mode = pMode;
    } else {
      throw new Exception("Mode Unknown");
    }
    
    super( pParent, new Rectangle( 0, 0, 265, 120), "Friend Details" );

    label1            = new Label( this, new Rectangle( 5, 6,80, 24 ), "Friend Id" );
    label2            = new Label( this, new Rectangle( 5, 31,80, 49 ), "Name" );
    label3            = new Label( this, new Rectangle( 5, 56,80, 74 ), "Surname" );

    friendIdTextBox  = new TextBox( this, new Rectangle( 85, 5, 180, 25 ), (mFriend is null ) ? "" : mFriend[0]["FRIEND_ID"].value() );
    friendIdTextBox.readOnly( true );
    nameTextBox        = new TextBox( this, new Rectangle( 85, 30, 180, 50 ), (mFriend is null ) ? "" : mFriend[0]["NAME"].value(), 20 , false );
    surnameTextBox     = new TextBox( this, new Rectangle( 85, 55, 180, 75 ), (mFriend is null ) ? "" : mFriend[0]["SURNAME"].value(), 20, false );

    applyButton            = new Button( this, new Rectangle( 200, 5, 255,  25 ), "Apply" );
    closeButton            = new Button( this, new Rectangle( 200, 30, 255, 50 ), "Close" );
    
    applyButton.add( new Button.ClickedEvent( &applyButton_onClick ) );
    closeButton.add( new Button.ClickedEvent( &closeButton_onClick ) );
    
  }
  
  void applyButton_onClick( Button.EventArgs e ) 
  in {
    applyButton.disable();
  }
  out {
    applyButton.enable();
  }
  body {
    try {
      if( __mode == "EDIT" ) {
        FriendDatabase.editFriend(  std.conv.toInt( friendIdTextBox.text() ),
                                    nameTextBox.text(),
                                    surnameTextBox.text() );
      } else if( __mode == "ADD" ) {
        friendIdTextBox.text(
          std.string.toString(
            FriendDatabase.addFriend( nameTextBox.text(),
                                      surnameTextBox.text() )
          )
        );
        __mode == "EDIT";
      } 
    } catch( Exception e ) {
      Application.showErrorMessage( e.toString(), Application.MessageBoxTypes.Ok );
    }
  }

  void closeButton_onClick( Button.EventArgs e  ) {
    modalResult( ModalResult.Ok );
    close();
  }
  
  
  Label   label1,
          label2,
          label3;

  TextBox friendIdTextBox,
          nameTextBox,
          surnameTextBox;

  Button  applyButton,
          closeButton;
          
  DataGrid    cihazlarGrid;
  
  Table   mFriend;
  
  char[]  __mode;
}

class MainForm : Form {
 
  this( Window pParent, Rectangle pRectangle ) {
    // Before creating controls and other layout objects the base constructor must be called.
    super( pParent, pRectangle, "Database Sample" );
    // Then create controls and add events
    /*  
      * Window.add method is used for adding event handlers 
      add( new SizeEvent( &mainForm_onSize ) );
      * SizeEvent and more Events are defined in framework\implementation\gui\window.d file
    */

    label2 =              new Label( this, new Rectangle( 5, 26,100, 44 ), "Name" );
    label3 =              new Label( this, new Rectangle( 5, 51,100, 69 ), "Surname" );
    label4 =              new Label( this, new Rectangle( 5, 81,100, 104 ), "Records Found" );
    
    nameTextBox =         new TextBox( this, new Rectangle( 105, 25, 200, 45 ), "" , 20 , false);
    surnameTextBox =      new TextBox( this, new Rectangle( 105, 50, 200, 70 ), "", 20, false );
    
    searchButton =        new Button( this, new Rectangle( 240, 25, 305, 50 ), "Search" );
    addFriendButton =     new Button( this, new Rectangle( 490, 75, 555, 100 ), "Add" );
    removeFriendButton =  new Button( this, new Rectangle( 560, 75, 625, 100 ), "Remove" );
    
    searchButton.add( new Button.ClickedEvent( &searchButton_onClick ) );
    addFriendButton.add( new Button.ClickedEvent( &addFriendButton_onClick ) );
    removeFriendButton.add( new Button.ClickedEvent( &removeFriendButton_onClick ) );
    
    friendsGrid    = new DataGrid( this, new Rectangle( 5, 105, 625, 430 ) );
    friendsGrid.add( new Grid.CellDblClickedEvent( &friendsGrid_onCellDblClicked ) );
  }

  void searchButton_onClick( Button.EventArgs e ) {
    search();
  }

  void friendsGrid_onCellDblClicked( EventArgs e ) {
    // Here we found the friend id value of the selected row
    Rectangle r = friendsGrid.adaptor().selection(); // To do this we obtain the selection rectangle 
    int friendId = std.conv.toInt(
                    /* then for the first selected row  and column we obtain the text value and 
                       convert  it to int */
                      ( cast(DataGrid.Formatter) friendsGrid.adaptor()[ r.y(), 0 ] ).text() 
                    );
    // Then open the detail form for the selection
    FriendDetailForm form = new FriendDetailForm( 
      this,
      FriendDatabase.getFriendDetails ( friendId ),
      "EDIT"
    );
    form.showModal();
    search(); // refresh grid after closing the detail form
  }
  
  void addFriendButton_onClick( Button.EventArgs e  ) {
    FriendDetailForm form = new FriendDetailForm ( this, null, "ADD" );
    form.showModal();
    search();
  }
 
  void removeFriendButton_onClick( Button.EventArgs e  ) {
    if( friendsGrid.adaptor().isSelectionValid() ) {
      Rectangle r = friendsGrid.adaptor().selection();
      int friendId = std.conv.toInt(
                         ( cast(DataGrid.Formatter) friendsGrid.adaptor()[ r.y(), 0 ] ).text()
                      );
      FriendDatabase.removeFriend( friendId );
      search();
    }
  }
 
  void search() {
    friendsGrid.table(
      FriendDatabase.searchFriend(  nameTextBox.text(),
                                    surnameTextBox.text() )
    );
  }
 
  Label       label1,
              label2,
              label3,
              label4;
  
  TextBox     nameTextBox,
              surnameTextBox;
          
  Button      searchButton,
              addFriendButton,
              removeFriendButton;
  
  DataGrid    friendsGrid;
}  

int main() {
  // Create instance of MainForm
  MainForm mainForm = new MainForm( Application.desktop, new Rectangle( 0, 0, 640, 480 ) );
  // Pass it to event loop. The second parameter indicates whether the event loops waits for a event or not
  // For gui applications pass 'true', to wait for events.
  return Application.runEventLoop( mainForm, true );
}