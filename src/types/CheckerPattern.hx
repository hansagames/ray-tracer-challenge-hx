package types;

class CheckerPattern extends Pattern {
	public var a(default, null):Tuple;
	public var b(default, null):Tuple;

	public function new(leftColor:Tuple, rightColor:Tuple) {
		super();
		a = leftColor;
		b = rightColor;
	}

	override function patternAt(point:Tuple):Tuple {
		if ((Math.floor(point.x) + Math.floor(point.y) + Math.floor(point.z)) % 2 == 0) {
			return a;
		}
		return b;
	}
}
