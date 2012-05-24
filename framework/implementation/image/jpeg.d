/*
  This file is in public domain
*/

module framework.implementation.image.jpeg;

private {
  import std.stream;
  import framework.c.image.jpeg_imp;
  import framework.implementation.image.image;
}

extern (C) void initSource ( j_decompress_ptr cinfo ) {
	// DO NOTHING
}

extern (C) boolean fillInputBuffer( j_decompress_ptr cinfo ) {
	// DO NOTHING
	return 1;
}

extern (C) void skipInputData (j_decompress_ptr cinfo, long count) {
	jpeg_source_mgr* src = cinfo.src;
	if(count > 0)	{
	  printf("count:%d\n", count);
		src.bytes_in_buffer -= count;
		src.next_input_byte += count;
	}
}

extern (C) int resyncToRestart (j_decompress_ptr cinfo, int desired) {
	// DO NOTHING
	return 0;
}

extern (C) void termSource (j_decompress_ptr cinfo) {
	// DO NOTHING
}

Image loadJPEG( char[] name )
in {
  loadJPEG62();
}
body {
  // ...
  jpeg_error_mgr           jerr;   // "public" fields
  jpeg_source_mgr          jsrc;
  jpeg_decompress_struct   cinfo;
  
  Image   image;
  
  File  f = new File( name, FileMode.In );

  ubyte[] buffer;
  buffer = cast(ubyte[]) f.readString( f.size() );

	cinfo.err = jpeg_std_error( &jerr );
 
  jpeg_CreateDecompress( &cinfo, JPEG_LIB_VERSION, 432 /*jpeg_decompress_struct.sizeof*/ );
  
  jsrc.bytes_in_buffer  = buffer.length;
  jsrc.next_input_byte  = buffer.ptr;
  cinfo.src             = &jsrc;
  
  jsrc.init_source        = &initSource;
  jsrc.fill_input_buffer  = &fillInputBuffer;
  jsrc.skip_input_data    = &skipInputData;
  jsrc.resync_to_restart  = &resyncToRestart;
  jsrc.term_source        = &termSource;

  jpeg_read_header(&cinfo, TRUE );

  jpeg_calc_output_dimensions(&cinfo);
  
  jpeg_start_decompress(&cinfo);

/*  printf("image width=%d\n", cinfo.image_width );
  printf("image height=%d\n", cinfo.image_height );
  printf("number of components=%d\n", cinfo.num_components );*/
  
  if (cinfo.jpeg_color_space == J_COLOR_SPACE.JCS_GRAYSCALE)
    image = new GrayscaleImage( cinfo.image_width, cinfo.image_height, true );
  else
    image = new RGBImage( cinfo.image_width, cinfo.image_height, true );

  uint  rowSpan = image.logicalWidth() * cinfo.num_components;

/*  printf("rowSpan = %d\n", rowSpan ); */

  uint      rowsRead = 0;
  ubyte*    rowPtr;
  
/*  printf("Output Scanline = %d\n", cinfo.output_scanline ); // ????
  printf("Output Height   = %d\n", cinfo.output_height );*/

  while( rowsRead < cinfo.image_height ) {
    rowPtr = &image.data()[ (cinfo.image_height - rowsRead - 1 ) * rowSpan ];
    rowsRead += jpeg_read_scanlines( &cinfo, &rowPtr, 1 );
  }  

  jpeg_finish_decompress(&cinfo);
  jpeg_destroy_decompress(&cinfo);
  
  return image;
}  
