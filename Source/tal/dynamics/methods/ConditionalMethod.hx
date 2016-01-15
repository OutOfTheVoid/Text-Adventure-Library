package tal.dynamics.methods;

import tal.dynamics.methods.IMethod;

import tal.dynamics.conditions.ICondition;

import tal.dynamics.World;

class ConditionalMethod implements IMethod
{
	
	private var Condition:ICondition;
	
	private var IfMethodSet:Array <IMethod>;
	private var ElseMethodSet:Array <IMethod>;
	
	private var WorldInstance:World;
	
	public function new ( Condition:ICondition, IfMethodSet:Array <IMethod> = null, ElseMethodSet:Array <IMethod> = null )
	{
		
		this.Condition = Condition;
		
		this.IfMethodSet = IfMethodSet;
		this.ElseMethodSet = ElseMethodSet;
		
	};
	
	public function Run ( OnFinished:Void -> Void ) : Void
	{
		
		if ( Condition.Test () )
		{
			
			if ( IfMethodSet != null )
				WorldInstance.PushMethodQueueForExecution ( IfMethodSet );
			
		}
		else
		{
			
			if ( ElseMethodSet != null )
				WorldInstance.PushMethodQueueForExecution ( ElseMethodSet );
			
		}
		
		OnFinished ();
		
	};
	
	public function Link ( WorldInstance:World ) : Void
	{
		
		this.WorldInstance = WorldInstance;
		
		Condition.Link ( WorldInstance );
		
	};
	
}
