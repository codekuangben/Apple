using System;

public enum TMXLayerAttrib
{
    TMXLayerAttribNone = 1 << 0,
    TMXLayerAttribBase64 = 1 << 1,
    TMXLayerAttribGzip = 1 << 2,
    TMXLayerAttribZlib = 1 << 3,
    TMXLayerAttribCSV = 1 << 4,
}

public enum TMXProperty
{
    TMXPropertyNone,
    TMXPropertyMap,
    TMXPropertyLayer,
    TMXPropertyObjectGroup,
    TMXPropertyObject,
    TMXPropertyTile
}

public enum TMXTileFlags
{
    kTMXTileHorizontalFlag  = 0x80000000,
    kTMXTileVerticalFlag    = 0x40000000,
    kTMXTileDiagonalFlag    = 0x20000000,
    kTMXFlipedAll           = (kTMXTileHorizontalFlag|kTMXTileVerticalFlag|kTMXTileDiagonalFlag),
    kTMXFlippedMask         = ~(kTMXFlipedAll)
}

public class TMXLayerInfo
{
    public TMXLayerInfo()
{
    _name = "";
    _tiles = null;
    _ownTiles = true;
}


public void setProperties(ValueMap properties)
{
    _properties = var;
}

public ValueMap getProperties()
{
    return _properties;
}

public ValueMap _properties;
public String         _name;
public Size _layerSize;
public uint32_t            *_tiles;
public bool _visible;
public byte       _opacity;
public bool _ownTiles;
public Vec2 _offset;
}

public class TMXTilesetInfo
{
    public String     _name;
public int _firstGid;
public Size _tileSize;
public int _spacing;
public int _margin;
public Vec2 _tileOffset;
//! filename containing the tiles (should be spritesheet / texture atlas)
public String _sourceImage;
//! size in pixels of the image
public Size _imageSize;
public String _originSourceImage;

/**
 * @js ctor
 */
public TMXTilesetInfo()
{
        _firstGid = 0;
        _tileSize = Size::ZERO;
        _spacing = 0;
    _margin = 0;
        _imageSize = Size::ZERO;
}

public Rect getRectForGID(uint gid)
{
    Rect rect;
    rect.size = _tileSize;
    gid &= kTMXFlippedMask;
    gid = gid - _firstGid;
    // max_x means the column count in tile map
    // in the origin:
    // max_x = (int)((_imageSize.width - _margin*2 + _spacing) / (_tileSize.width + _spacing));
    // but in editor "Tiled", _margin variable only effect the left side
    // for compatible with "Tiled", change the max_x calculation
    int max_x = (int)((_imageSize.width - _margin + _spacing) / (_tileSize.width + _spacing));

    rect.origin.x = (gid % max_x) * (_tileSize.width + _spacing) + _margin;
    rect.origin.y = (gid / max_x) * (_tileSize.height + _spacing) + _margin;
    return rect;
}
}

