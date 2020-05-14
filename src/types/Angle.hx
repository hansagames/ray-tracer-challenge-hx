package types;

abstract Degree(Float) from Float to Float {
	inline public function new(degree:Float) {
		this = degree;
	}
}

abstract Radians(Float) from Float to Float {
	inline public function new(radians:Float) {
		this = radians;
	}
}
