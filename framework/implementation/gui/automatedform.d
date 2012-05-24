module framework.implementation.gui.automatedform;

private {
  import framework.implementation.gui.dockmanager;
  import framework.implementation.gui.form;
}

class AutomatedForm : Form {

  this( Window pParent, Rectangle pRectangle, char[] pTitle ) {
    super( pParent, pRectangle, pTitle );
    mDockManager = new DockManager( this );
    Form.add( new SizeEvent( &AutomatedForm.onSize ) );
  }

  private void onSize( SizeEventArgs e ) {
    mDockManager.resize( clientRectangle() );
  }
  
  void add( DockInfo pDockInfo ) {
    mDockManager.add( pDockInfo );
  }
  
  DockManager dockManager() {
    return mDockManager;
  }
  
  DockManager mDockManager;
}
