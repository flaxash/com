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
	
	public class VideoTracking extends Sprite
	{
		// const
		private static const SEQUENCE_PATH:String = "assets/";
		private static const XML_PATH:String = "assets/";
		private static const VIDEO_SIZE:Object = {width:640,height:360};
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
		private var m:Matrix3D;
		private var lastPointData:Object;
		private var queueXML:LoaderMax;
		private var dataLoader:XMLLoader;
		public var signalFinVideo:Signal;
		public var signalChargementVideo:Signal;
		public var signalVideoReady:Signal;
		
		public function VideoTracking()
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
		
		
		public function initCompositing():void
		{
			
			bitmapData = new BitmapData(VIDEO_SIZE.width,VIDEO_SIZE.height,true);
			// maskBitmapData     = new BitmapData (VIDEO_SIZE.width,VIDEO_SIZE.height,true);
			shapeBitmapData = new BitmapData(VIDEO_SIZE.width,VIDEO_SIZE.height,true);
			
			bitmap = new Bitmap(bitmapData);
			bitmap.smoothing = true;
			addChild(bitmap);
			assets = new Object();
			assets["statut1"] = { 	asset:new Statut1(),
				matrice:new Matrix3D()
			};
			assets["statut2"] = {	asset:new Statut2(),
				matrice:new Matrix3D()
			};
			assets["statut3"] = {	asset:new Statut3(),
				matrice:new Matrix3D()
			};
			assets["lien1"] = {	asset:new Lien1(),
				matrice:new Matrix3D()
			};
			assets["lien2"] = {	asset:new Lien2(),
				matrice:new Matrix3D()
			};
			assets["annivPrenom"] = {	asset:new AnnivPrenom(),
				matrice:new Matrix3D()
			};
			assets["annivDate"] = {	asset:new AnnivDate(),
				matrice:new Matrix3D()
			};
			assets["photos"] = {	asset:new Photos(),
				matrice:new Matrix3D()
			};
			assets["amiActif"] = {	asset:new AmiActif(),
				matrice:new Matrix3D()
			};

			// ..
			assetsToTrack = new Dictionary();
			// ..
			assetsContainer    = new Sprite();
			trace("ok");
			//addReperes();
			cx = root.transform.perspectiveProjection.projectionCenter.x;
			cy = root.transform.perspectiveProjection.projectionCenter.y;
			cz = root.transform.perspectiveProjection.focalLength;
			
			this.addEventListener(Event.ENTER_FRAME,refresh);
			
			
			//frontVideo.play();
			backVideo.play();
			//maskVideo.play();
		}
		
		private function drawVideo():void
		{
			//trace(this+' -> drawVideo');
			frameIndex = backVideo.currentFrame - 1;// get frame index to know what point to do.
			
			shapeBitmapData.fillRect(shapeBitmapData.rect,0x00FFFFFF);
			
			bitmapData.draw(backVideo);
			
			if (assetsToTrack) {
				var sequenceData:TrackingCP;
				
				for( var sequenceName:String in assetsToTrack){
					//trace(sequenceName + " traité dans drawVideo");
					//trace(assetsToTrack[sequenceName]);
					sequenceData = assetsToTrack[sequenceName];
					//trace(sequenceData.frameOffset);
					// we have to remove asset to the assetsToTrack when we reach the end of points list
					if (frameIndex - sequenceData.frameOffset >= sequenceData.points.length)
					{
						removeCuePoint(sequenceName);
					}
					else
					{
						
						majMatrice3D(sequenceData);
						//drawReperes(sequenceData);
					}
				}
				
				// ..
				shapeBitmapData.draw(assetsContainer);
				
				// shapeBitmapData.copyChannel(maskBitmapData,maskBitmapData.rect,new Point(0,0),BitmapDataChannel.BLUE, BitmapDataChannel.ALPHA);
				
				bitmapData.draw(shapeBitmapData);
				
				//bitmapData.draw(frontVideo,null,null,BlendMode.SCREEN);
			}
			
		}
		private function majMatrice3D(sequenceData:TrackingCP):void
		{
			
			var pointData:Array = sequenceData.points[frameIndex - sequenceData.frameOffset];
			if (sequenceData.name=="lien1") {
				trace(pointData);
			}
			//trace(sequenceData.asset.width);
			solve(pointData[0][0],pointData[1][0],pointData[2][0],pointData[3][0],
				pointData[0][1],pointData[1][1],pointData[2][1],pointData[3][1],
				sequenceData.asset.trackingWidth,sequenceData.asset.trackingHeight,sequenceData.matrice);
			
		}
		private function solve(x0:Number, x1:Number, x2:Number, x3:Number, 
							   y0:Number, y1:Number, y2:Number, y3:Number, 
							   w:Number, h:Number,mat:Matrix3D):void 
		{
			// I got these equations from matlab ):
			var v:Vector.<Number> = mat.rawData;
			v[12] = x0;
			v[13] = y0;
			v[0] = -(cx*x0*y2-cx*x2*y0-cx*x0*y3-cx*x1*y2+cx*x2*y1+cx*x3*y0+cx*x1*y3-cx*x3*y1-x0*x2*y1+x1*x2*y0+x0*x3*y1-x1*x3*y0+x0*x2*y3-x0*x3*y2-x1*x2*y3+x1*x3*y2)/(x1*y2-x2*y1-x1*y3+x3*y1+x2*y3-x3*y2) / w;
			v[1] = -(cy*x0*y2-cy*x2*y0-cy*x0*y3-cy*x1*y2+cy*x2*y1+cy*x3*y0+cy*x1*y3-cy*x3*y1-x0*y1*y2+x1*y0*y2+x0*y1*y3-x1*y0*y3+x2*y0*y3-x3*y0*y2-x2*y1*y3+x3*y1*y2)/(x1*y2-x2*y1-x1*y3+x3*y1+x2*y3-x3*y2) / w;
			v[2] = (cz*x0*y2-cz*x2*y0-cz*x0*y3-cz*x1*y2+cz*x2*y1+cz*x3*y0+cz*x1*y3-cz*x3*y1)/(x1*y2-x2*y1-x1*y3+x3*y1+x2*y3-x3*y2) / w;
			v[4] = (cx*x0*y1-cx*x1*y0-cx*x0*y3+cx*x1*y2-cx*x2*y1+cx*x3*y0+cx*x2*y3-cx*x3*y2-x0*x1*y2+x1*x2*y0+x0*x1*y3-x0*x3*y1+x0*x3*y2-x2*x3*y0-x1*x2*y3+x2*x3*y1)/(x1*y2-x2*y1-x1*y3+x3*y1+x2*y3-x3*y2) / h;
			v[5] = (cy*x0*y1-cy*x1*y0-cy*x0*y3+cy*x1*y2-cy*x2*y1+cy*x3*y0+cy*x2*y3-cy*x3*y2-x0*y1*y2+x2*y0*y1+x1*y0*y3-x3*y0*y1+x0*y2*y3-x2*y0*y3-x1*y2*y3+x3*y1*y2)/(x1*y2-x2*y1-x1*y3+x3*y1+x2*y3-x3*y2) / h;
			v[6] = -(cz*x0*y1-cz*x1*y0-cz*x0*y3+cz*x1*y2-cz*x2*y1+cz*x3*y0+cz*x2*y3-cz*x3*y2)/(x1*y2-x2*y1-x1*y3+x3*y1+x2*y3-x3*y2) / h;
			
			mat.rawData = v;
		}
		
		public function cuePointHandler(cpName:String):void
		{
			trace(this+' -> cuePointHandler:' + cpName);
			var asset:MovieClip = assets[cpName].asset;// asset you want to draw inside the shape 
			assetsContainer.addChild(asset);
			trace(asset.trackingWidth);
			var trackingCP:TrackingCP = new TrackingCP();
			trackingCP.points = _trackingData[cpName];
			trackingCP.frameOffset = backVideo.currentFrame - 1;
			trackingCP.asset = asset;
			trackingCP.name = cpName;
			trackingCP.matrice = assets[cpName].matrice;
			asset.transform.matrix3D = trackingCP.matrice;
			assetsToTrack[cpName] = trackingCP;
			/*assetsToTrack[cpName]    = {
				points      : _trackingData[cpName],
				frameOffset : backVideo.currentFrame - 1,
					asset       : asset,
					name        : cpName
			};*/
			//m = assets[cpName].matrice;
			
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
		
		public function set trackingData(value:Object):void
		{
			_trackingData = value;
		}
		
		
	}
}