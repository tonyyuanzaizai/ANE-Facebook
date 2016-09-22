package com.freshplanet.ane.AirFacebook.functions;

import android.os.Bundle;
import com.adobe.fre.*;
import com.facebook.appevents.AppEventsLogger;
import com.freshplanet.ane.AirFacebook.AirFacebookExtension;
import com.freshplanet.ane.AirFacebook.utils.FREConversionUtil;

public class LogEventFunction implements FREFunction
{
	@Override
	public FREObject call(FREContext context, FREObject[] args)
	{
		String eventName = FREConversionUtil.toString(FREConversionUtil.getProperty("eventName", args[0]));
		Double valueToSum = FREConversionUtil.toDouble(FREConversionUtil.getProperty("valueToSum", args[0]));
		Bundle parameters = FREConversionUtil.toBundle(args[0]);

		AirFacebookExtension.log("LogEventFunction eventName:" + eventName + " valueToSum:" + valueToSum
				+ " parameters:" + parameters);

		AppEventsLogger logger = AppEventsLogger.newLogger(context.getActivity().getApplicationContext());
		if (valueToSum == null) {
			logger.logEvent(eventName, parameters);
		} else {
			logger.logEvent(eventName, valueToSum, parameters);
		}

		return null;
	}

}
