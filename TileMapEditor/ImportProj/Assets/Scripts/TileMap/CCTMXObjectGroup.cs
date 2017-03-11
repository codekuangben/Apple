using System;

public class CC_DLL TMXObjectGroup
{
    /**
     * @js ctor
     */
    public TMXObjectGroup()
{
    _groupName = "";
}

/** Get the group name. 
 *
 * @return The group name.
 */
public String getGroupName()
{
    return _groupName;
}
    
    /** Set the group name. 
     *
     * @param groupName A string,it is used to set the group name.
     */
    public void setGroupName(ref String groupName)
{
    _groupName = groupName;
}

/** Return the value for the specific property name. 
 *
 * @param propertyName The specific property name.
 * @return Return the value for the specific property name.
 * @js NA
 */
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

    /** Return the dictionary for the specific object name.
     * It will return the 1st object found on the array for the given name.
     *
     * @return Return the dictionary for the specific object name.
     */
    public ValueMap getObject(ref String objectName)
{
    if (!_objects.empty())
    {
        for (const auto&v : _objects)
        {
            const ValueMap&dict = v.asValueMap();
            if (dict.find("name") != dict.end())
            {
                if (dict.at("name").asString() == objectName)
                    return dict;
            }
        }
    }

    // object not found
    return ValueMap();
}

public ValueMap objectNamed(ref String objectName)
{
    return getObject(objectName);
}
    
    /** Gets the offset position of child objects. 
     *
     * @return The offset position of child objects.
     */
    public Vec2 getPositionOffset()
{
    return _positionOffset;
}
    
    /** Sets the offset position of child objects. 
     *
     * @param offset The offset position of child objects.
     */
    public void setPositionOffset(ref Vec2 offset)
{
    _positionOffset = offset;
}

/** Gets the list of properties stored in a dictionary. 
 *
 * @return The list of properties stored in a dictionary.
 */
public ValueMap getProperties()
{
    return _properties;
}

    public ValueMap getProperties()
{
    return 
        _properties;
}

/** Sets the list of properties.
 *
 * @param properties The list of properties.
 */
public void setProperties(const ValueMap& properties)
{
        _properties = properties;
    }

/** Gets the array of the objects. 
 *
 * @return The array of the objects.
 */
public const ValueVector& getObjects()
{
    return _objects;
}
    ValueVector& getObjects()
{
    return _objects;
}

/** Sets the array of the objects.
 *
 * @param objects The array of the objects.
 */
public void setObjects(const ValueVector& objects)
{
        _objects = objects;
    }

/** name of the group */
protected String _groupName;
/** offset position of child objects */
protected Vec2 _positionOffset;
/** list of properties stored in a dictionary */
protected ValueMap _properties;
/** array of the objects */
protected ValueVector _objects;
}