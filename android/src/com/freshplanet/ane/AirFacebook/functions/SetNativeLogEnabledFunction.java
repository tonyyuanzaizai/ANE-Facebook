package com.freshplanet.ane.AirFacebook.functions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.freshplanet.ane.AirFacebook.AirFacebookExtension;
import com.freshplanet.ane.AirFacebook.utils.FREConversionUtil;

public class SetNativeLogEnabledFunction implements FREFunction
{
	@Override
	public FREObject call(FREContext context, FREObject[] args)
	{
		Boolean nativeLogEnabled = FREConversionUtil.toBoolean(args[0]);

		AirFacebookExtension.nativeLogEnabled = nativeLogEnabled;
		
		return null;
	}

}
