package tal.dynamics.commands.matching;

interface ICommandMatch
{
	
	public function Test ( CommandArgument:String ) : Bool;
	public function Link ( WorldInstance:World ) : Void;
	
}