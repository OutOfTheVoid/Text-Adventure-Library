package tal.exceptions;

import haxe.CallStack;

class TALException
{
	
	private var What:String;
	private var Code:UInt;
	private var CallStackString:String;
	
	public function new ( What:String, Code:UInt = 0 )
	{
		
		this.What = What;
		this.Code = Code;
		
		CallStackString = "Callstack: \n";
		
		CallStackString = CallStack.toString ( CallStack.callStack () );
		
	}
	
	public function GetWhat () : String
	{
		
		return What;
		
	};
	
	public function GetCode () : UInt
	{
		
		return Code;
		
	};
	
	public function GetStackDescription () : String
	{
		
		return CallStackString;
		
	};
	
}