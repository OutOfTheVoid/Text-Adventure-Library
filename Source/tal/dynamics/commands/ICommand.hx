package tal.dynamics.commands;

import tal.dynamics.methods.IMethod;

interface ICommand
{
	
	public function GetIDName () : String;
	public function GetHidden () : Bool;
	public function Test ( Argument:String ) : IMethod;
		
}
