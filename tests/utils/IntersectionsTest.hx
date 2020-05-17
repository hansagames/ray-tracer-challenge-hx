package utils;

import utils.IntersectionCreator.createIntersection;
import utils.SphereCreator.createSphere;

using utils.Intersections;

class IntersectionsTest extends BuddySuite {
	public function new() {
		describe("IntersectionsTest", {
			describe("groupIntersections", {
				it("should aggregate intersections", {
					final sphere = createSphere();
					final i1 = createIntersection(1, sphere);
					final i2 = createIntersection(2, sphere);
					final xs = [i1, i2].groupIntersections();
					xs.length.should.be(2);
					xs[0].t.should.be(1);
					xs[1].t.should.be(2);
				});
			});
			describe("hit", {
				it("should calculate hit when all intersections have positive t", {
					final sphere = createSphere();
					final i1 = createIntersection(1, sphere);
					final i2 = createIntersection(2, sphere);
					final xs = [i2, i1].groupIntersections();
					xs.hit().should.be(i1);
				});
				it("should calculate hit when some intersections have negative t", {
					final sphere = createSphere();
					final i1 = createIntersection(-1, sphere);
					final i2 = createIntersection(1, sphere);
					final xs = [i2, i1].groupIntersections();
					xs.hit().should.be(i2);
				});
				it("should calculate hit when all intersections have negative t", {
					final sphere = createSphere();
					final i1 = createIntersection(-2, sphere);
					final i2 = createIntersection(-1, sphere);
					final xs = [i2, i1].groupIntersections();
					xs.hit().should.be(null);
				});
				it("should always return lowest non negative intersection", {
					final sphere = createSphere();
					final i1 = createIntersection(5, sphere);
					final i2 = createIntersection(7, sphere);
					final i3 = createIntersection(-3, sphere);
					final i4 = createIntersection(2, sphere);
					final xs = [i1, i2, i3, i4].groupIntersections();
					xs.hit().should.be(i4);
				});
			});
		});
	}
}
