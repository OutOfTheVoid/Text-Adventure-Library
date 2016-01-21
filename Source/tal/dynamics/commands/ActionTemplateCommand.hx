package tal.dynamics.commands;

import tal.dynamics.methods.IMethod;

import tal.dynamics.commands.ICommand;
import tal.dynamics.commands.matching.ICommandMatch;

import tal.util.parsing.StringParsingTools;

class ActionTemplateCommand implements ICommand
{
	
	private var MethodList:Array <IMethod>;
	
	private var IDName:String;
	private var Hidden:Bool;
	
	private var Matcher:ICommandMatch;
	
	public function new ( MethodList:Array <IMethod>, IDName:String, Matcher:ICommandMatch, Hidden:Bool )
	{
		
		this.MethodList = MethodList;
		this.IDName = IDName;
		this.Hidden = Hidden;
		this.Matcher = Matcher;
		
	};
	
	public function GetIDName () : String
	{
		
		return IDName;
		
	};
	
	public function GetHidden () : Bool
	{
		
		return Hidden;
		
	};
	
	public function Test ( Argument:String ) : Array <IMethod>
	{
		
		if ( Matcher.Test ( Argument ) )
			return MethodList;
		
		return null;
		
	};
	
	public function Link ( WorldInstance:World ) : Void
	{
		
		for ( Method in MethodList )
			Method.Link ( WorldInstance );
		
		Matcher.Link ( WorldInstance );
		
	};
	
}
