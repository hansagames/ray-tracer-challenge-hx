package components;

import utils.CanvasCreator.createCanvas;
import utils.TuplesCreator.createColor;

class CanvasTest extends BuddySuite {
	public function new() {
		describe("CanvasTest", {
			it("should write pixel", {
				var canvas = createCanvas(10, 20);
				var row = 1;
				var column = 2;
				var color = createColor(1, 0, 1);

				canvas.writePixel(column, row, color);
				canvas.pixelAt(column, row).should.equal(color);
			});
		});
	}
}
