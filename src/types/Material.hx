package types;

import utils.TuplesCreator.createColor;

class Material {
	public var color:Tuple;
	public var ambient:Float;
	public var diffuse:Float;
	public var specular:Float;
	public var shininess:Float;
	public var pattern:Null<Pattern>;

	public function new() {
		color = createColor(1, 1, 1);
		ambient = 0.1;
		diffuse = 0.9;
		specular = 0.9;
		shininess = 200.0;
	}

	public static function equals(a:Material, b:Material):Bool {
		return a.ambient == b.ambient && a.color == b.color && a.diffuse == b.diffuse && a.shininess == b.shininess && a.specular == b.specular
			&& a.pattern == b.pattern;
	}
}
