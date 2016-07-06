package com.sampleboardonline.controller.helpers.addItemHelper {
import com.sampleboardonline.model.vo.CanvasItemVO;
import com.sampleboardonline.ui.renderer.canvasRenderer.BaseCanvasRenderer;
import com.sampleboardonline.ui.renderer.canvasRenderer.ImageItemRenderer;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Loader;
import flash.events.Event;
import flash.events.HTTPStatusEvent;
import flash.events.IOErrorEvent;
import flash.events.SecurityErrorEvent;
import flash.net.URLRequest;

import mx.core.ClassFactory;
import mx.core.IDataRenderer;

public class AddImageHelper extends BaseAddItemHelper {

		private var loader:Loader;

		override public function add(item:CanvasItemVO):void {
			super.add(item);
		}

		override public function startInitializing():void{
			super.startInitializing();
			if(imageCacheDictionary[itemVO.imagePath]){
				var bd:BitmapData = BitmapData(imageCacheDictionary[itemVO.imagePath]).clone();
				complete(bd.clone(),bd.width,bd.height);
			} else {
				initLoader();
				loader.load(new URLRequest(itemVO.imagePath));
			}
		}

		private function initLoader():void{
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onLoadingComplete);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,onIOError);
			loader.contentLoaderInfo.addEventListener(HTTPStatusEvent.HTTP_STATUS,onHTTPStatus);
			loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR,onSecurityError);
		}

		private function disposeLoader():void{
			if(loader){
				loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,onLoadingComplete);
				loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,onIOError);
				loader.contentLoaderInfo.removeEventListener(HTTPStatusEvent.HTTP_STATUS,onHTTPStatus);
				loader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,onSecurityError);
				loader = null;
			}
		}

		private function onIOError(event:IOErrorEvent):void{
			trace("IO_ERROR, ", event);
			disposeLoader();
			sendCompleteEvent();
		}

		private function onHTTPStatus(event:HTTPStatusEvent):void{
			//trace("HTTP_STATUS", event);
		}

		private function onSecurityError(event:SecurityErrorEvent):void{
			trace("SECURITY_ERROR", event);
			disposeLoader();
			sendCompleteEvent();
		}

		private function onLoadingComplete(event:Event):void{
			trace(">>>>>>>>>> image loading complete");
			var bitmapDataFromEvent:BitmapData = Bitmap(event.currentTarget.content).bitmapData.clone();
			if(imageCacheDictionary[itemVO.imagePath]==null){
				imageCacheDictionary[itemVO.imagePath] = bitmapDataFromEvent.clone();
			}
			complete(bitmapDataFromEvent,event.target.width,event.target.height);
		}

		public function complete(bitmapData:BitmapData, _width:Number, _height:Number):void{
			if(bitmapData){
				var bitmapDataFromEvent:BitmapData = bitmapData;

				itemVO.source =itemVO.sourceOriginal = new Bitmap(bitmapDataFromEvent);
				var scale:Number = Math.min(300/itemVO.source.width, 300/itemVO.source.height);

				itemVO.canvasGeometry.width = itemVO.imageGeometry.width = itemVO.source.width*scale;
				itemVO.canvasGeometry.height = itemVO.imageGeometry.height = itemVO.source.height*scale;

				createNewInstance();
				updateContainerEffects(BaseCanvasRenderer(instance));

				disposeLoader();
			}
			sendCompleteEvent();
		}

		public function createNewInstance():void{
			var factory:ClassFactory = new ClassFactory(ImageItemRenderer);
			instance = factory.newInstance();
			IDataRenderer(instance).data = itemVO;
		}

		protected function updateContainerEffects(drawingContainer:BaseCanvasRenderer):void {
		}
	}
}
