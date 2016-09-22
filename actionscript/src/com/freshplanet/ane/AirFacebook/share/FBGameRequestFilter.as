package com.freshplanet.ane.AirFacebook.share {

/**
 * @see http://developers.facebook.com/docs/reference/android/current/class/GameRequestContent.Filters/
 */
    public class FBGameRequestFilter {

        public static const NONE:FBGameRequestFilter = new FBGameRequestFilter(Private, "NONE", 0);
        public static const APP_USERS:FBGameRequestFilter = new FBGameRequestFilter(Private, "APP_USERS", 1);
        public static const APP_NON_USERS:FBGameRequestFilter = new FBGameRequestFilter(Private, "APP_NON_USERS", 2);

        private var _name:String;
        private var _value:int;

        public function FBGameRequestFilter(access:Class, name:String, value:int)
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