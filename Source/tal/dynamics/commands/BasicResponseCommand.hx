package tal.dynamics.commands;

import tal.dynamics.commands.ICommand;

import tal.dynamics.methods.IMethod;
import tal.dynamics.methods.SimpleOutputMethod;
import tal.dynamics.methods.ClearInputMethod;

import tal.util.parsing.StringParsingTools;

class BasicResponseCommand implements ICommand
{
	
	private var MethodList:Array <IMethod>;
	private var ResponseMethod:SimpleOutputMethod;
	
	private var MatchList:Array <String>;
	
	public function new ( Response:String, MatchList:Array <String> )
	{
		
		MethodList = new Array <IMethod> ();
		
		ResponseMethod = new SimpleOutputMethod ( Response );
		
		MethodList.push ( ResponseMethod );
		MethodList.push ( new ClearInputMethod () );
		
		this.MatchList = MatchList;
		
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
		
		Argument = StringParsingTools.FormatCommandForMatching ( Argument );
		
		for ( Match in MatchList )
		{
			
			if ( Argument == Match )
				return MethodList;
			
		}
		
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
		
	};
	
}
