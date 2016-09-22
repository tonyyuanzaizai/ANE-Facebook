package com.freshplanet.ane.AirFacebook.functions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.facebook.login.LoginBehavior;
import com.facebook.share.widget.ShareDialog;
import com.freshplanet.ane.AirFacebook.AirFacebookExtension;
import com.freshplanet.ane.AirFacebook.utils.FREConversionUtil;

public class SetLoginBehaviorFunction implements FREFunction {

    @Override
    public FREObject call(FREContext context, FREObject[] args)
    {
        LoginBehavior loginBehavior;

        Integer loginBehaviorInt = FREConversionUtil.toInt(args[0]);
        if(loginBehaviorInt != null) {
            switch (loginBehaviorInt) {
                case 0:
                    loginBehavior = LoginBehavior.NATIVE_WITH_FALLBACK;
                    break;
                case 1:
                    loginBehavior = LoginBehavior.NATIVE_ONLY;
                    break;
                case 2:
                    loginBehavior = LoginBehavior.WEB_ONLY;
                    break;
                default:
                    loginBehavior = LoginBehavior.NATIVE_WITH_FALLBACK;
            }
            AirFacebookExtension.context.setLoginBehavior(loginBehavior);
        }

        return null;
    }
}
