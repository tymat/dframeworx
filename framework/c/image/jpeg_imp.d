/*
 * jpeg.d is ported from jpeglib.h so same license terms are applied. 
 *
 * Copyright (C) 1991-1998, Thomas G. Lane.
 * This file is part of the Independent JPEG Group's software.
 * For conditions of distribution and use, see the accompanying README file.
 *
 * This file defines the application interface for the JPEG library.
 * Most applications using the library need only include this file,
 * and perhaps jerror.h if they want to know the exact error codes.
 * 
 * Ported by Selcuk IYIKALENDER 
 */


private {
  import std.c.stdio;
  import std.c.stdlib;
  import framework.c.windows;
}

private {
  HANDLE dllHandle;
}

void getProcedure( void** func, char[] symbolName ) {
  symbolName ~= "\0";
  *func = GetProcAddress( dllHandle, symbolName );
  if( *func is null ) {
    throw new Exception("Couldn't find procedure " ~ symbolName );
  }  
}  

void loadJPEG62() {

  if( dllHandle !is null )
    return;

  dllHandle = LoadLibraryW( "jpeg62.dll" );
  
  if( dllHandle is null ) {
    throw new Exception("Couldn't load jpeg62.dll");
  }
  
  getProcedure( cast(void**) &jpeg_CreateCompress, "jpeg_CreateCompress" );
  getProcedure( cast(void**) &jpeg_CreateDecompress, "jpeg_CreateDecompress" );
  getProcedure( cast(void**) &jpeg_std_error, "jpeg_std_error" );
  getProcedure( cast(void**) &jpeg_CreateCompress, "jpeg_CreateCompress" );
  getProcedure( cast(void**) &jpeg_CreateDecompress, "jpeg_CreateDecompress" );
  getProcedure( cast(void**) &jpeg_destroy_compress, "jpeg_destroy_compress" );
  getProcedure( cast(void**) &jpeg_destroy_decompress, "jpeg_destroy_decompress" );
  getProcedure( cast(void**) &jpeg_stdio_dest, "jpeg_stdio_dest" );
  getProcedure( cast(void**) &jpeg_stdio_src, "jpeg_stdio_src" );
  getProcedure( cast(void**) &jpeg_set_defaults, "jpeg_set_defaults" );
  getProcedure( cast(void**) &jpeg_default_colorspace, "jpeg_default_colorspace" );
  getProcedure( cast(void**) &jpeg_set_quality, "jpeg_set_quality" );
  getProcedure( cast(void**) &jpeg_set_linear_quality, "jpeg_set_linear_quality" );
  getProcedure( cast(void**) &jpeg_add_quant_table, "jpeg_add_quant_table" );
  getProcedure( cast(void**) &jpeg_simple_progression, "jpeg_simple_progression" );
  getProcedure( cast(void**) &jpeg_suppress_tables, "jpeg_suppress_tables" );
  getProcedure( cast(void**) &jpeg_alloc_quant_table, "jpeg_alloc_quant_table" );
  getProcedure( cast(void**) &jpeg_alloc_huff_table, "jpeg_alloc_huff_table" );
  getProcedure( cast(void**) &jpeg_start_compress, "jpeg_start_compress" );
  getProcedure( cast(void**) &jpeg_write_scanlines, "jpeg_write_scanlines" );
  getProcedure( cast(void**) &jpeg_finish_compress, "jpeg_finish_compress" );
  getProcedure( cast(void**) &jpeg_write_raw_data, "jpeg_write_raw_data" );
  getProcedure( cast(void**) &jpeg_write_marker, "jpeg_write_marker" );
  getProcedure( cast(void**) &jpeg_write_m_header, "jpeg_write_m_header" );
  getProcedure( cast(void**) &jpeg_write_m_byte, "jpeg_write_m_byte" );
  getProcedure( cast(void**) &jpeg_write_tables, "jpeg_write_tables" );
  getProcedure( cast(void**) &jpeg_write_marker, "jpeg_write_marker" );
  getProcedure( cast(void**) &jpeg_read_header, "jpeg_read_header" );
  getProcedure( cast(void**) &jpeg_start_decompress, "jpeg_start_decompress" );
  getProcedure( cast(void**) &jpeg_read_scanlines, "jpeg_read_scanlines" );
  getProcedure( cast(void**) &jpeg_finish_decompress, "jpeg_finish_decompress" );
  getProcedure( cast(void**) &jpeg_read_raw_data, "jpeg_read_raw_data" );
  getProcedure( cast(void**) &jpeg_has_multiple_scans, "jpeg_has_multiple_scans" );
  getProcedure( cast(void**) &jpeg_start_output, "jpeg_start_output" );
  getProcedure( cast(void**) &jpeg_finish_output, "jpeg_finish_output" );
  getProcedure( cast(void**) &jpeg_input_complete, "jpeg_input_complete" );
  getProcedure( cast(void**) &jpeg_new_colormap, "jpeg_new_colormap" );
  getProcedure( cast(void**) &jpeg_consume_input, "jpeg_consume_input" );
  getProcedure( cast(void**) &jpeg_calc_output_dimensions, "jpeg_calc_output_dimensions" );
  getProcedure( cast(void**) &jpeg_save_markers, "jpeg_save_markers" );
  getProcedure( cast(void**) &jpeg_read_coefficients, "jpeg_read_coefficients" );
  getProcedure( cast(void**) &jpeg_write_coefficients, "jpeg_write_coefficients" );
  getProcedure( cast(void**) &jpeg_copy_critical_parameters, "jpeg_copy_critical_parameters" );
  getProcedure( cast(void**) &jpeg_abort_compress, "jpeg_abort_compress" );
  getProcedure( cast(void**) &jpeg_abort_decompress, "jpeg_abort_decompress" );
  getProcedure( cast(void**) &jpeg_abort, "jpeg_abort" );
  getProcedure( cast(void**) &jpeg_destroy, "jpeg_destroy" );
  getProcedure( cast(void**) &jpeg_resync_to_restart, "jpeg_resync_to_restart" );

  // get procedures
}  


static ~this() {
//  freeJPEG62();
}


extern (C) :

const int JPEG_LIB_VERSION = 62;	/* Version 6b */

alias uint          JDIMENSION;

alias ubyte         UINT8;
alias ushort        UINT16;
alias uint          UINT32;

alias ubyte         JSAMPLE;
alias ubyte         JOCTET;
alias ushort        JCOEF;

alias int           boolean;


