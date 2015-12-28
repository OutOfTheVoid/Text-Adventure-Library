package tal.dynamics.room;

import tal.dynamics.commands.ICommand;

class BasicRoom
{
	
	private var IDName:String;
	private var SimpleDescription:String;
	
	private var LocalCommandSet:Array <ICommand>;
	
	public function new ( IDName:String, SimpleDescription:String )
	{
		
		this.IDName = IDName;
		this.SimpleDescription = SimpleDescription;
		
		LocalCommandSet = new Array <ICommand> ();
		
	};
	
	public function GetIDName () : String
	{
		
		return IDName;
		
	};
	
	public function GetSimpleDescription () : String
	{
		
		return SimpleDescription;
		
	};
	
	public function GetLocalCommandSet () : Array <ICommand>
	{
		
		return LocalCommandSet;
		
	};
	
	public function Enter () : Void
	{
		
		
		
	};
	
	public function Exit () : Void
	{
		
		
		
	};
	
}
