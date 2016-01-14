package example;

import openfl.display.Sprite;

import tal.dynamics.World;

import tal.graphics.BasicTextInterfaceFormat;
import tal.graphics.BasicTextInterface;

import tal.dynamics.rooms.BasicRoom;

import tal.dynamics.commands.ICommand;
import tal.dynamics.commands.BasicMoveCommand;
import tal.dynamics.commands.BasicResponseCommand;
import tal.dynamics.commands.ActionTemplateCommand;

import tal.dynamics.methods.IMethod;
import tal.dynamics.methods.ScriptedMethod;

class ExampleGame extends Sprite
{
	
	private var GameWorld:World;
	private var GameInterface:BasicTextInterface;
	
	public function new ( Width:UInt, Height:UInt )
	{
		
		super ();
		
		InitInterface ( Width, Height );
		InitWorld ();
		InitRooms ();
		Link ();
		
		GameWorld.SetRoom ( "red_room" );
		
	};
	
	private function InitInterface ( Width:UInt, Height:UInt ) : Void
	{
		
		var InterfaceFormat:BasicTextInterfaceFormat = new BasicTextInterfaceFormat ();
		
		InterfaceFormat.Font = "Courier"; // Usually safe. The system will choose a default font if not.
		
		GameInterface = new BasicTextInterface ( Width, Height, InterfaceFormat );
		
	};
	
	private function InitWorld () : Void
	{
		
		GameWorld = new World ();
		
		GameWorld.SetInterface ( GameInterface );
		
		addChild ( GameWorld.GetGraphicsRoot () );
		
	};
	
	private function InitRooms () : Void
	{
		
		InitRedRoom ();
		InitBlueRoom ();
		InitGreenRoom ();
		InitWhiteRoom ();
		
	};
	
	private function Link () : Void
	{
		
		GameWorld.Link ();
		
	};
	
	private function InitRedRoom () : Void
	{
		
		var CommandSet:Array <ICommand> = new Array <ICommand> ();
		
		CommandSet.push ( new BasicResponseCommand ( "You stand in a red room.\n\n", [ "__enter" ] ) );
		CommandSet.push ( new BasicMoveCommand ( [ "left" ], BasicMoveCommand.MOVE_MATCHES, "blue_room", "==> Go Left\n\nYou go left.\n\n" ) );
		
		GameWorld.AddRoom ( new BasicRoom ( "red_room", "A red room.", CommandSet, "__enter", null ) );
		
	};
	
	private function InitBlueRoom () : Void
	{
		
		var CommandSet:Array <ICommand> = new Array <ICommand> ();
		
		CommandSet.push ( new BasicResponseCommand ( "You stand in a blue room.\n\n", [ "__enter" ] ) );
		
		GameWorld.AddRoom ( new BasicRoom ( "blue_room", "A blue room.", CommandSet, "__enter", null ) );
		
	};
	
	private function InitGreenRoom () : Void
	{
		
		var CommandSet:Array <ICommand> = new Array <ICommand> ();
		
		CommandSet.push ( new BasicResponseCommand ( "You stand in a green room.\n\n", [ "__enter" ] ) );
		
		GameWorld.AddRoom ( new BasicRoom ( "green_room", "A red room.", CommandSet, "__enter", null ) );
		
	};
	
	private function InitWhiteRoom () : Void
	{
		
		var CommandSet:Array <ICommand> = new Array <ICommand> ();
		
		CommandSet.push ( new BasicResponseCommand ( "You stand in a white room.\n\n", [ "__enter" ] ) );
		
		GameWorld.AddRoom ( new BasicRoom ( "white_room", "A red room.", CommandSet, "__enter", "" ) );
		
	};
	
}