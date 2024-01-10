package com.rocket.common;

import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.util.Enumeration;
import java.util.HashMap;

@Component
@Slf4j
public class Getrequest {

    public static HashMap<String, Object> getParameterMap(HttpServletRequest request) {

        HashMap<String, Object> parameterMap = new HashMap<String, Object>();

        Enumeration<String> enums = request.getParameterNames();

        while (enums.hasMoreElements()) {
            String paramName = (String)enums.nextElement();
            String[] parameters = request.getParameterValues(paramName);

            if (parameters.length > 1) {
                parameterMap.put(paramName, parameters);
            } else {
                parameterMap.put(paramName, parameters[0]);
            }
        }

        return parameterMap;
    }
}
