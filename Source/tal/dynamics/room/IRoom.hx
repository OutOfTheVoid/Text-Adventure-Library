package tal.dynamics.room;

import tal.dynamics.commands.ICommand;

interface IRoom
{
	
	public function GetIDName () : String;
	public function GetSimpleDescription () : String;
	
	public function GetLocalCommandSet () : Array <ICommand>;
	
	public function Enter () : Void;
	public function Exit () : Void;
	
}
