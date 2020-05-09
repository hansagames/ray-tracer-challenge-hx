package exercises;

import haxe.Timer;
import types.Projectile;
import types.Environment;
import utils.TuplesCreator.createPoint;
import utils.TuplesCreator.createVector;

using utils.Tuples;

class Chapter01 {
	private var projectile:Projectile;
	private var environment:Environment;

	private var timer:Timer;

	public function new() {
		projectile = new Projectile(createPoint(0, 1, 0), createVector(1, 1, 0).normalize());
		environment = new Environment(createVector(0, -0.1, 0), createVector(-0.01, 0, 0));
		timer = new Timer(16);
		timer.run = onUpdate;
	}

	private function onUpdate() {
		var position = projectile.poisition + projectile.velocity;
		var velocity = projectile.velocity + environment.gravity + environment.wind;
		projectile = new Projectile(position, velocity);

		if (position.y <= 0) {
			timer.stop();
		}
	}
}
