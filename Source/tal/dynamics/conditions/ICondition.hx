package tal.dynamics.conditions;

import tal.dynamics.World;

interface ICondition
{
	
	public function Test () : Bool;
	public function Link ( WorldInstance:World ) : Void;
	
}
