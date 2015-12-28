package tal.dynamics;

import tal.dynamics.room.IRoom;

import tal.dynamics.commands.ICommand;

import tal.dynamics.variables.StringVariable;

import tal.graphics.ITextInterface;

import openfl.events.KeyboardEvent;

class World
{
	
	private var Rooms:Array <IRoom>;
	
	private var GlobalCommandSet:Array <ICommand>;
	private var LocalCommandSet:Array <ICommand>;
	private var InventoryCommandSet:Array <ICommand>;
	
	private var StringVariables:Array <StringVariable>;
	
	private var CurrentRoom:IRoom;
	
	private var Interface:ITextInterface;
	
	public function new ()
	{
		
		Rooms = new Array <IRoom> ();
		
		GlobalCommandSet = new Array <ICommand> ();
		LocalCommandSet = new Array <ICommand> ();
		InventoryCommandSet = new Array <ICommand> ();
		
		StringVariables = new Array <StringVariable> ();
		
		CurrentRoom = null;
		
	};
	
	public function SetInterface ( Interface:ITextInterface ) : Void
	{
		
		if ( this.Interface != null )
		{
			
			Interface.SetMode ( this.Interface.GetMode () );
			Interface.SetOutput ( this.Interface.GetOutput () );
			
			this.Interface.SetInputCallback ( null );
			this.Interface.SetCapturedInputCallback ( null );
			
		}
		
		this.Interface = Interface;
		
		Interface.SetCapturedInputCallback ( CapturedInputCallback );
		Interface.SetInputCallback ( InputCallback );
		
	};
	
	public function CapturedInputCallback ( E:KeyboardEvent, Down:Bool ) : Void
	{
		
		// TODO
		
	};
	
	public function InputCallback ( Input:String ) : Void
	{
		
		// TODO
		
	};
	
	public function AddRoom ( Room:IRoom ) : Void
	{
		
		Rooms.push ( Room );
		
	};
	
	public function SetRoom ( IDName:String ) : Void
	{
		
		for ( Room in Rooms )
		{
			
			if ( Room.GetIDName () == IDName )
			{
				
				if ( CurrentRoom != null )
					CurrentRoom.Exit ();
				
				CurrentRoom = Room;
				CurrentRoom.Enter ();
				
				return;
				
			}
			
		}
		
		trace ( "ERROR! Set invalid room!" );
		
	};
	
	public function GetStringVariable ( Name:String ) : String
	{
		
		for ( Variable in StringVariables )
		{
			
			if ( Variable.GetName () == Name )
				return Variable.Get ();
			
		}
		
		return null;
		
	};
	
	public function SetStringVariable ( Name:String, Value:String ) : String
	{
		
		for ( Vairable in StringVariables )
		{
			
			if ( Vairable.GetName () == Name )
			{
				
				Vairable.Set ( Value );
				
				return;
				
			}
			
		}
		
		StringVariables.push ( new StringVariable ( Name, Value ) );
		
	};
	
	public function GetInterface () : ITextInterface
	{
		
		return 
		
	};
	
}
