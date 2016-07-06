package com.sampleboardonline.controller.helpers.addItemHelper {
import com.sampleboardonline.model.vo.CanvasItemVO;
import com.sampleboardonline.ui.renderer.canvasRenderer.BaseCanvasRenderer;
import com.sampleboardonline.ui.renderer.canvasRenderer.TextItemRenderer;

import mx.core.ClassFactory;

public class AddTextHelper extends BaseAddItemHelper {

		override public function add(item:CanvasItemVO):void {
			super.add(item);
		}

		override public function startInitializing():void{
			createNewInstance();
			updateContainerEffects(instance);
			sendCompleteEvent();
		}

		public function createNewInstance():void{
			var factory:ClassFactory = new ClassFactory(TextItemRenderer);
			instance = factory.newInstance();
			instance.data = itemVO;
		}

		protected function updateContainerEffects(drawingContainer:BaseCanvasRenderer):void {
			/*if(drawingContainer){
				CanvasFilterUtils.applyFilters(drawingContainer, false, false);
			}*/
		}
	}
}
