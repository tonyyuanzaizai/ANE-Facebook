package com.freshplanet.ane.AirFacebook.functions;

import android.content.Intent;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.facebook.share.model.GameRequestContent;
import com.freshplanet.ane.AirFacebook.AirFacebookExtension;
import com.freshplanet.ane.AirFacebook.GameRequestActivity;
import com.freshplanet.ane.AirFacebook.utils.FREConversionUtil;
import com.freshplanet.ane.AirFacebook.utils.FacebookObjectsConversionUtil;

public class GameRequestDialogFunction implements FREFunction
{
	public FREObject call(FREContext context, FREObject[] args)
	{
		GameRequestContent.Builder builder = new GameRequestContent.Builder();
		FacebookObjectsConversionUtil.parseGameRequestContent(args[0], builder);
		GameRequestContent content = builder.build();
		String callback = FREConversionUtil.toString(args[1]);

		AirFacebookExtension.log("GameRequestDialogFunction content:" + FacebookObjectsConversionUtil.toString(content) +
				" callback:" + callback);

		// Start dialog activity
		Intent i = new Intent(context.getActivity().getApplicationContext(), GameRequestActivity.class);
		i.putExtra(GameRequestActivity.extraPrefix + ".callback", callback);
		i.putExtra(GameRequestActivity.extraPrefix + ".content", content);
		context.getActivity().startActivity(i);

		return null;

	}
}