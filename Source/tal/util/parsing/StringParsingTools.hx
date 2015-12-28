package tal.util.parsing;

class StringParsingTools
{
	
	public static function FormatCommandForMatching ( Command:String ) : String
	{
		
		Command = StringTools.ltrim ( Command );
		Command = StringTools.rtrim ( Command );
		return Command.toLowerCase ();
		
	};
	
}
