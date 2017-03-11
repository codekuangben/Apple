public class CC_DLL TMXLayer
{
    // TMXLayer - atlasIndex and Z
static int compareInts(const void* a, const void* b)
{
    const int ia = *(int*)a;
    const int ib = *(int*)b;
    return (ia - ib);
}

/** Creates a TMXLayer with an tileset info, a layer info and a map info.
 *
 * @param tilesetInfo An tileset info.
 * @param layerInfo A layer info.
 * @param mapInfo A map info.
 * @return An autorelease object.
 */
static public TMXLayer create(TMXTilesetInfo tilesetInfo, TMXLayerInfo layerInfo, TMXMapInfo mapInfo)
{
    TMXLayer* ret = new (std::nothrow) TMXLayer();
    if (ret->initWithTilesetInfo(tilesetInfo, layerInfo, mapInfo))
    {
        ret->autorelease();
        return ret;
    }
    CC_SAFE_DELETE(ret);
    return nullptr;
}
/**
 * @js ctor
 */
public TMXLayer()
{
    :_layerName("")
,_opacity(0)
,_vertexZvalue(0)
,_useAutomaticVertexZ(false)
,_reusedTile(nullptr)
,_atlasIndexArray(nullptr)
,_contentScaleFactor(1.0f)
,_layerSize(Size::ZERO)
,_mapTileSize(Size::ZERO)
,_tiles(nullptr)
,_tileSet(nullptr)
,_layerOrientation(TMXOrientationOrtho)
,_staggerAxis(TMXStaggerAxis_Y)
,_staggerIndex(TMXStaggerIndex_Even)
,_hexSideLength(0)
}
/**
 * @js NA
 * @lua NA
 */
public virtual ~TMXLayer()
{
    CC_SAFE_RELEASE(_tileSet);
    CC_SAFE_RELEASE(_reusedTile);

    if (_atlasIndexArray)
    {
        ccCArrayFree(_atlasIndexArray);
        _atlasIndexArray = nullptr;
    }

    CC_SAFE_FREE(_tiles);
}

/** Initializes a TMXLayer with a tileset info, a layer info and a map info.
 *
 * @param tilesetInfo An tileset info.
 * @param layerInfo A layer info.
 * @param mapInfo A map info.
 * @return If initializes successfully, it will return true.
 */
public bool initWithTilesetInfo(TMXTilesetInfo *tilesetInfo, TMXLayerInfo *layerInfo, TMXMapInfo *mapInfo)
{
    // FIXME:: is 35% a good estimate ?
    Size size = layerInfo->_layerSize;
    float totalNumberOfTiles = size.width * size.height;
    float capacity = totalNumberOfTiles * 0.35f + 1; // 35 percent is occupied ?

    Texture2D* texture = nullptr;
    if (tilesetInfo)
    {
        texture = Director::getInstance()->getTextureCache()->addImage(tilesetInfo->_sourceImage);
    }

    if (nullptr == texture)
        return false;

    if (SpriteBatchNode::initWithTexture(texture, static_cast<ssize_t>(capacity)))
    {
        // layerInfo
        _layerName = layerInfo->_name;
        _layerSize = size;
        _tiles = layerInfo->_tiles;
        _opacity = layerInfo->_opacity;
        setProperties(layerInfo->getProperties());
        _contentScaleFactor = Director::getInstance()->getContentScaleFactor();

        // tilesetInfo
        _tileSet = tilesetInfo;
        CC_SAFE_RETAIN(_tileSet);

        // mapInfo
        _mapTileSize = mapInfo->getTileSize();
        _layerOrientation = mapInfo->getOrientation();
        _staggerAxis = mapInfo->getStaggerAxis();
        _staggerIndex = mapInfo->getStaggerIndex();
        _hexSideLength = mapInfo->getHexSideLength();

        // offset (after layer orientation is set);
        Vec2 offset = this->calculateLayerOffset(layerInfo->_offset);
        this->setPosition(CC_POINT_PIXELS_TO_POINTS(offset));

        _atlasIndexArray = ccCArrayNew(totalNumberOfTiles);

        float width = 0;
        float height = 0;
        if (_layerOrientation == TMXOrientationHex)
        {
            if (_staggerAxis == TMXStaggerAxis_X)
            {
                height = _mapTileSize.height * (_layerSize.height + 0.5);
                width = (_mapTileSize.width + _hexSideLength) * ((int)(_layerSize.width / 2)) + _mapTileSize.width * ((int)_layerSize.width % 2);
            }
            else
            {
                width = _mapTileSize.width * (_layerSize.width + 0.5);
                height = (_mapTileSize.height + _hexSideLength) * ((int)(_layerSize.height / 2)) + _mapTileSize.height * ((int)_layerSize.height % 2);
            }
        }
        else
        {
            width = _layerSize.width * _mapTileSize.width;
            height = _layerSize.height * _mapTileSize.height;
        }
        this->setContentSize(CC_SIZE_PIXELS_TO_POINTS(Size(width, height)));

        _useAutomaticVertexZ = false;
        _vertexZvalue = 0;

        return true;
    }
    return false;
}

/** Dealloc the map that contains the tile position from memory.
 * Unless you want to know at runtime the tiles positions, you can safely call this method.
 * If you are going to call layer->tileGIDAt() then, don't release the map.
 */
public void releaseMap()
{
    if (_tiles)
    {
        free(_tiles);
        _tiles = nullptr;
    }

    if (_atlasIndexArray)
    {
        ccCArrayFree(_atlasIndexArray);
        _atlasIndexArray = nullptr;
    }
}

/** Returns the tile (Sprite) at a given a tile coordinate.
 * The returned Sprite will be already added to the TMXLayer. Don't add it again.
 * The Sprite can be treated like any other Sprite: rotated, scaled, translated, opacity, color, etc.
 * You can remove either by calling:
 * - layer->removeChild(sprite, cleanup);
 * - or layer->removeTileAt(Vec2(x,y));
 *
 * @param tileCoordinate A tile coordinate.
 * @return Returns the tile (Sprite) at a given a tile coordinate.
 */
public Sprite* getTileAt(const Vec2& tileCoordinate)
{
    CCASSERT(pos.x < _layerSize.width && pos.y < _layerSize.height && pos.x >= 0 && pos.y >= 0, "TMXLayer: invalid position");
    CCASSERT(_tiles && _atlasIndexArray, "TMXLayer: the tiles map has been released");

    Sprite* tile = nullptr;
    int gid = this->getTileGIDAt(pos);

    // if GID == 0, then no tile is present
    if (gid)
    {
        int z = (int)(pos.x + pos.y * _layerSize.width);
        tile = static_cast<Sprite*>(this->getChildByTag(z));

        // tile not created yet. create it
        if (!tile)
        {
            Rect rect = _tileSet->getRectForGID(gid);
            rect = CC_RECT_PIXELS_TO_POINTS(rect);

            tile = Sprite::createWithTexture(this->getTexture(), rect);
            tile->setBatchNode(this);
            tile->setPosition(getPositionAt(pos));
            tile->setPositionZ((float)getVertexZForPos(pos));
            tile->setAnchorPoint(Vec2::ZERO);
            tile->setOpacity(_opacity);

            ssize_t indexForZ = atlasIndexForExistantZ(z);
            this->addSpriteWithoutQuad(tile, static_cast<int>(indexForZ), z);
        }
    }

    return tile;
}

/**
 * @js NA
 */
public CC_DEPRECATED_ATTRIBUTE Sprite* tileAt(const Vec2& tileCoordinate) { return getTileAt(tileCoordinate); };

/** Returns the tile gid at a given tile coordinate. It also returns the tile flags.
 * This method requires the tile map has not been previously released (eg. don't call [layer releaseMap]).
 * 
 * @param tileCoordinate The tile coordinate.
 * @param flags Tile flags.
 * @return Returns the tile gid at a given tile coordinate. It also returns the tile flags.
 */
public uint32_t getTileGIDAt(const Vec2& tileCoordinate, TMXTileFlags* flags = nullptr)
{
    CCASSERT(pos.x < _layerSize.width && pos.y < _layerSize.height && pos.x >= 0 && pos.y >= 0, "TMXLayer: invalid position");
    CCASSERT(_tiles && _atlasIndexArray, "TMXLayer: the tiles map has been released");

    ssize_t idx = static_cast<int>(((int)pos.x + (int)pos.y * _layerSize.width));
    // Bits on the far end of the 32-bit global tile ID are used for tile flags
    uint32_t tile = _tiles[idx];

    // issue1264, flipped tiles can be changed dynamically
    if (flags)
    {
        *flags = (TMXTileFlags)(tile & kTMXFlipedAll);
    }

    return (tile & kTMXFlippedMask);
}
/**
 * @js NA
 */
public CC_DEPRECATED_ATTRIBUTE uint32_t tileGIDAt(const Vec2& tileCoordinate, TMXTileFlags* flags = nullptr){
        return getTileGIDAt(tileCoordinate, flags);
    }

/** Sets the tile gid (gid = tile global id) at a given tile coordinate.
 * The Tile GID can be obtained by using the method "tileGIDAt" or by using the TMX editor -> Tileset Mgr +1.
 * If a tile is already placed at that position, then it will be removed.
 *
 * @param gid The tile gid.
 * @param tileCoordinate The tile coordinate.
 */
public void setTileGID(uint32_t gid, const Vec2& tileCoordinate)
{
    setTileGID(gid, pos, (TMXTileFlags)0);
}

/** Sets the tile gid (gid = tile global id) at a given tile coordinate.
 * The Tile GID can be obtained by using the method "tileGIDAt" or by using the TMX editor -> Tileset Mgr +1.
 * If a tile is already placed at that position, then it will be removed.
 * Use withFlags if the tile flags need to be changed as well.
 * 
 * @param gid The tile gid.
 * @param tileCoordinate The tile coordinate.
 * @param flags The tile flags.
 */

public void setTileGID(uint32_t gid, const Vec2& tileCoordinate, TMXTileFlags flags)
{
    CCASSERT(pos.x < _layerSize.width && pos.y < _layerSize.height && pos.x >= 0 && pos.y >= 0, "TMXLayer: invalid position");
    CCASSERT(_tiles && _atlasIndexArray, "TMXLayer: the tiles map has been released");
    CCASSERT(gid == 0 || (int)gid >= _tileSet->_firstGid, "TMXLayer: invalid gid");

    TMXTileFlags currentFlags;
    uint32_t currentGID = getTileGIDAt(pos, &currentFlags);

    if (currentGID != gid || currentFlags != flags)
    {
        uint32_t gidAndFlags = gid | flags;

        // setting gid=0 is equal to remove the tile
        if (gid == 0)
        {
            removeTileAt(pos);
        }
        // empty tile. create a new one
        else if (currentGID == 0)
        {
            insertTileForGID(gidAndFlags, pos);
        }
        // modifying an existing tile with a non-empty tile
        else
        {
            int z = (int)pos.x + (int)pos.y * _layerSize.width;
            Sprite* sprite = static_cast<Sprite*>(getChildByTag(z));
            if (sprite)
            {
                Rect rect = _tileSet->getRectForGID(gid);
                rect = CC_RECT_PIXELS_TO_POINTS(rect);

                sprite->setTextureRect(rect, false, rect.size);
                if (flags)
                {
                    setupTileSprite(sprite, sprite->getPosition(), gidAndFlags);
                }
                _tiles[z] = gidAndFlags;
            }
            else
            {
                updateTileForGID(gidAndFlags, pos);
            }
        }
    }
}

/** Removes a tile at given tile coordinate. 
 *
 * @param tileCoordinate The tile coordinate.
 */
public void removeTileAt(const Vec2& tileCoordinate)
{
    CCASSERT(pos.x < _layerSize.width && pos.y < _layerSize.height && pos.x >= 0 && pos.y >= 0, "TMXLayer: invalid position");
    CCASSERT(_tiles && _atlasIndexArray, "TMXLayer: the tiles map has been released");

    int gid = getTileGIDAt(pos);

    if (gid)
    {
        int z = pos.x + pos.y * _layerSize.width;
        ssize_t atlasIndex = atlasIndexForExistantZ(z);

        // remove tile from GID map
        _tiles[z] = 0;

        // remove tile from atlas position array
        ccCArrayRemoveValueAtIndex(_atlasIndexArray, atlasIndex);

        // remove it from sprites and/or texture atlas
        Sprite* sprite = (Sprite*)getChildByTag(z);
        if (sprite)
        {
            SpriteBatchNode::removeChild(sprite, true);
        }
        else
        {
            _textureAtlas->removeQuadAtIndex(atlasIndex);

            // update possible children
            for (const auto &obj : _children) {
                Sprite* child = static_cast<Sprite*>(obj);
                ssize_t ai = child->getAtlasIndex();
                if (ai >= atlasIndex)
                {
                    child->setAtlasIndex(ai - 1);
                }
            }
        }
    }
}

/** Returns the position in points of a given tile coordinate.
 *
 * @param tileCoordinate The tile coordinate.
 * @return The position in points of a given tile coordinate.
 */
public Vec2 getPositionAt(const Vec2& tileCoordinate)
{
    Vec2 ret;
    switch (_layerOrientation)
    {
        case TMXOrientationOrtho:
            ret = getPositionForOrthoAt(pos);
            break;
        case TMXOrientationIso:
            ret = getPositionForIsoAt(pos);
            break;
        case TMXOrientationHex:
            ret = getPositionForHexAt(pos);
            break;
        case TMXOrientationStaggered:
            ret = getPositionForStaggeredAt(pos);
            break;
    }
    ret = CC_POINT_PIXELS_TO_POINTS(ret);
    return ret;
}

/**
* @js NA
*/
public CC_DEPRECATED_ATTRIBUTE Vec2 positionAt(const Vec2& tileCoordinate) { return getPositionAt(tileCoordinate); };

/** Return the value for the specific property name.
 *
 * @param propertyName The specific property name.
 * @return Return the value for the specific property name.
 */
public Value getProperty(const std::string& propertyName)
{
    if (_properties.find(propertyName) != _properties.end())
        return _properties.at(propertyName);

    return Value();
}
/**
* @js NA
*/
public CC_DEPRECATED_ATTRIBUTE Value propertyNamed(const std::string& propertyName) const { return getProperty(propertyName); };

    /** Creates the tiles. */
    public void setupTiles()
{
    // Optimization: quick hack that sets the image size on the tileset
    _tileSet->_imageSize = _textureAtlas->getTexture()->getContentSizeInPixels();

    // By default all the tiles are aliased
    // pros:
    //  - easier to render
    // cons:
    //  - difficult to scale / rotate / etc.
    _textureAtlas->getTexture()->setAliasTexParameters();

    //CFByteOrder o = CFByteOrderGetCurrent();

    // Parse cocos2d properties
    this->parseInternalProperties();

    for (int y = 0; y < _layerSize.height; y++)
    {
        for (int x = 0; x < _layerSize.width; x++)
        {
            int newX = x;
            // fix correct render ordering in Hexagonal maps when stagger axis == x
            if (_staggerAxis == TMXStaggerAxis_X && _layerOrientation == TMXOrientationHex)
            {
                if (_staggerIndex == TMXStaggerIndex_Odd)
                {
                    if (x >= _layerSize.width / 2)
                        newX = (x - std::ceil(_layerSize.width / 2)) * 2 + 1;
                    else
                        newX = x * 2;
                }
                else
                {
                    // TMXStaggerIndex_Even
                    if (x >= static_cast<int>(_layerSize.width / 2))
                        newX = (x - static_cast<int>(_layerSize.width / 2)) * 2;
                    else
                        newX = x * 2 + 1;
                }
            }

            int pos = static_cast<int>(newX + _layerSize.width * y);
            int gid = _tiles[pos];

            // gid are stored in little endian.
            // if host is big endian, then swap
            //if( o == CFByteOrderBigEndian )
            //    gid = CFSwapInt32( gid );
            /* We support little endian.*/

            // FIXME:: gid == 0 --> empty tile
            if (gid != 0)
            {
                this->appendTileForGID(gid, Vec2(newX, y));
            }
        }
    }
}

/** Get the layer name. 
 *
 * @return The layer name.
 */
public const std::string& getLayerName() { return _layerName; }

/** Set the layer name.
 *
 * @param layerName The layer name.
 */
public void setLayerName(const std::string& layerName) { _layerName = layerName; }

/** Size of the layer in tiles.
 *
 * @return Size of the layer in tiles.
 */
public const Size& getLayerSize() const { return _layerSize; }
    
    /** Set size of the layer in tiles.
     *
     * @param size Size of the layer in tiles.
     */
    public void setLayerSize(const Size& size) { _layerSize = size; }

/** Size of the map's tile (could be different from the tile's size).
 *
 * @return The size of the map's tile.
 */
public const Size& getMapTileSize() const { return _mapTileSize; }
    
    /** Set the size of the map's tile.
     *
     * @param size The size of the map's tile.
     */
    public void setMapTileSize(const Size& size) { _mapTileSize = size; }

/** Pointer to the map of tiles.
 * @js NA
 * @lua NA
 * @return Pointer to the map of tiles.
 */
public uint32_t* getTiles() const { return _tiles; };
    
    /** Set a pointer to the map of tiles.
     *
     * @param tiles A pointer to the map of tiles.
     */
    public void setTiles(uint32_t* tiles) { _tiles = tiles; };

/** Tileset information for the layer. 
 *
 * @return Tileset information for the layer.
 */
public TMXTilesetInfo* getTileSet() const { return _tileSet; }
    
    /** Set tileset information for the layer.
     *
     * @param info The tileset information for the layer.
     * @js NA
     */
    public void setTileSet(TMXTilesetInfo* info) {
        CC_SAFE_RETAIN(info);
        CC_SAFE_RELEASE(_tileSet);
        _tileSet = info;
    }

/** Layer orientation, which is the same as the map orientation.
 *
 * @return Layer orientation, which is the same as the map orientation.
 */
public int getLayerOrientation() const { return _layerOrientation; }
    
    /** Set layer orientation, which is the same as the map orientation.
     *
     * @param orientation Layer orientation,which is the same as the map orientation.
     */
    public void setLayerOrientation(int orientation) { _layerOrientation = orientation; }

/** Properties from the layer. They can be added using Tiled.
 *
 * @return Properties from the layer. They can be added using Tiled.
 */
public const ValueMap& getProperties() const { return _properties; }
    
    /** Properties from the layer. They can be added using Tiled.
     *
     * @return Properties from the layer. They can be added using Tiled.
     */
    public ValueMap& getProperties() { return _properties; }

/** Set an Properties from to layer.
 *
 * @param properties It is used to set the layer Properties.
 */
public void setProperties(const ValueMap& properties) {
        _properties = properties;
    }
    //
    // Override
    //
    /** TMXLayer doesn't support adding a Sprite manually.
     @warning addChild(z, tag); is not supported on TMXLayer. Instead of setTileGID.
     */
    public virtual void addChild(Node * child, int zOrder, int tag)
{
    CCASSERT(0, "addChild: is not supported on TMXLayer. Instead use setTileGID:at:/tileAt:");
}
// super method
public void removeChild(Node* child, bool cleanup)
{
    Sprite* sprite = (Sprite*)node;
    // allows removing nil objects
    if (!sprite)
    {
        return;
    }

    CCASSERT(_children.contains(sprite), "Tile does not belong to TMXLayer");

    ssize_t atlasIndex = sprite->getAtlasIndex();
    ssize_t zz = (ssize_t)_atlasIndexArray->arr[atlasIndex];
    _tiles[zz] = 0;
    ccCArrayRemoveValueAtIndex(_atlasIndexArray, atlasIndex);
    SpriteBatchNode::removeChild(sprite, cleanup);
}

/**
* @js NA
*/
public virtual std::string getDescription()
{
    return StringUtils::format("<TMXLayer | tag = %d, size = %d,%d>", _tag, (int)_mapTileSize.width, (int)_mapTileSize.height);
}

protected Vec2 getPositionForIsoAt(const Vec2& pos)
{
    return Vec2(_mapTileSize.width / 2 * (_layerSize.width + pos.x - pos.y - 1),
                             _mapTileSize.height / 2 * ((_layerSize.height * 2 - pos.x - pos.y) - 2));
}
protected Vec2 getPositionForOrthoAt(const Vec2& pos)
{
    return Vec2(pos.x * _mapTileSize.width,
                            (_layerSize.height - pos.y - 1) * _mapTileSize.height);
}

protected Vec2 getPositionForHexAt(const Vec2& pos)
{
    Vec2 xy;
    Vec2 offset = _tileSet->_tileOffset;

    int odd_even = (_staggerIndex == TMXStaggerIndex_Odd) ? 1 : -1;
    switch (_staggerAxis)
    {
        case TMXStaggerAxis_Y:
            {
                float diffX = 0;
                if ((int)pos.y % 2 == 1)
                {
                    diffX = _mapTileSize.width / 2 * odd_even;
                }
                xy = Vec2(pos.x * _mapTileSize.width + diffX + offset.x,
                          (_layerSize.height - pos.y - 1) * (_mapTileSize.height - (_mapTileSize.height - _hexSideLength) / 2) - offset.y);
                break;
            }

        case TMXStaggerAxis_X:
            {
                float diffY = 0;
                if ((int)pos.x % 2 == 1)
                {
                    diffY = _mapTileSize.height / 2 * -odd_even;
                }

                xy = Vec2(pos.x * (_mapTileSize.width - (_mapTileSize.width - _hexSideLength) / 2) + offset.x,
                          (_layerSize.height - pos.y - 1) * _mapTileSize.height + diffY - offset.y);
                break;
            }
    }
    return xy;
}


protected Vec2 getPositionForStaggeredAt(const Vec2& pos)
{
    float diffX = 0;
    if ((int)pos.y % 2 == 1)
    {
        diffX = _mapTileSize.width / 2;
    }
    return Vec2(pos.x * _mapTileSize.width + diffX,
                (_layerSize.height - pos.y - 1) * _mapTileSize.height / 2);
}

protected Vec2 calculateLayerOffset(const Vec2& offset)
{
    Vec2 ret;
    switch (_layerOrientation)
    {
        case TMXOrientationOrtho:
            ret.set(pos.x * _mapTileSize.width, -pos.y * _mapTileSize.height);
            break;
        case TMXOrientationIso:
            ret.set((_mapTileSize.width / 2) * (pos.x - pos.y),
                  (_mapTileSize.height / 2) * (-pos.x - pos.y));
            break;
        case TMXOrientationHex:
            {
                if (_staggerAxis == TMXStaggerAxis_Y)
                {
                    int diffX = (_staggerIndex == TMXStaggerIndex_Even) ? _mapTileSize.width / 2 : 0;
                    ret.set(pos.x * _mapTileSize.width + diffX, -pos.y * (_mapTileSize.height - (_mapTileSize.width - _hexSideLength) / 2));
                }
                else if (_staggerAxis == TMXStaggerAxis_X)
                {
                    int diffY = (_staggerIndex == TMXStaggerIndex_Odd) ? _mapTileSize.height / 2 : 0;
                    ret.set(pos.x * (_mapTileSize.width - (_mapTileSize.width - _hexSideLength) / 2), -pos.y * _mapTileSize.height + diffY);
                }
                break;
            }
        case TMXOrientationStaggered:
            {
                float diffX = 0;
                if ((int)std::abs(pos.y) % 2 == 1)
                {
                    diffX = _mapTileSize.width / 2;
                }
                ret.set(pos.x * _mapTileSize.width + diffX,
                             (-pos.y) * _mapTileSize.height / 2);
            }
            break;
    }
    return ret;
}

/* optimization methods */
protected Sprite* appendTileForGID(uint32_t gid, const Vec2& pos)
{
    if (gid != 0 && (static_cast<int>((gid & kTMXFlippedMask)) - _tileSet->_firstGid) >= 0)
    {
        Rect rect = _tileSet->getRectForGID(gid);
        rect = CC_RECT_PIXELS_TO_POINTS(rect);

        // Z could be just an integer that gets incremented each time it is called.
        // but that wouldn't work on layers with empty tiles.
        // and it is IMPORTANT that Z returns an unique and bigger number than the previous one.
        // since _atlasIndexArray must be ordered because `bsearch` is used to find the GID for
        // a given Z. (github issue #16512)
        intptr_t z = getZForPos(pos);

        Sprite* tile = reusedTileWithRect(rect);

        setupTileSprite(tile, pos, gid);

        // optimization:
        // The difference between appendTileForGID and insertTileforGID is that append is faster, since
        // it appends the tile at the end of the texture atlas
        ssize_t indexForZ = _atlasIndexArray->num;

        // don't add it using the "standard" way.
        insertQuadFromSprite(tile, indexForZ);

        // append should be after addQuadFromSprite since it modifies the quantity values
        ccCArrayInsertValueAtIndex(_atlasIndexArray, (void*)z, indexForZ);

        // Validation for issue #16512
        CCASSERT(_atlasIndexArray->num == 1 ||
                 _atlasIndexArray->arr[_atlasIndexArray->num - 1] > _atlasIndexArray->arr[_atlasIndexArray->num - 2], "Invalid z for _atlasIndexArray");

        return tile;
    }

    return nullptr;
}

protected Sprite* insertTileForGID(uint32_t gid, const Vec2& pos)
{
    if (gid != 0 && (static_cast<int>((gid & kTMXFlippedMask)) - _tileSet->_firstGid) >= 0)
    {
        Rect rect = _tileSet->getRectForGID(gid);
        rect = CC_RECT_PIXELS_TO_POINTS(rect);

        intptr_t z = (intptr_t)((int)pos.x + (int)pos.y * _layerSize.width);

        Sprite* tile = reusedTileWithRect(rect);

        setupTileSprite(tile, pos, gid);

        // get atlas index
        ssize_t indexForZ = atlasIndexForNewZ(static_cast<int>(z));

        // Optimization: add the quad without adding a child
        this->insertQuadFromSprite(tile, indexForZ);

        // insert it into the local atlasindex array
        ccCArrayInsertValueAtIndex(_atlasIndexArray, (void*)z, indexForZ);

        // update possible children

        for (const auto &child : _children) {
            Sprite* sp = static_cast<Sprite*>(child);
            ssize_t ai = sp->getAtlasIndex();
            if (ai >= indexForZ)
            {
                sp->setAtlasIndex(ai + 1);
            }
        }

        _tiles[z] = gid;
        return tile;
    }

    return nullptr;
}
protected Sprite* updateTileForGID(uint32_t gid, const Vec2& pos)
{
    Rect rect = _tileSet->getRectForGID(gid);
    rect = Rect(rect.origin.x / _contentScaleFactor, rect.origin.y / _contentScaleFactor, rect.size.width / _contentScaleFactor, rect.size.height / _contentScaleFactor);
    int z = (int)((int)pos.x + (int)pos.y * _layerSize.width);

    Sprite* tile = reusedTileWithRect(rect);

    setupTileSprite(tile, pos, gid);

    // get atlas index
    ssize_t indexForZ = atlasIndexForExistantZ(z);
    tile->setAtlasIndex(indexForZ);
    tile->setDirty(true);
    tile->updateTransform();
    _tiles[z] = gid;

    return tile;
}

protected intptr_t getZForPos(const Vec2& pos)
{
    intptr_t z = -1;
    // fix correct render ordering in Hexagonal maps when stagger axis == x
    if (_staggerAxis == TMXStaggerAxis_X && _layerOrientation == TMXOrientationHex)
    {
        if (_staggerIndex == TMXStaggerIndex_Odd)
        {
            if (((int)pos.x % 2) == 0)
                z = pos.x / 2 + pos.y * _layerSize.width;
            else
                z = pos.x / 2 + std::ceil(_layerSize.width / 2) + pos.y * _layerSize.width;
        }
        else
        {
            // TMXStaggerIndex_Even
            if (((int)pos.x % 2) == 1)
                z = pos.x / 2 + pos.y * _layerSize.width;
            else
                z = pos.x / 2 + std::floor(_layerSize.width / 2) + pos.y * _layerSize.width;
        }
    }
    else
    {
        z = (pos.x + pos.y * _layerSize.width);
    }

    CCASSERT(z != -1, "Invalid Z");
    return z;
}

/* The layer recognizes some special properties, like cc_vertexz */
protected void parseInternalProperties()
{
    // if cc_vertex=automatic, then tiles will be rendered using vertexz

    auto vertexz = getProperty("cc_vertexz");
    if (!vertexz.isNull())
    {
        std::string vertexZStr = vertexz.asString();
        // If "automatic" is on, then parse the "cc_alpha_func" too
        if (vertexZStr == "automatic")
        {
            _useAutomaticVertexZ = true;
            auto alphaFuncVal = getProperty("cc_alpha_func");
            float alphaFuncValue = alphaFuncVal.asFloat();
            setGLProgramState(GLProgramState::getOrCreateWithGLProgramName(GLProgram::SHADER_NAME_POSITION_TEXTURE_ALPHA_TEST));

            GLint alphaValueLocation = glGetUniformLocation(getGLProgram()->getProgram(), GLProgram::UNIFORM_NAME_ALPHA_TEST_VALUE);

            // NOTE: alpha test shader is hard-coded to use the equivalent of a glAlphaFunc(GL_GREATER) comparison

            // use shader program to set uniform
            getGLProgram()->use();
            getGLProgram()->setUniformLocationWith1f(alphaValueLocation, alphaFuncValue);
            CHECK_GL_ERROR_DEBUG();
        }
        else
        {
            _vertexZvalue = vertexz.asInt();
        }
    }
}

protected void setupTileSprite(Sprite* sprite, const Vec2& pos, uint32_t gid)
{
    sprite->setPosition(getPositionAt(pos));
    sprite->setPositionZ((float)getVertexZForPos(pos));
    sprite->setAnchorPoint(Vec2::ZERO);
    sprite->setOpacity(_opacity);

    //issue 1264, flip can be undone as well
    sprite->setFlippedX(false);
    sprite->setFlippedY(false);
    sprite->setRotation(0.0f);
    sprite->setAnchorPoint(Vec2(0, 0));

    // Rotation in tiled is achieved using 3 flipped states, flipping across the horizontal, vertical, and diagonal axes of the tiles.
    if (gid & kTMXTileDiagonalFlag)
    {
        // put the anchor in the middle for ease of rotation.
        sprite->setAnchorPoint(Vec2(0.5f, 0.5f));
        sprite->setPosition(getPositionAt(pos).x + sprite->getContentSize().height / 2,
           getPositionAt(pos).y + sprite->getContentSize().width / 2);

        auto flag = gid & (kTMXTileHorizontalFlag | kTMXTileVerticalFlag);

        // handle the 4 diagonally flipped states.
        if (flag == kTMXTileHorizontalFlag)
        {
            sprite->setRotation(90.0f);
        }
        else if (flag == kTMXTileVerticalFlag)
        {
            sprite->setRotation(270.0f);
        }
        else if (flag == (kTMXTileVerticalFlag | kTMXTileHorizontalFlag))
        {
            sprite->setRotation(90.0f);
            sprite->setFlippedX(true);
        }
        else
        {
            sprite->setRotation(270.0f);
            sprite->setFlippedX(true);
        }
    }
    else
    {
        if (gid & kTMXTileHorizontalFlag)
        {
            sprite->setFlippedX(true);
        }

        if (gid & kTMXTileVerticalFlag)
        {
            sprite->setFlippedY(true);
        }
    }
}

protected Sprite* reusedTileWithRect(const Rect& rect)
{
    if (!_reusedTile)
    {
        _reusedTile = Sprite::createWithTexture(_textureAtlas->getTexture(), rect);
        _reusedTile->setBatchNode(this);
        _reusedTile->retain();
    }
    else
    {
        // FIXME: HACK: Needed because if "batch node" is nil,
        // then the Sprite'squad will be reset
        _reusedTile->setBatchNode(nullptr);

        // Re-init the sprite
        _reusedTile->setTextureRect(rect, false, rect.size);

        // restore the batch node
        _reusedTile->setBatchNode(this);
    }

    return _reusedTile;
}
protected int getVertexZForPos(const Vec2& pos)
{
    int ret = 0;
    int maxVal = 0;
    if (_useAutomaticVertexZ)
    {
        switch (_layerOrientation)
        {
            case TMXOrientationIso:
                maxVal = static_cast<int>(_layerSize.width + _layerSize.height);
                ret = static_cast<int>(-(maxVal - (pos.x + pos.y)));
                break;
            case TMXOrientationOrtho:
                ret = static_cast<int>(-(_layerSize.height - pos.y));
                break;
            case TMXOrientationStaggered:
                ret = static_cast<int>(-(_layerSize.height - pos.y));
                break;
            case TMXOrientationHex:
                ret = static_cast<int>(-(_layerSize.height - pos.y));
                break;
            default:
                CCASSERT(0, "TMX invalid value");
                break;
        }
    }
    else
    {
        ret = _vertexZvalue;
    }

    return ret;
}

// index
protected ssize_t atlasIndexForExistantZ(int z)
{
    int key = z;
    int* item = (int*)bsearch((void*)&key, (void*)&_atlasIndexArray->arr[0], _atlasIndexArray->num, sizeof(void*), compareInts);

    CCASSERT(item, "TMX atlas index not found. Shall not happen");

    ssize_t index = ((size_t)item - (size_t)_atlasIndexArray->arr) / sizeof(void*);
    return index;
}
protected ssize_t atlasIndexForNewZ(int z)
{
    // FIXME:: This can be improved with a sort of binary search
    ssize_t i = 0;
    for (i = 0; i < _atlasIndexArray->num; i++)
    {
        ssize_t val = (size_t)_atlasIndexArray->arr[i];
        if (z < val)
        {
            break;
        }
    }

    return i;
}


//! name of the layer
protected std::string _layerName;
//! TMX Layer supports opacity
protected unsigned char _opacity;

//! Only used when vertexZ is used
protected int _vertexZvalue;
protected bool _useAutomaticVertexZ;

//! used for optimization
protected Sprite* _reusedTile;
protected ccCArray* _atlasIndexArray;

// used for retina display
protected float _contentScaleFactor;

/** size of the layer in tiles */
protected Size _layerSize;
/** size of the map's tile (could be different from the tile's size) */
protected Size _mapTileSize;
/** pointer to the map of tiles */
protected uint32_t* _tiles;
/** Tileset information for the layer */
protected TMXTilesetInfo* _tileSet;
/** Layer orientation, which is the same as the map orientation */
protected int _layerOrientation;
/** Stagger Axis */
protected int _staggerAxis;
/** Stagger Index */
protected int _staggerIndex;
/** Hex side length*/
protected int _hexSideLength;
/** properties from the layer. They can be added using Tiled */
protected ValueMap _properties;
};

// end of tilemap_parallax_nodes group
/** @} */

NS_CC_END

#endif //__CCTMX_LAYER_H__

