

#include "ofxSpriteSheetLoader.h"

// --------------------------------------------------------------------------------------
ofxSpriteSheetLoader::ofxSpriteSheetLoader() {
}


// --------------------------------------------------------------------------------------
 void ofxSpriteSheetLoader::loadFromTexturePackerXml(string file){
    
    
    bool loadOK = loadFile(file);
    ofLog( OF_LOG_WARNING, "xml loaded %s ok=%i\n", file.c_str(), (int)loadOK);

    
    
}
