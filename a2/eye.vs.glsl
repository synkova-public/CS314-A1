// Shared variable passed to the fragment shader
varying vec3 color;
uniform vec3 eye;
uniform vec3 lightPosition;
uniform vec3 up;
uniform mat4 translate;


#define MAX_EYE_DEPTH 0.15
#define PI 3.1415926535

void main() {
  // simple way to color the pupil where there is a concavity in the sphere
  // position is in local space, assuming radius 1
  float d = min(1.0 - length(position), MAX_EYE_DEPTH);
  color = mix(vec3(1.0), vec3(0.0), d * 1.0 / MAX_EYE_DEPTH);


  mat4 scale = mat4(vec4(0.13, 0.0, 0.0, 0.0),
                         vec4(0.0, 0.13, 0.0, 0.0),
                         vec4(0.0, 0.0, 0.13, 0.0),
                         vec4(0.0, 0.0, 0.0, 1.0));

  float angle = -PI/2.0;

  mat4 rotateAroundX = mat4(vec4(1.0, 0.0, 0.0, 0.0),
                       vec4(0.0, cos(angle), sin(angle), 0.0),
                       vec4(0.0, -sin(angle), cos(angle), 0.0),
                       vec4(0.0, 0.0, 0.0, 1.0));

  mat4 rotateAroundZ = mat4(vec4(cos(angle), sin(angle), 0.0, 0.0),
                       vec4(-sin(angle), cos(angle), 0.0, 0.0),
                       vec4(0.0, 0.0, 1.0, 0.0),
                       vec4(0.0, 0.0, 0.0, 1.0));


  mat4 finalTrans = scale * rotateAroundZ * rotateAroundX;

  vec3 lookAtZ = normalize(eye - lightPosition);
  vec3 lookAtX = normalize(cross(up, lookAtZ));
  vec3 lookAtY = cross(lookAtZ, lookAtX);

  mat4 lookAt = mat4(vec4(lookAtX, 0.0),
                     vec4(lookAtY, 0.0),
                     vec4(lookAtZ, 0.0),
                     vec4(eye, 1.0));


  // Multiply each vertex by the model-view matrix and the projection matrix to get final vertex position
  gl_Position = projectionMatrix * viewMatrix * lookAt* modelMatrix * finalTrans * vec4(position, 1.0);
}
