package types;

class Environment {
	public var gravity(default, null):Tuple;

	public var wind(default, null):Tuple;

	public function new(gravity:Tuple, wind:Tuple) {
		this.gravity = gravity;
		this.wind = wind;
	}
}
