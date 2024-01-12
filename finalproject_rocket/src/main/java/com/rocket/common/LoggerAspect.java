package com.rocket.common;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.Signature;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;
import org.springframework.util.StopWatch;

import lombok.extern.slf4j.Slf4j;

@Component
@Aspect
@Slf4j
public class LoggerAspect {

    @Pointcut("execution(* com.rocket.seoj..*(..))")
    public void test() {
    }

    @Pointcut("within(com.rocket.seoj..service.*)")
    public void test2() {
    }


    //@Before("test()")
    public void loggerTest(JoinPoint jp) {
        log.debug("---- anno aspect before실행 ------");
    }

    //    @After("test2()")
    public void loggerTest2(JoinPoint jp) {
        Signature sig = jp.getSignature();
        log.debug(sig.getDeclaringTypeName() + "." + sig.getName());
        Object[] params = jp.getArgs();
        if (params != null) {
            for (Object o : params) {
                log.debug("{}", o);
            }
        }
    }


    //    @Around("within(com.rocket.seoj..controller..*)")
//    @Around("within(com.rocket.seoj.logistics.controller.*)")
    @Around("within(com.rocket.seoj..*) && @annotation(org.springframework.web.bind.annotation.PostMapping)")
    public Object seojTest(ProceedingJoinPoint pj) throws Throwable {


        log.debug("================ around before log ================");
/*        StopWatch watch = new StopWatch();
        watch.start();*/
        Signature sig = pj.getSignature();

        log.debug("around before 실행 메소드 : " + sig.getDeclaringTypeName() + "." + sig.getName());


        Object[] params = pj.getArgs();
        if (params != null) {
            for (Object o : params) {

                log.debug("around before 매개변수 : " + "{}", o);

            }
        }
        log.debug("-----------------------------------------------------");
        Object obj = pj.proceed();
        log.debug("================ around after log ================");

/*        watch.stop();
        log.debug("실행 시간 : " + watch.getTotalTimeMillis() + "ms");*/
        sig = pj.getSignature();

        log.debug("around after 실행 메소드 : " + sig.getDeclaringTypeName() + "." + sig.getName());


        params = pj.getArgs();
        if (params != null) {
            for (Object o : params) {

                log.debug("around after 실행 매개변수 : " + "{}", o);

            }
        }
        log.debug("-----------------------------------------------------");
        return obj;
    }
    @Around("within(com.rocket.pdw..*) && @annotation(org.springframework.web.bind.annotation.PostMapping)")
    public Object dwTest(ProceedingJoinPoint pj) throws Throwable {


        log.debug("================ around before log ================");
/*        StopWatch watch = new StopWatch();
        watch.start();*/
        Signature sig = pj.getSignature();

        log.debug("around before 실행 메소드 : " + sig.getDeclaringTypeName() + "." + sig.getName());


        Object[] params = pj.getArgs();
        if (params != null) {
            for (Object o : params) {

                log.debug("around before 매개변수 : " + "{}", o);

            }
        }
        log.debug("-----------------------------------------------------");
        Object obj = pj.proceed();
        log.debug("================ around after log ================");

/*        watch.stop();
        log.debug("실행 시간 : " + watch.getTotalTimeMillis() + "ms");*/
        sig = pj.getSignature();

        log.debug("around after 실행 메소드 : " + sig.getDeclaringTypeName() + "." + sig.getName());


        params = pj.getArgs();
        if (params != null) {
            for (Object o : params) {

                log.debug("around after 실행 매개변수 : " + "{}", o);

            }
        }
        log.debug("-----------------------------------------------------");
        return obj;
    }
    
    //AfterThrowing 설정하기
    @AfterThrowing(value = "within(com.rocket.seoj..controller.*)", throwing = "e")
    public void afterThrowingLogger(JoinPoint jp, Throwable e) {
        log.debug("==== 비상비상 에러발생 ====");
        Signature sig = jp.getSignature();
        log.debug(sig.getDeclaringTypeName() + "." + sig.getName() + "에서 에러발생");
        log.debug("에러내용 : " + e.getMessage());
        StackTraceElement[] stackTrace = e.getStackTrace();
        for (StackTraceElement se : stackTrace) {
            log.debug("{}", se);
        }
    }


}







