package tal.dynamics;

import tal.dynamics.room.IRoom;

import tal.dynamics.commands.ICommand;
import tal.dynamics.commands.BasicHelpCommand;

import tal.dynamics.methods.IMethod;
import tal.dynamics.methods.IInputWaiterMethod;
import tal.dynamics.methods.ICapturedInputWaiterMethod;

import tal.dynamics.variables.StringVariable;

import tal.graphics.ITextInterface;
import tal.graphics.TextInterfaceMode;

import openfl.events.KeyboardEvent;

import openfl.display.Sprite;
import openfl.display.DisplayObject;

typedef MethodQueue = { MethodList:Array <IMethod>, Index:UInt };

class World
{
	
	private var Rooms:Array <IRoom>;
	
	private var GlobalCommandSet:Array <ICommand>;
	private var LocalCommandSet:Array <ICommand>;
	private var InventoryCommandSet:Array <ICommand>;
	
	private var StringVariables:Array <StringVariable>;
	
	private var CurrentRoom:IRoom;
	
	private var Interface:ITextInterface;
	
	private var CommandQueue:Array <ICommand>;
	
	private var MethodQueueStack:Array <MethodQueue>;
	
	private var GraphicsRoot:Sprite;
	
	private var GlobalHelpDefinition:BasicHelpCommand;
	
	private var Blocked:Bool;
	private var Executing:Bool;
	private var EnteredContext:Bool;
	
	private var InputWaiter:IInputWaiterMethod;
	private var CapturedInputWaiter:ICapturedInputWaiterMethod;
	
	public function new ()
	{
		
		Rooms = new Array <IRoom> ();
		
		GlobalCommandSet = new Array <ICommand> ();
		LocalCommandSet = new Array <ICommand> ();
		InventoryCommandSet = new Array <ICommand> ();
		
		StringVariables = new Array <StringVariable> ();
		
		CurrentRoom = null;
		
		GraphicsRoot = new Sprite ();
		
		MethodQueueStack = new Array <MethodQueue> ();
		
		GlobalHelpDefinition = new BasicHelpCommand ( "HELP: Hello world!" );
		GlobalCommandSet.push ( GlobalHelpDefinition );
		
		Blocked = false;
		Executing = false;
		EnteredContext = false;
		
	};
	
	public function SetInterface ( Interface:ITextInterface ) : Void
	{
		
		if ( this.Interface != null )
		{
			
			Interface.SetMode ( this.Interface.GetMode () );
			Interface.SetOutput ( this.Interface.GetOutput () );
			
			this.Interface.SetInputCallback ( null );
			this.Interface.SetCapturedInputCallback ( null );
			
			GraphicsRoot.removeChild ( this.Interface.GetGraphicsRoot () );
			
		}
		
		this.Interface = Interface;
		
		GraphicsRoot.addChild ( Interface.GetGraphicsRoot () );
		
		Interface.SetCapturedInputCallback ( CapturedInputCallback );
		Interface.SetInputCallback ( InputCallback );
		
	};
	
	public function GetGraphicsRoot () : DisplayObject
	{
		
		return GraphicsRoot;
		
	};
	
	public function CapturedInputCallback ( E:KeyboardEvent, Down:Bool ) : Void
	{
		
		if ( CapturedInputWaiter != null )
			CapturedInputWaiter.SupplyCapturedInput ( E, Down );
		
	};
	
	public function InputCallback ( Input:String ) : Void
	{
		
		if ( InputWaiter != null )
			InputWaiter.SupplyInput ( Input );
		else
		{
			
			
			
		}
		
	};
	
	public function AddRoom ( Room:IRoom ) : Void
	{
		
		Rooms.push ( Room );
		
	};
	
	public function SetRoom ( IDName:String ) : Void
	{
		
		for ( Room in Rooms )
		{
			
			if ( Room.GetIDName () == IDName )
			{
				
				if ( CurrentRoom != null )
					CurrentRoom.Exit ();
				
				CurrentRoom = Room;
				CurrentRoom.Enter ();
				
				return;
				
			}
			
		}
		
		trace ( "ERROR! Set invalid room!" );
		
	};
	
	public function GetStringVariable ( Name:String ) : String
	{
		
		for ( Variable in StringVariables )
		{
			
			if ( Variable.GetName () == Name )
				return Variable.Get ();
			
		}
		
		return null;
		
	};
	
	public function SetStringVariable ( Name:String, Value:String ) : Void
	{
		
		for ( Vairable in StringVariables )
		{
			
			if ( Vairable.GetName () == Name )
			{
				
				Vairable.Set ( Value );
				
				return;
				
			}
			
		}
		
		StringVariables.push ( new StringVariable ( Name, Value ) );
		
	};
	
	public function AppendOutput ( Output:String ) : Void
	{
		
		if ( Interface != null )
			Interface.AddOutput ( Output );
		
	};
	
	public function PushMethodQueueForExecution ( Queue:Array <IMethod> ) : Void
	{
		
		var MQueue:MethodQueue = { Index : 0, MethodList : Queue };
		
		MQueue.Index = 0;
		MQueue.MethodList = Queue;
		
		MethodQueueStack.push ( MQueue );
		
		EnteredContext = true;
		
	};
	
	private function UnBlock () : Void
	{
		
		Blocked = false;
		
		if ( ! Executing )
		{
			
			Execute ();
			
			InputWaiter = null;
			
		}
		
	};
	
	public function Execute () : Void
	{
		
		Blocked = false;
		Executing = true;
		
		if ( MethodQueueStack.length == 0 )
			return;
		
		var CurrentQueue:MethodQueue = MethodQueueStack [ MethodQueueStack.length - 1 ];
		
		while ( ! Blocked && CurrentQueue != null )
		{
			
			while ( CurrentQueue.Index < CurrentQueue.MethodList.length && ! Blocked )
			{
				
				Blocked = true;
				
				CurrentQueue.MethodList [ CurrentQueue.Index ].Run ( UnBlock );
				
				if ( ! Blocked )
				{
					
					CurrentQueue.Index ++;
					
					if ( EnteredContext )
						break;
					
				}
				
			}
			
			if ( EnteredContext )
			{
				
				CurrentQueue = MethodQueueStack [ MethodQueueStack.length - 1 ];
				
				EnteredContext = false;
				
			}
			else if ( CurrentQueue.Index == CurrentQueue.MethodList.length )
				MethodQueueStack.pop ();
			
		}
		
		Executing = false;
		
	};
	
	public function WaitOnInput ( SourceMethod:IInputWaiterMethod ) : Void
	{
		
		InputWaiter = SourceMethod;
		
	};
	
	public function WaitOnCapturedInput ( SourceMethod:ICapturedInputWaiterMethod ) : Void
	{
		
		CapturedInputWaiter = SourceMethod;
		
	};
	
}
