package com.oracle.projectGo.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping(value = "/game")
public class GameController {

    @RequestMapping(value = "gameContentInsert")
    public String gameContentInsert(Model mode){

        return "admin/game/gameContentInsert";
    }





}
