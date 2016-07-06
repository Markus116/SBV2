package com.sampleboardonline.controller.helpers.addItemHelper {
import com.sampleboardonline.model.vo.CanvasItemVO;
import com.sampleboardonline.ui.renderer.canvasRenderer.BaseCanvasRenderer;
import com.sampleboardonline.ui.renderer.canvasRenderer.ShapeItemRenderer;

import mx.core.ClassFactory;

public class AddShapeHelper extends BaseAddItemHelper {

		override public function add(item:CanvasItemVO):void {
			super.add(item);
		}

		override public function startInitializing():void{
			createNewInstance();
			validateDrawingContainer(instance);
			sendCompleteEvent();
		}

		public function createNewInstance():void{
			var factory:ClassFactory = new ClassFactory(ShapeItemRenderer);
			instance = factory.newInstance();
			instance.data = itemVO;
		}

		protected function updateContainerEffects(drawingContainer:BaseCanvasRenderer):void {
		}

		public function validateDrawingContainer(drawingContainer:BaseCanvasRenderer):void {
			updateContainerEffects(drawingContainer);
		}
	}
}
