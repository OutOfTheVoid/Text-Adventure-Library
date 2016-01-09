package example;

import openfl.display.Sprite;

import tal.dynamics.World;

import tal.graphics.BasicTextInterfaceFormat;
import tal.graphics.BasicTextInterface;

import tal.dynamics.rooms.BasicRoom;

class ExampleGame extends Sprite
{
	
	private var GameWorld:World;
	private var GameInterface:BasicTextInterface;
	
	public function new ( Width:UInt, Height:UInt )
	{
		
		super ();
		
		InitInterface ( Width, Height );
		InitRooms ();
		InitWorld ();
		Link ();
		
	};
	
	private function InitInterface ( Width:UInt, Height:UInt ) : Void
	{
		
		var InterfaceFormat:BasicTextInterfaceFormat = new BasicTextInterfaceFormat ();
		
		InterfaceFormat.Font = "Courier New"; // Usually safe.
		
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
		
		
		
	};
	
	private function Link () : Void
	{
		
		GameWorld.Link ();
		
	};
	
	private function InitRedRoom () : Void
	{
		
		
		
	};
	
	private function InitBlueRoom () : Void
	{
		
		
		
	};
	
	private function InitGreenRoom () : Void
	{
		
		
		
	};
	
	private function InitWhiteRoom () : Void
	{
		
		
		
	};
	
}