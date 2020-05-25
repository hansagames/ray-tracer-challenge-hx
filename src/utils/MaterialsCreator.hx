package utils;

import types.PointLight;
import types.Tuple;
import types.Material;
import utils.TuplesCreator.createColor;

using utils.Tuples;

class MaterialsCreator {
	public static function createMaterial():Material {
		return new Material();
	}

	public static function lighting(m:Material, light:PointLight, point:Tuple, eyeView:Tuple, n:Tuple, inShadow:Bool):Tuple {
		final efectiveColor = m.color * light.intensity;
		final lightDirection = (light.position - point).normalize();
		final ambient = efectiveColor * m.ambient;
		final lightDot = lightDirection.dot(n);
		var diffuse:Tuple;
		var specular:Tuple;

		if (inShadow) {
			return ambient;
		}

		if (lightDot < 0) {
			diffuse = createColor(0, 0, 0);
			specular = createColor(0, 0, 0);
		} else {
			diffuse = efectiveColor * m.diffuse * lightDot;
			final reflect = -lightDirection.reflect(n);
			final reflectDot = reflect.dot(eyeView);

			if (reflectDot <= 0) {
				specular = createColor(0, 0, 0);
			} else {
				final factor = Math.pow(reflectDot, m.shininess);
				specular = light.intensity * m.specular * factor;
			}
		}
		return ambient + diffuse + specular;
	}
}
