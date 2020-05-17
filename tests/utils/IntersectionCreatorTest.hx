package utils;

import utils.IntersectionCreator.createIntersection;
import utils.SphereCreator.createSphere;

class IntersectionCreatorTest extends BuddySuite {
	public function new() {
		describe("IntersectionCreatorTest", {
			describe("createIntersection", {
				it("should create intersection", {
					final t = 3.5;
					final sphere = createSphere();
					final intersection = createIntersection(t, sphere);
					intersection.t.should.be(t);
					intersection.object.should.be(sphere);
				});
			});
		});
	}
}
