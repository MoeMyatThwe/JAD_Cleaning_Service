package com.cleaningService.model;

public class User {
	private int id;
    private String name;
    private String email;
    private String password;
    private String phoneNum;
    private String address;
    private int role;
    
    public User() {
    	
    }
    
    public User(String name, String email, String password, String phoneNum, String address, int role) {
        this.name = name;
        this.email = email;
        this.password = password;
        this.phoneNum = phoneNum;
        this.address = address;
        this.role = role;
    }
    
	// Getters and Setters

    public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

    public String getName() {
        return name;
    }

    public String getPhoneNum() {
		return phoneNum;
	}

	public void setPhoneNum(String phoneNum) {
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
    
    public int getRole() {
		return role;
	}

	public void setRole(int role) {
		this.role = role;
	}
}