public class TMXMapInfo
{    
    /** creates a TMX Format with a tmx file */
    public static TMXMapInfo create(ref String tmxFile)
{
    TMXMapInfo ret = new TMXMapInfo();
    if (ret.initWithTMXFile(tmxFile))
    {
        return ret;
    }

    return null;
}
/** creates a TMX Format with an XML string and a TMX resource path */
public static TMXMapInfo createWithXML(ref String tmxString, ref String resourcePath)
{
    TMXMapInfo ret = new TMXMapInfo();
    if (ret.initWithXML(tmxString, resourcePath))
    {
        return ret;
    }
    return null;
}

public TMXMapInfo()
{
        _orientation = TMXOrientationOrtho;
 _staggerAxis = TMXStaggerAxis_Y;
 _staggerIndex = TMXStaggerIndex_Even;
 _hexSideLength = 0;
 _parentElement = 0;
 _parentGID = 0;
 _mapSize = Size::ZERO;
 _tileSize = Size::ZERO;
 _layerAttribs = 0;
 _storingCharacters = false;
 _xmlTileIndex = 0;
 _currentFirstGID = -1;
 _recordFirstGID = true;
    }

public bool initWithTMXFile(ref String tmxFile)
{
    internalInit(tmxFile, "");
    return parseXMLFile(_TMXFileName);
}
/** initializes a TMX format with an XML string and a TMX resource path */
public bool initWithXML(ref String tmxString, ref String resourcePath)
{
    internalInit("", resourcePath);
    return parseXMLString(tmxString);
}
/** initializes parsing of an XML file, either a tmx (Map) file or tsx (Tileset) file */
public bool parseXMLFile(ref String xmlFilename)
{
    size_t len = xmlString.size();
    if (len <= 0)
        return false;

    SAXParser parser;

    if (false == parser.init("UTF-8"))
    {
        return false;
    }

    parser.setDelegator(this);

    return parser.parse(xmlString.c_str(), len);
}
/* initializes parsing of an XML string, either a tmx (Map) string or tsx (Tileset) string */
public bool parseXMLString(ref String xmlString)
{
    SAXParser parser;

    if (false == parser.init("UTF-8"))
    {
        return false;
    }

    parser.setDelegator(this);

    return parser.parse(FileUtils::getInstance()->fullPathForFilename(xmlFilename));
}

public ValueMapIntKey& getTileProperties()
    {
        return _tileProperties;
    }

public void setTileProperties(const ValueMapIntKey& tileProperties) 
        {
        _tileProperties = tileProperties;
    }

/// map orientation
public int getOrientation()
{
    return _orientation;
}

    public void setOrientation(int orientation)
{
    _orientation = orientation;
}

/// map staggeraxis
public int getStaggerAxis()
{
    return _staggerAxis;
}

    public void setStaggerAxis(int staggerAxis)
{
    _staggerAxis = staggerAxis;
}

/// map stagger index
public int getStaggerIndex()
{
    return _staggerIndex;
}

    public void setStaggerIndex(int staggerIndex)
{
    _staggerIndex = staggerIndex;
}

/// map hexsidelength
public int getHexSideLength()
{
    return _hexSideLength;
}

    public void setHexSideLength(int hexSideLength)
{
    _hexSideLength = hexSideLength;
}

/// map width & height
public const Size& getMapSize()
{
    return _mapSize;
}

public void setMapSize(const Size& mapSize)
{
    _mapSize = mapSize;
}

/// tiles width & height
public const Size& getTileSize()
{
    return _tileSize;
}

    public void setTileSize(const Size& tileSize)
{
    _tileSize = tileSize;
}

/// Layers
public const Vector<TMXLayerInfo*>& getLayers()
{
    return _layers;
}

    public Vector<TMXLayerInfo*>& getLayers()
{
    return _layers;
}

public void setLayers(const Vector<TMXLayerInfo*>& layers)
{
        _layers = layers;
    }

/// tilesets
public const Vector<TMXTilesetInfo*>& getTilesets()
{
    return _tilesets;
}

    public Vector<TMXTilesetInfo*>& getTilesets()
{
    return _tilesets;
}

public void setTilesets(const Vector<TMXTilesetInfo*>& tilesets)
{
        _tilesets = tilesets;
    }

/// ObjectGroups
public const Vector<TMXObjectGroup*>& getObjectGroups()
{
    return _objectGroups;
}

   public Vector<TMXObjectGroup*>& getObjectGroups()
{
    return _objectGroups;
}

public void setObjectGroups(const Vector<TMXObjectGroup*>& groups)
{
        _objectGroups = groups;
    }

/// parent element
public int getParentElement()
{
    return _parentElement;
}

    public void setParentElement(int element)
{
    _parentElement = element;
}

/// parent GID
public int getParentGID()
{
    return _parentGID;
}

