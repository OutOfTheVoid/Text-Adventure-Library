package tal.graphics;

import openfl.events.KeyboardEvent;

interface ITextInterface
{
	
	public function AddOutput ( Output:String ) : Void;
	public function SetOutput ( Output:String ) : Void;
	public function GetOutput () : String;
	
	public function SetMode ( Mode:UInt ) : Void;
	
	public function SetInputCallback ( OnInput:String -> Void ) : Void;
	public function SetCapturedInputCallback ( OnCapturedInput:KeyboardEvent -> Bool -> Void ) : Void;
	
	public function ClearInput () : Void;
		
}