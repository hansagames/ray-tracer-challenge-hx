package buddy;

import buddy.Should;
import haxe.PosInfos;
import types.Tuple;

/**
 * Add check for Tuples in Buddy unit tests
 */
class ShouldTuple extends Should<Tuple> {
	static public function should(t:Tuple) {
		return new ShouldTuple(t);
	}

	public function new(value:Tuple, inverse = false) {
		super(value, inverse);
	}

	public var not(get, never):ShouldTuple;

	private function get_not() {
		return new ShouldTuple(value, !inverse);
	}

	public function equal(expected:Tuple, ?p:PosInfos) {
		test(value == expected, p, 'Expected ${quote(value)} to be equal to ${quote(expected)}',
			'Expected ${quote(value)} to not be equal to ${quote(expected)}');
	}
}
