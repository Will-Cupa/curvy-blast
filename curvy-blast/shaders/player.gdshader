shader_type canvas_item;

uniform vec3 baseColor = vec3(1,0.8,0);

void fragment() {
	COLOR = vec4(baseColor, texture(TEXTURE, UV).a);
	
	NORMAL_MAP = texture(TEXTURE, UV).rgb;
}

void light() {
	float cNdotL = max(0.7,ceil(max(0,dot(NORMAL, LIGHT_DIRECTION))));
	if(LIGHT_IS_DIRECTIONAL)
		LIGHT = vec4(LIGHT_COLOR.rgb * COLOR.rgb * LIGHT_ENERGY * cNdotL, 1);
	
	//// Called for every pixel for every light affecting the CanvasItem.
	//// Uncomment to replace the default light processing function with this one.
}
