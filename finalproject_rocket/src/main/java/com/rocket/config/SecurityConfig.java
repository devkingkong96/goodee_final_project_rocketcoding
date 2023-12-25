package com.rocket.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.web.SecurityFilterChain;

import com.rocket.security.DBConnectionProvider;

import lombok.RequiredArgsConstructor;

@Configuration
@EnableWebSecurity
@RequiredArgsConstructor
public class SecurityConfig {
	
	private final DBConnectionProvider dbprovider;
	
	@Bean
	SecurityFilterChain authenticationPath(HttpSecurity http) throws Exception {
		return http
		.csrf(csrf->csrf.disable())
		.authorizeHttpRequests(request->{
			request.requestMatchers("/login","/resources/**").permitAll()
			.requestMatchers("/WEB-INF/views/**").permitAll()
			.requestMatchers("/**").hasAnyAuthority("USER")
			.anyRequest().authenticated();
		})
		.formLogin(formlogin->{
			formlogin.loginPage("/login") //로그인 페이지
			.defaultSuccessUrl("/")
			.usernameParameter("empNo")
			.passwordParameter("empPw");
		})
		.logout(logout->{
			logout.logoutUrl("/logout")
			.logoutSuccessUrl("/login")
			.invalidateHttpSession(true);
		})
		.authenticationProvider(dbprovider)
		.build();
	}
}
