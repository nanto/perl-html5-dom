package HTML5::DOM;
use strict;
use warnings;

# Node types
use HTML5::DOM::Node;
use HTML5::DOM::Element;
use HTML5::DOM::Fragment;
use HTML5::DOM::Comment;
use HTML5::DOM::DocType;
use HTML5::DOM::Text;
use HTML5::DOM::Document;

use HTML5::DOM::Encoding;
use HTML5::DOM::Tree;
use HTML5::DOM::Collection;
use HTML5::DOM::CSS;
use HTML5::DOM::TokenList;

our $VERSION = '1.09';
require XSLoader;

# https://developer.mozilla.org/pl/docs/Web/API/Element/nodeType
use constant {
	ELEMENT_NODE					=> 1, 
	ATTRIBUTE_NODE					=> 2,	# not supported
	TEXT_NODE						=> 3, 
	CDATA_SECTION_NODE				=> 4,	# not supported
	ENTITY_REFERENCE_NODE			=> 5,	# not supported
	ENTITY_NODE						=> 6,	# not supported
	PROCESSING_INSTRUCTION_NODE		=> 7,	# not supported
	COMMENT_NODE					=> 8, 
	DOCUMENT_NODE					=> 9, 
	DOCUMENT_TYPE_NODE				=> 10, 
	DOCUMENT_FRAGMENT_NODE			=> 11, 
	NOTATION_NODE					=> 12	# not supported
};

