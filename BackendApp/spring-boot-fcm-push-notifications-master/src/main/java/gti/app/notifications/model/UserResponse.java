package gti.app.notifications.model;

public class UserResponse {
    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public UserResponse(int status, String message) {
        this.status = status;
        this.message = message;
    }

    private int status;
    private String message;
}