enum {
 DCTSIZE=8,	/* The basic DCT block is 8x8 samples */
 DCTSIZE2=64,	/* DCTSIZE squared; # of elements in a block */
 NUM_QUANT_TBLS=4,	/* Quantization tables are numbered 0..3 */
 NUM_HUFF_TBLS=4,	/* Huffman tables are numbered 0..3 */
 NUM_ARITH_TBLS=16,	/* Arith-coding tables are numbered 0..15 */
 MAX_COMPS_IN_SCAN=4,	/* JPEG limit on # of components in one scan */
 MAX_SAMP_FACTOR=4,	/* JPEG limit on sampling factors */

/* Unfortunately, some bozo at Adobe saw no reason to be bound by the standard;
 * the PostScript DCT filter can emit files with many more than 10 blocks/MCU.
 * If you happen to run across such a file, you can up D_MAX_BLOCKS_IN_MCU
 * to handle it.  We even let you do this from the jconfig.h file.  However,
 * we strongly discourage changing C_MAX_BLOCKS_IN_MCU; just because Adobe
 * sometimes emits noncompliant files doesn't mean you should too.
 */

 C_MAX_BLOCKS_IN_MCU=10, /* compressor's limit on blocks per MCU */
 D_MAX_BLOCKS_IN_MCU=10, /* decompressor's limit on blocks per MCU */
}


alias JSAMPLE*      JSAMPROW;	    /* ptr to one image row of pixel samples.*/
alias JSAMPROW*     JSAMPARRAY;	      /* ptr to some rows (a 2-D sample array)*/
alias JSAMPARRAY*   JSAMPIMAGE;	    /* a 3-D sample array: top index is color*/

alias JCOEF         JBLOCK[DCTSIZE2];	    /* one block of coefficients*/
alias JBLOCK*       JBLOCKROW;	   /* pointer to one row of coefficient blocks*/
alias JBLOCKROW*    JBLOCKARRAY;		 /* a 2-D array of coefficient blocks*/
alias JBLOCKARRAY*  JBLOCKIMAGE;	  /* a 3-D array of coefficient blocks*/

alias JCOEF*        JCOEFPTR;	/* useful in a couple of places*/


struct JQUANT_TBL {
  /* This array gives the coefficient quantizers in natural array order
   * (not the zigzag order in which they are stored in a JPEG DQT marker).
   * CAUTION: IJG versions prior to v6a kept this array in zigzag order.
   */
  UINT16 quantval[DCTSIZE2];	/* quantization step for each coefficient */
  /* This field is used only during compression.  It's initialized FALSE when
   * the table is created, and set TRUE when it's been output to the file.
   * You could suppress output of a table by setting this to TRUE.
   * (See jpeg_suppress_tables for an example.)
   */
  boolean sent_table;		/* TRUE when table has been output */
}


/* Huffman coding tables. */

struct JHUFF_TBL{
  /* These two fields directly represent the contents of a JPEG DHT marker */
  UINT8 bits[17];		/* bits[k] = # of symbols with codes of */
				/* length k bits; bits[0] is unused */
  UINT8 huffval[256];		/* The symbols, in order of incr code length */
  /* This field is used only during compression.  It's initialized FALSE when
   * the table is created, and set TRUE when it's been output to the file.
   * You could suppress output of a table by setting this to TRUE.
   * (See jpeg_suppress_tables for an example.)
   */
  boolean sent_table;		/* TRUE when table has been output */
}


/* Basic info about one component (color channel). */

struct jpeg_component_info {
  /* These values are fixed over the whole image. */
  /* For compression, they must be supplied by parameter setup; */
  /* for decompression, they are read from the SOF marker. */
  int component_id;		/* identifier for this component (0..255) */
  int component_index;		/* its index in SOF or cinfo->comp_info[] */
  int h_samp_factor;		/* horizontal sampling factor (1..4) */
  int v_samp_factor;		/* vertical sampling factor (1..4) */
  int quant_tbl_no;		/* quantization table selector (0..3) */
  /* These values may vary between scans. */
  /* For compression, they must be supplied by parameter setup; */
  /* for decompression, they are read from the SOS marker. */
  /* The decompressor output side may not use these variables. */
  int dc_tbl_no;		/* DC entropy table selector (0..3) */
  int ac_tbl_no;		/* AC entropy table selector (0..3) */
  
  /* Remaining fields should be treated as private by applications. */
  
  /* These values are computed during compression or decompression startup: */
  /* Component's size in DCT blocks.
   * Any dummy blocks added to complete an MCU are not counted; therefore
   * these values do not depend on whether a scan is interleaved or not.
   */
  JDIMENSION width_in_blocks;
  JDIMENSION height_in_blocks;
  /* Size of a DCT block in samples.  Always DCTSIZE for compression.
   * For decompression this is the size of the output from one DCT block,
   * reflecting any scaling we choose to apply during the IDCT step.
   * Values of 1,2,4,8 are likely to be supported.  Note that different
   * components may receive different IDCT scalings.
   */
  int DCT_scaled_size;
  /* The downsampled dimensions are the component's actual, unpadded number
   * of samples at the main buffer (preprocessing/compression interface), thus
   * downsampled_width = ceil(image_width * Hi/Hmax)
   * and similarly for height.  For decompression, IDCT scaling is included, so
   * downsampled_width = ceil(image_width * Hi/Hmax * DCT_scaled_size/DCTSIZE)
   */
  JDIMENSION downsampled_width;	 /* actual width in samples */
  JDIMENSION downsampled_height; /* actual height in samples */
  /* This flag is used only for decompression.  In cases where some of the
   * components will be ignored (eg grayscale output from YCbCr image),
   * we can skip most computations for the unused components.
   */
  boolean component_needed;	/* do we need the value of this component? */

  /* These values are computed before starting a scan of the component. */
  /* The decompressor output side may not use these variables. */
  int MCU_width;		/* number of blocks per MCU, horizontally */
  int MCU_height;		/* number of blocks per MCU, vertically */
  int MCU_blocks;		/* MCU_width * MCU_height */
  int MCU_sample_width;		/* MCU width in samples, MCU_width*DCT_scaled_size */
  int last_col_width;		/* # of non-dummy blocks across in last MCU */
  int last_row_height;		/* # of non-dummy blocks down in last MCU */

  /* Saved quantization table for component; NULL if none yet saved.
   * See jdinput.c comments about the need for this information.
   * This field is currently used only for decompression.
   */
  JQUANT_TBL * quant_table;

  /* Private per-component storage for DCT or IDCT subsystem. */
  void * dct_table;
}


/* The script for encoding a multiple-scan file is an array of these: */

struct jpeg_scan_info {
  int comps_in_scan;		/* number of components encoded in this scan */
  int component_index[MAX_COMPS_IN_SCAN]; /* their SOF/comp_info[] indexes */
  int Ss, Se;			/* progressive JPEG spectral selection parms */
  int Ah, Al;			/* progressive JPEG successive approx. parms */
}

/* The decompressor can save APPn and COM markers in a list of these: */



