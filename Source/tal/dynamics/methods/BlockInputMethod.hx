package tal.dynamics.methods;

import tal.dynamics.methods.IMethod;

import tal.dynamics.World;

class BlockInputMethod implements IMethod
{
	
	private var WorldInstance:World;
	
	public function new ()
	{
	};
	
	public function Run ( OnFinished : Void -> Void ) : Void
	{
		
		WorldInstance.BlockInput ();
		OnFinished ();
		
	};
	
	public function Link ( WorldInstance:World ) : Void
	{
		
		this.WorldInstance = WorldInstance;
		
	};
	
}