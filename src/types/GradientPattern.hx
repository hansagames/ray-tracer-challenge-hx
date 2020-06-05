package types;

class GradientPattern extends Pattern {
	public var a(default, null):Tuple;
	public var b(default, null):Tuple;

	public function new(leftColor:Tuple, rightColor:Tuple) {
		super();
		a = leftColor;
		b = rightColor;
	}

	override function patternAt(point:Tuple):Tuple {
		final distance = b - a;
		final fraction = point.x - Math.floor(point.x);
		return a + distance * fraction;
	}
}