struct jpeg_marker_struct {
  jpeg_saved_marker_ptr next;	/* next in list, or NULL */
  UINT8 marker;			/* marker code: JPEG_COM, or JPEG_APP0+n */
  uint original_length;	/* # bytes of data in the file */
  uint data_length;	/* # bytes of data saved at data[] */
  JOCTET* data;		/* the data contained in the marker */
  /* the marker length word is not counted in data_length or original_length */
}

alias jpeg_marker_struct* jpeg_saved_marker_ptr;

/* Known color spaces. */

enum J_COLOR_SPACE {
	JCS_UNKNOWN,		/* error/unspecified */
	JCS_GRAYSCALE,		/* monochrome */
	JCS_RGB,		/* red/green/blue */
	JCS_YCbCr,		/* Y/Cb/Cr (also known as YUV) */
	JCS_CMYK,		/* C/M/Y/K */
	JCS_YCCK		/* Y/Cb/Cr/K */
}

/* DCT/IDCT algorithm options. */

enum J_DCT_METHOD {
	JDCT_ISLOW,		/* slow but accurate integer algorithm */
	JDCT_IFAST,		/* faster, less accurate integer method */
	JDCT_FLOAT		/* floating-point: accurate, fast on fast HW */
}


//#ifndef JDCT_DEFAULT		/* may be overridden in jconfig.h */
//#define JDCT_DEFAULT  JDCT_ISLOW
//#endif
//#ifndef JDCT_FASTEST		/* may be overridden in jconfig.h */
//#define JDCT_FASTEST  JDCT_IFAST
//#endif

/* Dithering options for decompression. */

enum J_DITHER_MODE {
	JDITHER_NONE,		/* no dithering */
	JDITHER_ORDERED,	/* simple ordered dither */
	JDITHER_FS		/* Floyd-Steinberg error diffusion dither */
};


/* Common fields between JPEG compression and decompression master structs. */

//#define jpeg_common_fields \ {
//jpeg_error_mgr*     err;	/* Error handler module */\
//jpeg_memory_mgr*    mem;	/* Memory manager module */\
//jpeg_progress_mgr*  progress; /* Progress monitor, or NULL if none */\
//void*               client_data;		/* Available for use by application */\
//boolean             is_decompressor;	/* So common code can tell which is which */\
//int                 global_state		/* For checking call sequence validity */
// } jpeg_common_fields

/* Routines that are to be used by both halves of the library are declared
 * to receive a pointer to this structure.  There are no actual instances of
 * jpeg_common_struct, only of jpeg_compress_struct and jpeg_decompress_struct.
 */

struct jpeg_common_struct {
//  jpeg_common_fields;		/* Fields common to both master struct types */
  jpeg_error_mgr*     err;	/* Error handler module */
  jpeg_memory_mgr*    mem;	/* Memory manager module */
  jpeg_progress_mgr*  progress; /* Progress monitor, or NULL if none */
  void*               client_data;		/* Available for use by application */
  boolean             is_decompressor;	/* So common code can tell which is which */
  int                 global_state;		/* For checking call sequence validity */

  /* Additional fields follow in an actual jpeg_compress_struct or
   * jpeg_decompress_struct.  All three structs must agree on these
   * initial fields!  (This would be a lot cleaner in C++.)
   */
};

alias jpeg_common_struct*      j_common_ptr;
alias jpeg_compress_struct*    j_compress_ptr;
alias jpeg_decompress_struct*  j_decompress_ptr;

/* Master record for a compression instance */

struct jpeg_compress_struct {
//  jpeg_common_fields;		/* Fields shared with jpeg_decompress_struct */
  jpeg_error_mgr*     err;	/* Error handler module */
  jpeg_memory_mgr*    mem;	/* Memory manager module */
  jpeg_progress_mgr*  progress; /* Progress monitor, or NULL if none */
  void*               client_data;		/* Available for use by application */
  boolean             is_decompressor;	/* So common code can tell which is which */
  int                 global_state;		/* For checking call sequence validity */

  /* Destination for compressed data */
  jpeg_destination_mgr * dest;

  /* Description of source image --- these fields must be filled in by
   * outer application before starting compression.  in_color_space must
   * be correct before you can even call jpeg_set_defaults().
   */

  JDIMENSION image_width;	/* input image width */
  JDIMENSION image_height;	/* input image height */
  int input_components;		/* # of color components in input image */
  J_COLOR_SPACE in_color_space;	/* colorspace of input image */

  double input_gamma;		/* image gamma of input image */

  /* Compression parameters --- these fields must be set before calling
   * jpeg_start_compress().  We recommend calling jpeg_set_defaults() to
   * initialize everything to reasonable defaults, then changing anything
   * the application specifically wants to change.  That way you won't get
   * burnt when new parameters are added.  Also note that there are several
   * helper routines to simplify changing parameters.
   */

  int data_precision;		/* bits of precision in image data */

  int num_components;		/* # of color components in JPEG image */
  J_COLOR_SPACE jpeg_color_space; /* colorspace of JPEG image */

  jpeg_component_info * comp_info;
  /* comp_info[i] describes component that appears i'th in SOF */
  
  JQUANT_TBL * quant_tbl_ptrs[NUM_QUANT_TBLS];
  /* ptrs to coefficient quantization tables, or NULL if not defined */
  
  JHUFF_TBL * dc_huff_tbl_ptrs[NUM_HUFF_TBLS];
  JHUFF_TBL * ac_huff_tbl_ptrs[NUM_HUFF_TBLS];
  /* ptrs to Huffman coding tables, or NULL if not defined */
  
  UINT8 arith_dc_L[NUM_ARITH_TBLS]; /* L values for DC arith-coding tables */
  UINT8 arith_dc_U[NUM_ARITH_TBLS]; /* U values for DC arith-coding tables */
  UINT8 arith_ac_K[NUM_ARITH_TBLS]; /* Kx values for AC arith-coding tables */

  int num_scans;		/* # of entries in scan_info array */
  const jpeg_scan_info * scan_info; /* script for multi-scan file, or NULL */
  /* The default value of scan_info is NULL, which causes a single-scan
   * sequential JPEG file to be emitted.  To create a multi-scan file,
   * set num_scans and scan_info to point to an array of scan definitions.
   */

  boolean raw_data_in;		/* TRUE=caller supplies downsampled data */
  boolean arith_code;		/* TRUE=arithmetic coding, FALSE=Huffman */
  boolean optimize_coding;	/* TRUE=optimize entropy encoding parms */
  boolean CCIR601_sampling;	/* TRUE=first samples are cosited */
  int smoothing_factor;		/* 1..100, or 0 for no input smoothing */
  J_DCT_METHOD dct_method;	/* DCT algorithm selector */

