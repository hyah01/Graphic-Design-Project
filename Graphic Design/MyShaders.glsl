// ***************************
// Shader programs to be used in conjunction with the
//  Phong lighting shaders of EduPhong.glsl
// Are first used with Project #6, Math 155A, Winter 2019
//
// Revision: Feb 23, 2019
// ***************************

// #beginglsl ...  #endglsl mark begining and end of code blocks.
// Syntax for #beginglsl is:
//
//   #beginglsl <shader-type> <shader-code-name>
//
// where <shader-type> is
//      vertexshader or fragmentshader or geometryshader or codeblock,
// and <shader-code-name> is used to compile/link the shader into a 
//      shader program.
// A codeblock is meant to be used as a portion of a larger shader.

// *****************************
// applyTextureMap - code block
//    applyTextureMap() is called after the Phong lighting is calculated.
//        - It returns a vec4 color value, which is used as the final pixel color.
//    Inputs: (all global variables)
//        - nonspecColor and specularColor (global variables, vec3 objects)
//        - theTexCoords (the texture coordinates, a vec2 object)
//    Returns a vec4:
//       - Will be used as the final fragment color
// *****************************
#beginglsl codeblock MyProcTexture
// vec3 nonspecColor;		// These items already declared 
// vec3 specularColor;
// vec2 theTexCoords;

/**
uniform sampler2D theTextureMap;	// An OpenGL texture map

bool InFshape( vec2 pos );	// Function prototype

vec4 applyTextureFunction() {
	vec2 wrappedTexCoords = fract(theTexCoords);	// Wrap s,t to [0,1].
	vec4 myColor = vec4(nonspecColor, 1.0f)*texture(theTextureMap, theTexCoords);
	if ( InFshape(wrappedTexCoords) ) {		
		return myColor;                // Black color inside the "F"
	}
	else {
		vec3 combinedPhongColor = nonspecColor+specularColor;
        return vec4(combinedPhongColor, 1.0f);   // Use the Phong light colors
	}
}

**/

uniform sampler2D theTextureMap;	// An OpenGL texture map

uniform float currentTime;

bool InFshape( vec2 pos );	// Function prototype

vec4 applyTextureFunction() {
	vec2 wrappedTexCoords = fract(theTexCoords);	// Wrap s,t to [0,1].
	vec4 myColor = vec4(nonspecColor, 1.0f)*texture(theTextureMap, theTexCoords);
	if ( InFshape(wrappedTexCoords) ) {	
	    float avgMinus = 1-(myColor.r+myColor.g+myColor.b)/6.0;
		myColor = vec4(avgMinus, avgMinus, avgMinus, 1.0);
		myColor = mix(myColor, vec4(0.3,0.6,0.6,1.0), 2.0*min(currentTime, 1-currentTime));
	}
	myColor += vec4(specularColor,0.0);
	return myColor;
}

// *******************************
// Recognize the interior of an "F" shape
//   Input "pos" contains s,t  texture coordinates.
//   Returns: true if inside the "F" shape.
//            false otherwise
// ******************************

// Original
/**
bool InFshape( vec2 pos ) {
	float sideMargin = 0.2;		// Left-to-right, F is in [sideMargin, 1-sideMargin]
	float verticalMargin = 0.1;	// Bottom-to-top, F is in [vertMargin, 1-vertMargin]
	float postWidth = 0.2;      // Width of the F's post
	float armWidth = 0.2;       // Width of the F's arms
	if ( pos.x<sideMargin || pos.x>1.0-sideMargin ||
	         pos.y<verticalMargin || pos.y>1.0-verticalMargin ) {
		 return false;
    }
	if ( pos.x<=sideMargin+postWidth || pos.y >= 1.0-verticalMargin-armWidth ) {
	    return true;
	}
	return ( pos.y <= 0.5+0.5*armWidth && pos.y >= 0.5-0.5*armWidth );
}

**/

// Making 6
/**
bool InFshape( vec2 pos ) {
	float sideMargin = 0.2;		// Left-to-right, F is in [sideMargin, 1-sideMargin]
	float verticalMargin = 0.1;	// Bottom-to-top, F is in [vertMargin, 1-vertMargin]
	float postWidth = 0.2;      // Width of the F's post
	float armWidth = 0.2;       // Width of the F's arms
	if ( pos.x<sideMargin || pos.x>1.0-sideMargin ||
	         pos.y<verticalMargin || pos.y>1.0-verticalMargin ) {
		 return false;
    }
	if ( pos.x<=sideMargin+postWidth || pos.y >= 1.0-verticalMargin-armWidth ) {
	    return true;
	}
	if ( pos.y <= 0.5+0.5*armWidth && pos.y >= 0.5-0.5*armWidth ){
		return true;
	}

	if ( pos.y <= 0.2+0.5*armWidth && pos.y >= 0.2-0.5*armWidth ) {
		return true;
	}

	if (pos.y <= 0.35+0.25*armWidth && pos.y >= 0.35-0.25*armWidth && pos.x <= 0.7+.5*postWidth && pos.x >= 0.7-.5*postWidth){
		return true;
	}
}
**/

