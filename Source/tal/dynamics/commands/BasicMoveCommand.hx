package tal.dynamics.commands;

import tal.dynamics.commands.matching.ICommandMatch;

import tal.dynamics.commands.ICommand;

import tal.dynamics.methods.IMethod;
import tal.dynamics.methods.ClearInputMethod;
import tal.dynamics.methods.RoomChangeMethod;
import tal.dynamics.methods.SimpleOutputMethod;

class BasicMoveCommand implements ICommand
{
	
	private var MethodList:Array <IMethod>;
	
	private var Matcher:ICommandMatch;
	
	public function new ( Matcher:ICommandMatch, DestinationIDName:String, Response:String = "" )
	{
		
		this.Matcher = Matcher;
		
		MethodList = new Array <IMethod> ();
		
		MethodList.push ( new ClearInputMethod () );
		MethodList.push ( new SimpleOutputMethod ( Response ) );
		MethodList.push ( new RoomChangeMethod ( DestinationIDName ) );
		
	};
	
	public function GetIDName () : String
	{
		
		return "tal.methods.basicmove";
		
	};
	
	public function GetHidden () : Bool
	{
		
		return false;
		
	};
	
	public function Test ( Argument:String ) : Array <IMethod>
	{
		
		if ( Matcher.Test ( Argument ) )
			return MethodList;
		
		return null;
		
	};
	
	public function Link ( WorldInstance:World )
	{
		
		for ( Method in MethodList )
			Method.Link ( WorldInstance );
		
		Matcher.Link ( WorldInstance );
		
	};
	
}
