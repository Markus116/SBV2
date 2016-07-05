package assets.header {
	public class HeaderAssets {

		[Embed(source="imgLogo.png")]
		public static const IMG_LOGO:Class;

		[Embed(source="imgBG.png")]
		public static const IMG_BG:Class;

		public function HeaderAssets() {
			throw new Error("AAA");
		}
	}
}
