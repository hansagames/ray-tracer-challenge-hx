package types;

class Intersection {
	public var t(default, null):Float;
	public var object(default, null):Sphere;

	public function new(t:Float, object:Sphere) {
		this.t = t;
		this.object = object;
	}
}
