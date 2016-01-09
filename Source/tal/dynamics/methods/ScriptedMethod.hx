package tal.dynamics.methods;

import tal.dynamics.World;

import tal.dynamics.methods.IMethod;
import tal.dynamics.methods.IInputWaiterMethod;
import tal.dynamics.methods.ICapturedInputWaiterMethod;

import openfl.events.KeyboardEvent;
import openfl.events.TimerEvent;

import openfl.utils.Timer;

import hscript.Interp;
import hscript.Parser;

class TimerUtil
{
	
	private var TimerInstance:Timer;
	private var Callback:Void -> Void;
	
	public function new ( Callback:Void -> Void, TimeoutMS:Float )
	{
		
		TimerInstance = new Timer ( TimeoutMS, 1 );
		
		this.Callback = Callback;
		
		TimerInstance.addEventListener ( TimerEvent.TIMER, OnTimer );
		TimerInstance.start ();
		
	};
	
	private function OnTimer ( T:TimerEvent ) : Void
	{
		
		TimerInstance.removeEventListener ( TimerEvent.TIMER, OnTimer );
		
		Callback ();
		
		TimerInstance = null;
		Callback = null;
		
	};
	
};

class ScriptedMethod implements IMethod implements IInputWaiterMethod implements ICapturedInputWaiterMethod
{
	
	private static var ScriptParser:Parser;
	
	static function __init__ ()
	{
		
		ScriptParser = new Parser ();
		
	}
	
	private var WorldInstance:World;
	
	private var SyntaxTree:Dynamic;
	private var ScriptInterpreter:Interp;
	
	private var OnFinishedCallback:Void -> Void;
	
	private var OnInputFunction:Dynamic;
	private var OnCapturedInputFunction:Dynamic;
	
	public function new ( Script:String )
	{
		
		SyntaxTree = ScriptParser.parseString ( Script );
		
		ScriptInterpreter = new Interp ();
		
		ScriptInterpreter.variables.set ( "Finished", OnFinishedWrapper );
		
		ScriptInterpreter.variables.set ( "WaitOnInput", WaitOnInputWrapper );
		ScriptInterpreter.variables.set ( "WaitOnCapturedInput", WaitOnCapturedInputWrapper );
		
		ScriptInterpreter.variables.set ( "SetTimeout", SetTimeoutWrapper );
		
	};
	
	public function Link ( WorldInstance:World ) : Void
	{
		
		this.WorldInstance = WorldInstance;
		
		ScriptInterpreter.variables.set ( "SetRoom", WorldInstance.SetRoom );
		ScriptInterpreter.variables.set ( "HoldInput", WorldInstance.HoldInput );
		ScriptInterpreter.variables.set ( "BlockInput", WorldInstance.BlockInput );
		ScriptInterpreter.variables.set ( "UnBlockInput", WorldInstance.UnBlockInput );
		ScriptInterpreter.variables.set ( "SetBool", WorldInstance.SetBoolVariable );
		ScriptInterpreter.variables.set ( "SetInt", WorldInstance.SetIntVariable );
		ScriptInterpreter.variables.set ( "SetFloat", WorldInstance.SetIntVariable );
		ScriptInterpreter.variables.set ( "SetString", WorldInstance.SetStringVariable );
		ScriptInterpreter.variables.set ( "GetBool", WorldInstance.GetBoolVariable );
		ScriptInterpreter.variables.set ( "GetInt", WorldInstance.GetIntVariable );
		ScriptInterpreter.variables.set ( "GetFloat", WorldInstance.GetFloatVariable );
		ScriptInterpreter.variables.set ( "GetString", WorldInstance.GetStringVariable );
		ScriptInterpreter.variables.set ( "AppendOutput", WorldInstance.AppendOutput );
		ScriptInterpreter.variables.set ( "ClearInput", WorldInstance.ClearInput );
		ScriptInterpreter.variables.set ( "GetPrompt", WorldInstance.GetPrompt );
		ScriptInterpreter.variables.set ( "EnqueueCommand", WorldInstance.EnqueueCommand );
		
	};
	
	public function Run ( OnFinished:Void -> Void ) : Void
	{
		
		OnFinishedCallback = OnFinished;
		
		ScriptInterpreter.execute ( SyntaxTree );
		
	};
	
	private function SetTimeoutWrapper ( Callback:Void -> Void, TimeoutMS:Float ) : Void
	{
		
		new TimerUtil ( Callback, TimeoutMS );
		
	};
	
	private function OnFinishedWrapper () : Void
	{
		
		OnFinishedCallback ();
		
	};
	
	private function WaitOnInputWrapper ( OnInputFunction:Dynamic ) : Void
	{
		
		this.OnInputFunction = OnInputFunction;
		
		WorldInstance.WaitOnInput ( this );
		
	};
	
	private function WaitOnCapturedInputWrapper ( OnCapturedInputFunction:Dynamic ) : Void
	{
		
		this.OnCapturedInputFunction = OnCapturedInputFunction;
		
		WorldInstance.WaitOnCapturedInput ( this );
		
	};
	
	public function SupplyCapturedInput ( E:KeyboardEvent, Down:Bool ) : Void
	{
		
		if ( OnCapturedInputFunction != null )
			OnCapturedInputFunction ( E, Down );
		
	};
	
	public function SupplyInput ( Input:String ) : Void
	{
		
		if ( OnInputFunction != null )
			OnInputFunction ( Input );
		
	};
	
}
