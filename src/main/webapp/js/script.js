/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

//script.js 
//var podList = [];
var curIdx = -1;
var playing = false;
var audio = new Audio();

/* FORMAT TIME */
function fmtTime(sec) {
    if (isNaN(sec))
        return '0:00';
    var m = Math.floor(sec / 60);
    var s = Math.floor(sec % 60);
    return m + ':' + (s < 10 ? '0' + s : s);
}

//play a podcast 

function playPodcast(id, title, author, feedUrl, coverUrl) {

    curIdx = -1;
    for (var i = 0; i < podList.length; i++) {
        if (podList[i].id == id) {
            curIdx = i;
            break;
        }
    }

    document.getElementById('playerBar').style.display = 'flex';
    document.getElementById('plTitle').textContent = title;
    document.getElementById('plAuth').textContent = author;

    var wrap = document.getElementById('plArtWrap');

    if (coverUrl && coverUrl.trim() !== '') {
        wrap.innerHTML = '<img class="pl-art" src="' + coverUrl + '" onerror="this.style.display=\'none\'">';
    } else {
        wrap.innerHTML = '<div class="pl-art-placeholder"><i class="fa-solid fa-microphone"></i></div>';
    }

    audio.src = feedUrl;
    audio.play().catch(function () {
        console.log("Audio play failed");
    });

    playing = true;
    document.getElementById('playMainBtn').innerHTML = '<i class="fa-solid fa-pause"></i>';

}

//play & pause

function togglePlay() {

    if (curIdx < 0)
        return;

    if (playing) {
        audio.pause();
        document.getElementById('playMainBtn').innerHTML = '<i class="fa-solid fa-play"></i>';
    } else {
        audio.play();
        document.getElementById('playMainBtn').innerHTML = '<i class="fa-solid fa-pause"></i>';
    }

    playing = !playing;
}

//next Podcast

function nextPod() {
    if (podList.length === 0)
        return;
    var next = podList[(curIdx + 1) % podList.length];
    playPodcast(next.id, next.title, next.author, next.feedUrl, next.coverUrl);
}

// prvious podcast 

function prevPod() {
    if (podList.length === 0)
        return;
    var prev = podList[(curIdx - 1 + podList.length) % podList.length];
    playPodcast(prev.id, prev.title, prev.author, prev.feedUrl, prev.coverUrl);
}

//skip back 10 sec
function skipBack(){
    if(!audio.duration) return;
    
    audio.currentTime = Math.min(audio.duration, audio.currentTime - 10 );
    
}

//skip for 30 sec 
function skipForward(){
      if (!audio.duration) return;
    audio.currentTime = Math.min(audio.duration, audio.currentTime + 30);
}

//Porgress Baar

audio.addEventListener('timeupdate', function () {
    if (!audio.duration)
        return;
    var pct = (audio.currentTime / audio.duration) * 100;
    document.getElementById('progFill').style.width = pct + '%';
    document.getElementById('curTime').textContent = fmtTime(audio.currentTime);
    document.getElementById('totTime').textContent = fmtTime(audio.duration);
});

//seek
function seekAudio(e) {
    if (!audio.duration)
        return;
    audio.currentTime = (e.offsetX / e.currentTarget.offsetWidth) * audio.duration;
}

//Voluem

function setVol(e) {
    var vol = Math.min(1, Math.max(0, e.offsetX / e.currentTarget.offsetWidth));
    audio.volume = vol;
    document.getElementById('volFill').style.width = (vol * 100) + '%';
}

//Search

function doSearch(contextPath) {
    var q = document.getElementById('searchInput').value.trim();
    if (q) {

        window.location.href = contextPath + '/podcast/search.fin?q=' + encodeURIComponent(q);
    }
}

//Open Add Model

function openModal() {
    document.getElementById('modalOverlay').classList.add('open');
}

//Close Add Modal

function closeModal() {
    document.getElementById('modalOverlay').classList.remove('open');
    document.getElementById('errMsg').classList.remove('show');
    document.getElementById('infoMsg').classList.remove('show');

}


//Save Podcast

