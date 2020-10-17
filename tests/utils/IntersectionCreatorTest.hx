package utils;

import utils.IntersectionCreator.createIntersection;
import utils.IntersectionCreator.createIntersectionWithUV;
import utils.TriangleCreator.createTriangle;
import utils.TuplesCreator.createPoint;
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
			describe("createIntersectionWithUV", {
				it("should intrsect with encapsuled u and v", {
					final t = createTriangle(createPoint(0, 1, 0), createPoint(-1, 0, 0), createPoint(1, 0, 0));
					final i = createIntersectionWithUV(3.5, t, 0.2, 0.4);
					i.u.should.be(0.2);
					i.v.should.be(0.4);
				});
			});
			
		});
	}
}
