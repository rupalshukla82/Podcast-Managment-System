<%-- 
    Document   : playerbaar
    Created on : May 5, 2026, 8:57:57 AM
    Author     : abhi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<div class="player" id="playerBar" style="display:none">
    <div class="pl-left">
        <div id="plArtWrap">
            <div class="pl-art-placeholder">
                <i class="fa-solid fa-microphone"></i>
            </div>
        </div>
        <div>
            <div class="pl-title" id="plTitle">Select a podcast</div>
            <div class="pl-auth"  id="plAuth">—</div>
        </div>
    </div>
    <div class="pl-center">
        <div class="pl-controls">
            <button class="ctrl-btn" onclick="prevPod()">
                <i class="fa-solid fa-backward-step"></i>
            </button>
            <!--                    <button class="ctrl-btn">
                                    <i class="fa-solid fa-shuffle"></i>
                                </button>-->
            <button class="ctrl-btn" onclick="skipBack()" title="10 seconds back">
                <i class="fa-solid fa-rotate-left"></i>
                <span style="font-size:8px;display:block;margin-top:-2px">10</span>
            </button>
            <button class="play-main" id="playMainBtn" onclick="togglePlay()">
                <i class="fa-solid fa-play"></i>
            </button>
            <!--                    <button class="ctrl-btn">
                                    <i class="fa-solid fa-repeat"></i>
                                </button>-->
            <button class="ctrl-btn" onclick="skipForward()" title="30 seconds forward">
                <i class="fa-solid fa-rotate-right"></i>
                <span style="font-size:8px;display:block;margin-top:-2px">30</span>
            </button>
            <button class="ctrl-btn" onclick="nextPod()">
                <i class="fa-solid fa-forward-step"></i>
            </button>
        </div>
        <div class="prog-row">
            <span class="prog-time" id="curTime">0:00</span>
            <div class="prog-bar" onclick="seekAudio(event)">
                <div class="prog-fill" id="progFill"></div>
            </div>
            <span class="prog-time" id="totTime">0:00</span>
        </div>
    </div>
    <div class="pl-right">
        <i class="fa-solid fa-volume-high" style="color:#a0a0a0"></i>
        <div class="vol-bar" onclick="setVol(event)">
            <div class="vol-fill" id="volFill"></div>
        </div>
    </div>
</div>


