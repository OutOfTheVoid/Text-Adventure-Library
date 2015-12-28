package tal.dynamics.methods;

import tal.dynamics.World;

interface IMethod
{
	
	public function Run ( OnFinished : Void -> Void ) : Void;
	
	public function Link ( WorldInstance:World ) : Void;
	
}
