package com.sampleboardonline.model.vo {
import flash.display.Bitmap;

[Bindable]
	public class CanvasItemVO extends BaseIdVO {

		public var type:int = 0;
		public var canvasGeometry:GeometryVO;
		public var imageGeometry:GeometryVO;
		public var imagePath:String;
		public var source:Bitmap;
		public var sourceOriginal:Bitmap;

		public function CanvasItemVO(id:String = "", type:int = 0) {
			super(id);
			this.type = type;
			canvasGeometry = new GeometryVO();
			imageGeometry = new GeometryVO();
		}
	}
}
