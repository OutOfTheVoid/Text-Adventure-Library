package tal.dynamics.methods;

import tal.dynamics.World;

import tal.dynamics.methods.IMethod;

class SetBoolConstantMethod implements IMethod
{
	
	var VName:String;
	var Value:Bool;
	var WorldInstance:World;
	
	public function new ( VName:String, Value:Bool = 0.0 )
	{
		
		this.VName = VName;
		this.Value = Value;
		
	};
	
	public function Run ( OnFinished:Void -> Void ) : Void
	{
		
		WorldInstance.SetBoolVariable ( VName, Value );
		
	};
	
	public function Link ( WorldInstance:World ) : Void
	{
		
		this.WorldInstance = WorldInstance;
		
	};
	
}
