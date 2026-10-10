package steam.data;

/**
	A language name of the Steam API (as returned by `steam.Api.getCurrentGameLanguage`).
**/
enum abstract Locale(String) from String to String
{
	/**
		Brazilian Portuguese.
	**/
	var BRAZILIAN = "brazilian";
	/**
		Bulgarian.
	**/
	var BULGARIAN = "bulgarian";
	/**
		Czech.
	**/
	var CZECH = "czech";
	/**
		Danish.
	**/
	var DANISH = "danish";
	/**
		Dutch.
	**/
	var DUTCH = "dutch";
	/**
		English.
	**/
	var ENGLISH = "english";
	/**
		Finnish.
	**/
	var FINNISH = "finnish";
	/**
		French.
	**/
	var FRENCH = "french";
	/**
		German.
	**/
	var GERMAN = "german";
	/**
		Greek.
	**/
	var GREEK = "greek";
	/**
		Hungarian.
	**/
	var HUNGARIAN = "hungarian";
	/**
		Italian.
	**/
	var ITALIAN = "italian";
	/**
		Japanese.
	**/
	var JAPANESE = "japanese";
	/**
		Korean (`koreana` is the code used by Steam for Korean).
	**/
	var KOREANA = "koreana";
	/**
		Korean (legacy code).
	**/
	var KOREAN = "korean";
	/**
		Norwegian.
	**/
	var NORWEGIAN = "norwegian";
	/**
		Polish.
	**/
	var POLISH = "polish";
	/**
		Portuguese.
	**/
	var PORTUGUESE = "portuguese";
	/**
		Romanian.
	**/
	var ROMANIAN = "romanian";
	/**
		Russian.
	**/
	var RUSSIAN = "russian";
	/**
		Simplified Chinese.
	**/
	var SCHINESE = "schinese";
	/**
		Spanish.
	**/
	var SPANISH = "spanish";
	/**
		Swedish.
	**/
	var SWEDISH = "swedish";
	/**
		Traditional Chinese.
	**/
	var TCHINESE = "tchinese";
	/**
		Thai.
	**/
	var THAI = "thai";
	/**
		Turkish.
	**/
	var TURKISH = "turkish";
	/**
		Ukrainian.
	**/
	var UKRAINIAN = "ukrainian";
	/**
		An unknown language.
	**/
	var UNKNOWN = "unknown";
	
	public function new(str:String) {
		
		str = str.toLowerCase();
		
		this = switch(str) {
			
			case 
				Locale.BRAZILIAN, 
				Locale.BULGARIAN, 
				Locale.CZECH, 
				Locale.DANISH, 
				Locale.DUTCH, 
				Locale.ENGLISH,
				Locale.FINNISH, 
				Locale.FRENCH, 
				Locale.GERMAN, 
				Locale.GREEK, 
				Locale.HUNGARIAN, 
				Locale.ITALIAN, 
				Locale.JAPANESE,
				Locale.KOREANA, 
				Locale.KOREAN, 
				Locale.NORWEGIAN, 
				Locale.POLISH, 
				Locale.PORTUGUESE, 
				Locale.ROMANIAN,
				Locale.RUSSIAN, 
				Locale.SCHINESE, 
				Locale.SPANISH, 
				Locale.SWEDISH, 
				Locale.TCHINESE, 
				Locale.THAI, 
				Locale.TURKISH,
				Locale.UKRAINIAN: 
					cast str;
			default:
				cast Locale.UNKNOWN;
		}
		
	}
}