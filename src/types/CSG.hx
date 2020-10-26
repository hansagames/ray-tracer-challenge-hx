package types;

import utils.IntersectionCreator.createIntersection;

using utils.Tuples;
using utils.Intersections;
using utils.Rays;
using utils.Matrices;

enum Operation {
	Union;
	Intersection;
	Difference;
}

class CSG extends Group {
	public final operation: Operation;
	public final left: Shape;
	public final right: Shape;
	public function new(operation: Operation, left: Shape, right: Shape) {
		super();
		this.operation = operation;
		this.left = left;
		this.right = right;
		addChild(left);
		addChild(right);
	}
	override function intersects(ray:Ray):Array<Intersection> {
		final transformedRay = ray.transform(transform.inverse());
		final leftxs = left.intersects(transformedRay);
		final rightxs = right.intersects(transformedRay);
		var intersections:Array<Intersection> = [];
		intersections = intersections.concat(leftxs);
		intersections = intersections.concat(rightxs);
		intersections = intersections.groupIntersections();
		return filterIntersections(this, intersections);
	}
	public static function filterIntersections(c: CSG, xs: Array<Intersection>): Array<Intersection> {
		final result:Array<Intersection> = [];
		var inl = false;
		var inr = false;

		for (i in xs) {
			final lhit = includes(c.left, i.object);
			if (intersectionAllowed(c.operation, lhit, inl, inr)) {
				result.push(i);
			}
			if (lhit) {
				inl = !inl;
			} else {
				inr = !inr;
			}
		}
		return result;
	}
	private static function includes(a: Shape, b: Shape): Bool {
		if (Std.isOfType(a, Group)) {
			final children = cast(a, Group).children;
			for (child in children) {
				final result = includes(child, b);
				if (result) {
					return true;
				}
			}
			return false;
		} else {
			return a == b;
		}
	}
	public static function intersectionAllowed(op: Operation, lhit: Bool, inl: Bool, inr: Bool): Bool {
		switch op {
			case Union:
				return (lhit && !inr) || (!lhit && !inl);
			case Intersection:
				return (lhit && inr) || (!lhit && inl);
			case Difference:
				return (lhit && !inr) || (!lhit && inl);
		}
		return false;
	}
}
