
dmd -c -O framework\c\image\jpeg_imp.d
dmd -c -O framework\c\xml_imp.d

lib -n -c framework\c\lib\imports.lib jpeg_imp.obj xml_imp.obj framework\c\lib\sqlite.lib

dmd -c -O framework\implementation\collections\array.d
dmd -c -O framework\implementation\collections\list.d
dmd -c -O framework\implementation\collections\graph.d
dmd -c -O framework\implementation\collections\queue.d

dmd -c -O framework\implementation\database\sqlite3.d

dmd -c -O framework\xml.d
dmd -c -O framework\serialstream.d
dmd -c -O framework\dllutils.d

dmd -c -O framework\implementation\gui\position.d
dmd -c -O framework\implementation\gui\size.d
dmd -c -O framework\implementation\gui\rectangle.d
dmd -c -O framework\implementation\gui\systemevent.d
dmd -c -O framework\implementation\gui\ievent.d
dmd -c -O framework\implementation\gui\ieventarray.d
dmd -c -O framework\implementation\gui\event.d
dmd -c -O framework\implementation\gui\eventarray.d
dmd -c -O framework\implementation\gui\eventdispatcher.d
dmd -c -O framework\implementation\gui\menu.d
dmd -c -O framework\implementation\gui\window.d
dmd -c -O framework\implementation\gui\form.d
dmd -c -O framework\implementation\gui\statedwindow.d
dmd -c -O framework\implementation\gui\automatedform.d
dmd -c -O framework\implementation\gui\graphics.d
dmd -c -O framework\implementation\gui\exceptions.d
dmd -c -O framework\implementation\gui\eventargs.d
dmd -c -O framework\implementation\gui\controls.d
dmd -c -O framework\implementation\gui\toolbox.d
dmd -c -O framework\implementation\gui\dockmanager.d
dmd -c -O framework\implementation\gui\treeview.d
dmd -c -O framework\implementation\gui\grid.d
dmd -c -O framework\implementation\gui\datacontrols.d
dmd -c -O framework\implementation\gui\application.d

dmd -c -O framework\implementation\image\image.d
dmd -c -O framework\implementation\image\bmp.d
dmd -c -O framework\implementation\image\jpeg.d

lib -n -c framework\lib\framework.lib array.obj list.obj graph.obj queue.obj sqlite3.obj window.obj graphics.obj systemevent.obj eventargs.obj exceptions.obj position.obj size.obj rectangle.obj ievent.obj ieventarray.obj event.obj eventarray.obj eventdispatcher.obj statedwindow.obj automatedform.obj menu.obj form.obj controls.obj toolbox.obj dockmanager.obj treeview.obj grid.obj image.obj jpeg.obj bmp.obj datacontrols.obj application.obj serialstream.obj dllutils.obj xml.obj ..\dm\lib\gdi32.lib ..\dm\lib\comdlg32.lib ..\dm\lib\comctl32.lib framework\c\lib\imports.lib

dmd -c -O framework\implementation\math\matrix.d
dmd -c -O framework\implementation\math\linear.d
dmd -c -O framework\implementation\math\matrixerrors.d

lib -n -c framework\lib\math.lib matrix.obj linear.obj matrixerrors.obj

del *.obj


