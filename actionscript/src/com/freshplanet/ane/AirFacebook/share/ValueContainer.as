/**
 * Created by nodrock on 26/08/15.
 */
package com.freshplanet.ane.AirFacebook.share {
public class ValueContainer {

    private static const TYPE_STRING:int = 0;
    private static const TYPE_INT:int = 1;
    private static const TYPE_BOOL:int = 2;
    private static const TYPE_LONG:int = 3;
    private static const TYPE_DOUBLE:int = 4;

    private static const TYPE_STRING_ARRAY:int = 5;
    private static const TYPE_INT_ARRAY:int = 6;
    private static const TYPE_BOOL_ARRAY:int = 7;
    private static const TYPE_LONG_ARRAY:int = 8;
    private static const TYPE_DOUBLE_ARRAY:int = 9;

    private static const TYPE_OBJECT:int = 10;
    private static const TYPE_OBJECT_ARRAY:int = 11;

    private var _keys:Array;
    private var _types:Array;
    private var _values:Array;

    public function ValueContainer()
    {
        _keys = [];
        _types = [];
        _values = [];
    }

    public function putBoolean(key:String, value:Boolean):ValueContainer
    {
        _keys.push(key);
        _types.push(TYPE_BOOL);
        _values.push(value);

        return this;
    }

    public function putBooleanArray(key:String, value:Array):ValueContainer
    {
        checkArrayType(value, TYPE_BOOL_ARRAY);

        _keys.push(key);
        _types.push(TYPE_BOOL_ARRAY);
        _values.push(value);

        return this;
    }

    public function putInt(key:String, value:int):ValueContainer
    {
        _keys.push(key);
        _types.push(TYPE_INT);
        _values.push(value);

        return this;
    }

    public function putIntArray(key:String, value:Array):ValueContainer
    {
        checkArrayType(value, TYPE_INT_ARRAY);

        _keys.push(key);
        _types.push(TYPE_INT_ARRAY);
        _values.push(value);

        return this;
    }

    public function putString(key:String, value:String):ValueContainer
    {
        _keys.push(key);
        _types.push(TYPE_STRING);
        _values.push(value);

        return this;
    }

    public function putStringArray(key:String, value:Array):ValueContainer
    {
        checkArrayType(value, TYPE_STRING_ARRAY);

        _keys.push(key);
        _types.push(TYPE_STRING_ARRAY);
        _values.push(value);

        return this;
    }

    public function putLong(key:String, value:Number):ValueContainer
    {
        _keys.push(key);
        _types.push(TYPE_LONG);
        _values.push(value);

        return this;
    }

    public function putLongArray(key:String, value:Array):ValueContainer
    {
        checkArrayType(value, TYPE_LONG_ARRAY);

        _keys.push(key);
        _types.push(TYPE_LONG_ARRAY);
        _values.push(value);

        return this;
    }

    public function putDouble(key:String, value:Number):ValueContainer
    {
        _keys.push(key);
        _types.push(TYPE_DOUBLE);
        _values.push(value);

        return this;
    }

    public function putDoubleArray(key:String, value:Array):ValueContainer
    {
        checkArrayType(value, TYPE_DOUBLE_ARRAY);

        _keys.push(key);
        _types.push(TYPE_DOUBLE_ARRAY);
        _values.push(value);

        return this;
    }

    public function putObject(key:String, value:ValueContainer):ValueContainer
    {
        _keys.push(key);
        _types.push(TYPE_OBJECT);
        _values.push(value);

        return this;
    }

    public function putObjectArray(key:String, value:Array):ValueContainer
    {
        checkArrayType(value, TYPE_OBJECT_ARRAY);

        _keys.push(key);
        _types.push(TYPE_OBJECT_ARRAY);
        _values.push(value);

        return this;
    }

    //----------------------------------
    // Private checks
    //----------------------------------

    private function checkArrayType(value:Array, type:int):void
    {
        var i:int = 0;
        var len:int = value.length;
        switch(type){
            case TYPE_BOOL_ARRAY:
                for(i = 0; i<len; i++){

                    if(!(value[i] is Boolean)){
                        throw new Error("Boolean array contains values which are not boolean!")
                    }
                }
                break;
            case TYPE_INT_ARRAY:
                for(i = 0; i<len; i++){

                    if(!(value[i] is int)){
                        throw new Error("Int array contains values which are not int!")
                    }
                }
                break;
            case TYPE_STRING_ARRAY:
                for(i = 0; i<len; i++){

                    if(!(value[i] is String)){
                        throw new Error("String array contains values which are not string!")
                    }
                }
                break;
            default:
        }

    }

    public function get keys():Array
    {
        return _keys;
    }

    public function get types():Array
    {
        return _types;
    }

    public function get values():Array
    {
        return _values;
    }
}
}