function savePodcast(contextPath) {

    var title = document.getElementById('f-title').value.trim();
    var author = document.getElementById('f-author').value.trim();
    var cat = document.getElementById('f-cat').value;
    var url = document.getElementById('f-url').value.trim();
    var desc = document.getElementById('f-desc').value.trim();

    var errMsg = document.getElementById('errMsg');
    var infoMsg = document.getElementById('infoMsg');
    var saveBtn = document.getElementById('saveBtn');

    //checking the required fiels 

    if (!title || !author || !cat || !url) {
        errMsg.textContent = 'PLEASE FILL ALL REQUIRED FEILDS';
        errMsg.classList.add('show');
        return;
    }

    //Checking FeedUrl is right or not 

    try {
        new URL(url);
    } catch (e) {
        errMsg.textContent = 'please enter a valid Url';
        errMsg.classList.add('show');
        return;
    }

    // Check RSS or MP3
//    var isRSS = url.includes('/rss') || url.includes('feed') || url.includes('.xml');
var isRSS = url.includes('rss') || url.includes('.xml') || url.includes('feed');
    var isMP3 = url.includes('.mp3') || url.includes('.ogg') || url.includes('.wav');

    if (!isRSS && !isMP3) {
        errMsg.textContent = 'Please use a valid RSS feed URL or direct MP3 link!';
        errMsg.classList.add('show');
        return;
    }

    errMsg.classList.remove('show');
    infoMsg.textContent = 'Verifying link...';
    infoMsg.classList.add('show');
    saveBtn.disabled = true;

    //Submit to Spring MVc

    var form = document.createElement('form');
    form.method = 'POST';
    form.action = contextPath + '/podcast/add.fin';

    var fields = {title: title, author: author, category: cat, feedUrl: url, description: desc};

    for (var key in fields) {
        var inp = document.createElement('input');
        inp.type = 'hidden';
        inp.name = key;
        inp.value = fields[key];
        form.appendChild(inp);
    }

    document.body.appendChild(form);
    form.submit();

}

function openDescModal(title, desc) {

    var titleEl = document.getElementById("descTitle");
    var contentEl = document.getElementById("descContent");
    var overlayEl = document.getElementById("descOverlay");

    if (!titleEl || !contentEl || !overlayEl) {
        console.error("Description modal elements not found");
        return;
    }

    titleEl.innerText = title;
    contentEl.innerText = desc;

    overlayEl.classList.add("open");
}

function closeDescModal() {

    document.getElementById("descOverlay")
        .classList.remove("open");
}

//Open edit Modal

function openEditModal(id, title, author, cat, url, desc) {
    document.getElementById('e-id').value = id;
    document.getElementById('e-title').value = title;
    document.getElementById('e-author').value = author;
    document.getElementById('e-cat').value = cat;
    document.getElementById('e-url').value = url;
    document.getElementById('e-desc').value = desc;
    document.getElementById('editModal').classList.add('open');
}

//Close EDitModal

function closeEditModal() {
    document.getElementById('editModal').classList.remove('open');
}

//submit EDit Modal

function submitEdit(contextPath) {

    var id = document.getElementById('e-id').value;
    var title = document.getElementById('e-title').value.trim();
    var author = document.getElementById('e-author').value.trim();
    var cat = document.getElementById('e-cat').value;
    var url = document.getElementById('e-url').value.trim();
    var desc = document.getElementById('e-desc').value.trim();


    if (!title || !author || !cat || !url) {
        alert('ALL FIELDS ARE REQUIRED');
        return;
    }

    var form = document.createElement('form');
    form.method = 'POST';
    form.action = contextPath + '/podcast/update.fin';

    var fields = {id: id, title: title, author: author, category: cat, feedUrl: url, description: desc};
    for (var key in fields) {
        var inp = document.createElement('input');
        inp.type = 'hidden';
        inp.name = key;
        inp.value = fields[key];
        form.appendChild(inp);
    }

    document.body.appendChild(form);
    form.submit();
}

//Delete Confirm

var deleteId = null;

function openDeleteConfirm(id, title) {
    deleteId = id;
    document.getElementById('confirmMsg').textContent = 'Are you sure you want to delete "' + title + '"?';
    document.getElementById('confirmOverlay').classList.add('open');

}


function closeConfirm() {
    document.getElementById('confirmOverlay').classList.remove('open');
     deleteId = null;
}

function submitDelete(contextPath) {
    if (!deleteId)
        return;

    var form = document.createElement('form');
    form.method = 'POST';
    form.action = contextPath + '/podcast/delete.fin';

    var inp = document.createElement('input');
    inp.type = 'hidden';
    inp.name = 'id';
    inp.value = deleteId;
    form.appendChild(inp);

    document.body.appendChild(form);
    form.submit();
}