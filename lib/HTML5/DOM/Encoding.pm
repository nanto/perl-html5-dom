package HTML5::DOM::Encoding;
use strict;
use warnings;

use constant {
# <MyENCODING_const>
	DEFAULT							=> 0x0, 
	AUTO								=> 0x1, 
	NOT_DETERMINED						=> 0x2, 
	UTF_8								=> 0x0, 
	UTF_16LE							=> 0x4, 
	UTF_16BE							=> 0x5, 
	X_USER_DEFINED						=> 0x6, 
	BIG5								=> 0x7, 
	EUC_JP								=> 0x8, 
	EUC_KR								=> 0x9, 
	GB18030							=> 0xa, 
	GBK								=> 0xb, 
	IBM866								=> 0xc, 
	ISO_2022_JP						=> 0xd, 
	ISO_8859_10						=> 0xe, 
	ISO_8859_13						=> 0xf, 
	ISO_8859_14						=> 0x10, 
	ISO_8859_15						=> 0x11, 
	ISO_8859_16						=> 0x12, 
	ISO_8859_2							=> 0x13, 
	ISO_8859_3							=> 0x14, 
	ISO_8859_4							=> 0x15, 
	ISO_8859_5							=> 0x16, 
	ISO_8859_6							=> 0x17, 
	ISO_8859_7							=> 0x18, 
	ISO_8859_8							=> 0x19, 
	ISO_8859_8_I						=> 0x1a, 
	KOI8_R								=> 0x1b, 
	KOI8_U								=> 0x1c, 
	MACINTOSH							=> 0x1d, 
	SHIFT_JIS							=> 0x1e, 
	WINDOWS_1250						=> 0x1f, 
	WINDOWS_1251						=> 0x20, 
	WINDOWS_1252						=> 0x21, 
	WINDOWS_1253						=> 0x22, 
	WINDOWS_1254						=> 0x23, 
	WINDOWS_1255						=> 0x24, 
	WINDOWS_1256						=> 0x25, 
	WINDOWS_1257						=> 0x26, 
	WINDOWS_1258						=> 0x27, 
	WINDOWS_874						=> 0x28, 
	X_MAC_CYRILLIC						=> 0x29, 
	LAST_ENTRY							=> 0x2a, 
	STATUS_OK							=> 0x0, 
	STATUS_ERROR						=> 0x1, 
	STATUS_CONTINUE					=> 0x2, 
	STATUS_DONE						=> 0x4, 
 </MyENCODING_const>
};

1;
__END__
