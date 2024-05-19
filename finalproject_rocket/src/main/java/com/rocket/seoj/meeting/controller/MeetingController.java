package com.rocket.seoj.meeting.controller;

import com.rocket.config.PubNubProperties;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;


@Controller
@RequiredArgsConstructor
@Slf4j
public class MeetingController {

    private final PubNubProperties pubNubProperties;
    @GetMapping("/meeting")
    public String meetingPage(Model model) {

        model.addAttribute("publishKey", pubNubProperties.getPublishKey());
        model.addAttribute("subscribeKey", pubNubProperties.getSubscribeKey());
        model.addAttribute("ssl", pubNubProperties.isSsl());


        return "meeting/meeting";
    }

}
