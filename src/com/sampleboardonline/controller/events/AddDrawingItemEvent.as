package com.sampleboardonline.controller.events {
import com.sampleboardonline.ui.renderer.canvasRenderer.BaseCanvasRenderer;

public class AddDrawingItemEvent extends BaseEvent {

		public static const ITEM_INITIALIZATION_FINISHED:String = "itemInitializationFinished";

		public var instance:BaseCanvasRenderer;

		public function AddDrawingItemEvent(type:String, data:Object = null, bubbles:Boolean = false) {
			super(type, data, bubbles);
		}
	}
}
