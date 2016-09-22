/**
 * Created by nodrock on 26/08/15.
 */
package com.freshplanet.ane.AirFacebook.share {
public class FBShareOpenGraphAction extends ValueContainer {

    private static const ACTION_TYPE_KEY:String = "og:type";

    public function FBShareOpenGraphAction() {}

    public function setActionType(actionType:String):void
    {
        putString(ACTION_TYPE_KEY, actionType);
    }
}
}
