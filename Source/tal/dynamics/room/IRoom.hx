package tal.dynamics.room;

import tal.dynamics.commands.ICommand;

import tal.dynamics.World;

interface IRoom
{
	
	public function GetIDName () : String;
	public function GetSimpleDescription () : String;
	
	public function GetLocalCommandSet () : Array <ICommand>;
	
	public function Enter () : Void;
	public function Exit () : Void;
	
	public function Link ( WorldInstance:World ) : Void;
	
}
