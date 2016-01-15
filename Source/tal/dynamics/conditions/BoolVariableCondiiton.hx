package tal.dynamics.conditions;

import tal.dynamics.conditions.ICondition;

import tal.dynamics.World;

class BoolVariableCondition implements ICondition
{
	
	private var InvertedTest:Bool;
	private var VariableName:String;
	
	private var WorldInstance:World;
	
	public function new ( VariableName:String, InvertedTest:Bool = false )
	{
		
		this.VariableName = VariableName;
		this.InvertedTest = InvertedTest;
		
	};
	
	public function Test () : Bool
	{
		
		return WorldInstance.GetBoolVariable ( VariableName ) ^ InvertedTest;
		
	};
	
	public function Link ( WorldInstance:World ) : Void
	{
		
		this.WorldInstance = WorldInstance;
		
	};
	
}