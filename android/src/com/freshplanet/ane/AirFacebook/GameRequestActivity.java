package com.freshplanet.ane.AirFacebook;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import com.facebook.CallbackManager;
import com.facebook.FacebookCallback;
import com.facebook.FacebookException;
import com.facebook.share.model.GameRequestContent;
import com.facebook.share.widget.GameRequestDialog;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class GameRequestActivity extends Activity implements FacebookCallback<GameRequestDialog.Result>
{
	public static String extraPrefix = "com.freshplanet.ane.AirFacebook.GameRequestActivity";

	private CallbackManager callbackManager;
	private GameRequestDialog gameRequestDialog;

	private String callback;
	private GameRequestContent gameRequestContent;

	@Override
	protected void onCreate(Bundle savedInstanceState)
	{
		super.onCreate(savedInstanceState);

		AirFacebookExtension.log("GameRequestActivity onCreate()");

		callback = this.getIntent().getStringExtra(extraPrefix + ".callback");
		gameRequestContent = this.getIntent().getParcelableExtra(extraPrefix + ".content");

		callbackManager = CallbackManager.Factory.create();

		if (GameRequestDialog.canShow()) {
			gameRequestDialog = new GameRequestDialog(this);
			gameRequestDialog.registerCallback(callbackManager, this);
			gameRequestDialog.show(gameRequestContent);
		} else {
			AirFacebookExtension.log("ERROR - CANNOT SEND GAME REQUEST!");
			finish();
		}
	}

	@Override
	protected void onActivityResult(int requestCode, int resultCode, Intent data) {
		super.onActivityResult(requestCode, resultCode, data);
		callbackManager.onActivityResult(requestCode, resultCode, data);
	}

	@Override
	public void onSuccess(GameRequestDialog.Result result) {

		String res;
		try {
			JSONObject object = new JSONObject();
			object.put("requestId", result.getRequestId());
			JSONArray recipients = new JSONArray();
			for (String recipient : result.getRequestRecipients()) {
				recipients.put(recipient);
			}
			object.put("recipients", recipients);
			res = object.toString();

		} catch (JSONException e) {
			res = "{\"error\": \"GameRequestDialog.Result parsing error!\"}";
			e.printStackTrace();
		}


		AirFacebookExtension.log("GAMEREQUEST_SUCCESS! " + res);
		AirFacebookExtension.context.dispatchStatusEventAsync("GAMEREQUEST_SUCCESS_" + callback, res);
		finish();
	}

	@Override
	public void onCancel() {
		AirFacebookExtension.log("GAMEREQUEST_CANCELLED!");
		AirFacebookExtension.context.dispatchStatusEventAsync("GAMEREQUEST_CANCELLED_" + callback, "{}");
		finish();
	}

	@Override
	public void onError(FacebookException error) {
		AirFacebookExtension.log("GAMEREQUEST_ERROR!" + error.getMessage());
		AirFacebookExtension.context.dispatchStatusEventAsync("GAMEREQUEST_ERROR_" + callback, error.getMessage());
		finish();
	}
}