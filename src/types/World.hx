package types;

class World {
	public var meshCount(get, never):Int;
	public var lightCount(get, never):Int;

	public var lights(default, null):Array<PointLight>;

	public var meshes(default, null):Array<Shape>;

	public function new() {
		meshes = [];
		lights = [];
	}

	function get_meshCount():Int {
		return meshes.length;
	}

	function get_lightCount():Int {
		return lights.length;
	}

	public function containsLight(light:PointLight):Bool {
		return lights.indexOf(light) >= 0;
	}

	public function addLight(light:PointLight):World {
		if (!containsLight(light)) {
			lights.push(light);
		}
		return this;
	}

	public function replaceLight(light:PointLight):World {
		lights = [];
		lights.push(light);
		return this;
	}

	public function containsMesh(mesh:Shape):Bool {
		return meshes.indexOf(mesh) >= 0;
	}

	public function addMesh(mesh:Shape):World {
		if (!containsMesh(mesh)) {
			meshes.push(mesh);
		}
		return this;
	}
}
