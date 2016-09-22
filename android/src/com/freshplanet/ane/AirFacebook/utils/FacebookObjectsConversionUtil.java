package com.freshplanet.ane.AirFacebook.utils;

import android.net.Uri;
import android.os.Bundle;
import android.os.Parcel;
import com.adobe.fre.FREArray;
import com.adobe.fre.FREObject;
import com.facebook.share.model.*;
import com.freshplanet.ane.AirFacebook.AirFacebookExtension;

import java.util.ArrayList;
import java.util.List;

public class FacebookObjectsConversionUtil {

    protected static void parseShareContent(FREObject object, ShareContent.Builder builder)
    {
        String contentUrl = FREConversionUtil.toString(FREConversionUtil.getProperty("contentUrl", object));
        List<String> peopleIds = FREConversionUtil.toStringArray(FREConversionUtil.getProperty("peopleIds", object));
        String placeId = FREConversionUtil.toString(FREConversionUtil.getProperty("placeId", object));
        String ref = FREConversionUtil.toString(FREConversionUtil.getProperty("ref", object));

        if(contentUrl != null) builder.setContentUrl(Uri.parse(contentUrl));
        if(peopleIds != null) builder.setPeopleIds(peopleIds);
        if(placeId != null) builder.setPlaceId(placeId);
        if(ref != null) builder.setRef(ref);
    }

    public static void parseShareOpenGraphContent(FREObject object, ShareOpenGraphContent.Builder builder)
    {
        FacebookObjectsConversionUtil.parseShareContent(object, builder);

        String previewPropertyName = FREConversionUtil.toString(FREConversionUtil.getProperty("previewPropertyName", object));
        ValueContainer valueContainer = ValueContainer.getValueContainer(FREConversionUtil.getProperty("action", object));

        AirFacebookExtension.log("VALUECONTAINER " + valueContainer);

        if(previewPropertyName != null) builder.setPreviewPropertyName(previewPropertyName);
        ShareOpenGraphAction shareOpenGraphAction = FacebookValueContainerBuilder.toOpenGraphAction(valueContainer);
        if(valueContainer != null) builder.setAction(shareOpenGraphAction);
    }

    public static String toString(ShareOpenGraphContent content)
    {
        StringBuilder builder = new StringBuilder();
        builder.append("[ShareOpenGraphContent ");
        builder.append("previewPropertyName:'").append(content.getPreviewPropertyName()).append("' ");

        builder.append("action:'");
        ShareOpenGraphAction action = content.getAction();
        if(action == null){
            builder.append("null");
        }else{
            builder.append("[ShareOpenGraphAction ");
            builder.append("actionType:'").append(action.getActionType()).append("' ");
            builder.append("*bundle:'").append(action.getBundle()).append("' ");

            ShareOpenGraphObject object = action.getObject(content.getPreviewPropertyName());
            if(object != null){
                builder.append("*object:'").append(object.getBundle()).append("' ");
            }
            ArrayList<ShareOpenGraphObject> objects = action.getObjectArrayList(content.getPreviewPropertyName());
            if(objects != null){
                for (ShareOpenGraphObject obj : objects) {
                    builder.append("*objects:'").append(obj.getBundle()).append("' ");
                }
            }
            builder.append("]");
        }
        builder.append("' ");

        builder.append("contentUrl:'").append(content.getContentUrl()).append("' ");
        builder.append("peopleIds:'").append(content.getPeopleIds()).append("' ");
        builder.append("placeId:'").append(content.getPlaceId()).append("' ");
        builder.append("ref:'").append(content.getRef()).append("']");
        return builder.toString();
    }

    public static void parseShareLinkContent(FREObject object, ShareLinkContent.Builder builder)
    {
        FacebookObjectsConversionUtil.parseShareContent(object, builder);

        String contentTitle = FREConversionUtil.toString(FREConversionUtil.getProperty("contentTitle", object));
        String contentDescription = FREConversionUtil.toString(FREConversionUtil.getProperty("contentDescription", object));
        String imageUrl = FREConversionUtil.toString(FREConversionUtil.getProperty("imageUrl", object));

        if(contentTitle != null) builder.setContentTitle(contentTitle);
        if(contentDescription != null) builder.setContentDescription(contentDescription);
        if(imageUrl != null) builder.setImageUrl(Uri.parse(imageUrl));
    }

