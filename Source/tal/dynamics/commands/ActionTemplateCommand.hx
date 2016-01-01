package tal.dynamics.commands;

import tal.dynamics.methods.IMethod;

import tal.dynamics.commands.ICommand;

import tal.util.parsing.StringParsingTools;

class ActionTemplateCommand implements ICommand
{
	
	private var MethodList:Array <IMethod>;
	
	private var TestReg:EReg;
	
	private var IDName:String;
	private var Hidden:Bool;
	
	public function new ( MethodList:Array <IMethod>, IDName:String, Hidden:Bool, RegExPattern:String, RegExOptions:String = "gi" )
	{
		
		this.MethodList = MethodList;
		this.IDName = IDName;
		this.Hidden = Hidden;
		
		TestReg = new EReg ( RegExPattern, RegExOptions );
		
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
		
		Argument = StringParsingTools.FormatCommandForMatching ( Argument );
		
		if ( ! TestReg.match ( Argument ) )
			return null;
		
		var MatchParams:Dynamic = TestReg.matchedPos ();
		
		if ( ( MatchParams.pos == 0 ) && ( MatchParams.len == Argument.length ) )
			return MethodList;
		
		return null;
		
	};
	
	public function Link ( WorldInstance:World ) : Void
	{
		
		for ( Method in MethodList )
			Method.Link ( WorldInstance );
		
	};
	
}
