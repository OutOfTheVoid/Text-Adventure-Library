package tal.dynamics.methods;

import tal.dynamics.World;

import tal.dynamics.methods.IMethod;

class SetIntConstantMethod implements IMethod
{
	
	var VName:String;
	var Value:Int;
	var WorldInstance:World;
	
	public function new ( VName:String, Value:Int = 0.0 )
	{
		
		this.VName = VName;
		this.Value = Value;
		
	};
	
	public function Run ( OnFinished:Void -> Void ) : Void
	{
		
		WorldInstance.SetIntVariable ( VName, Value );
		
	};
	
	public function Link ( WorldInstance:World ) : Void
	{
		
		this.WorldInstance = WorldInstance;
		
	};
	
}
