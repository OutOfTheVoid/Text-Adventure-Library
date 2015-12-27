package tal.graphics;

import tal.graphics.TextInterfaceMode;

import openfl.display.DisplayObject;
import openfl.display.Sprite;
import openfl.display.Shape;
import openfl.display.Stage;

import openfl.utils.Timer;

import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.TextFieldAutoSize;
import openfl.text.TextFieldType;

import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.events.KeyboardEvent;
import openfl.events.TimerEvent;

import openfl.ui.Keyboard;

class BasicTextInterface implements ITextInterface
{
	
	private var InputCallback:String -> Void;
	private var CaptureInputCalback:KeyboardEvent -> Bool -> Void;
	
	private var GraphicsRoot:Sprite;
	
	private var InterfaceFormat:BasicTextInterfaceFormat;
	
	private var GlobalTextFormat:TextFormat;
	
	private var OutputField:TextField;
	private var InputField:TextField;
	
	private var InterfaceMode:UInt;
	private var BorderShape:Shape;
	
	private var ScrollShape:Shape;
	
	private var BackgroundShape:Shape;
	
	private var OnStage:Bool;
	private var StageRef:Stage;
	
	private var TextCarrotState:Bool;
	private var CarrotTimer:Timer;
	
	public function new ( Width:UInt, Height:UInt, Format:BasicTextInterfaceFormat = null )
	{
		
		if ( Format == null )
			Format = new BasicTextInterfaceFormat ();
		
		InterfaceFormat = Format;
		
		InputCallback = null;
		
		GraphicsRoot = new Sprite ();
		GraphicsRoot.addEventListener ( Event.ADDED_TO_STAGE, OnAddedToStage );
		GraphicsRoot.addEventListener ( Event.REMOVED_FROM_STAGE, OnRemovedFromStage );
		
		BackgroundShape = new Shape ();
		
		BackgroundShape.graphics.beginFill ( Format.BackgroundColor, 1.0 );
		BackgroundShape.graphics.drawRect ( 0.0, 0.0, Width, Height );
		BackgroundShape.graphics.endFill ();
		
		GraphicsRoot.addChild ( BackgroundShape );
		
		GlobalTextFormat = new TextFormat ( Format.Font, Format.FontSize, Format.FontColor, Format.Bold );
		
		OutputField = new TextField ();
		InputField = new TextField ();
		
		OutputField.defaultTextFormat = GlobalTextFormat;
		InputField.defaultTextFormat = GlobalTextFormat;
		
		InputField.x = Format.BorderSize + Format.TextBorderSpacing + Format.TextOffset_X;
		InputField.y = Height - Format.BorderSize - Format.FontSize - Format.LinePadding - Format.TextOffset_Y - Format.TextBorderSpacing;
		InputField.autoSize = TextFieldAutoSize.NONE;
		InputField.width = Width - Format.BorderSize * 2 - Format.TextBorderSpacing * 2;
		
		InputField.doubleClickEnabled = false;
		InputField.multiline = false;
		InputField.selectable = false;
		InputField.type = TextFieldType.DYNAMIC;
		
		InputField.appendText ( Format.Prompt );
		
		OutputField.x = Format.BorderSize + Format.TextBorderSpacing + Format.TextOffset_X;
		OutputField.y = Format.BorderSize + Format.TextBorderSpacing + Format.TextOffset_Y;
		
		OutputField.width = Width - Format.BorderSize * 2 - Format.TextBorderSpacing * 2 - Format.ScrollSize;
		OutputField.height = InputField.y - Format.BorderSize * 2 - Format.TextBorderSpacing * 3;
		
		OutputField.selectable = false;
		OutputField.wordWrap = true;
		OutputField.multiline = true;
		
		//-----
		
		BorderShape = new Shape ();
		
		BorderShape.graphics.beginFill ( Format.BorderColor, 1.0 );
		BorderShape.graphics.drawRect ( Format.BorderSize, 0.0, Width - Format.BorderSize * 2.0, Format.BorderSize );
		BorderShape.graphics.drawRect ( Format.BorderSize, Height - Format.BorderSize, Width - Format.BorderSize * 2.0, Format.BorderSize );
		BorderShape.graphics.drawRect ( Format.BorderSize, InputField.y - Format.BorderSize - Format.TextBorderSpacing, Width - Format.BorderSize * 2.0, Format.BorderSize );
		BorderShape.graphics.drawRect ( 0.0, 0.0, Format.BorderSize, Height );
		BorderShape.graphics.drawRect ( Width - Format.BorderSize, 0.0, Format.BorderSize, Height );
		BorderShape.graphics.endFill ();
		
		BorderShape.graphics.beginFill ( Format.ScrollBackColor, 1.0 );
		BorderShape.graphics.drawRect ( Width - Format.BorderSize - Format.ScrollSize, Format.BorderSize, Format.ScrollSize, InputField.y - Format.BorderSize * 2 - Format.TextBorderSpacing );
		BorderShape.graphics.endFill ();
		
		//=======Not Done=======//
		
		OnStage = false;
		
		InterfaceMode = TextInterfaceMode.ALLOW_INPUT;
		
		GraphicsRoot.addChild ( InputField );
		GraphicsRoot.addChild ( OutputField );
		GraphicsRoot.addChild ( BorderShape );
		
		TextCarrotState = false;
		
		CarrotTimer = new Timer ( Format.CarrotTiming * 1000.0 );
		CarrotTimer.addEventListener ( TimerEvent.TIMER, OnCarrotTimer );
		CarrotTimer.start ();
		
	};
	
