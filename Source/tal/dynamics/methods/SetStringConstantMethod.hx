package tal.dynamics.methods;

import tal.dynamics.World;

import tal.dynamics.methods.IMethod;

class SetStringConstantMethod implements IMethod
{
	
	var VName:String;
	var Value:String;
	var WorldInstance:World;
	
	public function new ( VName:String, Value:String = "" )
	{
		
		this.VName = VName;
		this.Value = Value;
		
	};
	
	public function Run ( OnFinished:Void -> Void ) : Void
	{
		
		WorldInstance.SetStringVariable ( VName, Value );
		
	};
	
	public function Link ( WorldInstance:World ) : Void
	{
		
		this.WorldInstance = WorldInstance;
		
	};
	
}
