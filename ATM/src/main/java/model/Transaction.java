package model;

import java.sql.Timestamp;

public class Transaction {
    private int id;
    private int userId;
    private String type;
    private double amount;
    private Integer targetUser;
    private Timestamp timestamp;

    public Transaction(int id, int userId, String type, double amount, Integer targetUser, Timestamp timestamp) {
        this.id = id;
        this.userId = userId;
        this.type = type;
        this.amount = amount;
        this.targetUser = targetUser;
        this.timestamp = timestamp;
    }

    public int getId() { return id; }
    public int getUserId() { return userId; }
    public String getType() { return type; }
    public double getAmount() { return amount; }
    public Integer getTargetUser() { return targetUser; }
    public Timestamp getTimestamp() { return timestamp; }
}
