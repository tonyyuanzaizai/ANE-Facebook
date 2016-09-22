package com.freshplanet.ane.AirFacebook.functions;

import android.util.Log;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.freshplanet.ane.AirFacebook.AirFacebookExtension;
import com.freshplanet.ane.AirFacebook.utils.FREConversionUtil;

/**
 * Created by nodrock on 12/06/15.
 */
public class NativeLogFunction implements FREFunction {
    public FREObject call(FREContext context, FREObject[] args)
    {
        String message = FREConversionUtil.toString(args[0]);

        // NOTE: logs from as3 should go only to native log
        AirFacebookExtension.nativeLog(message, "AS3");

        return null;
    }
}
