package buddy;

import buddy.Should;
import haxe.PosInfos;
import types.Matrix;

/**
 * Add check for Tuples in Buddy unit tests
 */
class ShouldMatrix extends Should<Matrix> {
	static public function should(t:Matrix) {
		return new ShouldMatrix(t);
	}

	public function new(value:Matrix, inverse = false) {
		super(value, inverse);
	}

	public var not(get, never):ShouldMatrix;

	private function get_not() {
		return new ShouldMatrix(value, !inverse);
	}

	public function equal(expected:Matrix, ?p:PosInfos) {
		test(value == expected, p, 'Expected ${quote(value)} to be equal to ${quote(expected)}',
			'Expected ${quote(value)} to not be equal to ${quote(expected)}');
	}
}
