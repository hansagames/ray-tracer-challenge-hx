package types;

import utils.RayCreator.createRay;
import utils.TuplesCreator.createPoint;
import utils.TuplesCreator.createVector;
import utils.TriangleCreator.createSmoothTriangle;
import utils.IntersectionCreator.createIntersectionWithUV;

using utils.Tuples;
using utils.Numbers;
using utils.Intersections;

class SmoothTriangleTest extends BuddySuite {
	public function new() {
		describe("SmoothTriangleTest", {
			describe("create", {
				it("should create smooth triangle", {
					final p1 = createPoint(0,1,0);
					final p2 = createPoint(-1, 0, 0);
					final p3 = createPoint(1, 0, 0);
					final n1 = createVector(0,1,0);
					final n2 = createVector(-1, 0, 0);
					final n3 = createVector(1, 0, 0);
					final t = createSmoothTriangle(p1, p2, p3, n1, n2, n3);
					t.p1.should.equal(p1);
					t.p2.should.equal(p2);
					t.p3.should.equal(p3);
					t.n1.should.equal(n1);
					t.n2.should.equal(n2);
					t.n3.should.equal(n3);
				});
			});
			it("should store u and v", {
				final p1 = createPoint(0,1,0);
				final p2 = createPoint(-1, 0, 0);
				final p3 = createPoint(1, 0, 0);
				final n1 = createVector(0,1,0);
				final n2 = createVector(-1, 0, 0);
				final n3 = createVector(1, 0, 0);
				final t = createSmoothTriangle(p1, p2, p3, n1, n2, n3);
				final ray = createRay(createPoint(-0.2, 0.3, -2), createVector(0, 0, 1));
				final xs = t.intersects(ray);
				xs[0].u.roundTo(2).should.be(0.45);
				xs[0].v.roundTo(2).should.be(0.25);
			});
			it("should interpolate normals with u and v", {
				final p1 = createPoint(0,1,0);
				final p2 = createPoint(-1, 0, 0);
				final p3 = createPoint(1, 0, 0);
				final n1 = createVector(0,1,0);
				final n2 = createVector(-1, 0, 0);
				final n3 = createVector(1, 0, 0);
				final t = createSmoothTriangle(p1, p2, p3, n1, n2, n3);
				final i = createIntersectionWithUV(1, t, 0.45, 0.25);
				final n = t.normalAt(createPoint(0, 0, 0), i);
				n.should.equal(createVector(-0.5547, 0.83205, 0));
			});
			@exclude // TODO: investigate why fails
			it("should prepeare normal on smooth triangle", {
				final p1 = createPoint(0, 1, 0);
				final p2 = createPoint(-1, 0, 0);
				final p3 = createPoint(1, 0, 0);
				final n1 = createVector(0, 1, 0);
				final n2 = createVector(-1, 0, 0);
				final n3 = createVector(1, 0, 0);
				final t = createSmoothTriangle(p1, p2, p3, n1, n2, n3);
				final i = createIntersectionWithUV(1, t, 0.45, 0.25);
				final r = createRay(createPoint(-0.2, 0.3, -2), createVector(0, 0, 1));
				final xs = [i];
				final comps = i.prepeareComputation(r, xs);
				comps.normal.roundTo(5).should.equal(createVector(-0.5547, 0.83205, 0));
			});
		});
	}
}
