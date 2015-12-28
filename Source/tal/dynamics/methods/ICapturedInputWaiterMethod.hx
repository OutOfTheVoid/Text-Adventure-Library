package tal.dynamics.methods;

import tal.dynamics.methods.IMethod;

import openfl.events.KeyboardEvent;

interface ICapturedInputWaiterMethod extends IMethod
{
	
	function SupplyCapturedInput ( E:KeyboardEvent, Down:Bool ) : Void;
	
}