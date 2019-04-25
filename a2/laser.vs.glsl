uniform vec3 eye;
uniform vec3 lightPosition;
uniform vec3 up;


#define PI 3.1415926535

void main() {

  float angle = -PI/2.0;


  vec3 eyeToLight = eye - lightPosition;
  float distance = length(eyeToLight);
  distance = distance / 2.0;

mat4 scale = mat4(vec4(1.0, 0.0, 0.0, 0.0),
                  vec4(0.0, 1.0, 0.0, 0.0),
                  vec4(0.0, 0.0, distance, 0.0),
                  vec4(0.0, 0.0, 0.0, 1.0));

  mat4 rotateAroundX = mat4(vec4(1.0, 0.0, 0.0, 0.0),
                       vec4(0.0, cos(angle), sin(angle), 0.0),
                       vec4(0.0, -sin(angle), cos(angle), 0.0),
                       vec4(0.0, 0.0, 0.0, 1.0));


  vec3 lookAtZ = normalize(eyeToLight);
  vec3 lookAtX = normalize(cross(up, lookAtZ));
  vec3 lookAtY = cross(lookAtZ, lookAtX);

  mat4 lookAt = mat4(vec4(lookAtX, 0.0),
                     vec4(lookAtY, 0.0),
                     vec4(lookAtZ, 0.0),
                     vec4(eye, 1.0));

  gl_Position = projectionMatrix * viewMatrix * lookAt * modelMatrix * scale * rotateAroundX * vec4(position, 1.0);
}
