package tal.dynamics.commands;

import tal.util.parsing.StringParsingTools;

import tal.dynamics.commands.ICommand;

import tal.dynamics.methods.IMethod;

class BasicMoveCommand
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
	
	private var MethodList:Array <IMethod>;
	
	private var DirectionNames:Array <String>;
	private var AuxVerbs:Array <String>;
	
	private var DestinationIDName:String;
	
	public function new ( DirectionNames:Array <String>, VerbFlags:UInt, DestinationIDName:String, AuxVerbs:Array <String> = null )
	{
		
		this.DirectionNames = DirectionNames;
		
		this.VerbFlags = VerbFlags;
		this.AuxVerbs = AuxVerbs;
		
		this.DestinationIDName = DestinationIDName;
		
	};
	
	public function GetIDName () : String
	{
		
		return "global.builtin.basichelp";
		
	};
	
	public function GetHidden () : Bool
	{
		
		return false;
		
	};
	
	public function Test ( Argument:String ) : Array <IMethod>
	{
		
		Argument = StringParsingTools.FormatCommandForMatching ( Argument );
		
		if ( ( VerbFlags & MOVE_MATCHES ) != 0 )
		{
			
			for ( Verb in MoveMatches )
			{
				
				if ( Verb == Argument.toLowerCase () )
				{
					
					if ( ( DirectionNames != null ) && ( DirectionNames.length != 0 ) )
					{
						
						for ( Direction in DirectionNames )
							if ( Argument.indexOf ( Direction ) > Verb.length )
								return MethodList;
						
					}
					else
						return MethodList;
					
				}
				
			}
			
		}
		
		if ( ( VerbFlags & TURN_MATCHES ) != 0 )
		{
			
			for ( Verb in TurnMatches )
			{
				
				if ( Verb == Argument.toLowerCase () )
				{
					
					if ( ( DirectionNames != null ) && ( DirectionNames.length != 0 ) )
					{
						
						for ( Direction in DirectionNames )
							if ( Argument.indexOf ( Direction ) > Verb.length )
								return MethodList;
						
					}
					else
						return MethodList;
					
				}
				
			}
			
		}
		
		if ( ( VerbFlags & CLIMB_MATCHES ) != 0 )
		{
			
			for ( Verb in ClimbMatches )
			{
				
				if ( Verb == Argument.toLowerCase () )
				{
					
					if ( ( DirectionNames != null ) && ( DirectionNames.length != 0 ) )
					{
						
						for ( Direction in DirectionNames )
							if ( Argument.indexOf ( Direction ) > Verb.length )
								return MethodList;
						
					}
					else
						return MethodList;
					
				}
				
			}
			
		}
		
		if ( ( VerbFlags & UP_MATCHES ) != 0 )
		{
			
			for ( Verb in UpMatches )
			{
				
				if ( Verb == Argument.toLowerCase () )
				{
					
					if ( ( DirectionNames != null ) && ( DirectionNames.length != 0 ) )
					{
						
						for ( Direction in DirectionNames )
							if ( Argument.indexOf ( Direction ) > Verb.length )
								return MethodList;
						
					}
					else
						return MethodList;
					
				}
				
			}
			
		}
		
		if ( ( VerbFlags & DOWN_MATCHES ) != 0 )
		{
			
			for ( Verb in DownMatches )
			{
				
				if ( Verb == Argument.toLowerCase () )
				{
					
					if ( ( DirectionNames != null ) && ( DirectionNames.length != 0 ) )
					{
						
						for ( Direction in DirectionNames )
							if ( Argument.indexOf ( Direction ) > Verb.length )
								return MethodList;
						
					}
					else
						return MethodList;
					
				}
				
			}
			
		}
		
		if ( ( AuxVerbs != null ) && ( AuxVerbs.length != 0 ) )
		{
			
			for ( Verb in AuxVerbs )
			{
				
				if ( Verb == Argument.toLowerCase () )
				{
					
					if ( ( DirectionNames != null ) && ( DirectionNames.length != 0 ) )
					{
						
						for ( Direction in DirectionNames )
							if ( Argument.indexOf ( Direction ) > Verb.length )
								return MethodList;
						
					}
					else
						return MethodList;
					
				}
				
			}
			
		}
		
		return null;
		
	};
	
	public function Link ( WorldInstance:World )
	{
		
		for ( Method in MethodList )
			Method.Link ( WorldInstance );
		
	};
	
}
