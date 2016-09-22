package com.freshplanet.ane.AirFacebook.functions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.facebook.appevents.AppEventsLogger;
import com.freshplanet.ane.AirFacebook.AirFacebookExtension;

public class ActivateAppFunction implements FREFunction
{
	@Override
	public FREObject call(FREContext context, FREObject[] args)
	{
		if(AirFacebookExtension.context.getAppID() != null){
			AppEventsLogger.activateApp(context.getActivity(), AirFacebookExtension.context.getAppID());
		} else {
			AppEventsLogger.activateApp(context.getActivity());
		}
		
		return null;
	}

}
