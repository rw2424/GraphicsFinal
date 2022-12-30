#version 150 core

uniform mat4 modelMatrix;
uniform mat4 viewMatrix;
uniform mat4 projMatrix;

uniform vec3 triangleColor;
uniform vec3 lightPos;
uniform vec3 lightParams;
uniform vec3 camPos;

in vec3 position;
in vec3 normal;

out vec3 n;
out vec3 color;
out vec3 pos;

// texture stuff
in vec2 vertexUV;
out vec2 UV;

in vec3 tangents;
in vec3 bitangents;

out mat3 TBN;
//out vec3 LightDirection_cameraspace;
//out vec3 EyeDirection_cameraspace;
void main()
{
    n = mat3(transpose(inverse(modelMatrix))) * normal;
    color = triangleColor;
    pos = vec3(modelMatrix * vec4(position, 1.0));
    gl_Position = projMatrix * viewMatrix * modelMatrix * vec4(position, 1.0);

    UV = vertexUV;

   vec3 T = normalize(vec3(modelMatrix * vec4(tangents,   0.0)));
   vec3 B = normalize(vec3(modelMatrix * vec4(bitangents, 0.0)));
   vec3 N = normalize(vec3(modelMatrix * vec4(normal,    0.0)));
   TBN = mat3(T, B, N);

   //LightDirection_tangentspace = normalize(lightPos - pos);
   //EyeDirection_tangentspace =  TBN * EyeDirection_cameraspace;
}
