package com.rocket.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;

@Configuration
@EnableWebSocketMessageBroker
public class WebSocketConfig implements WebSocketMessageBrokerConfigurer{
	
	@Value("${contextPath}")
	private String path;
	//웹 소켓 연결을 위한 엔드포인트 설정, stomp sub/pub 엔드포인트 설정
	@Override
	public void registerStompEndpoints(StompEndpointRegistry registry) {
		
		//WebSocket 또는 SockJs Client가 웹소켓 핸드셰이크 커넥션을 생성할 경로
		// stomp 접속 주소 url -> /ws/chat
		// 웹소켓 session을 Httpsession으로 인터셉터
//		registry.addEndpoint("/ws/chat").setAllowedOrigins("*").withSockJS(); //.withSockJs(); ->연결될 엔드포인트
		registry.addEndpoint("/ws/chat").setAllowedOrigins("http://localhost:8080").withSockJS(); //Sockjs는 보안이슈로 와일드카드 허용 X
		registry.addEndpoint("/ws/list").setAllowedOrigins("http://localhost:8080").withSockJS(); //채팅방 목록
//		registry.addEndpoint("/ws/alarm").setAllowedOrigins("http://localhost:8080").withSockJS(); 
		registry.addEndpoint("/ws/chat").setAllowedOrigins("http://14.36.141.71:15555/"+path).withSockJS(); //채팅방
		registry.addEndpoint("/ws/list").setAllowedOrigins("http://14.36.141.71:15555/"+path).withSockJS(); 
//		registry.addEndpoint("/ws/alarm").setAllowedOrigins("http://14.36.141.71:15555/"+path).withSockJS();
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
