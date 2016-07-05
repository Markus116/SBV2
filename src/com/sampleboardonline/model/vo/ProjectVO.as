package com.sampleboardonline.model.vo {
import mx.collections.ArrayCollection;

public class ProjectVO extends BaseIdVO {

	public var page:PageVO;
	public var items:ArrayCollection = new ArrayCollection();

	public function ProjectVO(id:String = "") {
		super(id);
		this.page = new PageVO("A",800,600);
	}
}
}
