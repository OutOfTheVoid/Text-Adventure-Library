package tal.dynamics.methods;

import tal.dynamics.World;

interface IMethod
{
	
	public function Run ( OnFinished : Dynamic -> Void, UserData : Dynamic ) : Void;
	
	public function Link ( WorldInstance:World ) : Void;
	
}
