package tal.dynamics.rooms;

import tal.dynamics.commands.ICommand;

import tal.dynamics.rooms.IRoom;

import tal.dynamics.World;

class BasicRoom implements IRoom
{
	
	private var IDName:String;
	private var SimpleDescription:String;
	
	private var LocalCommandSet:Array <ICommand>;
	
	private var OnEnterCommand:String;
	private var OnExitCommand:String;
	
	private var WorldInstance:World;
	
	public function new ( IDName:String, SimpleDescription:String, CommandSet:Array <ICommand>, OnEnterCommand:String, OnExitCommand:String = null )
	{
		
		this.IDName = IDName;
		this.SimpleDescription = SimpleDescription;
		
		LocalCommandSet = CommandSet;
		
		this.OnEnterCommand = OnEnterCommand;
		this.OnExitCommand = OnExitCommand;
		
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
	
	public function Link ( WorldInstance:World ) : Void
	{
		
		this.WorldInstance = WorldInstance;
		
	};
	
	public function Enter () : Void
	{
		
		if ( OnEnterCommand != null )
			WorldInstance.EnqueueCommand ( OnEnterCommand, true );
		
	};
	
	public function Exit () : Void
	{
		
		if ( OnEnterCommand != null )
			WorldInstance.EnqueueCommand ( OnExitCommand, true );
		
	};
	
}