	private function OnAddedToStage ( E:Event ) : Void
	{
		
		OnStage = true;
		StageRef = GraphicsRoot.stage;
		
		if ( InterfaceMode != TextInterfaceMode.BLOCK_INPUT )
			StageRef.focus = StageRef;
		
		StageRef.addEventListener ( MouseEvent.CLICK, OnStageClick );
		StageRef.addEventListener ( KeyboardEvent.KEY_DOWN, OnKeyDown );
		StageRef.addEventListener ( KeyboardEvent.KEY_UP, OnKeyUp );
		
	};
	
	private function OnRemovedFromStage ( E:Event ) : Void
	{
		
		OnStage = false;
		
		StageRef.removeEventListener ( MouseEvent.CLICK, OnStageClick );
		StageRef.removeEventListener ( KeyboardEvent.KEY_DOWN, OnKeyDown );
		StageRef.removeEventListener ( KeyboardEvent.KEY_UP, OnKeyUp );
		
		StageRef.focus = null;
		StageRef = null;
		
	};
	
	private function OnStageClick ( E:MouseEvent ) : Void
	{
		
		switch ( InterfaceMode )
		{
			
			case TextInterfaceMode.ALLOW_INPUT:
			{
				
				StageRef.focus = StageRef;
				
			}
			
			case TextInterfaceMode.CAPTURE_INPUT:
			{
				
				StageRef.focus = StageRef;
				
			}
			
			case TextInterfaceMode.HOLD_INPUT:
			{
				
				StageRef.focus = StageRef;
				
			}
			
		}
		
	};
	
	private function OnKeyDown ( E:KeyboardEvent ) : Void
	{
		
		switch ( InterfaceMode )
		{
			
			case TextInterfaceMode.CAPTURE_INPUT:
			{
				
				if ( CaptureInputCalback != null )
					CaptureInputCalback ( E, true );
				
			}
			
			case TextInterfaceMode.ALLOW_INPUT:
			{
				
				if ( E.keyCode == Keyboard.BACKSPACE )
				{
					
					if ( TextCarrotState )
					{
						
						if ( InputField.text.length > InterfaceFormat.Prompt.length + 1 )
							InputField.text = InputField.text.substr ( 0, InputField.text.length - 2 ) + "|";
						
					}
					else
					{
						
						if ( InputField.text.length > InterfaceFormat.Prompt.length )
							InputField.text = InputField.text.substr ( 0, InputField.text.length - 1 );
						
					}
					
				}
				else if ( E.keyCode == Keyboard.ENTER )
				{
					
					if ( InputCallback != null )
					{
						
						if ( TextCarrotState )
							InputCallback ( InputField.text.substring ( InterfaceFormat.Prompt.length, InputField.text.length - 1 ) );
						else
							InputCallback ( InputField.text.substr ( InterfaceFormat.Prompt.length ) );
						
					}
					
				}
				else
				{
					
					var CharachterIn:String = String.fromCharCode ( E.charCode );
					
					if ( InterfaceFormat.Restrict.indexOf ( CharachterIn ) != - 1 )
					{
						
						if ( TextCarrotState )
							InputField.text = InputField.text.substr ( 0, InputField.text.length - 1 ) + CharachterIn + "|";
						else
							InputField.text += CharachterIn;
						
					}
					
				}
				
			}
			
			case TextInterfaceMode.HOLD_INPUT:
			{
				
				if ( E.keyCode == Keyboard.BACKSPACE )
				{
					
					if ( TextCarrotState )
					{
						
						if ( InputField.text.length > InterfaceFormat.HeldPrompt.length + 1 )
							InputField.text = InputField.text.substr ( 0, InputField.text.length - 2 ) + "|";
						
					}
					else
					{
						
						if ( InputField.text.length > InterfaceFormat.HeldPrompt.length )
							InputField.text = InputField.text.substr ( 0, InputField.text.length - 1 );
						
					}
					
				}
				else
				{
					
					var CharachterIn:String = String.fromCharCode ( E.charCode );
					
					if ( InterfaceFormat.Restrict.indexOf ( CharachterIn ) != - 1 )
					{
						
						if ( TextCarrotState )
							InputField.text = InputField.text.substr ( 0, InputField.text.length - 1 ) + CharachterIn + "|";
						else
							InputField.text += CharachterIn;
						
					}
					
				}
				
			}
			
		}
		
	};
	
