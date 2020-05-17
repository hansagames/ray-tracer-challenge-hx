package types;

class Ray {
	public var origin(default, null):Tuple;
	public var direction(default, null):Tuple;

	public function new(origin:Tuple, direction:Tuple) {
		this.origin = origin;
		this.direction = direction;
	}
}
