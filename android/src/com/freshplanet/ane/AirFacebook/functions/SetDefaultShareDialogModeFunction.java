package com.freshplanet.ane.AirFacebook.functions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.facebook.login.DefaultAudience;
import com.facebook.share.widget.ShareDialog;
import com.freshplanet.ane.AirFacebook.AirFacebookExtension;
import com.freshplanet.ane.AirFacebook.utils.FREConversionUtil;

public class SetDefaultShareDialogModeFunction implements FREFunction {

    @Override
    public FREObject call(FREContext context, FREObject[] args)
    {
        ShareDialog.Mode defaultShareDialogMode;

        Integer defaultShareDialogModeInt = FREConversionUtil.toInt(args[0]);
        if(defaultShareDialogModeInt != null) {
            switch (defaultShareDialogModeInt) {
                case 0:
                    defaultShareDialogMode = ShareDialog.Mode.AUTOMATIC;
                    break;
                case 1:
                    defaultShareDialogMode = ShareDialog.Mode.NATIVE;
                    break;
                case 2:
                    defaultShareDialogMode = ShareDialog.Mode.WEB;
                    break;
                case 3:
                    defaultShareDialogMode = ShareDialog.Mode.FEED;
                    break;
                default:
                    defaultShareDialogMode = ShareDialog.Mode.AUTOMATIC;
            }
            AirFacebookExtension.context.setDefaultShareDialogMode(defaultShareDialogMode);
        }

        return null;
    }
}
