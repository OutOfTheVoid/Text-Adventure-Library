package tal.dynamics.commands;

import tal.dynamics.commands.ICommand;

import tal.dynamics.methods.IMethod;
import tal.dynamics.methods.SimpleOutputMethod;
import tal.dynamics.methods.ClearInputMethod;

class BasicHelpCommand implements ICommand
{
	
	private var MethodList:Array <IMethod>;
	private var SimpleOutput:SimpleOutputMethod;
	
	public function new ( HelpString:String )
	{
		
		MethodList = new Array <IMethod> ();
		MethodList.push ( new SimpleOutputMethod ( HelpString ) );
		MethodList.push ( new ClearInputMethod () );
		
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
		
		if ( Argument.toLowerCase () == "help" )
			return MethodList;
		
		return null;
		
	};
	
	public function Link ( WorldInstance:World )
	{
		
		for ( Method in MethodList )
			Method.Link ( WorldInstance );
		
	};
	
}
