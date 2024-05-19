package com.rocket;

import com.rocket.config.PubNubProperties;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@SpringBootApplication
@EnableTransactionManagement
@EnableAspectJAutoProxy
@EnableConfigurationProperties(PubNubProperties.class)
public class FinalprojectRocketApplication {

    public static void main(String[] args) {
        SpringApplication.run(FinalprojectRocketApplication.class, args);
    }

}
