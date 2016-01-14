package tal.dynamics.methods;

import tal.dynamics.World;

import tal.dynamics.methods.IMethod;

class RoomChangeMethod implements IMethod
{
	
	private var Destination:String;
	private var WorldInstance:World;
	
	public function new ( DestinationRoomIDName:String )
	{
		
		Destination = DestinationRoomIDName;
		
	};
	
	public function Run ( OnFinished : Void -> Void ) : Void
	{
		
		WorldInstance.SetRoom ( Destination );
		
		OnFinished ();
		
	};
	
	public function Link ( WorldInstance:World )
	{
		
		this.WorldInstance = WorldInstance;
		
	};
	
}
