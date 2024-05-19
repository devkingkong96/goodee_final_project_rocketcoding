package com.rocket.config;

import com.rocket.ksj.chat.controller.CustomAuthenticationFailureHandler;
import com.rocket.security.DBConnectionProvider;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.security.core.session.SessionRegistryImpl;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

@Configuration
@EnableWebSecurity
@RequiredArgsConstructor
public class SecurityConfig {

    private final DBConnectionProvider dbprovider;
    private final CustomAuthenticationFailureHandler customFailureHandler;

    @Bean
    SecurityFilterChain authenticationPath(HttpSecurity http) throws Exception {
        return http
                .csrf(csrf->csrf.disable())
                .authorizeHttpRequests(request->{
                    request.requestMatchers("/login","/resources/**").permitAll()
                           .requestMatchers("/member/emailCheck").permitAll()
                           .requestMatchers("/member/sendPwd").permitAll()
                           .requestMatchers("/WEB-INF/views/**").permitAll()
                           .requestMatchers("/**").hasAnyAuthority("USER")
                           .anyRequest().authenticated();
                })
                .formLogin(formlogin->{
                    formlogin.loginPage("/login") //로그인 페이지
                             .successForwardUrl("/")
                             .failureHandler(customFailureHandler)
//                             .failureForwardUrl("/login")
                             .usernameParameter("empNo")
                             .passwordParameter("empPw");
                })
                .logout(logout->{
                    logout.logoutUrl("/logout")
                          .logoutSuccessUrl("/login")
                          .deleteCookies("JSESSIONID")
                          .clearAuthentication(true)
                          .invalidateHttpSession(true);
                })
                .rememberMe(rememberme->{
                    rememberme.tokenValiditySeconds(60*60*3)
                              .rememberMeParameter("rememberMe")
                              .userDetailsService(dbprovider);
                })
                //세션 관리 -> 중복 로그인 방지,세션 무효화,세션 수 관리
                .sessionManagement(maxsession->{
                	//새로운 세션 생성
                	maxsession.sessionFixation().changeSessionId()
                				.maximumSessions(1)
                				//세션 만료 됐을 때 커스텀 URL
                				.expiredUrl("/login")
                				//true->로그인 시도 차단, false->기존 세션이 로그아웃or만료되면 새로운 로그인 세션 허용
                				.maxSessionsPreventsLogin(false)
                				//동시에 로그인한 세션들을 추적,관리
                				.sessionRegistry(sessionRegistry());
                })
                //.userDetailsService(dbprovider)

                .authenticationProvider(dbprovider)
                .build();
    }
    //로그아웃 후 로그인할 때 정상작동을 위해 선언
    @Bean
    public SessionRegistry sessionRegistry() {
    	return new SessionRegistryImpl();
    }
    
//    //에러 핸들러
//    @Bean
//    AuthenticationManager authenticationManager(AuthenticationConfiguration authenticationConfiguration) throws Exception{
//    	return authenticationConfiguration.getAuthenticationManager();
//    }
}