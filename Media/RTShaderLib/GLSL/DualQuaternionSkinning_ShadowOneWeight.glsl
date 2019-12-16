#version 120

vec3 calculateBlendPosition(vec3 position, mat2x4 blendDQ);

uniform mat4x2 worldDualQuaternion2x4Array[24];
uniform mat4x4 viewProjectionMatrix;
uniform vec4   ambient;

attribute vec4 vertex;
attribute vec4 blendIndices;
attribute vec4 blendWeights;

varying vec4 colour;

//Shadow caster pass
void main()
{
	mat2x4 dq0 = transpose(worldDualQuaternion2x4Array[int(blendIndices.x)]);
	mat2x4 blendDQ = blendWeights.x * dq0;

	float len = length(blendDQ[0]);
	blendDQ /= len;

	vec3 blendPosition = calculateBlendPosition(vertex.xyz, blendDQ);

	// view / projection
	gl_Position = viewProjectionMatrix * vec4(blendPosition, 1.0);
	
	colour = ambient;
}

