package com.freshplanet.ane.AirFacebook.share {

/**
 * @see http://developers.facebook.com/docs/reference/android/current/class/GameRequestContent.ActionType/
 */
    public class FBGameRequestActionType {

        public static const NONE:FBGameRequestActionType = new FBGameRequestActionType(Private, "NONE", 0);
        public static const SEND:FBGameRequestActionType = new FBGameRequestActionType(Private, "SEND", 1);
        public static const ASK_FOR:FBGameRequestActionType = new FBGameRequestActionType(Private, "ASK_FOR", 2);
        public static const TURN:FBGameRequestActionType = new FBGameRequestActionType(Private, "TURN", 3);

        private var _name:String;
        private var _value:int;

        public function FBGameRequestActionType(access:Class, name:String, value:int)
        {
            if(access != Private){
                throw new Error("Private constructor call!");
            }

            _name = name;
            _value = value;
        }

        public function get value():int
        {
            return _value;
        }

        public function toString():String
        {
            return _name;
        }
    }
}

final class Private{}