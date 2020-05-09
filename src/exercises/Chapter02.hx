package exercises;

import components.Canvas;
import haxe.Timer;
import types.Projectile;
import types.Environment;
import utils.TuplesCreator.createPoint;
import utils.TuplesCreator.createVector;
import utils.CanvasCreator.createCanvas;
import utils.TuplesCreator.createColor;
import sys.io.File;
import haxe.io.Path;

using utils.Tuples;
using utils.CanvasPPM;

class Chapter02 {
	private var projectile:Projectile;
	private var environment:Environment;
	private var canvas:Canvas;

	private var timer:Timer;

	public function new() {
		projectile = new Projectile(createPoint(0, 1, 0), createVector(1, 1.8, 0).normalize() * 11.25);
		environment = new Environment(createVector(0, -0.1, 0), createVector(-0.01, 0, 0));
		canvas = createCanvas(900, 550);
		timer = new Timer(16);
		timer.run = onUpdate;
	}

	private function onUpdate() {
		canvas.writePixel(Std.int(projectile.poisition.x), canvas.height - Std.int(projectile.poisition.y), createColor(1, 0, 1));

		var position = projectile.poisition + projectile.velocity;
		var velocity = projectile.velocity + environment.gravity + environment.wind;
		projectile = new Projectile(position, velocity);

		if (position.y <= 0) {
			timer.stop();
			File.saveContent(Path.join(["build", "chapter02.ppm"]), canvas.toPPM());
		}
	}
}
