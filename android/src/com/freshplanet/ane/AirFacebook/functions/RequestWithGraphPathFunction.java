package com.freshplanet.ane.AirFacebook.functions;

import android.os.Bundle;

import com.adobe.fre.FREArray;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.freshplanet.ane.AirFacebook.AirFacebookExtension;
import com.freshplanet.ane.AirFacebook.RequestThread;
import com.freshplanet.ane.AirFacebook.utils.FREConversionUtil;

public class RequestWithGraphPathFunction implements FREFunction
{
	@Override
	public FREObject call(FREContext context, FREObject[] args)
	{
		String graphPath = FREConversionUtil.toString(args[0]);
		Bundle parameters = FREConversionUtil.toStringBundle((FREArray) args[1], (FREArray) args[2]);
		String httpMethod = FREConversionUtil.toString(args[3]);
		String callback = FREConversionUtil.toString(args[4]);

		new RequestThread(AirFacebookExtension.context, graphPath, parameters, httpMethod, callback).start();
		
		return null;
	}
}