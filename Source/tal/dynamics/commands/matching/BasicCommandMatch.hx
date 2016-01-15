package tal.dynamics.commands.matching;

import tal.dynamics.World;

import tal.util.StringParsingTools;

class BasicCommandMatch
{
	
	private var Matches:Array <String>;
	
	public function new ( Matches:Array <String> )
	{
		
		this.Matches = Matches;
		
	};
	
	public function Test ( CommandArgument:String ) : Bool
	{
		
		CommandArgument = StringParsingTools.FormatCommandForMatching ( CommandArgument );
		
		for ( Match in Matches )
			if ( Match == CommandArgument )
				return true;
		
		return false;
				
	};
	
	public function Link ( WorldInstance:World ) : Void {};
	
}
