package tal.dynamics.methods;

import tal.dynamics.World;

import tal.dynamics.methods.IMethod;

class SimpleOutputMethod implements IMethod
{
	
	private var OutputString:String;
	private var WorldInstance:World;
	
	public function new ( OutputString:String )
	{
		
		this.OutputString = OutputString;
		
	};
	
	public function ResetOutput ( OutputString:String ) : Void
	{
		
		this.OutputString = OutputString;
		
	};
	
	public function Run ( OnFinished:Void -> Void ) : Void
	{
		
		WorldInstance.AppendOutput ( OutputString );
		
		OnFinished ();
		
	};
	
	public function Link ( WorldInstance:World ) : Void
	{
		
		this.WorldInstance = WorldInstance;
		
	};
	
}
