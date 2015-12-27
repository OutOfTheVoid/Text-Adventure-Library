package tal.graphics;

class BasicTextInterfaceFormat
{
	
	public var BorderSize:Float;
	public var BorderColor:UInt;
	
	public var BackgroundColor:UInt;
	
	public var ScrollSize:Float;
	public var ScrollBarColor:UInt;
	public var ScrollBackColor:UInt;
	
	public var TextBorderSpacing:Float;
	
	public var TextOffset_X:Float;
	public var TextOffset_Y:Float;
	
	public var Font:String;
	public var FontSize:Int;
	public var FontColor:UInt;
	public var LinePadding:Float;
	public var Bold:Bool;
	public var Italic:Bool;
	
	public var Prompt:String;
	public var DisabledPrompt:String;
	public var HeldPrompt:String;
	
	public var Restrict:String;
	
	public var CarrotTiming:Float;
	
	public function new ()
	{
		
		BorderSize = 10.0;
		BorderColor = 0x000000;	
		
		BackgroundColor = 0xBB9999;
		
		ScrollSize = 10.0;
		ScrollBackColor = 0x9999FF;
		ScrollBarColor = 0xFFFFFF;
		
		TextBorderSpacing = 5.0;
		
		TextOffset_X = 0.0;
		TextOffset_Y = 0.0;
		
		Font = "Arial";
		FontSize = 20;
		FontColor = 0x000000;
		LinePadding = 5;
		Italic = false;
		Bold = false;
		
		Prompt = "==> ";
		DisabledPrompt = "*";
		HeldPrompt = "--> ";
		
		Restrict = " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVQXYZ0123456789_!.[]{}<>,.?/\\|~`\"\'@#$%^&*()_+-=";
		
		CarrotTiming = 0.5;
		
	};
	
}