  /* The restart interval can be specified in absolute MCUs by setting
   * restart_interval, or in MCU rows by setting restart_in_rows
   * (in which case the correct restart_interval will be figured
   * for each scan).
   */
  uint restart_interval; /* MCUs per restart, or 0 for no restart */
  int restart_in_rows;		/* if > 0, MCU rows per restart interval */

  /* Parameters controlling emission of special markers. */

  boolean write_JFIF_header;	/* should a JFIF marker be written? */
  UINT8 JFIF_major_version;	/* What to write for the JFIF version number */
  UINT8 JFIF_minor_version;
  /* These three values are not used by the JPEG code, merely copied */
  /* into the JFIF APP0 marker.  density_unit can be 0 for unknown, */
  /* 1 for dots/inch, or 2 for dots/cm.  Note that the pixel aspect */
  /* ratio is defined by X_density/Y_density even when density_unit=0. */
  UINT8 density_unit;		/* JFIF code for pixel size units */
  UINT16 X_density;		/* Horizontal pixel density */
  UINT16 Y_density;		/* Vertical pixel density */
  boolean write_Adobe_marker;	/* should an Adobe marker be written? */
  
  /* State variable: index of next scanline to be written to
   * jpeg_write_scanlines().  Application may use this to control its
   * processing loop, e.g., "while (next_scanline < image_height)".
   */

  JDIMENSION next_scanline;	/* 0 .. image_height-1  */

  /* Remaining fields are known throughout compressor, but generally
   * should not be touched by a surrounding application.
   */

  /*
   * These fields are computed during compression startup
   */
  boolean progressive_mode;	/* TRUE if scan script uses progressive mode */
  int max_h_samp_factor;	/* largest h_samp_factor */
  int max_v_samp_factor;	/* largest v_samp_factor */

  JDIMENSION total_iMCU_rows;	/* # of iMCU rows to be input to coef ctlr */
  /* The coefficient controller receives data in units of MCU rows as defined
   * for fully interleaved scans (whether the JPEG file is interleaved or not).
   * There are v_samp_factor * DCTSIZE sample rows of each component in an
   * "iMCU" (interleaved MCU) row.
   */
  
  /*
   * These fields are valid during any one scan.
   * They describe the components and MCUs actually appearing in the scan.
   */
  int comps_in_scan;		/* # of JPEG components in this scan */
  jpeg_component_info * cur_comp_info[MAX_COMPS_IN_SCAN];
  /* *cur_comp_info[i] describes component that appears i'th in SOS */
  
  JDIMENSION MCUs_per_row;	/* # of MCUs across the image */
  JDIMENSION MCU_rows_in_scan;	/* # of MCU rows in the image */
  
  int blocks_in_MCU;		/* # of DCT blocks per MCU */
  int MCU_membership[C_MAX_BLOCKS_IN_MCU];
  /* MCU_membership[i] is index in cur_comp_info of component owning */
  /* i'th block in an MCU */

  int Ss, Se, Ah, Al;		/* progressive JPEG parameters for scan */

  /*
   * Links to compression subobjects (methods and private variables of modules)
   */
//  jpeg_comp_master*       master;
//  jpeg_c_main_controller* main;
//  jpeg_c_prep_controller* prep;
//  jpeg_c_coef_controller* coef;
//  jpeg_marker_writer*     marker;
//  jpeg_color_converter*   cconvert;
//  jpeg_downsampler*       downsample;
//  jpeg_forward_dct*       fdct;
//  jpeg_entropy_encoder*   entropy;
//  jpeg_scan_info*         script_space; /* workspace for jpeg_simple_progression */

  void* master;
  void* main;
  void* prep;
  void* coef;
  void* marker;
  void* cconvert;
  void* downsample;
  void* fdct;
  void* entropy;
  void* script_space; /* workspace for jpeg_simple_progression */
  
  int script_space_size;
};


/* Master record for a decompression instance */

struct jpeg_decompress_struct {
//  jpeg_common_fields;		/* Fields shared with jpeg_compress_struct */
  jpeg_error_mgr*     err;	/* Error handler module */
  jpeg_memory_mgr*    mem;	/* Memory manager module */
  jpeg_progress_mgr*  progress; /* Progress monitor, or NULL if none */
  void*               client_data;		/* Available for use by application */
  boolean             is_decompressor;	/* So common code can tell which is which */
  int                 global_state;		/* For checking call sequence validity */

  /* Source of compressed data */
  jpeg_source_mgr*    src;

  /* Basic description of image --- filled in by jpeg_read_header(). */
  /* Application may inspect these values to decide how to process image. */

  JDIMENSION          image_width;	/* nominal image width (from SOF marker) */
  JDIMENSION          image_height;	/* nominal image height */
  int                 num_components;		/* # of color components in JPEG image */
  J_COLOR_SPACE       jpeg_color_space; /* colorspace of JPEG image */

  /* Decompression processing parameters --- these fields must be set before
   * calling jpeg_start_decompress().  Note that jpeg_read_header() initializes
   * them to default values.
   */

  J_COLOR_SPACE       out_color_space; /* colorspace for output */

  uint                scale_num, scale_denom; /* fraction by which to scale image */

  double              output_gamma;		/* image gamma wanted in output */

  boolean             buffered_image;	/* TRUE=multiple output passes */
  boolean             raw_data_out;		/* TRUE=downsampled data wanted */

  J_DCT_METHOD        dct_method;	/* IDCT algorithm selector */
  boolean             do_fancy_upsampling;	/* TRUE=apply fancy upsampling */
  boolean             do_block_smoothing;	/* TRUE=apply interblock smoothing */

  boolean             quantize_colors;	/* TRUE=colormapped output wanted */
  /* the following are ignored if not quantize_colors: */
  J_DITHER_MODE       dither_mode;	/* type of color dithering to use */
  boolean             two_pass_quantize;	/* TRUE=use two-pass color quantization */
  int                 desired_number_of_colors;	/* max # colors to use in created colormap */
  /* these are significant only in buffered-image mode: */
  boolean             enable_1pass_quant;	/* enable future use of 1-pass quantizer */
  boolean             enable_external_quant;/* enable future use of external colormap */
  boolean             enable_2pass_quant;	/* enable future use of 2-pass quantizer */

  /* Description of actual output image that will be returned to application.
   * These fields are computed by jpeg_start_decompress().
   * You can also use jpeg_calc_output_dimensions() to determine these values
   * in advance of calling jpeg_start_decompress().
   */

  JDIMENSION          output_width;	/* scaled image width */
  JDIMENSION          output_height;	/* scaled image height */
  int                 out_color_components;	/* # of color components in out_color_space */
  int                 output_components;	/* # of color components returned */
  /* output_components is 1 (a colormap index) when quantizing colors;
   * otherwise it equals out_color_components.
   */
  int                 rec_outbuf_height;	/* min recommended height of scanline buffer */
  /* If the buffer passed to jpeg_read_scanlines() is less than this many rows
   * high, space and time will be wasted due to unnecessary data copying.
   * Usually rec_outbuf_height will be 1 or 2, at most 4.
   */

