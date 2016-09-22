package com.freshplanet.ane.AirFacebook.share {

/**
 * Describes the content that will be displayed by the GameRequestDialog.
 *
 * @see http://developers.facebook.com/docs/reference/android/current/class/GameRequestContent/
 */
public class FBGameRequestContent {

    public var message:String;
    public var to:Array;
    public var data:String;
    public var title:String;
    public var actionType:FBGameRequestActionType;
    public var objectId:String;
    public var filters:FBGameRequestFilter;
    public var suggestions:Array;

    public function FBGameRequestContent() {}

    public function toString():String
    {
        var str:String = "[FBGameRequestContent";
        str += " message:'" + message + "'";
        str += " to:'" + to + "'";
        str += " data:'" + data + "'";
        str += " title:'" + title + "'";
        str += " actionType:'" + actionType + "'";
        str += " objectId:'" + objectId + "'";
        str += " filters:'" + filters + "'";
        str += " suggestions:'" + suggestions + "'";
        return str + "]";
    }
}
}
