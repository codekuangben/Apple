using System;

public enum TMXOrientation
{
    TMXOrientationOrtho,

    TMXOrientationHex,

    TMXOrientationIso,
    
    TMXOrientationStaggered,
}

public enum TMXStagger
{
    TMXStaggerAxis_X,

    TMXStaggerAxis_Y,
}

public enum TMXStaggerIndex
{
    TMXStaggerIndex_Odd,

    TMXStaggerIndex_Even,
}

public class TMXTiledMap
{
    static public TMXTiledMap create(ref String tmxFile)
    {
        TMXTiledMap ret = new TMXTiledMap();
        if (ret.initWithTMXFile(tmxFile))
        {
            return ret;
        }

        return null;
    }

    static public TMXTiledMap createWithXML(ref String tmxString, ref String resourcePath)
{
    TMXTiledMap ret = new TMXTiledMap();
    if (ret.initWithXML(tmxString, resourcePath))
    {
        return ret;
    }

    return null;
}

public TMXLayer getLayer(ref String layerName)
{
    for (auto & child : _children)
    {
        TMXLayer layer = child as TMXLayer;
        if (layer)
        {
            if (layerName.compare(layer.getLayerName()) == 0)
            {
                return layer;
            }
        }
    }

    // layer not found
    return null;
}

public TMXLayer layerNamed(ref String layerName)
    {
        return getLayer(layerName);
    }


public TMXObjectGroup getObjectGroup(ref String groupName)
{
    for (const auto objectGroup : _objectGroups)
    {
        if (objectGroup && objectGroup->getGroupName() == groupName)
        {
            return objectGroup;
        }
    }

    // objectGroup not found
    return null;
}

public TMXObjectGroup objectGroupNamed(ref String groupName)
    {
        return getObjectGroup(groupName);
    }


   public Value getProperty(ref String propertyName)
{
    if (_properties.find(propertyName) != _properties.end())
        return _properties.at(propertyName);

    return Value();
}

public Value propertyNamed(ref String propertyName)
    {
        return getProperty(propertyName);
    }

    public Value getPropertiesForGID(int GID)
{
    if (_tileProperties.find(GID) != _tileProperties.end())
        return _tileProperties.at(GID);

    return Value();
}


public Value propertiesForGID(int GID)
    {
        return getPropertiesForGID(GID);
    }


    public bool getPropertiesForGID(int GID, ref Value value)
{
    if (_tileProperties.find(GID) != _tileProperties.end())
    {
        *value = &_tileProperties.at(GID);
        return true;
    }
    else
    {
        return false;
    }
}

public ref Size getMapSize()
    {
        return _mapSize;
    }
    
    public void setMapSize(ref Size& mapSize) 
        { 
        _mapSize = mapSize; 
}

public Size getTileSize()
    {
        return _tileSize;
    }
    
    public void setTileSize(ref Size tileSize)
    {
        _tileSize = tileSize;
    }

public int getMapOrientation()
    {
        return _mapOrientation;
    }
    
    public void setMapOrientation(int mapOrientation)
    {
        _mapOrientation = mapOrientation;
    }

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


public ValueMap& getProperties()
{
    return _properties;
}


public void setProperties(const ValueMap& properties)
{
        _properties = properties;
    }


public virtual String getDescription() const override
    {
    return StringUtils::format("<TMXTiledMap | Tag = %d, Layers = %d", _tag, static_cast<int>(_children.size()));
}

    public int getLayerNum()
{
    return _tmxLayerNum;
}

public String getResourceFile()
{
    return _tmxFile;
}