    public void setParentGID(int gid)
{
    _parentGID = gid;
}

/// layer attribs
public int getLayerAttribs()
{
    return _layerAttribs;
}

    public void setLayerAttribs(int layerAttribs)
{
    _layerAttribs = layerAttribs;
}

/// is storing characters?
public bool isStoringCharacters()
{
    return _storingCharacters;
}

    public bool getStoringCharacters()
{
    return isStoringCharacters();
}

    public void setStoringCharacters(bool storingCharacters)
{
    _storingCharacters = storingCharacters;
}

/// properties
public ValueMap& getProperties()
{
    return _properties;
}

    public ValueMap& getProperties()
{
    return _properties;
}

public void setProperties(ValueMap& properties)
{
        _properties = properties;
    }

// implement pure virtual methods of SAXDelegator
/**
 * @js NA
 * @lua NA
 */
public void startElement(void *ctx, const char *name, const char **atts)
{
    TMXMapInfo* tmxMapInfo = this;
    std::string elementName = name;
    ValueMap attributeDict;
    if (atts && atts[0])
    {
        for (int i = 0; atts[i]; i += 2)
        {
            std::string key = atts[i];
            std::string value = atts[i + 1];
            attributeDict.emplace(key, Value(value));
        }
    }
    if (elementName == "map")
    {
        std::string version = attributeDict["version"].asString();
        if (version != "1.0")
        {
            CCLOG("cocos2d: TMXFormat: Unsupported TMX version: %s", version.c_str());
        }
        std::string orientationStr = attributeDict["orientation"].asString();
        if (orientationStr == "orthogonal")
        {
            tmxMapInfo->setOrientation(TMXOrientationOrtho);
        }
        else if (orientationStr == "isometric")
        {
            tmxMapInfo->setOrientation(TMXOrientationIso);
        }
        else if (orientationStr == "hexagonal")
        {
            tmxMapInfo->setOrientation(TMXOrientationHex);
        }
        else if (orientationStr == "staggered")
        {
            tmxMapInfo->setOrientation(TMXOrientationStaggered);
        }
        else
        {
            CCLOG("cocos2d: TMXFomat: Unsupported orientation: %d", tmxMapInfo->getOrientation());
        }

        std::string staggerAxisStr = attributeDict["staggeraxis"].asString();
        if (staggerAxisStr == "x")
        {
            tmxMapInfo->setStaggerAxis(TMXStaggerAxis_X);
        }
        else if (staggerAxisStr == "y")
        {
            tmxMapInfo->setStaggerAxis(TMXStaggerAxis_Y);
        }

        std::string staggerIndex = attributeDict["staggerindex"].asString();
        if (staggerIndex == "odd")
        {
            tmxMapInfo->setStaggerIndex(TMXStaggerIndex_Odd);
        }
        else if (staggerIndex == "even")
        {
            tmxMapInfo->setStaggerIndex(TMXStaggerIndex_Even);
        }


        float hexSideLength = attributeDict["hexsidelength"].asFloat();
        tmxMapInfo->setHexSideLength(hexSideLength);

        Size s;
        s.width = attributeDict["width"].asFloat();
        s.height = attributeDict["height"].asFloat();
        tmxMapInfo->setMapSize(s);

        s.width = attributeDict["tilewidth"].asFloat();
        s.height = attributeDict["tileheight"].asFloat();
        tmxMapInfo->setTileSize(s);



        // The parent element is now "map"
        tmxMapInfo->setParentElement(TMXPropertyMap);
    }
    else if (elementName == "tileset")
    {
        // If this is an external tileset then start parsing that
        std::string externalTilesetFilename = attributeDict["source"].asString();
        if (externalTilesetFilename != "")
        {
            _externalTilesetFilename = externalTilesetFilename;

            // Tileset file will be relative to the map file. So we need to convert it to an absolute path
            if (_TMXFileName.find_last_of("/") != string::npos)
            {
                string dir = _TMXFileName.substr(0, _TMXFileName.find_last_of("/") + 1);
                externalTilesetFilename = dir + externalTilesetFilename;
            }
            else
            {
                externalTilesetFilename = _resources + "/" + externalTilesetFilename;
            }
            externalTilesetFilename = FileUtils::getInstance()->fullPathForFilename(externalTilesetFilename);

            _currentFirstGID = attributeDict["firstgid"].asInt();
            if (_currentFirstGID < 0)
            {
                _currentFirstGID = 0;
            }
            _recordFirstGID = false;

            tmxMapInfo->parseXMLFile(externalTilesetFilename);
        }
        else
        {
            TMXTilesetInfo* tileset = new (std::nothrow) TMXTilesetInfo();
            tileset->_name = attributeDict["name"].asString();

            if (_recordFirstGID)
            {
                // unset before, so this is tmx file.
                tileset->_firstGid = attributeDict["firstgid"].asInt();

                if (tileset->_firstGid < 0)
                {
                    tileset->_firstGid = 0;
                }
            }
            else
            {
                tileset->_firstGid = _currentFirstGID;
                _currentFirstGID = 0;
            }

            tileset->_spacing = attributeDict["spacing"].asInt();
            tileset->_margin = attributeDict["margin"].asInt();
            Size s;
            s.width = attributeDict["tilewidth"].asFloat();
            s.height = attributeDict["tileheight"].asFloat();
            tileset->_tileSize = s;

            tmxMapInfo->getTilesets().pushBack(tileset);
            tileset->release();
        }
    }
    else if (elementName == "tile")
    {
        if (tmxMapInfo->getParentElement() == TMXPropertyLayer)
        {
            TMXLayerInfo* layer = tmxMapInfo->getLayers().back();
            Size layerSize = layer->_layerSize;
            uint32_t gid = static_cast<uint32_t>(attributeDict["gid"].asUnsignedInt());
            int tilesAmount = layerSize.width * layerSize.height;

            if (_xmlTileIndex < tilesAmount)
            {
                layer->_tiles[_xmlTileIndex++] = gid;
            }
        }
        else
        {
            TMXTilesetInfo* info = tmxMapInfo->getTilesets().back();
            tmxMapInfo->setParentGID(info->_firstGid + attributeDict["id"].asInt());
            tmxMapInfo->getTileProperties()[tmxMapInfo->getParentGID()] = Value(ValueMap());
            tmxMapInfo->setParentElement(TMXPropertyTile);
        }
    }
    else if (elementName == "layer")
    {
        TMXLayerInfo* layer = new (std::nothrow) TMXLayerInfo();
        layer->_name = attributeDict["name"].asString();

        Size s;
        s.width = attributeDict["width"].asFloat();
        s.height = attributeDict["height"].asFloat();
        layer->_layerSize = s;

        Value & visibleValue = attributeDict["visible"];
        layer->_visible = visibleValue.isNull() ? true : visibleValue.asBool();

        Value & opacityValue = attributeDict["opacity"];
        layer->_opacity = opacityValue.isNull() ? 255 : (unsigned char)(255.0f * opacityValue.asFloat());

        float x = attributeDict["x"].asFloat();
        float y = attributeDict["y"].asFloat();
        layer->_offset.set(x, y);

        tmxMapInfo->getLayers().pushBack(layer);
        layer->release();

        // The parent element is now "layer"
        tmxMapInfo->setParentElement(TMXPropertyLayer);
    }
    else if (elementName == "objectgroup")
    {
        TMXObjectGroup* objectGroup = new (std::nothrow) TMXObjectGroup();
        objectGroup->setGroupName(attributeDict["name"].asString());
        Vec2 positionOffset;
        positionOffset.x = attributeDict["x"].asFloat() * tmxMapInfo->getTileSize().width;
        positionOffset.y = attributeDict["y"].asFloat() * tmxMapInfo->getTileSize().height;
        objectGroup->setPositionOffset(positionOffset);

        tmxMapInfo->getObjectGroups().pushBack(objectGroup);
        objectGroup->release();

        // The parent element is now "objectgroup"
        tmxMapInfo->setParentElement(TMXPropertyObjectGroup);
    }
    else if (elementName == "tileoffset")
    {
        TMXTilesetInfo* tileset = tmxMapInfo->getTilesets().back();

        double tileOffsetX = attributeDict["x"].asDouble();

        double tileOffsetY = attributeDict["y"].asDouble();

        tileset->_tileOffset = Vec2(tileOffsetX, tileOffsetY);

    }
    else if (elementName == "image")
    {
        TMXTilesetInfo* tileset = tmxMapInfo->getTilesets().back();

        // build full path
        std::string imagename = attributeDict["source"].asString();
        tileset->_originSourceImage = imagename;

        if (_TMXFileName.find_last_of("/") != string::npos)
        {
            string dir = _TMXFileName.substr(0, _TMXFileName.find_last_of("/") + 1);
            tileset->_sourceImage = dir + imagename;
        }
        else
        {
            tileset->_sourceImage = _resources + (_resources.size() ? "/" : "") + imagename;
        }
    }
    else if (elementName == "data")
    {
        std::string encoding = attributeDict["encoding"].asString();
        std::string compression = attributeDict["compression"].asString();

        if (encoding == "")
        {
            tmxMapInfo->setLayerAttribs(tmxMapInfo->getLayerAttribs() | TMXLayerAttribNone);

            TMXLayerInfo* layer = tmxMapInfo->getLayers().back();
            Size layerSize = layer->_layerSize;
            int tilesAmount = layerSize.width * layerSize.height;

            uint32_t* tiles = (uint32_t*)malloc(tilesAmount * sizeof(uint32_t));
            // set all value to 0
            memset(tiles, 0, tilesAmount * sizeof(int));

            layer->_tiles = tiles;
        }
        else if (encoding == "base64")
        {
            int layerAttribs = tmxMapInfo->getLayerAttribs();
            tmxMapInfo->setLayerAttribs(layerAttribs | TMXLayerAttribBase64);
            tmxMapInfo->setStoringCharacters(true);

            if (compression == "gzip")
            {
                layerAttribs = tmxMapInfo->getLayerAttribs();
                tmxMapInfo->setLayerAttribs(layerAttribs | TMXLayerAttribGzip);
            }
            else
            if (compression == "zlib")
            {
                layerAttribs = tmxMapInfo->getLayerAttribs();
                tmxMapInfo->setLayerAttribs(layerAttribs | TMXLayerAttribZlib);
            }
            CCASSERT(compression == "" || compression == "gzip" || compression == "zlib", "TMX: unsupported compression method");
        }
        else if (encoding == "csv")
        {
            int layerAttribs = tmxMapInfo->getLayerAttribs();
            tmxMapInfo->setLayerAttribs(layerAttribs | TMXLayerAttribCSV);
            tmxMapInfo->setStoringCharacters(true);
        }
    }
    else if (elementName == "object")
    {
        TMXObjectGroup* objectGroup = tmxMapInfo->getObjectGroups().back();

        // The value for "type" was blank or not a valid class name
        // Create an instance of TMXObjectInfo to store the object and its properties
        ValueMap dict;
        // Parse everything automatically
        const char* keys[] = { "name", "type", "width", "height", "gid", "id" };

        for (const auto&key : keys)
        {
            Value value = attributeDict[key];
            dict[key] = value;
        }

        // But X and Y since they need special treatment
        // X
        int x = attributeDict["x"].asInt();
        // Y
        int y = attributeDict["y"].asInt();

        Vec2 p(x + objectGroup->getPositionOffset().x, _mapSize.height * _tileSize.height - y - objectGroup->getPositionOffset().y - attributeDict["height"].asInt());
        p = CC_POINT_PIXELS_TO_POINTS(p);
        dict["x"] = Value(p.x);
        dict["y"] = Value(p.y);

        int width = attributeDict["width"].asInt();
        int height = attributeDict["height"].asInt();
        Size s(width, height);
        s = CC_SIZE_PIXELS_TO_POINTS(s);
        dict["width"] = Value(s.width);
        dict["height"] = Value(s.height);

        // Add the object to the objectGroup
        objectGroup->getObjects().push_back(Value(dict));

        // The parent element is now "object"
        tmxMapInfo->setParentElement(TMXPropertyObject);
    }
    else if (elementName == "property")
    {
        if (tmxMapInfo->getParentElement() == TMXPropertyNone)
        {
            CCLOG("TMX tile map: Parent element is unsupported. Cannot add property named '%s' with value '%s'",
                  attributeDict["name"].asString().c_str(), attributeDict["value"].asString().c_str());
        }
        else if (tmxMapInfo->getParentElement() == TMXPropertyMap)
        {
            // The parent element is the map
            Value value = attributeDict["value"];
            std::string key = attributeDict["name"].asString();
            tmxMapInfo->getProperties().emplace(key, value);
        }
        else if (tmxMapInfo->getParentElement() == TMXPropertyLayer)
        {
            // The parent element is the last layer
            TMXLayerInfo* layer = tmxMapInfo->getLayers().back();
            Value value = attributeDict["value"];
            std::string key = attributeDict["name"].asString();
            // Add the property to the layer
            layer->getProperties().emplace(key, value);
        }
        else if (tmxMapInfo->getParentElement() == TMXPropertyObjectGroup)
        {
            // The parent element is the last object group
            TMXObjectGroup* objectGroup = tmxMapInfo->getObjectGroups().back();
            Value value = attributeDict["value"];
            std::string key = attributeDict["name"].asString();
            objectGroup->getProperties().emplace(key, value);
        }
        else if (tmxMapInfo->getParentElement() == TMXPropertyObject)
        {
            // The parent element is the last object
            TMXObjectGroup* objectGroup = tmxMapInfo->getObjectGroups().back();
            ValueMap & dict = objectGroup->getObjects().rbegin()->asValueMap();

            std::string propertyName = attributeDict["name"].asString();
            dict[propertyName] = attributeDict["value"];
        }
        else if (tmxMapInfo->getParentElement() == TMXPropertyTile)
        {
            ValueMap & dict = tmxMapInfo->getTileProperties().at(tmxMapInfo->getParentGID()).asValueMap();

            std::string propertyName = attributeDict["name"].asString();
            dict[propertyName] = attributeDict["value"];
        }
    }
    else if (elementName == "polygon")
    {
        // find parent object's dict and add polygon-points to it
        TMXObjectGroup* objectGroup = _objectGroups.back();
        ValueMap & dict = objectGroup->getObjects().rbegin()->asValueMap();

        // get points value string
        std::string value = attributeDict["points"].asString();
        if (!value.empty())
        {
            ValueVector pointsArray;
            pointsArray.reserve(10);

            // parse points string into a space-separated set of points
            stringstream pointsStream(value);
            string pointPair;
            while (std::getline(pointsStream, pointPair, ' '))
            {
                // parse each point combo into a comma-separated x,y point
                stringstream pointStream(pointPair);
                string xStr, yStr;

                ValueMap pointDict;

                // set x
                if (std::getline(pointStream, xStr, ','))
                {
                    int x = atoi(xStr.c_str()) + (int)objectGroup->getPositionOffset().x;
                    pointDict["x"] = Value(x);
                }

                // set y
                if (std::getline(pointStream, yStr, ','))
                {
                    int y = atoi(yStr.c_str()) + (int)objectGroup->getPositionOffset().y;
                    pointDict["y"] = Value(y);
                }

                // add to points array
                pointsArray.push_back(Value(pointDict));
            }

            dict["points"] = Value(pointsArray);
        }
    }
    else if (elementName == "polyline")
    {
        // find parent object's dict and add polyline-points to it
        TMXObjectGroup* objectGroup = _objectGroups.back();
        ValueMap & dict = objectGroup->getObjects().rbegin()->asValueMap();

        // get points value string
        std::string value = attributeDict["points"].asString();
        if (!value.empty())
        {
            ValueVector pointsArray;
            pointsArray.reserve(10);

            // parse points string into a space-separated set of points
            stringstream pointsStream(value);
            string pointPair;
            while (std::getline(pointsStream, pointPair, ' '))
            {
                // parse each point combo into a comma-separated x,y point
                stringstream pointStream(pointPair);
                string xStr, yStr;

                ValueMap pointDict;

                // set x
                if (std::getline(pointStream, xStr, ','))
                {
                    int x = atoi(xStr.c_str()) + (int)objectGroup->getPositionOffset().x;
                    pointDict["x"] = Value(x);
                }

                // set y
                if (std::getline(pointStream, yStr, ','))
                {
                    int y = atoi(yStr.c_str()) + (int)objectGroup->getPositionOffset().y;
                    pointDict["y"] = Value(y);
                }

                // add to points array
                pointsArray.push_back(Value(pointDict));
            }

            dict["polylinePoints"] = Value(pointsArray);
        }
    }
}
/**
 * @js NA
 * @lua NA
 */
public void endElement(void *ctx, const char *name)
{
    TMXMapInfo* tmxMapInfo = this;
    std::string elementName = name;

    if (elementName == "data")
    {
        if (tmxMapInfo->getLayerAttribs() & TMXLayerAttribBase64)
        {
            tmxMapInfo->setStoringCharacters(false);

            TMXLayerInfo* layer = tmxMapInfo->getLayers().back();

            std::string currentString = tmxMapInfo->getCurrentString();
            unsigned char* buffer;
            auto len = base64Decode((unsigned char *)currentString.c_str(), (unsigned int)currentString.length(), &buffer);
            if (!buffer)
            {
                CCLOG("cocos2d: TiledMap: decode data error");
                return;
            }

            if (tmxMapInfo->getLayerAttribs() & (TMXLayerAttribGzip | TMXLayerAttribZlib))
            {
                unsigned char* deflated = nullptr;
                Size s = layer->_layerSize;
                // int sizeHint = s.width * s.height * sizeof(uint32_t);
                ssize_t sizeHint = s.width * s.height * sizeof(unsigned int);

                ssize_t CC_UNUSED inflatedLen = ZipUtils::inflateMemoryWithHint(buffer, len, &deflated, sizeHint);
                CCASSERT(inflatedLen == sizeHint, "inflatedLen should be equal to sizeHint!");

                free(buffer);
                buffer = nullptr;

                if (!deflated)
                {
                    CCLOG("cocos2d: TiledMap: inflate data error");
                    return;
                }

                layer->_tiles = reinterpret_cast<uint32_t*>(deflated);
            }
            else
            {
                layer->_tiles = reinterpret_cast<uint32_t*>(buffer);
            }

            tmxMapInfo->setCurrentString("");
        }
        else if (tmxMapInfo->getLayerAttribs() & TMXLayerAttribCSV)
        {
            unsigned char* buffer;

            TMXLayerInfo* layer = tmxMapInfo->getLayers().back();

            tmxMapInfo->setStoringCharacters(false);
            std::string currentString = tmxMapInfo->getCurrentString();

            vector<string> gidTokens;
            istringstream filestr(currentString);
            string sRow;
            while (getline(filestr, sRow, '\n'))
            {
                string sGID;
                istringstream rowstr(sRow);
                while (getline(rowstr, sGID, ','))
                {
                    gidTokens.push_back(sGID);
                }
            }

            // 32-bits per gid
            buffer = (unsigned char*)malloc(gidTokens.size() * 4);
            if (!buffer)
            {
                CCLOG("cocos2d: TiledMap: CSV buffer not allocated.");
                return;
            }

            uint32_t* bufferPtr = reinterpret_cast<uint32_t*>(buffer);
            for (auto gidToken : gidTokens)
            {
                auto tileGid = (uint32_t)strtoul(gidToken.c_str(), nullptr, 10);
                *bufferPtr = tileGid;
                bufferPtr++;
            }

            layer->_tiles = reinterpret_cast<uint32_t*>(buffer);

            tmxMapInfo->setCurrentString("");
        }
        else if (tmxMapInfo->getLayerAttribs() & TMXLayerAttribNone)
        {
            _xmlTileIndex = 0;
        }
    }
    else if (elementName == "map")
    {
        // The map element has ended
        tmxMapInfo->setParentElement(TMXPropertyNone);
    }
    else if (elementName == "layer")
    {
        // The layer element has ended
        tmxMapInfo->setParentElement(TMXPropertyNone);
    }
    else if (elementName == "objectgroup")
    {
        // The objectgroup element has ended
        tmxMapInfo->setParentElement(TMXPropertyNone);
    }
    else if (elementName == "object")
    {
        // The object element has ended
        tmxMapInfo->setParentElement(TMXPropertyNone);
    }
    else if (elementName == "tileset")
    {
        _recordFirstGID = true;
    }
}
/**
 * @js NA
 * @lua NA
 */
public void textHandler(void *ctx, const char *ch, size_t len)
{
    TMXMapInfo* tmxMapInfo = this;
    std::string text(ch, 0, len);

    if (tmxMapInfo->isStoringCharacters())
    {
        std::string currentString = tmxMapInfo->getCurrentString();
        currentString += text;
        tmxMapInfo->setCurrentString(currentString);
    }
}

public const std::string& getCurrentString()
{
    return _currentString;
}

