package com.flaxash.bouygues.socialminute.view 
{
	import com.flaxash.bouygues.socialminute.model.VO.TrackingCP;
	import com.greensock.TweenLite;
	import com.greensock.easing.Quad;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.SWFLoader;
	import com.greensock.loading.XMLLoader;
	
	import flash.display.*;
	import flash.events.*;
	import flash.geom.Matrix3D;
	import flash.geom.PerspectiveProjection;
	import flash.geom.Point;
	import flash.geom.Utils3D;
	import flash.net.*;
	import flash.system.LoaderContext;
	import flash.system.SecurityDomain;
	import flash.text.*;
	import flash.utils.*;
	
	import org.osflash.signals.Signal;
	
	public class VideoAssetsComposer extends Sprite
	{
		// const
		private static const SEQUENCE_PATH:String = "assets/";
		private static const XML_PATH:String = "assets/";
		private static const VIDEO_SIZE:Object = {width:512,height:288};
		//private var trackingSize:Object = {width:449,height:251.5};
		private var trackingSize:Object = {width:359,height:201};
		
		// loading assets
		private var videoName:String;
		private var loader:SWFLoader;
		
		private var frontVideo:MovieClip;
		public var backVideo:MovieClip;
		private var maskVideo:MovieClip;
		
		// loading tracking data
		private var trackinDataloader:URLLoader;
		private var _trackingData:Object;
		
		// init compositing
		private var bitmapData:BitmapData;
		private var bitmap:Bitmap;
		private var asset:Sprite;
		private var assets:Object;
		private var maskBitmapData:BitmapData;
		private var shapeBitmapData:BitmapData;
		private var assetsContainer:Sprite;
		
		
		// draw video
		private var frameIndex:uint;
		
		//multi sequence
		
		private var assetsToTrack:Dictionary;
		//
		private var isTracking:Boolean = false;
		private var cx:Number;
		private var cy:Number;
		private var cz:Number;
		private var topLeft:Point;
		private var bottomLeft:Point;
		private var topRight:Point;
		private var bottomRight:Point;
		private var m:Matrix3D;
		private var lastPointData:Object;
		private var queueXML:LoaderMax;
		private var dataLoader:XMLLoader;
		public var signalFinVideo:Signal;
		public var signalChargementVideo:Signal;
		public var signalVideoReady:Signal;

		private var test:MovieClip;
		
		public function VideoAssetsComposer()
		{
			super();
			signalFinVideo = new Signal();
			signalChargementVideo = new Signal(uint);
			signalVideoReady = new Signal();
		}
		
		
		public function loadVideo(vName:String):void
		{
			videoName = vName;
			var context:LoaderContext = new LoaderContext();
			context.securityDomain = SecurityDomain.currentDomain;//just in case  assets are somewhere else
			
			
			loader    = new SWFLoader(SEQUENCE_PATH+videoName+".swf",{name:"backVideoLoader",onProgress:onProgress,onComplete:initAssets});
			//loader.load(new URLRequest(SEQUENCE_PATH+videoName+".swf"),context);
			loader.load();
			
			
		}
		
		private function onProgress(le:LoaderEvent):void {
			//signalChargementVideo.dispatch(Math.floor(100*pe.bytesLoaded/pe.bytesTotal));
			trace(Math.floor(100*le.target.progress));
			
		}
		public function initAssets(le:LoaderEvent = null):void
		{
			
			// capitalize first letter of video name to have a proper asset class name
			var sequenceClassName:String = videoName.substring(0,1).toLocaleUpperCase() + videoName.substring(1);
			
			// get the class from loader context
			var backVideoAsset      :Class  = loader.getClass("sequences.BackVideo");
			//var frontVideoAsset     :Class  = loader.contentLoaderInfo.applicationDomain.getDefinition("sequences."+ sequenceClassName +"FrontVideo") as Class;
			//var maskVideoAsset      :Class  = loader.contentLoaderInfo.applicationDomain.getDefinition("sequences."+ sequenceClassName +"MaskVideo") as Class;
			
			// get instance of each assets
			
			// frontVideo = new frontVideoAsset() as MovieClip;
			backVideo  = new backVideoAsset()  as MovieClip;
			//maskVideo  = new maskVideoAsset()  as MovieClip;
			
			// stop each video
			// frontVideo.stop();
			backVideo.stop();
			//maskVideo.stop();
			
			// function called from the timeline
			backVideo.cuePointEntered = cuePointHandler;
			backVideo.videoComplete = videoCompleteHandler;
			backVideo.trackingComplete = trackingCompleteHandler;
			//loadTrackingData();// function explained later on
			//
			signalVideoReady.dispatch();
		}
		
		
		public function initCompositing(_assets:Object):void
		{
			assets = _assets;
			bitmapData = new BitmapData(VIDEO_SIZE.width,VIDEO_SIZE.height,true);
			// maskBitmapData     = new BitmapData (VIDEO_SIZE.width,VIDEO_SIZE.height,true);
			shapeBitmapData = new BitmapData(VIDEO_SIZE.width,VIDEO_SIZE.height,true);
			
			bitmap = new Bitmap(bitmapData);
			bitmap.smoothing = true;
			addChild(bitmap);
			
			// ..
			assetsToTrack = new Dictionary();
			// ..
			assetsContainer    = new Sprite();
			//addChild(assetsContainer);
			
			trace("ok");
			//addReperes();
			
			this.addEventListener(Event.ENTER_FRAME,refresh);
			
			
			//frontVideo.play();
			backVideo.play();
			//maskVideo.play();
		}
		
		private function drawVideo():void
		{
			//trace(this+' -> drawVideo');
			frameIndex = backVideo.currentFrame - 1;// get frame index to know what point to do.
			bitmapData.lock();
			shapeBitmapData.fillRect(shapeBitmapData.rect,0x00FFFFFF);
			
			bitmapData.draw(backVideo);
			
			if (assetsToTrack) {
				var sequenceData:TrackingCP;
				
				for( var sequenceName:String in assetsToTrack){
					sequenceData = assetsToTrack[sequenceName];
					// we have to remove asset to the assetsToTrack when we reach the end of points list
					if (frameIndex - sequenceData.frameOffset >= sequenceData.asset.totalFrames)
					{
						removeCuePoint(sequenceName);
					}
				}
				
				// ..
				
				shapeBitmapData.draw(assetsContainer);
				
				// shapeBitmapData.copyChannel(maskBitmapData,maskBitmapData.rect,new Point(0,0),BitmapDataChannel.BLUE, BitmapDataChannel.ALPHA);
				
				bitmapData.draw(shapeBitmapData);
				bitmapData.unlock();
				//bitmapData.draw(frontVideo,null,null,BlendMode.SCREEN);
			}
			
		}
		public function cuePointHandler(cpName:String):void
		{
			trace(this+' -> cuePointHandler:' + cpName);
			var asset:MovieClip = assets[cpName].asset;// asset you want to draw inside the shape 
			assetsContainer.addChild(asset);
			trace(cpName + " : height = "+ asset.getRect(this).height);
			asset.gotoAndPlay(2);
			asset.joue();
			//var assetBmpData:BitmapData = new BitmapData(asset.trackingWidth,asset.trackingHeight,true,0x000000);
			//assetBmpData.draw(asset);
			//trace(asset.trackingWidth);
			var trackingCP:TrackingCP = new TrackingCP();
			//trackingCP.points = _trackingData[cpName];
			trackingCP.frameOffset = backVideo.currentFrame - 1;
			trackingCP.asset = asset;
			//trackingCP.assetBD = assetBmpData;
			trackingCP.name = cpName;
			//trackingCP.matrice = assets[cpName].matrice;
			//asset.transform.matrix3D = trackingCP.matrice;
			assetsToTrack[cpName] = trackingCP;
			/*assetsToTrack[cpName]    = {
			points      : _trackingData[cpName],
			frameOffset : backVideo.currentFrame - 1,
			asset       : asset,
			name        : cpName
			};*/
			//m = assets[cpName].matrice;
			trace(asset);
			isTracking = true;
			
		}
		
		public function removeCuePoint(cpName:String):void
		{
			trace(assetsToTrack[cpName]);
			if (assetsToTrack[cpName])
			{
				//var asset:MovieClip = assetsToTrack[cpName].asset;
				assetsContainer.removeChild(assetsToTrack[cpName].asset);
				delete assetsToTrack[cpName];
				
			}
			for( var sequenceName:String in assetsToTrack){
				trace(sequenceName);
			}
			/*
			//pour test sur séquence1&2
			if (cpName=="amiActif") {
				this.removeEventListener(Event.ENTER_FRAME,refresh);
				backVideo.stop();
			}
			*/
		}
		
		private function videoCompleteHandler():void
		{
			//frontVideo.stop();
			backVideo.stop();
			//maskVideo.stop();
			refresh();
			this.removeEventListener(Event.ENTER_FRAME,refresh);
			signalFinVideo.dispatch();
			
		}
		private function trackingCompleteHandler(cpName:String=null):void
		{
			//isTracking = false;
			trace (cpName + " cuepoint fini");
			removeCuePoint(cpName);
		}
		private function refresh(e:Event = null):void
		{
			drawVideo();
		}
		public function replayVideo():void {
			backVideo.gotoAndStop(1);
			this.addEventListener(Event.ENTER_FRAME,refresh);
			backVideo.play();
		}
		public function set trackingData(value:Object):void
		{
			_trackingData = value;
		}
		
		
	}
}