  /* When quantizing colors, the output colormap is described by these fields.
   * The application can supply a colormap by setting colormap non-NULL before
   * calling jpeg_start_decompress; otherwise a colormap is created during
   * jpeg_start_decompress or jpeg_start_output.
   * The map has out_color_components rows and actual_number_of_colors columns.
   */
  int                 actual_number_of_colors;	/* number of entries in use */
  JSAMPARRAY          colormap;		/* The color map as a 2-D pixel array */

  /* State variables: these variables indicate the progress of decompression.
   * The application may examine these but must not modify them.
   */

  /* Row index of next scanline to be read from jpeg_read_scanlines().
   * Application may use this to control its processing loop, e.g.,
   * "while (output_scanline < output_height)".
   */
  JDIMENSION          output_scanline;	/* 0 .. output_height-1  */

  /* Current input scan number and number of iMCU rows completed in scan.
   * These indicate the progress of the decompressor input side.
   */
  int                 input_scan_number;	/* Number of SOS markers seen so far */
  JDIMENSION          input_iMCU_row;	/* Number of iMCU rows completed */

  /* The "output scan number" is the notional scan being displayed by the
   * output side.  The decompressor will not allow output scan/row number
   * to get ahead of input scan/row, but it can fall arbitrarily far behind.
   */
  int                 output_scan_number;	/* Nominal scan number being displayed */
  JDIMENSION          output_iMCU_row;	/* Number of iMCU rows read */

  /* Current progression status.  coef_bits[c][i] indicates the precision
   * with which component c's DCT coefficient i (in zigzag order) is known.
   * It is -1 when no data has yet been received, otherwise it is the point
   * transform (shift) value for the most recent scan of the coefficient
   * (thus, 0 at completion of the progression).
   * This pointer is NULL when reading a non-progressive file.
   */
  int (*coef_bits)[DCTSIZE2];	/* -1 or current Al value for each coef */

  /* Internal JPEG parameters --- the application usually need not look at
   * these fields.  Note that the decompressor output side may not use
   * any parameters that can change between scans.
   */

  /* Quantization and Huffman tables are carried forward across input
   * datastreams when processing abbreviated JPEG datastreams.
   */

  JQUANT_TBL * quant_tbl_ptrs[NUM_QUANT_TBLS];
  /* ptrs to coefficient quantization tables, or NULL if not defined */

  JHUFF_TBL * dc_huff_tbl_ptrs[NUM_HUFF_TBLS];
  JHUFF_TBL * ac_huff_tbl_ptrs[NUM_HUFF_TBLS];
  /* ptrs to Huffman coding tables, or NULL if not defined */

  /* These parameters are never carried across datastreams, since they
   * are given in SOF/SOS markers or defined to be reset by SOI.
   */

  int data_precision;		/* bits of precision in image data */

  jpeg_component_info * comp_info;
  /* comp_info[i] describes component that appears i'th in SOF */

  boolean progressive_mode;	/* TRUE if SOFn specifies progressive mode */
  boolean arith_code;		/* TRUE=arithmetic coding, FALSE=Huffman */

  UINT8 arith_dc_L[NUM_ARITH_TBLS]; /* L values for DC arith-coding tables */
  UINT8 arith_dc_U[NUM_ARITH_TBLS]; /* U values for DC arith-coding tables */
  UINT8 arith_ac_K[NUM_ARITH_TBLS]; /* Kx values for AC arith-coding tables */

  uint restart_interval; /* MCUs per restart interval, or 0 for no restart */

  /* These fields record data obtained from optional markers recognized by
   * the JPEG library.
   */
  boolean saw_JFIF_marker;	/* TRUE iff a JFIF APP0 marker was found */
  /* Data copied from JFIF marker; only valid if saw_JFIF_marker is TRUE: */
  UINT8 JFIF_major_version;	/* JFIF version number */
  UINT8 JFIF_minor_version;
  UINT8 density_unit;		/* JFIF code for pixel size units */
  UINT16 X_density;		/* Horizontal pixel density */
  UINT16 Y_density;		/* Vertical pixel density */
  boolean saw_Adobe_marker;	/* TRUE iff an Adobe APP14 marker was found */
  UINT8 Adobe_transform;	/* Color transform code from Adobe marker */

  boolean CCIR601_sampling;	/* TRUE=first samples are cosited */

  /* Aside from the specific data retained from APPn markers known to the
   * library, the uninterpreted contents of any or all APPn and COM markers
   * can be saved in a list for examination by the application.
   */
  jpeg_saved_marker_ptr marker_list; /* Head of list of saved markers */

  /* Remaining fields are known throughout decompressor, but generally
   * should not be touched by a surrounding application.
   */

  /*
   * These fields are computed during decompression startup
   */
  int max_h_samp_factor;	/* largest h_samp_factor */
  int max_v_samp_factor;	/* largest v_samp_factor */

  int min_DCT_scaled_size;	/* smallest DCT_scaled_size of any component */

  JDIMENSION total_iMCU_rows;	/* # of iMCU rows in image */
  /* The coefficient controller's input and output progress is measured in
   * units of "iMCU" (interleaved MCU) rows.  These are the same as MCU rows
   * in fully interleaved JPEG scans, but are used whether the scan is
   * interleaved or not.  We define an iMCU row as v_samp_factor DCT block
   * rows of each component.  Therefore, the IDCT output contains
   * v_samp_factor*DCT_scaled_size sample rows of a component per iMCU row.
   */

  JSAMPLE * sample_range_limit; /* table for fast range-limiting */

  /*
   * These fields are valid during any one scan.
   * They describe the components and MCUs actually appearing in the scan.
   * Note that the decompressor output side must not use these fields.
   */
  int comps_in_scan;		/* # of JPEG components in this scan */
  jpeg_component_info * cur_comp_info[MAX_COMPS_IN_SCAN];
  /* *cur_comp_info[i] describes component that appears i'th in SOS */

  JDIMENSION MCUs_per_row;	/* # of MCUs across the image */
  JDIMENSION MCU_rows_in_scan;	/* # of MCU rows in the image */

  int blocks_in_MCU;		/* # of DCT blocks per MCU */
  int MCU_membership[D_MAX_BLOCKS_IN_MCU];
  /* MCU_membership[i] is index in cur_comp_info of component owning */
  /* i'th block in an MCU */

  int Ss, Se, Ah, Al;		/* progressive JPEG parameters for scan */

  /* This field is shared between entropy decoder and marker parser.
   * It is either zero or the code of a JPEG marker that has been
   * read from the data source, but has not yet been processed.
   */
  int unread_marker;