// Making checker
bool InFshape( vec2 pos ) {
	float checkerWidth = 0.2;
	float sideMargin = 0.1;		// Left-to-right, F is in [sideMargin, 1-sideMargin]
	float verticalMargin = 0.1;	// Bottom-to-top, F is in [vertMargin, 1-vertMargin]
	float postWidth = 0.2;      // Width of the F's post
	float armWidth = 0.2;       // Width of the F's arms
	if ( pos.x<sideMargin || pos.x>1.0-sideMargin ||
	         pos.y<verticalMargin || pos.y>1.0-verticalMargin ) {
		 return false;
    }
	if ((pos.x >= sideMargin && pos.x <= .2 || pos.x >= sideMargin + 0.2 && pos.x <= 0.4 || pos.x >= sideMargin + 0.4 && pos.x <= 0.6 || pos.x >= sideMargin + 0.6 && pos.x <= 0.8 )&& (pos.y <= 0.9  && pos.y >= 0.8)){
		return true;
		}
	if ((pos.x >= sideMargin + 0.1 && pos.x <= sideMargin + 0.2 || pos.x >= sideMargin + 0.3 && pos.x <= sideMargin + 0.4 || pos.x >= sideMargin + 0.5 && pos.x <= sideMargin + 0.6 || pos.x >= sideMargin + 0.7 && pos.x <= sideMargin + 0.8 ) && (pos.y <= 0.8  && pos.y >= 0.7)){
		return true;
		}
	if ((pos.x >= sideMargin && pos.x <= .2 || pos.x >= sideMargin + 0.2 && pos.x <= 0.4 || pos.x >= sideMargin + 0.4 && pos.x <= 0.6 || pos.x >= sideMargin + 0.6 && pos.x <= 0.8 )&& (pos.y <= 0.7  && pos.y >= 0.6)){
		return true;
		}
	if ((pos.x >= sideMargin + 0.1 && pos.x <= sideMargin + 0.2 || pos.x >= sideMargin + 0.3 && pos.x <= sideMargin + 0.4 || pos.x >= sideMargin + 0.5 && pos.x <= sideMargin + 0.6 || pos.x >= sideMargin + 0.7 && pos.x <= sideMargin + 0.8 ) && (pos.y <= 0.6  && pos.y >= 0.5)){
		return true;
		}
	if ((pos.x >= sideMargin && pos.x <= .2 || pos.x >= sideMargin + 0.2 && pos.x <= 0.4 || pos.x >= sideMargin + 0.4 && pos.x <= 0.6 || pos.x >= sideMargin + 0.6 && pos.x <= 0.8 )&& (pos.y <= 0.5  && pos.y >= 0.4)){
		return true;
		}
	if ((pos.x >= sideMargin + 0.1 && pos.x <= sideMargin + 0.2 || pos.x >= sideMargin + 0.3 && pos.x <= sideMargin + 0.4 || pos.x >= sideMargin + 0.5 && pos.x <= sideMargin + 0.6 || pos.x >= sideMargin + 0.7 && pos.x <= sideMargin + 0.8 ) && (pos.y <= 0.4  && pos.y >= 0.3)){
		return true;
		}
	if ((pos.x >= sideMargin && pos.x <= .2 || pos.x >= sideMargin + 0.2 && pos.x <= 0.4 || pos.x >= sideMargin + 0.4 && pos.x <= 0.6 || pos.x >= sideMargin + 0.6 && pos.x <= 0.8 )&& (pos.y <= 0.3  && pos.y >= 0.2)){
		return true;
		}
	if ((pos.x >= sideMargin + 0.1 && pos.x <= sideMargin + 0.2 || pos.x >= sideMargin + 0.3 && pos.x <= sideMargin + 0.4 || pos.x >= sideMargin + 0.5 && pos.x <= sideMargin + 0.6 || pos.x >= sideMargin + 0.7 && pos.x <= sideMargin + 0.8 ) && (pos.y <= 0.2  && pos.y >= 0.1)){
		return true;
		}
						
}

#endglsl
