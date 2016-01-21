package tal.dynamics.commands;

import tal.dynamics.commands.ICommand;

import tal.dynamics.commands.matching.ICommandMatch;

import tal.dynamics.methods.IMethod;
import tal.dynamics.methods.SimpleOutputMethod;
import tal.dynamics.methods.ClearInputMethod;

import tal.util.parsing.StringParsingTools;

class BasicResponseCommand implements ICommand
{
	
	private var MethodList:Array <IMethod>;
	private var ResponseMethod:SimpleOutputMethod;
	
	private var Matcher:ICommandMatch;
	
	public function new ( Response:String, Matcher:ICommandMatch )
	{
		
		MethodList = new Array <IMethod> ();
		
		ResponseMethod = new SimpleOutputMethod ( Response );
		
		MethodList.push ( ResponseMethod );
		MethodList.push ( new ClearInputMethod () );
		
		this.Matcher = Matcher;
		
	};
	
	public function GetIDName () : String
	{
		
		return "global.builtin.basicresponse";
		
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
	
	public function ResetResponse ( Response:String ) : Void
	{
		
		ResponseMethod.ResetOutput ( Response );
		
	};
	
	public function Link ( WorldInstance:World )
	{
		
		for ( Method in MethodList )
			Method.Link ( WorldInstance );
		
		Matcher.Link ( WorldInstance );
		
	};
	
}
