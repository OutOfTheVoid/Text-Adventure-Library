package tal.dynamics;

import tal.dynamics.rooms.IRoom;

import tal.dynamics.commands.ICommand;
import tal.dynamics.commands.BasicResponseCommand;

import tal.dynamics.commands.matching.BasicCommandMatch;

import tal.dynamics.methods.IMethod;
import tal.dynamics.methods.IInputWaiterMethod;
import tal.dynamics.methods.ICapturedInputWaiterMethod;

import tal.graphics.ITextInterface;
import tal.graphics.TextInterfaceMode;

import tal.util.parsing.StringParsingTools;

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
	
	private var StringVariables:Map <String, String>;
	private var IntVariables:Map <String, Int>;
	private var FloatVariables:Map <String, Float>;
	private var BoolVariables:Map <String, Bool>;
	
	private var CurrentRoom:IRoom;
	
	private var Interface:ITextInterface;
	
	private var CommandQueue:Array <Array <IMethod>>;
	
	private var MethodQueueStack:Array <MethodQueue>;
	
	private var GraphicsRoot:Sprite;
	
	private var GlobalHelpDefinition:BasicResponseCommand;
	
	private var Blocked:Bool;
	private var Executing:Bool;
	private var EnteredContext:Bool;
	
	private var PreWaiterMode:UInt;
	private var InputWaiter:IInputWaiterMethod;
	private var CapturedInputWaiter:ICapturedInputWaiterMethod;
	
	private var CurrentRoomVName:String;
	
	public function new ()
	{
		
		Rooms = new Array <IRoom> ();
		
		GlobalCommandSet = new Array <ICommand> ();
		LocalCommandSet = new Array <ICommand> ();
		InventoryCommandSet = new Array <ICommand> ();
		
		StringVariables = new Map <String, String> ();
		IntVariables = new Map <String, Int> ();
		FloatVariables = new Map <String, Float> ();
		BoolVariables = new Map <String, Bool> ();
		
		CurrentRoom = null;
		
		GraphicsRoot = new Sprite ();
		
		MethodQueueStack = new Array <MethodQueue> ();
		CommandQueue = new Array <Array <IMethod>> ();
		
		GlobalHelpDefinition = new BasicResponseCommand ( "==> Help\n\nHelp: Text Adventure Library Development Release.\n\nTry looking around?\n\n", new BasicCommandMatch ( [ "help" ] ) );
		GlobalCommandSet.push ( GlobalHelpDefinition );
		
		Blocked = false;
		Executing = false;
		EnteredContext = false;
		
		CurrentRoomVName = "__rt_current_room";
		
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
	
	public function SetCurrentRoomVName ( VName:String ) : Void
	{
		
		StringVariables [ CurrentRoomVName ] = "";
		
		CurrentRoomVName = VName;
		
		StringVariables [ CurrentRoomVName ] = CurrentRoom.GetIDName ();
		
	};
	
	public function GetCurrentRoomVName () : String
	{
		
		return CurrentRoomVName;
		
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
			
			var MethodList:Array <IMethod> = null;
			
			for ( Command in GlobalCommandSet )
			{
				
				if ( Command.GetHidden () == false )
				{
					
					MethodList = Command.Test ( Input );
					
					if ( MethodList != null )
						break;
					
				}
				
			}
			
			if ( ( MethodList == null ) && ( LocalCommandSet != null ) )
			{
				
				for ( Command in LocalCommandSet )
				{
					
					if ( Command.GetHidden () == false )
					{
						
						MethodList = Command.Test ( Input );
						
						if ( MethodList != null )
							break;
						
					}
					
				}
				
			}
			
			if ( ( MethodList == null ) && ( InventoryCommandSet != null ) )
			{
				
				for ( Command in InventoryCommandSet )
				{
					
					if ( Command.GetHidden () == false )
					{
						
						MethodList = Command.Test ( Input );
						
						if ( MethodList != null )
							break;
						
					}
					
				}
				
			}
			
			if ( MethodList != null )
			{
				
				PushMethodQueueForExecution ( MethodList );
				EnteredContext = false;
				
				Execute ();
				
			}
			else
			{
				
				var CommandString:String = StringParsingTools.FormatCommandForMatching ( Input );
				CommandString = CommandString.charAt ( 0 ).toUpperCase () + CommandString.substr ( 1 ).toLowerCase ();
				
				AppendOutput ( "==> " + CommandString + "\n\nYou tried to \"" + Input + "\" but it didn't make sense.\n\n" );
				ClearInput ();
				
			}
			
		}
		
	};
	
	public function AddRoom ( Room:IRoom ) : Void
	{
		
		Rooms.push ( Room );
		
	};
	
	public function AddGlobalCommand ( Command:ICommand ) : Void
	{
		
		GlobalCommandSet.push ( Command );
		
	};
	
	public function Link () : Void
	{
		
		for ( Command in GlobalCommandSet )
			Command.Link ( this );
		
		for ( Room in Rooms )
		{
			
			Room.Link ( this );
			
			for ( Command in Room.GetLocalCommandSet () )
				Command.Link ( this );
			
		}
		
	};
	
	public function SetRoom ( IDName:String ) : Void
	{
		
		trace ( "SetRoom ( \"" + IDName + "\" );" );
		
		for ( Room in Rooms )
		{
			
			if ( Room.GetIDName () == IDName )
			{
				
				if ( CurrentRoom != null )
					CurrentRoom.Exit ();
				
				CurrentRoom = Room;
				
				LocalCommandSet = CurrentRoom.GetLocalCommandSet ();
				
				CurrentRoom.Enter ();
				
				StringVariables.set ( CurrentRoomVName, IDName );
				
				return;
				
			}
			
		}
		
		trace ( "ERROR! Set invalid room!" );
		
	};
	
	public function EnqueueCommand ( Command:String, AllowHidden:Bool = false ) : Void
	{
		
		var MethodList:Array <IMethod> = null;
		
		for ( TestCommand in GlobalCommandSet )
		{
			
			if ( ( ! TestCommand.GetHidden () ) || AllowHidden )
			{
				
				MethodList = TestCommand.Test ( Command );
				
				if ( MethodList != null )
					break;
				
			}
			
		}
		
		if ( ( MethodList == null ) && ( LocalCommandSet != null ) )
		{
			
			for ( TestCommand in LocalCommandSet )
			{
				
				if ( ( ! TestCommand.GetHidden () ) || AllowHidden )
				{
					
					MethodList = TestCommand.Test ( Command );
					
					if ( MethodList != null )
						break;
				
				}
					
			}
			
		}
		
		if ( ( MethodList == null ) && ( InventoryCommandSet != null ) )
		{
			
			for ( TestCommand in InventoryCommandSet )
			{
				
				if ( ( ! TestCommand.GetHidden () ) || AllowHidden )
				{
					
					MethodList = TestCommand.Test ( Command );
					
					if ( MethodList != null )
						break;
				
				}
				
			}
			
		}
		
		if ( MethodList != null )
			CommandQueue.push ( MethodList );
		
		if ( ( ! Executing ) && ( ! Blocked ) )
			Execute ();
		
	};
	
	public function GetStringVariable ( Name:String ) : String
	{
		
		return StringVariables.get ( Name );
		
	};
	
	public function GetIntVariable ( Name:String ) : Int
	{
		
		return IntVariables.get ( Name );
		
	};
	
	public function GetFloatVariable ( Name:String ) : Float
	{
		
		return FloatVariables.get ( Name );
		
	};
	
	public function GetBoolVariable ( Name:String ) : Bool
	{
		
		return BoolVariables.get ( Name );
		
	};
	
	public function SetStringVariable ( Name:String, Value:String ) : Void
	{
		
		StringVariables.set ( Name, Value );
		
	};
	
	public function SetIntVariable ( Name:String, Value:Int ) : Void
	{
		
		IntVariables.set ( Name, Value );
		
	};
	
	public function SetFloatVariable ( Name:String, Value:Float ) : Void
	{
		
		FloatVariables.set ( Name, Value );
		
	};
	
	public function SetBoolVariable ( Name:String, Value:Bool ) : Void
	{
		
		BoolVariables.set ( Name, Value );
		
	};
	
	public function AppendOutput ( Output:String ) : Void
	{
		
		if ( Interface != null )
			Interface.AddOutput ( Output );
		
	};
	
	public function ClearInput () : Void
	{
		
		if ( Interface != null )
			Interface.ClearInput ();
		
	};
	
	public function GetPrompt () : String
	{
		
		if ( Interface != null )
			return Interface.GetPrompt ();
		
		return "";
		
	};
	
	public function PushMethodQueueForExecution ( Queue:Array <IMethod> ) : Void
	{
		
		var MQueue:MethodQueue = { Index : 0, MethodList : Queue };
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
			CapturedInputWaiter = null;
			
			if ( Interface.GetMode () != TextInterfaceMode.BLOCK_INPUT )
				Interface.SetMode ( PreWaiterMode );
			
		}
		
	};
	
	public function Execute () : Void
	{
		
		Blocked = false;
		Executing = true;
		
		if ( MethodQueueStack.length == 0 )
		{
			
			if ( CommandQueue.length != 0 )
			{
				
				var NewQueue:MethodQueue = { Index : 0, MethodList : CommandQueue.shift () };
				MethodQueueStack.push ( NewQueue );
				
			}
			else
				return;
			
		}
		
		var CurrentQueue:MethodQueue = MethodQueueStack [ MethodQueueStack.length - 1 ];
		
		while ( ( ! Blocked ) && ( CurrentQueue != null ) )
		{
			
			while ( ( CurrentQueue.Index < CurrentQueue.MethodList.length ) && ( ! Blocked ) )
			{
				
				Blocked = true;
				
				CurrentQueue.MethodList [ CurrentQueue.Index ].Run ( UnBlock );
				
				CurrentQueue.Index ++;
				
				if ( ! Blocked )
				{
					
					if ( EnteredContext )
						break;
					
				}
				
			}
			
			if ( ! Blocked )
			{
				
				if ( EnteredContext )
				{
					
					CurrentQueue = MethodQueueStack [ MethodQueueStack.length - 1 ];
					
					EnteredContext = false;
					
				}
				else if ( CurrentQueue.Index == CurrentQueue.MethodList.length )
				{
					
					MethodQueueStack.pop ();
					
					if ( MethodQueueStack.length != 0 )
						CurrentQueue = MethodQueueStack [ MethodQueueStack.length - 1 ];
					else
					{
						
						if ( CommandQueue.length != 0 )
						{
							
							var NewQueue:MethodQueue = { Index : 0, MethodList : CommandQueue.shift () };
							
							MethodQueueStack.push ( NewQueue );
							CurrentQueue = NewQueue;
							
						}
						else
							CurrentQueue = null;
						
					}
					
				}
				
			}
			
		}
		
		Executing = false;
		
		if ( ! Blocked )
			Interface.SetMode ( TextInterfaceMode.ALLOW_INPUT );
		
	};
	
	public function HoldInput () : Void
	{
		
		Interface.SetMode ( TextInterfaceMode.HOLD_INPUT );
		
	};
	
	public function BlockInput () : Void
	{
		
		Interface.SetMode ( TextInterfaceMode.BLOCK_INPUT );
		
	};
	
	public function UnBlockInput () : Void
	{
		
		Interface.SetMode ( TextInterfaceMode.ALLOW_INPUT );
		
	};
	
	public function WaitOnInput ( SourceMethod:IInputWaiterMethod ) : Void
	{
		
		InputWaiter = SourceMethod;
		
		PreWaiterMode = Interface.GetMode ();
		Interface.SetMode ( TextInterfaceMode.ALLOW_INPUT );
		
	};
	
	public function WaitOnCapturedInput ( SourceMethod:ICapturedInputWaiterMethod ) : Void
	{
		
		CapturedInputWaiter = SourceMethod;
		
		PreWaiterMode = Interface.GetMode ();
		Interface.SetMode ( TextInterfaceMode.CAPTURE_INPUT );
		
	};
	
}
