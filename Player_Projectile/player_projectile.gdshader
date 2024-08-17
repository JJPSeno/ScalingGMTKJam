shader_type canvas_item;

uniform float speed = 2.0;

vec2 rotate(vec2 uv, vec2 pivot, float angle)
{
	mat2 rotation = mat2(vec2(sin(angle), -cos(angle)),
						vec2(cos(angle), sin(angle)));
	
	uv -= pivot;
	uv = uv * rotation;
	uv += pivot;
	return uv;
}

void fragment()
{
	COLOR = texture(TEXTURE, rotate(UV, vec2(0.5), TIME * speed));
}
