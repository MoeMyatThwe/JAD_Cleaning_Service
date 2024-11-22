package com.cleaningService.model;

public class User {
    private String name;
    private String email;
    private String password;
    private Integer phoneNum;
    private String address;
    private Integer role;

    public Integer getRole() {
		return role;
	}

	public void setRole(Integer role) {
		this.role = role;
	}

	public User(String name, String email, String password, Integer phoneNum, String address, Integer role) {
        this.name = name;
        this.email = email;
        this.password = password;
        this.phoneNum = phoneNum;
        this.address = address;
        this.role = role;
    }

    // Getters and Setters
    public String getName() {
        return name;
    }

    public Integer getPhoneNum() {
		return phoneNum;
	}

	public void setPhoneNum(Integer phoneNum) {
		this.phoneNum = phoneNum;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
