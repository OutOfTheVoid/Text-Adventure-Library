package tal.dynamics.methods;

import tal.dynamics.methods.IMethod;

import openfl.utils.Timer;
import openfl.events.TimerEvent;

class DelayMethod implements IMethod
{
	
	private var Clock:Timer;
	private var OnFinished:Void -> Void;
	
	public function new ( DelayMS:UInt )
	{
		
		Clock = new Timer ( DelayMS, 1 );
		Clock.addEventListener ( TimerEvent.TIMER, OnTimer );
		
	};
	
	public function Run ( OnFinished : Void -> Void ) : Void
	{
		
		this.OnFinished = OnFinished;
		
		Clock.start ();
		
	};
	
	public function Link ( WorldInstance:World ) : Void
	{
	};
	
	private function OnTimer ( E:TimerEvent ) : Void
	{
		
		OnFinished ();
		
	};
	
}