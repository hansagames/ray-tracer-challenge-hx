package utils;

import utils.TuplesCreator.create;
import utils.TuplesCreator.createPoint;
import utils.TuplesCreator.createVector;
import utils.TuplesCreator.createColor;
import types.Tuple;

using utils.Tuples;

class TuplesCreatorTest extends BuddySuite {
	public function new() {
		describe("TuplesCreatorTest", {
			describe("create", {
				it("should be point if w = 1.0", {
					create(2, 3, 4, 1).isPoint().should.be(true);
				});
				it("should be vector if w = 0.0", {
					create(2, 3, 4, 0).isVector().should.be(true);
				});
				it("should have w = 1 for point", {
					createPoint(2, 3, 4).w.should.be(1);
				});
				it("should have w = 0 for vector", {
					createVector(2, 3, 4).w.should.be(0);
				});
				it("should create color", {
					createColor(1, 1, 1).should.equal(new Tuple(1, 1, 1, 0));
				});
			});
		});
	}
}
