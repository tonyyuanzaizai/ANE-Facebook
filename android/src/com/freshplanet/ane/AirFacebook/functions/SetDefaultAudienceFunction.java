package com.freshplanet.ane.AirFacebook.functions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.facebook.login.DefaultAudience;
import com.freshplanet.ane.AirFacebook.AirFacebookExtension;
import com.freshplanet.ane.AirFacebook.utils.FREConversionUtil;

public class SetDefaultAudienceFunction implements FREFunction
{
	@Override
	public FREObject call(FREContext context, FREObject[] args)
	{
		DefaultAudience defaultAudience;

		Integer defaultAudienceInt = FREConversionUtil.toInt(args[0]);
		if(defaultAudienceInt != null) {
			int defaultAudienceIntVal = defaultAudienceInt.intValue();
			switch (defaultAudienceIntVal) {
				case 0:
					defaultAudience = DefaultAudience.FRIENDS;
					break;
				case 1:
					defaultAudience = DefaultAudience.ONLY_ME;
					break;
				case 2:
					defaultAudience = DefaultAudience.EVERYONE;
					break;
				default:
					defaultAudience = DefaultAudience.FRIENDS;
					break;
			}
			AirFacebookExtension.context.setDefaultAudience(defaultAudience);
		}

		return null;
	}

}
