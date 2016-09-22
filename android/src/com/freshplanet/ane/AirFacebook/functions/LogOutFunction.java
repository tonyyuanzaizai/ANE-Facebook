package com.freshplanet.ane.AirFacebook.functions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.facebook.AccessToken;
import com.facebook.Profile;
import com.facebook.login.LoginManager;
import com.freshplanet.ane.AirFacebook.AirFacebookExtension;

public class LogOutFunction implements FREFunction
{	
	public FREObject call(FREContext context, FREObject[] args)
	{
		AirFacebookExtension.log("CloseSessionAndClearTokenInformationFunction");

		LoginManager.getInstance().logOut();
		
		return null;
	}
	
}