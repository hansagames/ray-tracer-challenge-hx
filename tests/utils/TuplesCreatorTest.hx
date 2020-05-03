package utils;

import utils.TuplesCreator.create;
import utils.TuplesCreator.createPoint;
import utils.TuplesCreator.createVector;

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
			});
		});
	}
}
