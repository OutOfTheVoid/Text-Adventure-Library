package tal.graphics;

import openfl.events.KeyboardEvent;

import openfl.display.DisplayObject;

interface ITextInterface
{
	
	public function GetGraphicsRoot () : DisplayObject;
	
	public function AddOutput ( Output:String ) : Void;
	public function SetOutput ( Output:String ) : Void;
	public function GetOutput () : String;
	
	public function GetSettingNameList () : Array <String>;
	public function GetSettingDescription ( SettingName:String ) : String;
	public function SetSetting ( SettingName:String, Value:String ) : Void;
	
	public function SetMode ( Mode:UInt ) : Void;
	public function GetMode () : UInt;
	
	public function SetInputCallback ( OnInput:String -> Void ) : Void;
	public function SetCapturedInputCallback ( OnCapturedInput:KeyboardEvent -> Bool -> Void ) : Void;
	
	public function ClearInput () : Void;
	
	public function GetPrompt () : String;
		
}
