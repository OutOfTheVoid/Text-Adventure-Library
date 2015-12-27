package tal;

import tal.exceptions.TALException;

class VariableBase
{
	
	public function new ()
	{	
	};
	
	public function GetType () : UInt
	{
		
		throw new TALException ( "Method GetType () called on Abstract base class VariableBase.", 0 );
		
		return 0;
		
	}
	
}