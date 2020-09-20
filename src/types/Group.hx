package types;

using utils.Intersections;
using utils.Matrices;
using utils.Rays;

class Group extends Shape {
	private var children:Array<Shape>;

	public function new() {
		super();
		children = [];
	}

	public function addChild(c:Shape) {
		c.parent = this;
		children.push(c);
	}

	public function contains(c:Shape):Bool {
		return children.contains(c);
	}

	override function intersects(ray:Ray):Array<Intersection> {
		final transformedRay = ray.transform(transform.inverse());
		var intersections:Array<Intersection> = [];
		for (child in children) {
			intersections = intersections.concat(child.intersects(transformedRay));
		}
		return intersections.groupIntersections();
	}
}
