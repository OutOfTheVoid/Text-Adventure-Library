package tal.dynamics.methods;

import tal.dynamics.World;

import tal.dynamics.methods.IMethod;

class SetFloatConstantMethod implements IMethod
{
	
	var VName:String;
	var Value:Float;
	var WorldInstance:World;
	
	public function new ( VName:String, Value:Float = 0.0 )
	{
		
		this.VName = VName;
		this.Value = Value;
		
	};
	
	public function Run ( OnFinished:Void -> Void ) : Void
	{
		
		WorldInstance.SetFloatVariable ( VName, Value );
		
	};
	
	public function Link ( WorldInstance:World ) : Void
	{
		
		this.WorldInstance = WorldInstance;
		
	};
	
}
