package com.rocket.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;

import lombok.RequiredArgsConstructor;

@Configuration
@EnableWebSocketMessageBroker
public class WebSocketConfig implements WebSocketMessageBrokerConfigurer{
	
	//웹 소켓 연결을 위한 엔드포인트 설정, stomp sub/pub 엔드포인트 설정
	@Override
	public void registerStompEndpoints(StompEndpointRegistry registry) {
		//WebSocket 또는 SockJs Client가 웹소켓 핸드셰이크 커넥션을 생성할 경로
		// stomp 접속 주소 url -> /ws/chat
		registry.addEndpoint("/ws/chat").setAllowedOrigins("*"); //.withSockJs(); ->연결될 엔드포인트
//		registry.addEndpoint("/ws/chat").setAllowedOrigins("http://localhost:8080"); //위에 코드가 오류날 시 이 코드로
	}
	
	@Override
	public void configureMessageBroker(MessageBrokerRegistry config) {
		// /pub 경로로 시작하는 STOMP 메시지의 "destination"헤더는 @MessasgeMapping메서드로 라우팅됨.
		
		// 메시지를 발행하는 요청 url -> 메시지 발신
		config.setApplicationDestinationPrefixes("/pub");
		// 메시지를 구독하는 요청 url -> 메시지 수신
		config.enableSimpleBroker("/sub");
	}

}
