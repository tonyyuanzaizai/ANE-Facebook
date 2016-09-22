package com.freshplanet.ane.AirFacebook.functions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.facebook.appevents.AppEventsLogger;
import com.freshplanet.ane.AirFacebook.AirFacebookExtension;

public class DeactivateAppFunction implements FREFunction
{
	@Override
	public FREObject call(FREContext context, FREObject[] args)
	{
		if(AirFacebookExtension.context.getAppID() != null) {
			AppEventsLogger.deactivateApp(context.getActivity(), AirFacebookExtension.context.getAppID());
		} else {
			AppEventsLogger.deactivateApp(context.getActivity());
		}
		
		return null;
	}

}
