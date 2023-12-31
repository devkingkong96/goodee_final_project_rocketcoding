package com.rocket;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@SpringBootApplication
@EnableTransactionManagement
public class FinalprojectRocketApplication {
	
	public static void main(String[] args) {
		SpringApplication.run(FinalprojectRocketApplication.class, args);
	}
	
}
