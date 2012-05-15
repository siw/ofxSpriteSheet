
#ifndef OFX_SPRITE_SHEET
#define OFX_SPRITE_SHEET

#include "ofMain.h"

// ---
class spriteType{
    
    public:
        spriteType(){
            position.x = 0.0;
            position.y = 0.0;
            position.z = 0.0;
        }
        string      name;
        ofVec3f     position;
        int         meshIndex;
        int         width;
        int         height;
    
};

// ---

typedef std::map<std::string, spriteType> spriteLists;

// ---

class ofxSpriteSheet{
	public:
		ofxSpriteSheet();
	
        void draw();

        void loadImage(string file);
    
        void addSprite(string name, int x, int y, int w, int h);
    
        void setPosition(string name, int x, int y);
    
    protected:
    
        void addPoint(int x, int y);
    
        spriteLists sprites;
        ofMesh      mesh;
        ofTexture   texture;
    
        int         imageWidth;
        int         imageHeight;
    
        int         index;
	
};

#endif