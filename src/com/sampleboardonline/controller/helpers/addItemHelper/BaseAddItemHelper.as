package com.sampleboardonline.controller.helpers.addItemHelper {
import com.sampleboardonline.controller.events.AddDrawingItemEvent;
import com.sampleboardonline.model.vo.CanvasItemVO;
import com.sampleboardonline.ui.renderer.canvasRenderer.BaseCanvasRenderer;

import flash.events.EventDispatcher;
import flash.utils.Dictionary;
import flash.utils.setTimeout;

public class BaseAddItemHelper extends EventDispatcher{

		public static const imageCacheDictionary:Dictionary = new Dictionary();

		protected var itemVO:CanvasItemVO;

		public var instance:BaseCanvasRenderer;

		protected function sendCompleteEvent():void{
			var event:AddDrawingItemEvent = new AddDrawingItemEvent(AddDrawingItemEvent.ITEM_INITIALIZATION_FINISHED);
			event.instance = instance;
			setTimeout(dispatchEvent,15,event);
		}

		public function startInitializing():void{
		}

		public function add(item:CanvasItemVO):void{
			itemVO = item;
		}
	}
}