# <MyHTML_tags>
use constant {
	TAG__UNDEF				=> 0x0, 
	TAG__TEXT				=> 0x1, 
	TAG__COMMENT			=> 0x2, 
	TAG__DOCTYPE			=> 0x3, 
	TAG_A					=> 0x4, 
	TAG_ABBR				=> 0x5, 
	TAG_ACRONYM				=> 0x6, 
	TAG_ADDRESS				=> 0x7, 
	TAG_ANNOTATION_XML		=> 0x8, 
	TAG_APPLET				=> 0x9, 
	TAG_AREA				=> 0xa, 
	TAG_ARTICLE				=> 0xb, 
	TAG_ASIDE				=> 0xc, 
	TAG_AUDIO				=> 0xd, 
	TAG_B					=> 0xe, 
	TAG_BASE				=> 0xf, 
	TAG_BASEFONT			=> 0x10, 
	TAG_BDI					=> 0x11, 
	TAG_BDO					=> 0x12, 
	TAG_BGSOUND				=> 0x13, 
	TAG_BIG					=> 0x14, 
	TAG_BLINK				=> 0x15, 
	TAG_BLOCKQUOTE			=> 0x16, 
	TAG_BODY				=> 0x17, 
	TAG_BR					=> 0x18, 
	TAG_BUTTON				=> 0x19, 
	TAG_CANVAS				=> 0x1a, 
	TAG_CAPTION				=> 0x1b, 
	TAG_CENTER				=> 0x1c, 
	TAG_CITE				=> 0x1d, 
	TAG_CODE				=> 0x1e, 
	TAG_COL					=> 0x1f, 
	TAG_COLGROUP			=> 0x20, 
	TAG_COMMAND				=> 0x21, 
	TAG_COMMENT				=> 0x22, 
	TAG_DATALIST			=> 0x23, 
	TAG_DD					=> 0x24, 
	TAG_DEL					=> 0x25, 
	TAG_DETAILS				=> 0x26, 
	TAG_DFN					=> 0x27, 
	TAG_DIALOG				=> 0x28, 
	TAG_DIR					=> 0x29, 
	TAG_DIV					=> 0x2a, 
	TAG_DL					=> 0x2b, 
	TAG_DT					=> 0x2c, 
	TAG_EM					=> 0x2d, 
	TAG_EMBED				=> 0x2e, 
	TAG_FIELDSET			=> 0x2f, 
	TAG_FIGCAPTION			=> 0x30, 
	TAG_FIGURE				=> 0x31, 
	TAG_FONT				=> 0x32, 
	TAG_FOOTER				=> 0x33, 
	TAG_FORM				=> 0x34, 
	TAG_FRAME				=> 0x35, 
	TAG_FRAMESET			=> 0x36, 
	TAG_H1					=> 0x37, 
	TAG_H2					=> 0x38, 
	TAG_H3					=> 0x39, 
	TAG_H4					=> 0x3a, 
	TAG_H5					=> 0x3b, 
	TAG_H6					=> 0x3c, 
	TAG_HEAD				=> 0x3d, 
	TAG_HEADER				=> 0x3e, 
	TAG_HGROUP				=> 0x3f, 
	TAG_HR					=> 0x40, 
	TAG_HTML				=> 0x41, 
	TAG_I					=> 0x42, 
	TAG_IFRAME				=> 0x43, 
	TAG_IMAGE				=> 0x44, 
	TAG_IMG					=> 0x45, 
	TAG_INPUT				=> 0x46, 
	TAG_INS					=> 0x47, 
	TAG_ISINDEX				=> 0x48, 
	TAG_KBD					=> 0x49, 
	TAG_KEYGEN				=> 0x4a, 
	TAG_LABEL				=> 0x4b, 
	TAG_LEGEND				=> 0x4c, 
	TAG_LI					=> 0x4d, 
	TAG_LINK				=> 0x4e, 
	TAG_LISTING				=> 0x4f, 
	TAG_MAIN				=> 0x50, 
	TAG_MAP					=> 0x51, 
	TAG_MARK				=> 0x52, 
	TAG_MARQUEE				=> 0x53, 
	TAG_MENU				=> 0x54, 
	TAG_MENUITEM			=> 0x55, 
	TAG_META				=> 0x56, 
	TAG_METER				=> 0x57, 
	TAG_MTEXT				=> 0x58, 
	TAG_NAV					=> 0x59, 
	TAG_NOBR				=> 0x5a, 
	TAG_NOEMBED				=> 0x5b, 
	TAG_NOFRAMES			=> 0x5c, 
	TAG_NOSCRIPT			=> 0x5d, 
	TAG_OBJECT				=> 0x5e, 
	TAG_OL					=> 0x5f, 
	TAG_OPTGROUP			=> 0x60, 
	TAG_OPTION				=> 0x61, 
	TAG_OUTPUT				=> 0x62, 
	TAG_P					=> 0x63, 
	TAG_PARAM				=> 0x64, 
	TAG_PLAINTEXT			=> 0x65, 
	TAG_PRE					=> 0x66, 
	TAG_PROGRESS			=> 0x67, 
	TAG_Q					=> 0x68, 
	TAG_RB					=> 0x69, 
	TAG_RP					=> 0x6a, 
	TAG_RT					=> 0x6b, 
	TAG_RTC					=> 0x6c, 
	TAG_RUBY				=> 0x6d, 
	TAG_S					=> 0x6e, 
	TAG_SAMP				=> 0x6f, 
	TAG_SCRIPT				=> 0x70, 
	TAG_SECTION				=> 0x71, 
	TAG_SELECT				=> 0x72, 
	TAG_SMALL				=> 0x73, 
	TAG_SOURCE				=> 0x74, 
	TAG_SPAN				=> 0x75, 
	TAG_STRIKE				=> 0x76, 
	TAG_STRONG				=> 0x77, 
	TAG_STYLE				=> 0x78, 
	TAG_SUB					=> 0x79, 
	TAG_SUMMARY				=> 0x7a, 
	TAG_SUP					=> 0x7b, 
	TAG_SVG					=> 0x7c, 
	TAG_TABLE				=> 0x7d, 
	TAG_TBODY				=> 0x7e, 
	TAG_TD					=> 0x7f, 
	TAG_TEMPLATE			=> 0x80, 
	TAG_TEXTAREA			=> 0x81, 
	TAG_TFOOT				=> 0x82, 
	TAG_TH					=> 0x83, 
	TAG_THEAD				=> 0x84, 
	TAG_TIME				=> 0x85, 
	TAG_TITLE				=> 0x86, 
	TAG_TR					=> 0x87, 
	TAG_TRACK				=> 0x88, 
	TAG_TT					=> 0x89, 
	TAG_U					=> 0x8a, 
	TAG_UL					=> 0x8b, 
	TAG_VAR					=> 0x8c, 
	TAG_VIDEO				=> 0x8d, 
	TAG_WBR					=> 0x8e, 
	TAG_XMP					=> 0x8f, 
	TAG_ALTGLYPH			=> 0x90, 
	TAG_ALTGLYPHDEF			=> 0x91, 
	TAG_ALTGLYPHITEM		=> 0x92, 
	TAG_ANIMATE				=> 0x93, 
	TAG_ANIMATECOLOR		=> 0x94, 
	TAG_ANIMATEMOTION		=> 0x95, 
	TAG_ANIMATETRANSFORM	=> 0x96, 
	TAG_CIRCLE				=> 0x97, 
	TAG_CLIPPATH			=> 0x98, 
	TAG_COLOR_PROFILE		=> 0x99, 
	TAG_CURSOR				=> 0x9a, 
	TAG_DEFS				=> 0x9b, 
	TAG_DESC				=> 0x9c, 
	TAG_ELLIPSE				=> 0x9d, 
	TAG_FEBLEND				=> 0x9e, 
	TAG_FECOLORMATRIX		=> 0x9f, 
	TAG_FECOMPONENTTRANSFER	=> 0xa0, 
	TAG_FECOMPOSITE			=> 0xa1, 
	TAG_FECONVOLVEMATRIX	=> 0xa2, 
	TAG_FEDIFFUSELIGHTING	=> 0xa3, 
	TAG_FEDISPLACEMENTMAP	=> 0xa4, 
	TAG_FEDISTANTLIGHT		=> 0xa5, 
	TAG_FEDROPSHADOW		=> 0xa6, 
	TAG_FEFLOOD				=> 0xa7, 
	TAG_FEFUNCA				=> 0xa8, 
	TAG_FEFUNCB				=> 0xa9, 
	TAG_FEFUNCG				=> 0xaa, 
	TAG_FEFUNCR				=> 0xab, 
	TAG_FEGAUSSIANBLUR		=> 0xac, 
	TAG_FEIMAGE				=> 0xad, 
	TAG_FEMERGE				=> 0xae, 
	TAG_FEMERGENODE			=> 0xaf, 
	TAG_FEMORPHOLOGY		=> 0xb0, 
	TAG_FEOFFSET			=> 0xb1, 
	TAG_FEPOINTLIGHT		=> 0xb2, 
	TAG_FESPECULARLIGHTING	=> 0xb3, 
	TAG_FESPOTLIGHT			=> 0xb4, 
	TAG_FETILE				=> 0xb5, 
	TAG_FETURBULENCE		=> 0xb6, 
	TAG_FILTER				=> 0xb7, 
	TAG_FONT_FACE			=> 0xb8, 
	TAG_FONT_FACE_FORMAT	=> 0xb9, 
	TAG_FONT_FACE_NAME		=> 0xba, 
	TAG_FONT_FACE_SRC		=> 0xbb, 
	TAG_FONT_FACE_URI		=> 0xbc, 
	TAG_FOREIGNOBJECT		=> 0xbd, 
	TAG_G					=> 0xbe, 
	TAG_GLYPH				=> 0xbf, 
	TAG_GLYPHREF			=> 0xc0, 
	TAG_HKERN				=> 0xc1, 
	TAG_LINE				=> 0xc2, 
	TAG_LINEARGRADIENT		=> 0xc3, 
	TAG_MARKER				=> 0xc4, 
	TAG_MASK				=> 0xc5, 
	TAG_METADATA			=> 0xc6, 
	TAG_MISSING_GLYPH		=> 0xc7, 
	TAG_MPATH				=> 0xc8, 
	TAG_PATH				=> 0xc9, 
	TAG_PATTERN				=> 0xca, 
	TAG_POLYGON				=> 0xcb, 
	TAG_POLYLINE			=> 0xcc, 
	TAG_RADIALGRADIENT		=> 0xcd, 
	TAG_RECT				=> 0xce, 
	TAG_SET					=> 0xcf, 
	TAG_STOP				=> 0xd0, 
	TAG_SWITCH				=> 0xd1, 
	TAG_SYMBOL				=> 0xd2, 
	TAG_TEXT				=> 0xd3, 
	TAG_TEXTPATH			=> 0xd4, 
	TAG_TREF				=> 0xd5, 
	TAG_TSPAN				=> 0xd6, 
	TAG_USE					=> 0xd7, 
	TAG_VIEW				=> 0xd8, 
	TAG_VKERN				=> 0xd9, 
	TAG_MATH				=> 0xda, 
	TAG_MACTION				=> 0xdb, 
	TAG_MALIGNGROUP			=> 0xdc, 
	TAG_MALIGNMARK			=> 0xdd, 
	TAG_MENCLOSE			=> 0xde, 
	TAG_MERROR				=> 0xdf, 
	TAG_MFENCED				=> 0xe0, 
	TAG_MFRAC				=> 0xe1, 
	TAG_MGLYPH				=> 0xe2, 
	TAG_MI					=> 0xe3, 
	TAG_MLABELEDTR			=> 0xe4, 
	TAG_MLONGDIV			=> 0xe5, 
	TAG_MMULTISCRIPTS		=> 0xe6, 
	TAG_MN					=> 0xe7, 
	TAG_MO					=> 0xe8, 
	TAG_MOVER				=> 0xe9, 
	TAG_MPADDED				=> 0xea, 
	TAG_MPHANTOM			=> 0xeb, 
	TAG_MROOT				=> 0xec, 
	TAG_MROW				=> 0xed, 
	TAG_MS					=> 0xee, 
	TAG_MSCARRIES			=> 0xef, 
	TAG_MSCARRY				=> 0xf0, 
	TAG_MSGROUP				=> 0xf1, 
	TAG_MSLINE				=> 0xf2, 
	TAG_MSPACE				=> 0xf3, 
	TAG_MSQRT				=> 0xf4, 
	TAG_MSROW				=> 0xf5, 
	TAG_MSTACK				=> 0xf6, 
	TAG_MSTYLE				=> 0xf7, 
	TAG_MSUB				=> 0xf8, 
	TAG_MSUP				=> 0xf9, 
	TAG_MSUBSUP				=> 0xfa, 
	TAG__END_OF_FILE		=> 0xfb, 
	TAG_LAST_ENTRY			=> 0xfc, 
};
# </MyHTML_tags>

# <MyHTML_ns>
use constant {
	NS_UNDEF				=> 0x0, 
	NS_HTML					=> 0x1, 
	NS_MATHML				=> 0x2, 
	NS_SVG					=> 0x3, 
	NS_XLINK				=> 0x4, 
	NS_XML					=> 0x5, 
	NS_XMLNS				=> 0x6, 
	NS_ANY					=> 0x7, 
	NS_LAST_ENTRY			=> 0x7, 
};
# </MyHTML_ns>

sub parseAsync($$;$$) {
	my ($self, $html, $options, $callback) = @_;
	
	if (ref($callback) eq 'CODE') {
		require EV;
		require AnyEvent::Util;
		
		my ($r, $w) = AnyEvent::Util::portable_pipe();
		AnyEvent::fh_unblock($r);
		
		my $async_w;
		my $async = $self->_parseAsync($html, $options, fileno($w));
		
		$async_w = EV::io($r, EV::READ(), sub {
			close $w;
			close $r;
			undef $w;
			undef $r;
			undef $async_w;
			
			$callback->($async->wait);
		});
		
		return $async_w;
	} else {
		_parseAsync(@_);
	}
}

XSLoader::load('HTML5::DOM', $VERSION);

1;
__END__
