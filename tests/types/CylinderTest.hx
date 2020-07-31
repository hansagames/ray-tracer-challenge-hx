package types;

import utils.CylinderCreator.createCylinder;
import utils.TuplesCreator.createPoint;
import utils.TuplesCreator.createVector;
import utils.RayCreator.createRay;
import types.Tuple;

using Lambda;
using utils.Tuples;
using utils.Numbers;

class CylinderTest extends BuddySuite {
	public function new() {
		describe("CylinderTest", {
			describe("intersects", {
				[
					[createPoint(1, 0, 0), createVector(0, 1, 0)],
					[createPoint(0, 0, 0), createVector(0, 1, 0)],
					[createPoint(0, 0, -5), createVector(1, 1, 1)]
				]
				.iter((data) -> {
					it('should miss cylinder with ray ${data[0]} ${data[1]}', {
						final cyl = createCylinder();
						final direction = data[1].normalize();
						final r = createRay(data[0], direction);
						final xs = cyl.intersects(r);
						xs.length.should.be(0);
					});
				});
				final dataForHit:Array<Array<Dynamic>> = [
					[createPoint(1, 0, -5), createVector(0, 0, 1), 5, 5],
					[createPoint(0, 0, -5), createVector(0, 0, 1), 4, 6],
					[createPoint(0.5, 0, -5), createVector(0.1, 1, 1), 6.80798, 7.08872]
				];
				dataForHit.iter((data:Array<Dynamic>) -> {
					it('should hit cylinder with ray ${data[0]} ${data[1]}', {
						final cyl = createCylinder();
						final nonNormalizedDirection:Tuple = cast data[1];
						final direction = nonNormalizedDirection.normalize();
						final r = createRay(data[0], direction);
						final xs = cyl.intersects(r);
						xs.length.should.be(2);
						xs[0].t.roundTo(5).should.be(data[2]);
						xs[1].t.roundTo(5).should.be(data[3]);
					});
				});
			});
			describe("normalAt", {
				final data:Array<Dynamic> = [
					[createPoint(1, 0, 0), createVector(1, 0, 0)],
					[createPoint(0, 5, -1), createVector(0, 0, -1)],
					[createPoint(0, -2, 1), createVector(0, 0, 1)],
					[createPoint(-1, 1, 0), createVector(-1, 0, 0)],
				];
				for (i in 0...data.length) {
					it("should have no intersection", {
						final cyl = createCylinder();
						final normal = cyl.normalAt(data[i][0]);
						normal.should.equal(data[i][1]);
					});
				}
			});
			describe("constrained cylinder", {
				it("should have default min / max values", {
					final cyl = createCylinder();
					cyl.minimum.should.be(Math.NEGATIVE_INFINITY);
					cyl.maximum.should.be(Math.POSITIVE_INFINITY);
				});
				final dataForIntersect:Array<Array<Dynamic>> = [
					[createPoint(0, 1.5, 0), createVector(0.1, 1, 0), 0],
					[createPoint(0, 3, -5), createVector(0, 0, 1), 0],
					[createPoint(0, 0, -5), createVector(0, 0, 1), 0],
					[createPoint(0, 2, -5), createVector(0, 0, 1), 0],
					[createPoint(0, 1, -5), createVector(0, 0, 1), 0],
					[createPoint(0, 1.5, -5), createVector(0, 0, 1), 2]
				];
				dataForIntersect.iter((data:Array<Dynamic>) -> {
					it('should intersect constrained cylinder with ray ${data[0]} ${data[1]}', {
						final cyl = createCylinder();
						cyl.minimum = 1;
						cyl.maximum = 2;
						final nonNormalizedDirection:Tuple = cast data[1];
						final direction = nonNormalizedDirection.normalize();
						final r = createRay(data[0], direction);
						final xs = cyl.intersects(r);
						xs.length.should.be(data[2]);
					});
				});
			});
			describe("closed cylinder", {
				it("should not be closed by default", {
					final cyl = createCylinder();
					cyl.closed.should.be(false);
				});
				final dataForIntersect:Array<Array<Dynamic>> = [
					[createPoint(0, 3, 0), createVector(0, -1, 0), 2],
					[createPoint(0, 3, -2), createVector(0, -1, 2), 2],
					[createPoint(0, 4, -2), createVector(0, -1, 1), 2],
					[createPoint(0, 0, -2), createVector(0, 1, 2), 2],
					[createPoint(0, -1, -2), createVector(0, 1, 1), 2]
				];
				dataForIntersect.iter((data:Array<Dynamic>) -> {
					it('should intersect closed cylinder with ray ${data[0]} ${data[1]}', {
						final cyl = createCylinder();
						cyl.minimum = 1;
						cyl.maximum = 2;
						cyl.closed = true;
						final nonNormalizedDirection:Tuple = cast data[1];
						final direction = nonNormalizedDirection.normalize();
						final r = createRay(data[0], direction);
						final xs = cyl.intersects(r);
						xs.length.should.be(data[2]);
					});
				});
				[
					[createPoint(0, 1, 0), createVector(0, -1, 0)],
					[createPoint(0.5, 1, 0), createVector(0, -1, 0)],
					[createPoint(0, 1, 0.5), createVector(0, -1, 0)],
					[createPoint(0, 2, 0), createVector(0, 1, 0)],
					[createPoint(0.5, 2, 0), createVector(0, 1, 0)],
					[createPoint(0, 2, 0.5), createVector(0, 1, 0)]
				]
				.iter((data) -> {
					it('should calcualte normal cylinder end cap with ray ${data[0]} ${data[1]}', {
						final cyl = createCylinder();
						cyl.minimum = 1;
						cyl.maximum = 2;
						cyl.closed = true;
						cyl.normalAt(data[0]).should.equal(data[1]);
					});
				});
			});
		});
	}
}
