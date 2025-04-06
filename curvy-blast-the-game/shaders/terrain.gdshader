shader_type canvas_item;

void light() {
	float cNdotL = max(0.7,ceil(max(0,dot(NORMAL, LIGHT_DIRECTION))));
	LIGHT = vec4(LIGHT_COLOR.rgb * COLOR.rgb * LIGHT_ENERGY * cNdotL, 1);

	//// Called for every pixel for every light affecting the CanvasItem.
	//// Uncomment to replace the default light processing function with this one.
}