    public static String toString(ShareLinkContent content)
    {
        StringBuilder builder = new StringBuilder();
        builder.append("[ShareLinkContent ");
        builder.append("contentDescription:'").append(content.getContentDescription()).append("' ");
        builder.append("contentTitle:'").append(content.getContentTitle()).append("' ");
        builder.append("imageUrl:'").append(content.getImageUrl()).append("' ");
        builder.append("contentUrl:'").append(content.getContentUrl()).append("' ");
        builder.append("peopleIds:'").append(content.getPeopleIds()).append("' ");
        builder.append("placeId:'").append(content.getPlaceId()).append("' ");
        builder.append("ref:'").append(content.getRef()).append("']");
        return builder.toString();
    }

    public static void parseAppInviteContent(FREObject object, AppInviteContent.Builder builder)
    {
        String appLinkUrl = FREConversionUtil.toString(FREConversionUtil.getProperty("appLinkUrl", object));
        String previewImageUrl = FREConversionUtil.toString(FREConversionUtil.getProperty("previewImageUrl", object));

        if(appLinkUrl != null) builder.setApplinkUrl(appLinkUrl);
        if(previewImageUrl != null) builder.setPreviewImageUrl(previewImageUrl);
    }

    public static String toString(AppInviteContent content)
    {
        StringBuilder builder = new StringBuilder();
        builder.append("[AppInviteContent ");
        builder.append("appLinkUrl:'").append(content.getApplinkUrl()).append("' ");
        builder.append("previewImageUrl:'").append(content.getPreviewImageUrl()).append("']");
        return builder.toString();
    }

    public static void parseGameRequestContent(FREObject object, GameRequestContent.Builder builder)
    {
        String message = FREConversionUtil.toString(FREConversionUtil.getProperty("message", object));
        List<String> to = FREConversionUtil.toStringArray(FREConversionUtil.getProperty("to", object));
        String data = FREConversionUtil.toString(FREConversionUtil.getProperty("data", object));
        String title = FREConversionUtil.toString(FREConversionUtil.getProperty("title", object));

        GameRequestContent.ActionType actionType = null;
        FREObject actionTypeObject = FREConversionUtil.getProperty("actionType", object);
        if(actionTypeObject != null) {

            Integer actionTypeInt = FREConversionUtil.toInt(FREConversionUtil.getProperty("value", actionTypeObject));
            if(actionTypeInt != null) {
                switch (actionTypeInt) {
                    case 1:
                        actionType = GameRequestContent.ActionType.SEND;
                        break;
                    case 2:
                        actionType = GameRequestContent.ActionType.ASKFOR;
                        break;
                    case 3:
                        actionType = GameRequestContent.ActionType.TURN;
                        break;
                    default:
                        actionType = null;
                }
            }
        }

        String objectId = FREConversionUtil.toString(FREConversionUtil.getProperty("objectId", object));

        GameRequestContent.Filters filters = null;
        FREObject filtersObject = FREConversionUtil.getProperty("filters", object);
        if(filtersObject != null) {

            Integer filtersObjectInt = FREConversionUtil.toInt(FREConversionUtil.getProperty("value", filtersObject));
            if(filtersObjectInt != null) {
                switch (filtersObjectInt) {
                    case 1:
                        filters = GameRequestContent.Filters.APP_USERS;
                        break;
                    case 2:
                        filters = GameRequestContent.Filters.APP_NON_USERS;
                        break;
                    default:
                        actionType = null;
                }
            }
        }

        List<String> suggestions = FREConversionUtil.toStringArray(FREConversionUtil.getProperty("suggestions", object));

        if(message != null) builder.setMessage(message);
        if(to != null) builder.setRecipients(to);
        if(data != null) builder.setData(data);
        if(title != null) builder.setTitle(title);
        if(actionType != null) builder.setActionType(actionType);
        if(objectId != null) builder.setObjectId(objectId);
        if(filters != null) builder.setFilters(filters);
        if(suggestions != null) builder.setSuggestions(suggestions);
    }

    public static String toString(GameRequestContent content)
    {
        StringBuilder builder = new StringBuilder();
        builder.append("[GameRequestContent ");
        builder.append("message:'").append(content.getMessage()).append("' ");
        builder.append("recipients:'").append(content.getRecipients()).append("' ");
        builder.append("data:'").append(content.getData()).append("' ");
        builder.append("title:'").append(content.getTitle()).append("' ");
        builder.append("actionType:'").append(content.getActionType()).append("' ");
        builder.append("objectId:'").append(content.getObjectId()).append("' ");
        builder.append("filters:'").append(content.getFilters()).append("' ");
        builder.append("suggestions:'").append(content.getSuggestions()).append("']");
        return builder.toString();
    }
}
