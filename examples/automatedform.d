import framework.gui;


/*
	Automated Form example
	
	Automated Form class provides functionality for layout managent. Currently it automatically 
  manages the docking of the controls in the form.
	
  Splitters and dynamic docking will be added in the future. 
	
*/




class MainForm : AutomatedForm {
  
  this( Window pParent, Rectangle pRectangle ) {
    super( pParent, pRectangle, "Automated Form Example" );
    // Create controls
    button1 = new Button( this, 
                          new Rectangle( new Position( 0, 0) , new Size(   0, 50)),
                          "Button 1" );
    button2 = new Button( this,
                          new Rectangle( new Position( 0, 0) , new Size( 100,  0)),
                          "Button 2" );
    button3 = new Button( this, new Rectangle(), "Button 3" );
    
//    button4 = new Button( this, new Rectangle(), "Button 3" );
    
    add( DockFactory.create( "BOTTOM",  button1, false ) );
    add( DockFactory.create( "LEFT",    button2, false ) );
    add( DockFactory.create( "FILL",    button3, false ) );
    
  }
  
  Button      button1,
              button2,
              button3;
}

int main() {
  MainForm mainForm = new MainForm( Application.desktop, new Rectangle( 0, 0, 320, 240 ) );
  return Application.runEventLoop( mainForm, true );
}

