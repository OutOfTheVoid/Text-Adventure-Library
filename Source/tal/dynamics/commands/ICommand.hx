package tal.dynamics.commands;

import tal.dynamics.methods.IMethod;

import tal.dynamics.World;

interface ICommand
{
	
	public function GetIDName () : String;
	public function GetHidden () : Bool;
	public function Test ( Argument:String ) : Array <IMethod>;
	public function Link ( WorldInstance:World ) : Void;
		
}
