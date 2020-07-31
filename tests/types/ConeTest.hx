package types;

import utils.ConeCreator.createCone;
import utils.TuplesCreator.createPoint;
import utils.TuplesCreator.createVector;
import utils.RayCreator.createRay;
import types.Tuple;

using Lambda;
using utils.Tuples;
using utils.Numbers;

class ConeTest extends BuddySuite {
	public function new() {
		describe("ConeTest", {
			describe("intersect", {
				final dataForIntersect:Array<Array<Dynamic>> = [
					[createPoint(0, 0, -5), createVector(0, 0, 1), 5, 5],
					[createPoint(0, 0, -5), createVector(1, 1, 1), 8.66025, 8.66025],
					[createPoint(1, 1, -5), createVector(-0.5, -1, 1), 4.55006, 49.44994],
				];
				dataForIntersect.iter((data:Array<Dynamic>) -> {
					it('should intersect cone with ray ${data[0]} ${data[1]}', {
						final cone = createCone();
						final nonNormalizedDirection:Tuple = cast data[1];
						final direction = nonNormalizedDirection.normalize();
						final r = createRay(data[0], direction);
						final xs = cone.intersects(r);
						xs.length.should.be(2);
						xs[0].t.roundTo(5).should.be(data[2]);
						xs[1].t.roundTo(5).should.be(data[3]);
					});
				});
				it("should intersect with a ray parallel to on of its halves", () -> {
					final cone = createCone();
					final direction = createVector(0, 1, 1).normalize();
					final r = createRay(createPoint(0, 0, -1), direction);
					final xs = cone.intersects(r);
					xs.length.should.be(1);
					xs[0].t.roundTo(5).should.be(0.35355);
				});
				final dataForCapeIntersect:Array<Array<Dynamic>> = [
					[createPoint(0, 0, -5), createVector(0, 1, 0), 0],
					[createPoint(0, 0, -0.25), createVector(0, 1, 1), 2],
					[createPoint(0, 0, -0.25), createVector(0, 1, 0), 4]
				];
				dataForCapeIntersect.iter((data:Array<Dynamic>) -> {
					it('should intersect cone end caps with ray ${data[0]} ${data[1]}', {
						final cone = createCone();
						cone.closed = true;
						cone.minimum = -0.5;
						cone.maximum = 0.5;
						final nonNormalizedDirection:Tuple = cast data[1];
						final direction = nonNormalizedDirection.normalize();
						final r = createRay(data[0], direction);
						final xs = cone.intersects(r);
						xs.length.should.be(data[2]);
					});
				});
			});
		});
	}
}
