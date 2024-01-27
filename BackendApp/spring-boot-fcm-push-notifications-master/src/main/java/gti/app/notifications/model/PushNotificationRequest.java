package gti.app.notifications.model;

import java.util.Map;


public class PushNotificationRequest {

    private String title;
    private String message;
    private String topic;
    private String token;

    private Map<String,String> data;

    public PushNotificationRequest() {
    }

    public PushNotificationRequest(String title, String messageBody, String topicName, Map<String,String> data) {
        this.title = title;
        this.message = messageBody;
        this.topic = topicName;
        this.data=data;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getTopic() {
        return topic;
    }

    public void setTopic(String topic) {
        this.topic = topic;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public Map<String, String> getData() {
        return data;
    }

    public void setData(Map<String, String> data) {
        this.data = data;
    }
}