  /*
   * Links to decompression subobjects (methods, private variables of modules)
   */
//  jpeg_decomp_master*     master;
//  jpeg_d_main_controller* main;
//  jpeg_d_coef_controller* coef;
//  jpeg_d_post_controller* post;
//  jpeg_input_controller*  inputctl;
//  jpeg_marker_reader*     marker;
//  jpeg_entropy_decoder*   entropy;
//  jpeg_inverse_dct*       idct;
//  jpeg_upsampler*         upsample;
//  jpeg_color_deconverter* cconvert;
//  jpeg_color_quantizer*   cquantize;

  void* master;
  void* main;
  void* coef;
  void* post;
  void* inputctl;
  void* marker;
  void* entropy;
  void* idct;
  void* upsample;
  void* cconvert;
  void* cquantize;

};


/* "Object" declarations for JPEG modules that may be supplied or called
 * directly by the surrounding application.
 * As with all objects in the JPEG library, these structs only define the
 * publicly visible methods and state variables of a module.  Additional
 * private fields may exist after the public ones.
 */

/* Error handler object */
// JMETHOD(type,methodname,arglist)  type (*methodname) arglist

// --> type function( arglist )   methodname;

//#define JMSG_LENGTH_MAX  200	/* recommended size of format_message buffer */
const int JMSG_LENGTH_MAX=      200;
const int  JMSG_STR_PARM_MAX=   80;

struct jpeg_error_mgr {
//  /* Error exit handler: does not return to caller */
//  JMETHOD(void, error_exit, (j_common_ptr cinfo));
//  /* Conditionally emit a trace or warning message */
//  JMETHOD(void, emit_message, (j_common_ptr cinfo, int msg_level));
//  /* Routine that actually outputs a trace or error message */
//  JMETHOD(void, output_message, (j_common_ptr cinfo));
//  /* Format a message string for the most recent JPEG error or message */
//  JMETHOD(void, format_message, (j_common_ptr cinfo, char * buffer));
//  /* Reset error state variables at start of a new image */
//  JMETHOD(void, reset_error_mgr, (j_common_ptr cinfo));

  void function(j_common_ptr)                         error_exit;
  void function(j_common_ptr cinfo, int msg_level)    emit_message;
  void function(j_common_ptr)                         output_message;
  void function(j_common_ptr cinfo, char * buffer)    format_message;
  void function(j_common_ptr)                         reset_error_mgr;

  /* The message ID code and any parameters are saved here.
   * A message can have one string parameter or up to 8 int parameters.
   */
  int msg_code;

  union msg_parm_t {
    int i[8];
    char s[JMSG_STR_PARM_MAX];
  } 
  
  msg_parm_t    msg_parm;
  
  /* Standard state variables for error facility */
  
  int trace_level;		/* max msg_level that will be displayed */
  
  /* For recoverable corrupt-data errors, we emit a warning message,
   * but keep going unless emit_message chooses to abort.  emit_message
   * should count warnings in num_warnings.  The surrounding application
   * can check for bad data by seeing if num_warnings is nonzero at the
   * end of processing.
   */
  long num_warnings;		/* number of corrupt-data warnings */

  /* These fields point to the table(s) of error message strings.
   * An application can change the table pointer to switch to a different
   * message list (typically, to change the language in which errors are
   * reported).  Some applications may wish to add additional error codes
   * that will be handled by the JPEG library error mechanism; the second
   * table pointer is used for this purpose.
   *
   * First table includes all errors generated by JPEG library itself.
   * Error code 0 is reserved for a "no such error string" message.
   */
  char ** jpeg_message_table; /* Library errors */
  int last_jpeg_message;    /* Table contains strings 0..last_jpeg_message */
  /* Second table can be added by application (see cjpeg/djpeg for example).
   * It contains strings numbered first_addon_message..last_addon_message.
   */
  const char** addon_message_table; /* Non-library errors */
  int first_addon_message;	/* code for first string in addon table */
  int last_addon_message;	/* code for last string in addon table */
};


/* Progress monitor object */

struct jpeg_progress_mgr {
//  JMETHOD(void, progress_monitor, (j_common_ptr cinfo));
  void function(j_common_ptr)                         progress_monitor;

  long pass_counter;		/* work units completed in this pass */
  long pass_limit;		/* total number of work units in this pass */
  int completed_passes;		/* passes completed so far */
  int total_passes;		/* total number of passes expected */
};


/* Data destination object for compression */

struct jpeg_destination_mgr {
  JOCTET * next_output_byte;	/* => next byte to write in buffer */
  size_t free_in_buffer;	/* # of byte spaces remaining in buffer */

//  JMETHOD(void, init_destination, (j_compress_ptr cinfo));
//  JMETHOD(boolean, empty_output_buffer, (j_compress_ptr cinfo));
//  JMETHOD(void, term_destination, (j_compress_ptr cinfo));
  
  void function(j_common_ptr)                         init_destination;
  boolean function(j_common_ptr)                      empty_output_buffer;
  void function(j_common_ptr)                         term_destination;
  
};


/* Data source object for decompression */

struct jpeg_source_mgr {
  JOCTET*   next_input_byte; /* => next byte to read from buffer */
  size_t    bytes_in_buffer;	/* # of bytes remaining in buffer */

//  JMETHOD(void, init_source, (j_decompress_ptr cinfo));
//  JMETHOD(boolean, fill_input_buffer, (j_decompress_ptr cinfo));
//  JMETHOD(void, skip_input_data, (j_decompress_ptr cinfo, long num_bytes));
//  JMETHOD(boolean, resync_to_restart, (j_decompress_ptr cinfo, int desired));
//  JMETHOD(void, term_source, (j_decompress_ptr cinfo));

  void function(j_decompress_ptr)                         init_source;
  boolean function(j_decompress_ptr)                      fill_input_buffer;
  void function(j_decompress_ptr, long num_bytes)         skip_input_data;
  boolean function(j_decompress_ptr, int desired)         resync_to_restart;
  void function(j_decompress_ptr)                         term_source;

};


/* Memory manager object.
 * Allocates "small" objects (a few K total), "large" objects (tens of K),
 * and "really big" objects (virtual arrays with backing store if needed).
 * The memory manager does not allow individual objects to be freed; rather,
 * each created object is assigned to a pool, and whole pools can be freed
 * at once.  This is faster and more convenient than remembering exactly what
 * to free, especially where malloc()/free() are not too speedy.
 * NB: alloc routines never return NULL.  They exit to error_exit if not
 * successful.
 */

//#define JPOOL_PERMANENT	0	/* lasts until master record is destroyed */
//#define JPOOL_IMAGE	1	/* lasts until done with image/datastream */
//#define JPOOL_NUMPOOLS	2

