<%-- 
    Document   : landing
    Created on : May 11, 2026, 11:33:44 AM
    Author     : abhi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title> PodcastMgr - Stream & Manage Podcasts</title>
        <link rel="icon" 
              type="image/png"
              href="${pageContext.request.contextPath}/images/favicon_1.png">
        <link href="https://fonts.googleapis.com/css2?family=Figtree:wght@400;500;600;700;800&display=swap" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/CSS/landing.css" rel="stylesheet">
    </head>
    <body>
        <%-- NAV --%>
        <nav class="nav">
            <div class="nav-logo">
                <i class="fa-solid fa-microphone"></i> PodcastMgr
            </div>
            <div class="nav-links">
                <a href="#about">About</a>
                <a href="#podcasts">Podcasts</a>
                <a href="#cta">Get Started</a>
                <button class="btn-login" onclick="window.location = '${pageContext.request.contextPath}/login.fin'">Log in</button>
                <button class="btn-signup" onclick="window.location = '${pageContext.request.contextPath}/index.fin'">Sign up free</button>
            </div>
        </nav>

        <%-- HERO --%>
        <div class="hero">
            <div class="hero-glow"></div>
            <div class="badge">
                <span class="badge-dot"></span>
                Now live — Stream & manage podcasts
            </div>
            <h1>Your podcasts,<br><span>your world.</span></h1>
            <p class="hero-sub">A Spotify-inspired podcast manager. Real audio streaming, RSS auto-fetch, full CRUD — built with Spring MVC & MySQL.</p>
            <div class="hero-btns">
                <button class="btn-primary" onclick="window.location = '${pageContext.request.contextPath}/index.fin'">
                    <i class="fa-solid fa-headphones"></i> Start listening free
                </button>
                <button class="btn-outline" onclick="document.getElementById('preview').scrollIntoView({behavior: 'smooth'})">
                    <i class="fa-solid fa-play"></i> See demo
                </button>
            </div>
            <div class="hero-stats">
                <div class="stat"><span class="stat-num">10+</span><span class="stat-label">Podcasts</span></div>
                <div class="stat-div"></div>
                <div class="stat"><span class="stat-num">6</span><span class="stat-label">Categories</span></div>
                <div class="stat-div"></div>
                <div class="stat"><span class="stat-num">100%</span><span class="stat-label">Free</span></div>
            </div>
        </div>

        <%-- APP PREVIEW --%>
        <div class="preview-section" id="preview">
            <div class="preview-wrap">
                <div class="preview-bar">
                    <div class="dot-r"></div>
                    <div class="dot-y"></div>
                    <div class="dot-g"></div>
                    <div class="preview-url">localhost:8081/SqlUtilityCrud/home.fin</div>
                </div>
                <div class="preview-body">
                    <div class="p-sidebar">
                        <div class="p-logo"><i class="fa-solid fa-microphone"></i> PodcastMgr</div>
                        <div class="p-link on"><i class="fa-solid fa-house"></i> Home</div>
                        <div class="p-link"><i class="fa-solid fa-magnifying-glass"></i> Search</div>
                        <div class="p-link"><i class="fa-solid fa-user"></i> My Profile</div>
                        <div class="p-link" style="color:var(--green)"><i class="fa-solid fa-plus"></i> Add Podcast</div>
                        <hr class="p-divider">
                        <div class="p-label">Categories</div>
                        <div class="p-cat"><i class="fa-solid fa-skull"></i> Horror</div>
                        <div class="p-cat"><i class="fa-solid fa-heart"></i> Love</div>
                        <div class="p-cat"><i class="fa-solid fa-face-laugh"></i> Comedy</div>
                        <div class="p-cat"><i class="fa-solid fa-microchip"></i> Technology</div>
                        <div class="p-cat on"><i class="fa-solid fa-fire"></i> Education</div>
                        <div class="p-cat"><i class="fa-solid fa-briefcase"></i> Business</div>
                    </div>
                    <div class="p-main">
                        <div class="p-topbar">
                            <div class="p-search"><i class="fa-solid fa-magnifying-glass"></i> Search podcasts...</div>
                            <button class="p-add-btn"><i class="fa-solid fa-plus"></i> Add Podcast</button>
                            <div class="p-avatar">A</div>
                        </div>
                        <div class="p-content">
                            <div class="p-greeting">Good evening, Abhi </div>

                            <div class="p-sec-hdr">
                                <div class="p-sec-title"><i class="fa-solid fa-bolt"></i> Recently Added</div>
                                <span class="p-see-all">See all</span>
                            </div>

                            <div class="p-feat-strip">
                                <div class="p-feat-card">
                                    <div class="p-feat-badge">Yours</div>
                                    <img class="p-feat-img" src="https://image.simplecastcdn.com/images/6c0ffcab-1640-429f-b7a6-62df20b25024/d3838c2f-27d9-4145-a37c-0a4d6f30dc87/3000x3000/trs-final-audio-1.jpg?aid=rss_feed" alt="Ranveer Show">
                                    <div class="p-feat-overlay">
                                        <div class="p-feat-title">Ranveer Show</div>
                                        <div class="p-feat-author">The Ranveer Show</div>
                                    </div>
                                </div>
                                <div class="p-feat-card">
                                    <img class="p-feat-img" src="https://d3t3ozftmdmh3i.cloudfront.net/production/podcast_uploaded_nologo/10685580/10685580-1605460352457-9e8f2b251ef21.jpg" alt="Horror">
                                    <div class="p-feat-overlay">
                                        <div class="p-feat-title">Horror & Mystery</div>
                                        <div class="p-feat-author">Deepak Medatwal</div>
                                    </div>
                                </div>
                                <div class="p-feat-card">
                                    <img class="p-feat-img" src="https://megaphone.imgix.net/podcasts/6fe427ec-b863-11ed-9e3b-f79bd21a2f4d/image/f75d642572ec0815e36be6a49a0284e6.png?ixlib=rails-4.3.1&max-w=3000&max-h=3000&fit=crop&auto=format,compress" alt="Netflix">
                                    <div class="p-feat-overlay">
                                        <div class="p-feat-title">Netflix Is A Daily Joke</div>
                                        <div class="p-feat-author">Netflix</div>
                                    </div>
                                </div>
                            </div>

                            <div class="p-sec-hdr">
                                <div class="p-sec-title"><i class="fa-solid fa-fire"></i> All Podcasts</div>
                                <span class="p-see-all">See all</span>
                            </div>

                            <div class="p-cards">
                                <div class="p-card">
                                    <img src="https://d3t3ozftmdmh3i.cloudfront.net/production/podcast_uploaded/3351519/3351519-1677217163769-b98817353d66a.jpg" alt="Simerjeet">
                                    <div class="p-card-info"><div class="p-card-title">Simerjeet Singh</div><div class="p-card-author">Education</div></div>
                                </div>
                                <div class="p-card">
                                    <img src="https://image.simplecastcdn.com/images/7f2f4c05-9c2f-4deb-82b7-b538062bc22d/73549bf1-94b3-40ff-8aeb-b4054848ec1b/3000x3000/the-daily-album-art-original.jpg?aid=rss_feed" alt="Modern Love">
                                    <div class="p-card-info"><div class="p-card-title">Modern Love NYT</div><div class="p-card-author">Love</div></div>
                                </div>
                                <div class="p-card">
                                    <img src="https://d3t3ozftmdmh3i.cloudfront.net/staging/podcast_uploaded_nologo/41889934/41889934-1760533194703-74d34863e7497.jpg" alt="Horror Tape">
                                    <div class="p-card-info"><div class="p-card-title">Horror Tape</div><div class="p-card-author">Horror</div></div>
                                </div>
                                <div class="p-card">
                                    <img src="https://d3t3ozftmdmh3i.cloudfront.net/staging/podcast_uploaded_nologo/31923216/31923216-1698674345725-0e3006beb4e3c.jpg" alt="Growth Genius">
                                    <div class="p-card-info"><div class="p-card-title">Growth Genius TGG</div><div class="p-card-author">Education</div></div>
                                </div>
                            </div>
                        </div>

                        <%-- PLAYER BAR --%>
                        <div class="p-player">
                            <div class="p-pl-thumb"><img id="pl-img" src="https://image.simplecastcdn.com/images/6c0ffcab-1640-429f-b7a6-62df20b25024/d3838c2f-27d9-4145-a37c-0a4d6f30dc87/3000x3000/trs-final-audio-1.jpg?aid=rss_feed" alt="now playing"></div>
                            <div>
                                <div class="p-pl-title" id="pl-title">Ranveer Show</div>
                                <div class="p-pl-auth" id="pl-auth">The Ranveer Show</div>
                            </div>
                            <div class="wave">
                                <div class="wb" style="height:4px"></div>
                                <div class="wb" style="height:10px"></div>
                                <div class="wb" style="height:6px"></div>
                                <div class="wb" style="height:12px"></div>
                            </div>
                            <div class="p-controls">
                                <button class="p-ctrl"><i class="fa-solid fa-backward-step"></i></button>
                                <div style="display:flex;flex-direction:column;align-items:center;color:#777;">
                                    <i class="fa-solid fa-rotate-left"></i>
                                    <span style="font-size:8px;line-height:1;">10</span>
                                </div>

                                <button class="p-play-main" id="pl-btn" onclick="togglePlay()">
                                    <i class="fa-solid fa-pause"></i>
                                </button>

                                <div style="display:flex;flex-direction:column;align-items:center;color:#777;">
                                    <i class="fa-solid fa-rotate-right"></i>
                                    <span style="font-size:8px;line-height:1;">30</span>
                                </div>
                                <button class="p-ctrl"><i class="fa-solid fa-forward-step"></i></button>
                            </div>
                            <div class="p-prog-row">
                                <span class="p-time">1:23</span>
                                <div class="p-prog-bar"><div class="p-prog-fill" id="pl-fill"></div></div>
                                <span class="p-time">24:00</span>
                            </div>
                            <span style="font-size:12px;color:#555"><i class="fa-solid fa-volume-high"></i></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <%-- TRENDING PODCASTS --%>
        <div class="section" id="podcasts">
            <div class="sec-tag">Discover</div>
            <div class="sec-h2">Trending <span>podcasts</span></div>
            <p class="sec-p">Real podcasts from our database — click any card to explore.</p>
            <div class="pods-grid">
                <div class="pod" onclick="window.location = '${pageContext.request.contextPath}/index.fin'">
                    <img src="https://image.simplecastcdn.com/images/6c0ffcab-1640-429f-b7a6-62df20b25024/d3838c2f-27d9-4145-a37c-0a4d6f30dc87/3000x3000/trs-final-audio-1.jpg?aid=rss_feed" alt="Ranveer Show" onerror="this.outerHTML='<div class=pod-ph>🎙</div>'">
                    <button class="pod-play"><i class="fa-solid fa-play"></i></button>
                    <div class="pod-info">
                        <div class="pod-title">Ranveer Show</div>
                        <div class="pod-author">The Ranveer Show</div>
                        <span class="pod-tag">Education</span>
                    </div>
                </div>
                <div class="pod" onclick="window.location = '${pageContext.request.contextPath}/index.fin'">
                    <img src="https://d3t3ozftmdmh3i.cloudfront.net/production/podcast_uploaded/3351519/3351519-1677217163769-b98817353d66a.jpg" alt="Simerjeet Singh" onerror="this.outerHTML='<div class=pod-ph>🎤</div>'">
                    <button class="pod-play"><i class="fa-solid fa-play"></i></button>
                    <div class="pod-info">
                        <div class="pod-title">Simerjeet Singh</div>
                        <div class="pod-author">Simerjeet Singh Podcast</div>
                        <span class="pod-tag">Education</span>
                    </div>
                </div>
                <div class="pod" onclick="window.location = '${pageContext.request.contextPath}/index.fin'">
                    <img src="https://d3t3ozftmdmh3i.cloudfront.net/staging/podcast_uploaded_nologo/41889934/41889934-1760533194703-74d34863e7497.jpg" alt="Horror Tape" onerror="this.outerHTML='<div class=pod-ph>👻</div>'">
                    <button class="pod-play"><i class="fa-solid fa-play"></i></button>
                    <div class="pod-info">
                        <div class="pod-title">Horror Tape</div>
                        <div class="pod-author">V. K. Rawat</div>
                        <span class="pod-tag">Horror</span>
                    </div>
                </div>
                <div class="pod" onclick="window.location = '${pageContext.request.contextPath}/index.fin'">
                    <img src="https://megaphone.imgix.net/podcasts/6fe427ec-b863-11ed-9e3b-f79bd21a2f4d/image/f75d642572ec0815e36be6a49a0284e6.png?ixlib=rails-4.3.1&max-w=3000&max-h=3000&fit=crop&auto=format,compress" alt="Netflix" onerror="this.outerHTML='<div class=pod-ph>😂</div>'">
                    <button class="pod-play"><i class="fa-solid fa-play"></i></button>
                    <div class="pod-info">
                        <div class="pod-title">Netflix Is A Daily Joke</div>
                        <div class="pod-author">Netflix</div>
                        <span class="pod-tag">Comedy</span>
                    </div>
                </div>
                <div class="pod" onclick="window.location = '${pageContext.request.contextPath}/index.fin'">
                    <img src="https://image.simplecastcdn.com/images/7f2f4c05-9c2f-4deb-82b7-b538062bc22d/73549bf1-94b3-40ff-8aeb-b4054848ec1b/3000x3000/the-daily-album-art-original.jpg?aid=rss_feed" alt="Modern Love" onerror="this.outerHTML='<div class=pod-ph>❤</div>'">
                    <button class="pod-play"><i class="fa-solid fa-play"></i></button>
                    <div class="pod-info">
                        <div class="pod-title">Modern Love NYT</div>
                        <div class="pod-author">NYT</div>
                        <span class="pod-tag">Love</span>
                    </div>
                </div>
                <div class="pod" onclick="window.location = '${pageContext.request.contextPath}/index.fin'">
                    <img src="https://d3t3ozftmdmh3i.cloudfront.net/production/podcast_uploaded_nologo/10685580/10685580-1605460352457-9e8f2b251ef21.jpg" alt="Horror" onerror="this.outerHTML='<div class=pod-ph>💀</div>'">
                    <button class="pod-play"><i class="fa-solid fa-play"></i></button>
                    <div class="pod-info">
                        <div class="pod-title">Horror & Mystery</div>
                        <div class="pod-author">Deepak Medatwal</div>
                        <span class="pod-tag">Horror</span>
                    </div>
                </div>
                <div class="pod" onclick="window.location = '${pageContext.request.contextPath}/index.fin'">
                    <img src="https://d3t3ozftmdmh3i.cloudfront.net/staging/podcast_uploaded_nologo/31923216/31923216-1698674345725-0e3006beb4e3c.jpg" alt="Growth Genius" onerror="this.outerHTML='<div class=pod-ph>📈</div>'">
                    <button class="pod-play"><i class="fa-solid fa-play"></i></button>
                    <div class="pod-info">
                        <div class="pod-title">Growth Genius TGG</div>
                        <div class="pod-author">Mehul Ashar</div>
                        <span class="pod-tag">Education</span>
                    </div>
                </div>
                <div class="pod" onclick="window.location = '${pageContext.request.contextPath}/index.fin'">
                    <img src="https://static.libsyn.com/p/assets/2/7/c/b/27cb0d3f502e4e85e5bbc093207a2619/40864291.png" alt="Teachers Off Duty" onerror="this.outerHTML='<div class=pod-ph>👩‍🏫</div>'">
                    <button class="pod-play"><i class="fa-solid fa-play"></i></button>
                    <div class="pod-info">
                        <div class="pod-title">Teachers Off Duty</div>
                        <div class="pod-author">Bored Teachers</div>
                        <span class="pod-tag">Comedy</span>
                    </div>
                </div>
            </div>
        </div>

        <%-- ABOUT --%>
        <div class="section" id="about">
            <div class="about-grid">
                <div class="about-text">
                    <div class="sec-tag">About</div>
                    <div class="sec-h2">Built for <span>real listeners</span></div>
                    <p>PodcastMgr is a full-stack podcast management app inspired by Spotify and Apple Podcast. Paste any RSS feed URL — cover image and audio are auto-fetched and stored in MySQL via Spring MVC.</p>
                    <p>Users can add, edit and delete their own podcasts. Everyone can listen. Search by title, author or category.</p>
                    <div class="tech-pills">
                        <span class="pill">Spring MVC</span>
                        <span class="pill">MySQL</span>
                        <span class="pill">JDBC Template</span>
                        <span class="pill">RSS Parsing</span>
                        <span class="pill">JSP</span>
                        <span class="pill">HTML</span>
                        <span class="pill">CSS</span>
                        <span class="pill">JS</span>
                    </div>
                </div>
                <div class="feat-grid">
                    <div class="feat">
                        <div class="feat-ico"><i class="fa-solid fa-play"></i></div>
                        <h3>Real Audio Streaming</h3>
                        <p>Stream real podcast episodes directly in browser with full player controls.</p>
                    </div>
                    <div class="feat">
                        <div class="feat-ico"><i class="fa-solid fa-satellite-dish"></i></div>
                        <h3>RSS Auto-Fetch</h3>
                        <p>Image and audio extracted automatically from RSS feed URL.</p>
                    </div>
                    <div class="feat">
                        <div class="feat-ico"><i class="fa-solid fa-lock"></i></div>
                        <h3>User Ownership</h3>
                        <p>Edit and delete only your own podcasts securely.</p>
                    </div>
                    <div class="feat">
                        <div class="feat-ico"><i class="fa-solid fa-magnifying-glass"></i></div>
                        <h3>Smart Search</h3>
                        <p>Search by title, author or category instantly.</p>
                    </div>
                </div>
            </div>
        </div>

        <%-- CTA --%>
        <div class="section" id="cta">
            <div class="cta-box">
                <h2>Ready to start listening?</h2>
                <p>Create your free account and start streaming podcasts today.</p>
                <div class="cta-btns">
                    <button class="btn-primary" onclick="window.location = '${pageContext.request.contextPath}/index.fin'">
                        <i class="fa-solid fa-headphones"></i> Get started free
                    </button>
                    <button class="btn-outline" onclick="window.location = '${pageContext.request.contextPath}/login.fin'">
                        <i class="fa-solid fa-right-to-bracket"></i> Log in
                    </button>
                </div>
            </div>
        </div>

        <%-- FOOTER --%>
        <div class="footer">
            <div class="f-logo"><i class="fa-solid fa-microphone"></i> PodcastMgr</div>
            <div class="f-links">
                <a href="https://github.com/rupalshukla82/Podcast-Managment-System/">Source Code </a>
               
                <a href="${pageContext.request.contextPath}/index.fin">Sign Up</a>
                <a href="${pageContext.request.contextPath}/login.fin">Login</a>
            </div>
            <div class="f-copy">© 2026 PodcastMgr · Spring MVC + MySQL</div>
        </div>

        <script>
            var isPlaying = true, fw = 35, iv;

            function tick() {
                fw += 0.08;
                if (fw > 100)
                    fw = 0;
                var e = document.getElementById('pl-fill');
                if (e)
                    e.style.width = fw + '%';
            }

            iv = setInterval(tick, 120);

            function togglePlay() {
                isPlaying = !isPlaying;
                var btn = document.getElementById('pl-btn');
                btn.innerHTML = isPlaying
                        ? '<i class="fa-solid fa-pause"></i>'
                        : '<i class="fa-solid fa-play"></i>';
                isPlaying ? (iv = setInterval(tick, 120)) : clearInterval(iv);
            }
        </script>
    </body>
</html>
