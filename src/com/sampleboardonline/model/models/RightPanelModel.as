package com.sampleboardonline.model.models {

[Bindable]
public class RightPanelModel {

	public var isPanelVisible:Boolean = true;

	private static var _instance:RightPanelModel;
	public static function get instance():RightPanelModel {
		if (!_instance) {
			_instance = new RightPanelModel(new Blocker());
		}
		return _instance;
	}

	public function RightPanelModel(blocker:Blocker) {
		if (!blocker) {
			throw new Error("RightPanelModel is singleton use RightPanelModel.instance");
		}
	}
}
}
internal class Blocker {
}
;