const int JPOOL_PERMANENT = 0;
const int JPOOL_IMAGE     = 1;
const int JPOOL_NUMPOOLS  = 2;

/*typedef struct jvirt_sarray_control * jvirt_sarray_ptr;
typedef struct jvirt_barray_control * jvirt_barray_ptr;*/

alias void*   jvirt_sarray_ptr;
alias void*   jvirt_barray_ptr;


struct jpeg_memory_mgr {
  /* Method pointers */
//  JMETHOD(void *, alloc_small, (j_common_ptr cinfo, int pool_id,
//				size_t sizeofobject));
//  JMETHOD(void FAR *, alloc_large, (j_common_ptr cinfo, int pool_id,
//				     size_t sizeofobject));
//  JMETHOD(JSAMPARRAY, alloc_sarray, (j_common_ptr cinfo, int pool_id,
//				     JDIMENSION samplesperrow,
//				     JDIMENSION numrows));
//  JMETHOD(JBLOCKARRAY, alloc_barray, (j_common_ptr cinfo, int pool_id,
//				      JDIMENSION blocksperrow,
//				      JDIMENSION numrows));
//  JMETHOD(jvirt_sarray_ptr, request_virt_sarray, (j_common_ptr cinfo,
//						  int pool_id,
//						  boolean pre_zero,
//						  JDIMENSION samplesperrow,
//						  JDIMENSION numrows,
//						  JDIMENSION maxaccess));
//  JMETHOD(jvirt_barray_ptr, request_virt_barray, (j_common_ptr cinfo,
//						  int pool_id,
//						  boolean pre_zero,
//						  JDIMENSION blocksperrow,
//						  JDIMENSION numrows,
//						  JDIMENSION maxaccess));
//  JMETHOD(void, realize_virt_arrays, (j_common_ptr cinfo));
//  JMETHOD(JSAMPARRAY, access_virt_sarray, (j_common_ptr cinfo,
//					   jvirt_sarray_ptr ptr,
//					   JDIMENSION start_row,
//					   JDIMENSION num_rows,
//					   boolean writable));
//  JMETHOD(JBLOCKARRAY, access_virt_barray, (j_common_ptr cinfo,
//					    jvirt_barray_ptr ptr,
//					    JDIMENSION start_row,
//					    JDIMENSION num_rows,
//					    boolean writable));
//  JMETHOD(void, free_pool, (j_common_ptr cinfo, int pool_id));
//  JMETHOD(void, self_destruct, (j_common_ptr cinfo));

  void* function(j_common_ptr cinfo, 
                 int pool_id, 
                 size_t sizeofobject)      alloc_small;

  void* function(j_common_ptr cinfo, 
                 int pool_id, 
                 size_t sizeofobject)      alloc_large;

  void* function(j_common_ptr cinfo, 
                 int pool_id,
				         JDIMENSION samplesperrow,
				         JDIMENSION numrows)      alloc_sarray;

  void* function(j_common_ptr cinfo, 
                 int pool_id,
				         JDIMENSION blocksperrow,
				         JDIMENSION numrows)      alloc_barray;

  void* function(j_common_ptr cinfo,
						  int pool_id,
						  boolean pre_zero,
						  JDIMENSION samplesperrow,
						  JDIMENSION numrows,
						  JDIMENSION maxaccess)      request_virt_sarray;

  void* function(j_common_ptr cinfo,
						  int pool_id,
						  boolean pre_zero,
						  JDIMENSION blocksperrow,
						  JDIMENSION numrows,
						  JDIMENSION maxaccess)      request_virt_barray;

  void* function(j_common_ptr cinfo)      realize_virt_arrays;


  void* function(j_common_ptr cinfo,
					   jvirt_sarray_ptr ptr,
					   JDIMENSION start_row,
					   JDIMENSION num_rows,
					   boolean writable)      access_virt_sarray;

  void* function(j_common_ptr cinfo,
					    jvirt_barray_ptr ptr,
					    JDIMENSION start_row,
					    JDIMENSION num_rows,
					    boolean writable)      access_virt_barray;

  void* function(j_common_ptr cinfo, int pool_id)      free_pool;

  void* function(j_common_ptr cinfo)      self_destruct;

  /* Limit on memory allocation for this JPEG object.  (Note that this is
   * merely advisory, not a guaranteed maximum; it only affects the space
   * used for virtual-array buffers.)  May be changed by outer application
   * after creating the JPEG object.
   */
  long max_memory_to_use;

  /* Maximum allocation request accepted by alloc_large. */
  long max_alloc_chunk;
};



//typedef JMETHOD(boolean, jpeg_marker_parser_method, (j_decompress_ptr cinfo));

alias boolean function(j_decompress_ptr cinfo)  jpeg_marker_parser_method;


/* Default error-management setup */
/*EXTERN(struct jpeg_error_mgr *) jpeg_std_error
	JPP((struct jpeg_error_mgr * err));*/

//export jpeg_error_mgr* jpeg_std_error( jpeg_error_mgr* );

jpeg_error_mgr* function(jpeg_error_mgr*)   jpeg_std_error;

/* Initialization of JPEG compression objects.
 * jpeg_create_compress() and jpeg_create_decompress() are the exported
 * names that applications should call.  These expand to calls on
 * jpeg_CreateCompress and jpeg_CreateDecompress with additional information
 * passed for version mismatch checking.
 * NB: you must set up the error-manager BEFORE calling jpeg_create_xxx.
 */
/*#define jpeg_create_compress(cinfo) \
    jpeg_CreateCompress((cinfo), JPEG_LIB_VERSION, \
			(size_t) sizeof(struct jpeg_compress_struct))
#define jpeg_create_decompress(cinfo) \
    jpeg_CreateDecompress((cinfo), JPEG_LIB_VERSION, \
			  (size_t) sizeof(struct jpeg_decompress_struct))*/

		  
/*export void jpeg_CreateCompress(  j_compress_ptr  cinfo,
				                          int             _version, 
                                  size_t          structsize);*/
                                  
void function(j_compress_ptr  cinfo,
              int             _version, 
              size_t          structsize)   jpeg_CreateCompress;

void (*jpeg_CreateDecompress)(j_decompress_ptr cinfo,
    					int              _version, 
              size_t           structsize);
/* Destruction of JPEG compression objects */
void function(j_compress_ptr cinfo) jpeg_destroy_compress;
void function(j_decompress_ptr cinfo) jpeg_destroy_decompress;

/* Standard data source and destination managers: stdio streams. */
/* Caller is responsible for opening the file before and closing after. */
void function(j_compress_ptr cinfo, FILE* outfile) jpeg_stdio_dest;
void function(j_decompress_ptr cinfo, FILE* infile) jpeg_stdio_src;

