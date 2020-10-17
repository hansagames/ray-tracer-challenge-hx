package types;

class Intersection {
	public var t(default, null):Float;
	public var object(default, null):Shape;
	public var u(default, null):Null<Float>;
	public var v(default, null):Null<Float>;

	public function new(t:Float, object:Shape, u = null, v = null) {
		this.t = t;
		this.object = object;
		this.u = u;
		this.v = v;
	}
}
