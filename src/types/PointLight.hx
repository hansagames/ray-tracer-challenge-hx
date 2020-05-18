package types;

class PointLight {
	public var position(default, null):Tuple;
	public var intensity(default, null):Tuple;

	public function new(position:Tuple, intensity:Tuple) {
		this.intensity = intensity;
		this.position = position;
	}
}
