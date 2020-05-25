package types;

class Intersection {
	public var t(default, null):Float;
	public var object(default, null):Shape;

	public function new(t:Float, object:Shape) {
		this.t = t;
		this.object = object;
	}
}