/* Default parameter setup for compression */
void function(j_compress_ptr cinfo) jpeg_set_defaults;
/* Compression parameter setup aids */
void function(j_compress_ptr cinfo,
				      J_COLOR_SPACE colorspace) jpeg_set_colorspace;
void function(j_compress_ptr cinfo) jpeg_default_colorspace;
void function(j_compress_ptr cinfo, 
              int quality,
				      boolean force_baseline) jpeg_set_quality;
void function(j_compress_ptr cinfo,
  					  int scale_factor,
              boolean force_baseline) jpeg_set_linear_quality;
void function( j_compress_ptr cinfo, 
               int            which_tbl,
				       uint*          basic_table,
				       int            scale_factor,
				       boolean        force_baseline ) jpeg_add_quant_table;

int function(int quality) jpeg_quality_scaling;
void function(j_compress_ptr cinfo) jpeg_simple_progression;
void function(j_compress_ptr cinfo,
				       boolean suppress) jpeg_suppress_tables;
JQUANT_TBL* function(j_common_ptr cinfo) jpeg_alloc_quant_table;
JHUFF_TBL*  function(j_common_ptr cinfo) jpeg_alloc_huff_table;

/* Main entry points for compression */
void function(j_compress_ptr cinfo,
				      boolean write_all_tables) jpeg_start_compress;
JDIMENSION function( j_compress_ptr cinfo,
      					     JSAMPARRAY scanlines,
      					     JDIMENSION num_lines) jpeg_write_scanlines;
void function (j_compress_ptr cinfo) jpeg_finish_compress ;

/* Replaces jpeg_write_scanlines when writing raw downsampled data. */
JDIMENSION function(j_compress_ptr cinfo,
      					    JSAMPIMAGE data,
      					    JDIMENSION num_lines) jpeg_write_raw_data;

/* Write a special marker.  See libjpeg.doc concerning safe usage. */
void function(j_compress_ptr cinfo, 
              int marker,
              JOCTET* dataptr, 
              uint datalen) jpeg_write_marker;
/* Same, but piecemeal. */
void function(j_compress_ptr cinfo, 
                int marker, 
                uint datalen ) jpeg_write_m_header;

void function(j_compress_ptr cinfo, 
              int val ) jpeg_write_m_byte;

/* Alternate compression function: just write an abbreviated table file */
void function(j_compress_ptr cinfo) jpeg_write_tables;

/* Decompression startup: read start of JPEG datastream to see what's there */
int function( j_decompress_ptr cinfo,
              boolean require_image) jpeg_read_header;
/* Return value is one of: */
enum {
  JPEG_SUSPENDED=           0, /* Suspended due to lack of input data */
  JPEG_HEADER_OK=           1, /* Found valid image datastream */
  JPEG_HEADER_TABLES_ONLY=  2, /* Found valid table-specs-only datastream */
}
/* If you pass require_image = TRUE (normal case), you need not check for
 * a TABLES_ONLY return code; an abbreviated file will cause an error exit.
 * JPEG_SUSPENDED is only possible if you use a data source module that can
 * give a suspension return (the stdio source module doesn't).
 */

/* Main entry points for decompression */
boolean function( j_decompress_ptr cinfo ) jpeg_start_decompress;
JDIMENSION function( j_decompress_ptr cinfo,
                    JSAMPARRAY scanlines,
                    JDIMENSION max_lines ) jpeg_read_scanlines;
boolean function( j_decompress_ptr cinfo ) jpeg_finish_decompress;

/* Replaces jpeg_read_scanlines when reading raw downsampled data. */
JDIMENSION function(j_decompress_ptr cinfo,
      					   JSAMPIMAGE data,
      					   JDIMENSION max_lines) jpeg_read_raw_data;

/* Additional entry points for buffered-image mode. */
boolean function(j_decompress_ptr cinfo) jpeg_has_multiple_scans;
boolean function(j_decompress_ptr cinfo,
  				       int scan_number) jpeg_start_output;
boolean function(j_decompress_ptr cinfo) jpeg_finish_output;
boolean function(j_decompress_ptr cinfo) jpeg_input_complete;
void function(j_decompress_ptr cinfo) jpeg_new_colormap;
int function(j_decompress_ptr cinfo) jpeg_consume_input;
/* Return value is one of: */
/*   JPEG_SUSPENDED	0    Suspended due to lack of input data */

enum {
  JPEG_REACHED_SOS=	1, /* Reached start of new scan */
  JPEG_REACHED_EOI=	2, /* Reached end of image */
  JPEG_ROW_COMPLETED=	3, /* Completed one iMCU row */
  JPEG_SCAN_COMPLETED=	4, /* Completed last iMCU row of a scan */
}

/* Precalculate output dimensions for current decompression parameters. */
void function(j_decompress_ptr cinfo) jpeg_calc_output_dimensions;

/* Control saving of COM and APPn markers into marker_list. */
void function(  j_decompress_ptr cinfo, 
                int marker_code,
                uint length_limit ) jpeg_save_markers;

/* Install a special processing method for COM or APPn markers. */
void function( j_decompress_ptr cinfo, 
               int marker_code,
               jpeg_marker_parser_method routine ) jpeg_set_marker_processor;

/* Read or write raw DCT coefficients --- useful for lossless transcoding. */
jvirt_barray_ptr* function(j_decompress_ptr cinfo) jpeg_read_coefficients;

void function( j_compress_ptr cinfo,
					     jvirt_barray_ptr * coef_arrays) jpeg_write_coefficients;
void function(j_decompress_ptr srcinfo,
  						j_compress_ptr dstinfo) jpeg_copy_critical_parameters;

/* If you choose to abort compression or decompression before completing
 * jpeg_finish_(de)compress, then you need to clean up to release memory,
 * temporary files, etc.  You can just call jpeg_destroy_(de)compress
 * if you're done with the JPEG object, but if you want to clean it up and
 * reuse it, call this:
 */
void function(j_compress_ptr cinfo) jpeg_abort_compress;
void function(j_decompress_ptr cinfo) jpeg_abort_decompress;

/* Generic versions of jpeg_abort and jpeg_destroy that work on either
 * flavor of JPEG object.  These may be more convenient in some places.
 */
void function(j_common_ptr cinfo) jpeg_abort;
void function(j_common_ptr cinfo) jpeg_destroy;

/* Default restart-marker-resync procedure for use by data source modules */
boolean function(  j_decompress_ptr cinfo,
                   int desired ) jpeg_resync_to_restart;


/* These marker codes are exported since applications and data source modules
 * are likely to want to use them.
 */
enum {
  JPEG_RST0=	0xD0,	/* RST0 marker code */
  JPEG_EOI=	  0xD9,	/* EOI marker code */
  JPEG_APP0=	0xE0,	/* APP0 marker code */
  JPEG_COM=	  0xFE	/* COM marker code */
}

