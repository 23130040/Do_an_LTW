package cleanmeat.security;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import cleanmeat.model.GoogleUserInfo;
import org.apache.http.client.fluent.Form;
import org.apache.http.client.fluent.Request;
import java.io.IOException;

public class GoogleOAuthUtil {
    public static final String CLIENT_ID = "584195356550-29lvjiudmg5i41sl38ubhgqtmakv3c8t.apps.googleusercontent.com";
    public static final String CLIENT_SECRET = "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";
    public static final String GRANT_TYPE = "authorization_code";
    public static final String LINK_GET_TOKEN = "https://oauth2.googleapis.com/token";
    public static final String LINK_GET_USER_INFO = "https://openidconnect.googleapis.com/v1/userinfo?access_token=";

    public static GoogleUserInfo getUserInfo(String code, String redirectUri)
            throws IOException {

        String accessToken = getToken(code, redirectUri);

        String userInfoJson = Request.Get(
                LINK_GET_USER_INFO + accessToken
        ).execute().returnContent().asString();

        return new Gson().fromJson(userInfoJson, GoogleUserInfo.class);
    }

    public static String getToken(String code, String redirectUri) throws IOException {
        String response = Request.Post(LINK_GET_TOKEN)
                .bodyForm(Form.form()
                        .add("client_id", CLIENT_ID)
                        .add("client_secret", CLIENT_SECRET)
                        .add("redirect_uri", redirectUri)
                        .add("code", code)
                        .add("grant_type", GRANT_TYPE)
                        .build())
                .execute()
                .returnContent()
                .asString();

        JsonObject jobj = new Gson().fromJson(response, JsonObject.class);
        return jobj.get("access_token").getAsString();
    }

}