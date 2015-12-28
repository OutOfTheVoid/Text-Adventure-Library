package tal.dynamics.methods;

import tal.dynamics.methods.IMethod;

import tal.dynamics.World;

class ClearInputMethod implements IMethod
{
	
	private var WorldInstance:World;
	
	public function new ()
	{
	};
	
	public function Run ( OnFinished:Void -> Void ) : Void
	{
		
		WorldInstance.ClearInput ();
		OnFinished ();
		
	};
	
	public function Link ( WorldInstance:World ) : Void
	{
		
		this.WorldInstance = WorldInstance;
		
	};
	
}