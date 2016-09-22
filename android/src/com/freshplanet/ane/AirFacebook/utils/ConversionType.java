package com.freshplanet.ane.AirFacebook.utils;

import java.util.HashMap;
import java.util.Map;
import java.util.NoSuchElementException;

public enum ConversionType {

    STRING(0),
    INT(1),
    BOOL(2),
    LONG(3),
    DOUBLE(4),

    STRING_ARRAY(5),
    INT_ARRAY(6),
    BOOL_ARRAY(7),
    LONG_ARRAY(8),
    DOUBLE_ARRAY(9),

    OBJECT(10),
    OBJECT_ARRAY(11);

    private static final Map<Integer, ConversionType> map =
            new HashMap<>();

    static {
        for (ConversionType type : ConversionType.values()) {
            map.put(type.getValue(), type);
        }
    }

    private int value;

    ConversionType(int value) {
        this.value = value;
    }

    public int getValue() {
        return value;
    }

    public static ConversionType fromValue(int value)
    {
        if(map.containsKey(value)){
            return map.get(value);
        }
        //throw new NoSuchElementException("ConversionType with value " + value + " not found!");
        return null;
    }
}
