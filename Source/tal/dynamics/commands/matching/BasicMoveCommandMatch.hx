package tal.dynamics.commands.matching;

import tal.util.parsing.StringParsingTools;

import tal.dynamics.commands.matching.ICommandMatch;

class BasicMoveCommandMatch implements ICommandMatch
{
	
	private static var MoveMatches:Array <String>;
	private static var TurnMatches:Array <String>;
	private static var ClimbMatches:Array <String>;
	private static var UpMatches:Array <String>;
	private static var DownMatches:Array <String>;
	
	public static inline var MOVE_MATCHES:UInt = 1;
	public static inline var TURN_MATCHES:UInt = 2;
	public static inline var CLIMB_MATCHES:UInt = 4;
	public static inline var UP_MATCHES:UInt = 8;
	public static inline var DOWN_MATCHES:UInt = 16;
	
	static function __init__ ()
	{
		
		MoveMatches = new Array <String> ();
		
		MoveMatches.push ( "move" );
		MoveMatches.push ( "go" );
		MoveMatches.push ( "travel" );
		MoveMatches.push ( "saunter" );
		MoveMatches.push ( "walk" );
		MoveMatches.push ( "head" );
		MoveMatches.push ( "come" );
		
		TurnMatches = new Array <String> ();
		
		TurnMatches.push ( "turn" );
		TurnMatches.push ( "pivot" );
		TurnMatches.push ( "branch" );
		TurnMatches.push ( "fork" );
		TurnMatches.push ( "aim" );
		
		ClimbMatches = new Array <String> ();
		
		ClimbMatches.push ( "climb" );
		ClimbMatches.push ( "come" );
		ClimbMatches.push ( "go" );
		
		UpMatches = new Array <String> ();
		
		UpMatches.push ( "ascend" );
		
		DownMatches = new Array <String> ();
		
		DownMatches.push ( "descend" );
		
	};
	
	private var VerbFlags:UInt;
	
	private var DirectionNames:Array <String>;
	private var AuxVerbs:Array <String>;
	
	public function new ( DirectionNames:Array <String>, VerbFlags:UInt, AuxVerbs:Array <String> = null )
	{
		
		this.DirectionNames = DirectionNames;
		this.VerbFlags = VerbFlags;
		this.AuxVerbs = AuxVerbs;
		
	};
	
	public function Test ( CommandArgument:String ) : Bool
	{
		
		CommandArgument = StringParsingTools.FormatCommandForMatching ( CommandArgument );
		
		if ( ( VerbFlags & MOVE_MATCHES ) != 0 )
		{
			
			for ( Verb in MoveMatches )
			{
				
				if ( CommandArgument.indexOf ( Verb ) == 0 )
				{
					
					if ( ( DirectionNames != null ) && ( DirectionNames.length != 0 ) )
					{
						
						for ( Direction in DirectionNames )
							if ( CommandArgument.indexOf ( Direction ) > Verb.length )
								return true;
						
					}
					else
						return true;
					
				}
				
			}
			
		}
		
		if ( ( VerbFlags & TURN_MATCHES ) != 0 )
		{
			
			for ( Verb in TurnMatches )
			{
				
				if ( CommandArgument.indexOf ( Verb ) == 0 )
				{
					
					if ( ( DirectionNames != null ) && ( DirectionNames.length != 0 ) )
					{
						
						for ( Direction in DirectionNames )
							if ( CommandArgument.indexOf ( Direction ) > Verb.length )
								return true;
						
					}
					else
						return true;
					
				}
				
			}
			
		}
		
		if ( ( VerbFlags & CLIMB_MATCHES ) != 0 )
		{
			
			for ( Verb in ClimbMatches )
			{
				
				if ( CommandArgument.indexOf ( Verb ) == 0 )
				{
					
					if ( ( DirectionNames != null ) && ( DirectionNames.length != 0 ) )
					{
						
						for ( Direction in DirectionNames )
							if ( CommandArgument.indexOf ( Direction ) > Verb.length )
								return true;
						
					}
					else
						return true;
					
				}
				
			}
			
		}
		
		if ( ( VerbFlags & UP_MATCHES ) != 0 )
		{
			
			for ( Verb in UpMatches )
			{
				
				if ( CommandArgument.indexOf ( Verb ) == 0 )
				{
					
					if ( ( DirectionNames != null ) && ( DirectionNames.length != 0 ) )
					{
						
						for ( Direction in DirectionNames )
							if ( CommandArgument.indexOf ( Direction ) > Verb.length )
								return true;
						
					}
					else
						return true;
					
				}
				
			}
			
		}
		
		if ( ( VerbFlags & DOWN_MATCHES ) != 0 )
		{
			
			for ( Verb in DownMatches )
			{
				
				if ( Verb == CommandArgument.toLowerCase () )
				{
					
					if ( ( DirectionNames != null ) && ( DirectionNames.length != 0 ) )
					{
						
						for ( Direction in DirectionNames )
							if ( CommandArgument.indexOf ( Direction ) > Verb.length )
								return true;
						
					}
					else
						return true;
					
				}
				
			}
			
		}
		
		if ( ( AuxVerbs != null ) && ( AuxVerbs.length != 0 ) )
		{
			
			for ( Verb in AuxVerbs )
			{
				
				if ( CommandArgument.indexOf ( Verb ) == 0 )
				{
					
					if ( ( DirectionNames != null ) && ( DirectionNames.length != 0 ) )
					{
						
						for ( Direction in DirectionNames )
							if ( CommandArgument.indexOf ( Direction ) > Verb.length )
								return true;
						
					}
					else
						return true;
					
				}
				
			}
			
		}
		
		return false;
		
	};
	
	public function Link ( WorldInstance:World ) : Void {};
	
}
