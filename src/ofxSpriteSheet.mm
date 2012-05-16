

#include "ofxSpriteSheet.h"

// --------------------------------------------------------------------------------------
ofxSpriteSheet::ofxSpriteSheet() {
    
    mesh.setMode( OF_PRIMITIVE_TRIANGLES );
    
    index = 0;
    
}

// --------------------------------------------------------------------------------------
void ofxSpriteSheet::draw(){
    
    
    // draw mesh with texture
    ofEnableAlphaBlending();
	ofSetColor(255, 255, 255);
    
	texture.bind();
	mesh.draw();

	texture.unbind();
    
    ofDisableAlphaBlending();
    
    // draw wireframes for debug
    ofNoFill();
	mesh.drawWireframe();

    
}
// --------------------------------------------------------------------------------------
void ofxSpriteSheet::loadImage(string file){   
    
    // load image
    ofImage loader;
    loader.setUseTexture(false);
    loader.loadImage(file);
    
    // store width & height
    imageWidth = loader.getWidth();
    imageHeight = loader.getHeight();
    
    // allocate texture & copy in data
    texture.allocate(imageWidth, imageHeight, GL_RGBA);
    texture.loadData(loader.getPixels(), imageWidth, imageHeight, GL_RGBA);
    
    // clear temp image
    loader.clear();

    
}

// --------------------------------------------------------------------------------------
void ofxSpriteSheet::addSprite(string name, int x, int y, int w, int h){
    
    // first create the vertices, text coords & mesh colors
    
    // triangle 1
    addPoint(x, y); // top-left
    
    addPoint(x+w, y); // top-right
    
    addPoint(x, y+h); // bottom-left
    
    // triangle 2
    addPoint(x+w, y); // top-right
    
    addPoint(x, y+h); // bottom-left
    
    addPoint(x+w, y+h); // bottom-right
 
    // create a new spriteType object using name as a reference
    sprites.insert( pair<std::string, spriteType>(name, spriteType()) );
    
    // store the name within the object for future use
    sprites[name].name = name;
    
    // temp, set position
    sprites[name].position.x = x;
    sprites[name].position.y = y;
    sprites[name].width = w;
    sprites[name].height = h;
    
    // store first index (in vertice/textcoord/color) within object for future use
    sprites[name].meshIndex = index;

    // add 6 to current index position
    // 2 triangles, 3 points each
    index += 6;
    
}
// -----------------------------------------
void ofxSpriteSheet::addPoint(int x, int y){
    
    // vertex
    ofVec3f v;
    v.x = x;
    v.y = y;
    v.z = 0;
    mesh.addVertex(v);

    // text coord
    ofVec2f t;
    t.x = x / (float)imageWidth;
    t.y = y / (float)imageHeight;
    mesh.addTexCoord(t);
    
    // color
    ofFloatColor c;
    c.set(255.0, 255.0, 255.0);
    mesh.addColor( c );
    
}

// -----------------------------------------
void ofxSpriteSheet::setPosition(string name, int x, int y){
    
    sprites[name].position.x = x;
    sprites[name].position.y = y;
    
    int w = sprites[name].width;
    int h = sprites[name].height;
    
    // first index    
    int thisIndex = sprites[name].meshIndex;

    ofVec3f tempVec;
    
    // triangle 1 update ----
    
    // top left
    mesh.setVertex(thisIndex, sprites[name].position); 
    
    // top right
    tempVec.x = sprites[name].position.x + w;
    tempVec.y = sprites[name].position.y;
    mesh.setVertex(thisIndex+1, tempVec); 
    
    // bottom left
    tempVec.x = sprites[name].position.x;
    tempVec.y = sprites[name].position.y+h;
    mesh.setVertex(thisIndex+2, tempVec); 
    
    // triangle 2 update ----
    
    // top right
    tempVec.x = sprites[name].position.x + w;
    tempVec.y = sprites[name].position.y;
    mesh.setVertex(thisIndex+3, tempVec); 
    
    // bottom left
    tempVec.x = sprites[name].position.x;
    tempVec.y = sprites[name].position.y+h;
    mesh.setVertex(thisIndex+4, tempVec);
    
    // bottom right
    tempVec.x = sprites[name].position.x+w;
    tempVec.y = sprites[name].position.y+h;
    mesh.setVertex(thisIndex+5, tempVec);
    
    
}
// -----------------------------------------
void ofxSpriteSheet::setAnchorPoint(string name, int x, int y){
    
    sprites[name].anchor.x = (float)x;
    sprites[name].anchor.y = (float)y;
    
}
// -----------------------------------------
void ofxSpriteSheet::setAngle(string name, float tangle){
    
    // store angle
    sprites[name].angle = tangle;
    
    // first index    
    int thisIndex = sprites[name].meshIndex;
    
    // angle rotation point
    ofVec3f anchor = sprites[name].anchor;
    
    for(int i=0; i<6; i++){
        
        int index = thisIndex + i;
        
        ofVec3f tempvec = mesh.getVertex(index);
        
        tempvec.rotate(tangle, anchor, ofVec3f(0,0,1));
        
        mesh.setVertex(index, tempvec);
    }
    
}
