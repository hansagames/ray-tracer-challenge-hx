package utils;

import utils.CanvasCreator.createCanvas;
import utils.TuplesCreator.createColor;

class CanvasCreatorTest extends BuddySuite {
	public function new() {
		describe("CanvasCreatorTest", {
			it("should create canvas", {
				var width = 10;
				var height = 20;
				var canvas = createCanvas(width, height);
				canvas.width.should.be(width);
				canvas.height.should.be(height);
			});
			it("should have all pixles black", {
				var width = 10;
				var height = 20;
				var canvas = createCanvas(width, height);
				var pixels = canvas.pixels;
				var color = createColor(0, 0, 0);

				pixels.length.should.be(height);

				for (row in pixels) {
					for (pixel in row) {
						pixel.should.equal(color);
					}
				}
			});
		});
	}
}
