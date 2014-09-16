package 
{
	import Cain.As3;
	import com.freshplanet.ane.AirFacebook.Facebook;
	import flash.desktop.NativeApplication;
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	/**
	 * ...
	 * @author cainmaila@gmail.com
	 */
	public class Main extends Sprite 
	{
		[Embed(source = "fb.png")]
		static private const FB:Class;
		private var fb:Sprite= new Sprite();
		public function Main():void 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(Event.DEACTIVATE, deactivate);
			
			// touch or gesture?
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			// entry point
			
			// init the ANE
			Facebook.getInstance().init( FacebookConfig.appID );
			Facebook.getInstance().logEnabled = true;
			
		    fb.addChild(new FB() as Bitmap);
			fb.width = stage.fullScreenWidth * 0.8;
			fb.scaleY = fb.scaleX;
			fb.x = (stage.fullScreenWidth >> 1) - (fb.width >> 1);
			fb.y = (stage.fullScreenHeight >> 1) - (fb.height >> 1);
			addChild(fb);
			//fb.visible = false;
			As3.clickFun(fb,function ():void 
			{
				if(Facebook.getInstance().canPresentShareDialog())
					Facebook.getInstance().shareLinkDialog( "http://www.funyunnan.com/event/2player/", "雲南快達", "標題A", "內容明細", "https://dl.dropboxusercontent.com/u/19304009/1.jpg", errorHandler );
					//Facebook.getInstance().shareLinkDialog( "http://www.funyunnan.com/event/2player/" , null, null, null, null, errorHandler );
				else
					Facebook.getInstance().webDialog( "feed", { 'link':"http://www.funyunnan.com/event/2player/" }, errorHandler );
			})
			// new to AIR? please read *carefully* the readme.txt files!
			if(Facebook.getInstance().isSessionOpen)
				onSessionOpened(true,null,null);
		}
		
		private function onSessionOpened(success:Boolean, userCancelled:Boolean, error:String):void
		{
			if (!success && error)
			{
				return;
			}
			if(success)
			{
				fb.visible = true;
			}
		}
		
		private function errorHandler(data:Object):void{
			
			trace(JSON.stringify(data));
		}
		private function deactivate(e:Event):void 
		{
			// make sure the app behaves well (or exits) when in background
			//NativeApplication.nativeApplication.exit();
		}
		
	}
	
}