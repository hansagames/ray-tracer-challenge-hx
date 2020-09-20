package types;

import utils.GroupCreator.createGroup;
import utils.RayCreator.createRay;
import utils.TuplesCreator.createPoint;
import utils.TuplesCreator.createVector;
import utils.SphereCreator.createSphere;
import utils.Transformation.translation;
import utils.Transformation.scaling;

class GroupTest extends BuddySuite {
	public function new() {
		describe("GroupTest", {
			it("should add child to the group", {
				final group = createGroup();
				final shape = new Shape();
				group.addChild(shape);
				shape.parent.should.be(group);
				group.contains(shape);
			});
		});
		describe("intersects", {
			it("should intersect with empty group", {
				final group = createGroup();
				final ray = createRay(createPoint(0, 0, 0), createVector(0, 0, 1));
				final xs = group.intersects(ray);
				xs.length.should.be(0);
			});
			it("should intersect with non empty group", {
				final group = createGroup();
				final s1 = createSphere();
				final s2 = createSphere();
				final s3 = createSphere();
				s2.transform = translation(0, 0, -3);
				s3.transform = translation(5, 0, 0);
				group.addChild(s1);
				group.addChild(s2);
				group.addChild(s3);
				final ray = createRay(createPoint(0, 0, -5), createVector(0, 0, 1));
				final xs = group.intersects(ray);
				xs.length.should.be(4);
				xs[0].object.should.be(s2);
				xs[1].object.should.be(s2);
				xs[2].object.should.be(s1);
				xs[3].object.should.be(s1);
			});
			it("should intersect transfored group", {
				final group = createGroup();
				final sphere = createSphere();
				group.transform = scaling(2, 2, 2);
				sphere.transform = translation(5, 0, 0);
				group.addChild(sphere);
				final ray = createRay(createPoint(10, 0, -10), createVector(0, 0, 1));
				final xs = group.intersects(ray);
				xs.length.should.be(2);
			});
		});
	}
}
