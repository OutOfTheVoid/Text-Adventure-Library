package tal.dynamics.variables;

class StringVariable
{
	
	private var Name:String;
	private var Value:String;
	
	public function new ( Name:String, InitialValue:String = "" )
	{
		
		this.Name = Name;
		this.Value = InitialValue;
		
	};
	
	public function GetName () : String
	{
		
		return Name;
		
	};
	
	public function Set ( Value:String ) : Void
	{
		
		this.Value = Value;
		
	};
	
	public function Get () : String
	{
		
		return Value;
		
	};
	
}