package com.sampleboardonline.model.vo {

[Bindable]
public class PageVO extends BaseVO {

	public var type:String;
	public var width:Number;
	public var height:Number;

	public function PageVO(type:String = "", width:Number = 0, height:Number = 0) {
		super();
		this.type = type;
		this.width = width;
		this.height = height;
	}
}
}
