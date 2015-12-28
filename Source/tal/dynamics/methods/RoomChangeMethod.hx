package tal.dynamics.methods;

import tal.dynamics.World;

class RoomChangeMethod
{
	
	private var Destination:String;
	private var WorldInstance:World;
	
	public function new ( DestinationRoomIDName:String )
	{
		
		Destination = DestinationRoomIDName;
		
	};
	
	public function Run ( OnFinished : Dynamic -> Void, UserData : Dynamic ) : Void
	{
		
		WorldInstance.SetRoom ( Destination );
		
	};
	
	public function Link ( WorldInstance:World )
	{
		
		this.WorldInstance = WorldInstance;
		
	};
	
}
