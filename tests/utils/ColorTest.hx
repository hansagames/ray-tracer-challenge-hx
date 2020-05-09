package utils;

import utils.TuplesCreator.createColor;

class ColorTest extends BuddySuite {
	public function new() {
		describe("ColorTest", {
			it("should add colors", {
				var a = createColor(0.9, 0.6, 0.75);
				var b = createColor(0.7, 0.1, 0.25);
				var result = a + b;
				var output = createColor(1.6, 0.7, 1.0);
				result.should.equal(output);
			});
			it("should substract color", {
				var a = createColor(0.9, 0.6, 0.75);
				var b = createColor(0.7, 0.1, 0.25);
				var result = a - b;
				var output = createColor(0.2, 0.5, 0.5);
				result.should.equal(output);
			});
			it("should multiplay color by scalar", {
				var a = createColor(0.2, 0.3, 0.4);
				var result = a * 2;
				var output = createColor(0.4, 0.6, 0.8);
				result.should.equal(output);
			});
			it("should multiplay color with color", {
				var a = createColor(1, 0.2, 0.4);
				var b = createColor(0.9, 1, 0.1);
				var result = a * b;
				var output = createColor(0.9, 0.2, 0.04);
				result.should.equal(output);
			});
		});
	}
}
