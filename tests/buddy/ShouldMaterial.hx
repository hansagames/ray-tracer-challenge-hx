package buddy;

import types.Material;
import buddy.Should;
import haxe.PosInfos;

/**
 * Add check for Materials in Buddy unit tests
 */
class ShouldMaterial extends Should<Material> {
	static public function should(t:Material) {
		return new ShouldMaterial(t);
	}

	public function new(value:Material, inverse = false) {
		super(value, inverse);
	}

	public var not(get, never):ShouldMaterial;

	private function get_not() {
		return new ShouldMaterial(value, !inverse);
	}

	public function equal(expected:Material, ?p:PosInfos) {
		test(Material.equals(expected, value), p, 'Expected ${quote(value)} to be equal to ${quote(expected)}',
			'Expected ${quote(value)} to not be equal to ${quote(expected)}');
	}
}