	private function OnCarrotTimer ( E:TimerEvent ) : Void
	{
		
		if ( ( InterfaceMode == TextInterfaceMode.ALLOW_INPUT ) || ( InterfaceMode == TextInterfaceMode.HOLD_INPUT ) )
		{
			
			if ( TextCarrotState )
			{
				
				TextCarrotState = false;
				
				InputField.text = InputField.text.substr ( 0, InputField.text.length - 1 );
				
			}
			else
			{
				
				TextCarrotState = true;
				
				InputField.text += "|";
				
			}
			
		}
		
	};
	
	private function OnKeyUp ( E:KeyboardEvent ) : Void
	{
		
		if ( ( CaptureInputCalback != null ) && ( InterfaceMode == TextInterfaceMode.CAPTURE_INPUT ) )
					CaptureInputCalback ( E, false );
		
	};
	
	public function GetDisplayObject () : DisplayObject
	{
		
		return GraphicsRoot;
		
	};
	
	public function GetOutput () : String
	{
		
		return OutputField.text;
		
	};
	
	public function SetOutput ( Output:String ) : Void
	{
		
		OutputField.text = Output;
		OutputField.scrollV = OutputField.bottomScrollV;
		
	};
	
	public function AddOutput ( Output:String ) : Void
	{
		
		OutputField.appendText ( Output );
		OutputField.scrollV = OutputField.bottomScrollV;
		
	};
	
	public function SetMode ( Mode:UInt ) : Void
	{
		
		var OldMode:UInt = InterfaceMode;
		InterfaceMode = Mode;
		
		if ( OldMode == Mode )
			return;
		
		switch ( InterfaceMode )
		{
		
			case TextInterfaceMode.ALLOW_INPUT:
			{
				
				if ( OldMode != TextInterfaceMode.HOLD_INPUT )
				{
					
					InputField.text = InterfaceFormat.Prompt;
					TextCarrotState = false;
					
				}
				else
					InputField.text = InterfaceFormat.Prompt + InputField.text.substr ( InterfaceFormat.HeldPrompt.length );
				
			}
			
			case TextInterfaceMode.CAPTURE_INPUT:
			{
				
				InputField.text = InterfaceFormat.DisabledPrompt;
				TextCarrotState = false;
				
			}
				
			case TextInterfaceMode.HOLD_INPUT:
			{
				
				if ( OldMode != TextInterfaceMode.ALLOW_INPUT )
				{
					
					InputField.text = InterfaceFormat.HeldPrompt;
					TextCarrotState = false;
					
				}
				else
					InputField.text = InterfaceFormat.HeldPrompt + InputField.text.substr ( InterfaceFormat.Prompt.length );
				
			}
			
			case TextInterfaceMode.BLOCK_INPUT:
			{
				
				InputField.text = InterfaceFormat.DisabledPrompt;
				TextCarrotState = false;
				
			}
			
			default:
			{
				
				
				
			}
			
		}
		
	};
	
	public function SetInputCallback ( OnInput:String -> Void ) : Void
	{
		
		InputCallback = OnInput;
		
	};
	
	public function SetCapturedInputCallback ( OnCapturedInput:KeyboardEvent -> Bool -> Void ) : Void
	{
		
		CaptureInputCalback = OnCapturedInput;
		
	};
	
	public function ClearInput () : Void
	{
		
		if ( TextCarrotState )
			InputField.text = InterfaceFormat.Prompt + "|";
		else
			InputField.text = InterfaceFormat.Prompt;
			
	};
	
}
