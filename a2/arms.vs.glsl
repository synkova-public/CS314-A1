void main() {
	// No lightbulb, but we still want to see the armadillo!
	vec3 l = vec3(0.0, 0.0, -1.0);
	color = vec3(1.0) * dot(l, normal);


	gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