    public TMXTiledMap()
{
    _mapSize(Size::ZERO)
    ,_tileSize(Size::ZERO)
    ,_tmxFile("")
    , _tmxLayerNum(0)
}

public virtual ~TMXTiledMap()
{

}

/** initializes a TMX Tiled Map with a TMX file */
public bool initWithTMXFile(ref String tmxFile)
{
    CCASSERT(tmxFile.size() > 0, "TMXTiledMap: tmx file should not be empty");

    _tmxFile = tmxFile;

    setContentSize(Size::ZERO);

    TMXMapInfo* mapInfo = TMXMapInfo::create(tmxFile);

    if (!mapInfo)
    {
        return false;
    }
    CCASSERT(!mapInfo->getTilesets().empty(), "TMXTiledMap: Map not found. Please check the filename.");
    buildWithMapInfo(mapInfo);

    return true;
}


/** initializes a TMX Tiled Map with a TMX formatted XML string and a path to TMX resources */
public bool initWithXML(ref String tmxString, ref String resourcePath)
{
    _tmxFile = tmxString;

    setContentSize(Size::ZERO);

    TMXMapInfo* mapInfo = TMXMapInfo::createWithXML(tmxString, resourcePath);

    CCASSERT(!mapInfo->getTilesets().empty(), "TMXTiledMap: Map not found. Please check the filename.");
    buildWithMapInfo(mapInfo);

    return true;
}

protected TMXLayer parseLayer(TMXLayerInfo layerInfo, TMXMapInfo mapInfo)
{
    TMXTilesetInfo* tileset = tilesetForLayer(layerInfo, mapInfo);
    if (tileset == nullptr)
        return nullptr;

    TMXLayer* layer = TMXLayer::create(tileset, layerInfo, mapInfo);

    if (nullptr != layer)
    {
        // tell the layerinfo to release the ownership of the tiles map.
        layerInfo->_ownTiles = false;
        layer->setupTiles();
    }

    return layer;
}

protected TMXTilesetInfo tilesetForLayer(TMXLayerInfo layerInfo, TMXMapInfo mapInfo)
{
    auto height = static_cast<uint32_t>(layerInfo->_layerSize.height);
    auto width = static_cast<uint32_t>(layerInfo->_layerSize.width);
    auto & tilesets = mapInfo->getTilesets();

    for (auto iter = tilesets.crbegin(), end = tilesets.crend(); iter != end; ++iter)
    {
        TMXTilesetInfo* tileset = *iter;

        if (tileset)
        {
            for (uint32_t y = 0; y < height; y++)
            {
                for (uint32_t x = 0; x < width; x++)
                {
                    auto pos = x + width * y;
                    auto gid = layerInfo->_tiles[pos];

                    // FIXME:: gid == 0 --> empty tile
                    if (gid != 0)
                    {
                        // Optimization: quick return
                        // if the layer is invalid (more than 1 tileset per layer)
                        // an CCAssert will be thrown later
                        if (tileset->_firstGid < 0 ||
                            (gid & kTMXFlippedMask) >= static_cast<uint32_t>(tileset->_firstGid))
                            return tileset;
                    }
                }
            }
        }
    }

    // If all the tiles are 0, return empty tileset
    CCLOG("cocos2d: Warning: TMX Layer '%s' has no tiles", layerInfo->_name.c_str());

    return nullptr;
}

protected void buildWithMapInfo(TMXMapInfo mapInfo)
{
    _mapSize = mapInfo->getMapSize();
    _tileSize = mapInfo->getTileSize();
    _mapOrientation = mapInfo->getOrientation();

    _objectGroups = mapInfo->getObjectGroups();

    _properties = mapInfo->getProperties();

    _tileProperties = mapInfo->getTileProperties();

    int idx = 0;

    auto & layers = mapInfo->getLayers();
    for (const auto &layerInfo : layers) {
        if (layerInfo->_visible)
        {
            TMXLayer* child = parseLayer(layerInfo, mapInfo);
            if (child == nullptr)
            {
                idx++;
                continue;
            }
            addChild(child, idx, idx);
            // update content size with the max size
            const Size&childSize = child->getContentSize();
            Size currentSize = this->getContentSize();
            currentSize.width = std::max(currentSize.width, childSize.width);
            currentSize.height = std::max(currentSize.height, childSize.height);
            this->setContentSize(currentSize);

            idx++;
        }
    }
    _tmxLayerNum = idx;
}


/** the map's size property measured in tiles */
protected Size _mapSize;
/** the tiles's size property measured in pixels */
protected Size _tileSize;
/** map orientation */
protected int _mapOrientation;
/** object groups */
protected Vector<TMXObjectGroup*> _objectGroups;
/** properties */
protected ValueMap _properties;

//! tile properties
protected ValueMapIntKey _tileProperties;

protected std::string _tmxFile;
protected int _tmxLayerNum;

static protected const int TMXLayerTag = 32768;
}