package types;

class Projectile {
	public var poisition(default, null):Tuple;
	public var velocity(default, null):Tuple;

	public function new(poisition:Tuple, velocity:Tuple) {
		this.poisition = poisition;
		this.velocity = velocity;
	}
}