    public void setCurrentString(ref String currentString)
{
    _currentString = currentString;
}

public String getTMXFileName()
{
    return _TMXFileName;
}

    public void setTMXFileName(ref String fileName)
{
    _TMXFileName = fileName;
}

public String getExternalTilesetFileName()
{
    return _externalTilesetFilename;
}

    protected void internalInit(ref String tmxFileName, ref String resourcePath)
{
    if (!tmxFileName.empty())
    {
        _TMXFileName = FileUtils::getInstance()->fullPathForFilename(tmxFileName);
    }

    if (!resourcePath.empty())
    {
        _resources = resourcePath;
    }

    _objectGroups.reserve(4);

    // tmp vars
    _currentString = "";
    _storingCharacters = false;
    _layerAttribs = TMXLayerAttribNone;
    _parentElement = TMXPropertyNone;
    _currentFirstGID = -1;
}

/// map orientation
protected int _orientation;
///map staggerAxis
protected int _staggerAxis;
///map staggerIndex
protected int    _staggerIndex;
///map hexsidelength
protected int _hexSideLength;
/// map width & height
protected Size _mapSize;
/// tiles width & height
protected Size _tileSize;
/// Layers
protected Vector<TMXLayerInfo*> _layers;
/// tilesets
protected Vector<TMXTilesetInfo*> _tilesets;
/// ObjectGroups
protected Vector<TMXObjectGroup*> _objectGroups;
/// parent element
protected int _parentElement;
/// parent GID
protected int _parentGID;
/// layer attribs
protected int _layerAttribs;
/// is storing characters?
protected bool _storingCharacters;
/// properties
protected ValueMap _properties;
//! xml format tile index
protected int _xmlTileIndex;

//! tmx filename
protected String _TMXFileName;
// tmx resource path
protected String _resources;
//! current string
protected String _currentString;
//! tile properties
protected ValueMapIntKey _tileProperties;
protected int _currentFirstGID;
protected bool _recordFirstGID;
protected String _externalTilesetFilename;
}