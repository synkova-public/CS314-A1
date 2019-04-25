// Shared variable passed to the fragment shader
varying vec3 color;

// Constant set via your javascript code
uniform vec3 lightPosition;
uniform float headRotation;



void main() {
	// No lightbulb, but we still want to see the armadillo!
	vec3 l = vec3(0.0, 0.0, -1.0);
	color = vec3(1.0) * dot(l, normal);

vec4 p = vec4(position, 1.0);

	// Identifying the head
	if (position.z < -0.33 && abs(position.x) < 0.46){

			 mat4 a = mat4(vec4(1.0, 0.0, 0.0, 0.0),
			 							 vec4(0.0, 1.0, 0.0, 0.0),
										 vec4(0.0, 0.0, 1.0, 0.0),
										 vec4(0.0, 2.50, -0.30, 1.0));

		mat4 rotateAroundX = mat4(vec4(1.0, 0.0, 0.0, 0.0),
												 vec4(0.0, cos(headRotation), sin(headRotation), 0.0),
												 vec4(0.0, -sin(headRotation), cos(headRotation), 0.0),
												 vec4(0.0, 0.0, 0.0, 1.0));

   mat4 invA = mat4(vec4(1.0, 0.0, 0.0, 0.0),
								 vec4(0.0, 1.0, 0.0, 0.0),
	 							 vec4(0.0, 0.0, 1.0, 0.0),
								 vec4(0.0, -2.50, 0.30, 1.0));

	p = a * rotateAroundX * invA * p;
	}


	// Multiply each vertex by the model-view matrix and the projection matrix to get final vertex position
	gl_Position = projectionMatrix * modelViewMatrix * p;
}
