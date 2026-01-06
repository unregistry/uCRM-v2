{*
/**
 * www.onl Agent Dashboard Login Page
 * Completely redesigned to match www.onl home page
 * This template replaces the default SuiteCRM login page
 *}
<script>
    // Early theme script to prevent flash of content
    (function() {
        var savedTheme = localStorage.getItem('theme');
        var theme = savedTheme || 'light';
        if (document.documentElement) {
            document.documentElement.setAttribute('data-theme', theme);
        }
    })();
</script>

<style>
    /* Hide default SuiteCRM page elements */
    .p_login > * { display: none; }
    .onl-login-wrapper { display: block !important; }
</style>

<!-- www.onl Styles -->
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">
<link rel="stylesheet" href="/css/style.css?v=20250101-5">
<link rel="stylesheet" href="/agent/dashboard/custom/css/login-page-complete.css">
<link rel="stylesheet" href="/agent/dashboard/custom/css/login-fix.css">

<!-- Close existing page container and open www.onl structure -->
<script>
(function() {
    // Hide original content
    var originalContent = document.querySelector('.p_login');
    if (originalContent) {
        originalContent.style.display = 'none';
    }
})();
</script>

<div class="onl-login-wrapper" style="display: none;">
    <!-- ==========================================================================
         www.onl Navigation Bar
         ========================================================================== -->
    <nav class="onl-navbar">
        <div class="onl-nav-container">
            <!-- Logo -->
            <div class="onl-nav-brand">
                <a href="https://www.onl" target="_blank">
                    <img src="/images/wwwonl-logo-dark-default.svg" alt="www.onl" class="onl-logo logo-dark">
                    <img src="/images/wwwonl-logo-light-default.svg" alt="www.onl" class="onl-logo logo-light">
                </a>
            </div>

            <!-- Desktop Menu -->
            <div class="onl-nav-menu">
                <a href="https://www.onl/tld-types/" target="_blank" class="onl-nav-link">TLD Types</a>
                <a href="https://www.onl/calculator/" target="_blank" class="onl-nav-link">Calculator</a>
                <a href="https://www.onl/contact/" target="_blank" class="onl-nav-link">Contact</a>
                <a href="https://www.onl/apply/" target="_blank" class="onl-nav-link">Start</a>

                <!-- Theme Toggle -->
                <button class="onl-theme-toggle" aria-label="Toggle theme">
                    <svg class="onl-theme-icon onl-sun-icon" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <circle cx="12" cy="12" r="5"></circle>
                        <line x1="12" y1="1" x2="12" y2="3"></line>
                        <line x1="12" y1="21" x2="12" y2="23"></line>
                        <line x1="4.22" y1="4.22" x2="5.64" y2="5.64"></line>
                        <line x1="18.36" y1="18.36" x2="19.78" y2="19.78"></line>
                        <line x1="1" y1="12" x2="3" y2="12"></line>
                        <line x1="21" y1="12" x2="23" y2="12"></line>
                        <line x1="4.22" y1="19.78" x2="5.64" y2="18.36"></line>
                        <line x1="18.36" y1="5.64" x2="19.78" y2="4.22"></line>
                    </svg>
                    <svg class="onl-theme-icon onl-moon-icon" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="display: none;">
                        <path d="M21 12.79A9 9 0 1 1 11.21 3 7 7 0 0 0 21 12.79z"></path>
                    </svg>
                </button>
            </div>

            <!-- Mobile Menu Toggle -->
            <button class="onl-nav-toggle" aria-label="Toggle menu">
                <span></span>
                <span></span>
                <span></span>
            </button>
        </div>
    </nav>

    <!-- ==========================================================================
         Login Content
         ========================================================================== -->
    <div class="p_login">
        <div class="p_login_middle">
            <div class="onl-login-container">
                <div class="onl-login-card">
                    <!-- Login Header -->
                    <div class="onl-login-title">
                        <h1>Agent Portal</h1>
                        <p>Access your www.onl agent dashboard</p>
                    </div>

                    <!-- Error Messages -->
                    {if $LOGIN_ERROR_MESSAGE}
                        <p align='center' class='error'>{$LOGIN_ERROR_MESSAGE}</p>
                    {/if}

                    <!-- Main Login Form -->
                    <div id="loginform">
                        <form class="form-signin" role="form" action="index.php" method="post" name="DetailView" id="form"
                              onsubmit="return document.getElementById('cant_login').value == ''" autocomplete="off">

                            {if $LOGIN_ERROR !=''}
                                <span class="error">{$LOGIN_ERROR}</span>
                                {if $WAITING_ERROR !=''}
                                    <span class="error">{$WAITING_ERROR}</span>
                                {/if}
                            {else}
                                <span id='post_error' class="error"></span>
                            {/if}

                            <input type="hidden" name="module" value="Users">
                            <input type="hidden" name="action" value="Authenticate">
                            <input type="hidden" name="return_module" value="Users">
                            <input type="hidden" name="return_action" value="Login">
                            <input type="hidden" id="cant_login" name="cant_login" value="">

                            {foreach from=$LOGIN_VARS key=key item=var}
                                <input type="hidden" name="{$key}" value="{$var}">
                            {/foreach}

                            {if !empty($SELECT_LANGUAGE)}
                                <div class="onl-form-group">
                                    <label for="login_language" style="display:block; margin-bottom:8px; color:var(--text-secondary); font-size:14px;">
                                        {sugar_translate module="Users" label="LBL_LANGUAGE"}:
                                    </label>
                                    <select name='login_language' id="login_language" class="onl-form-control" onchange="switchLanguage(this.value)">
                                        {$SELECT_LANGUAGE}
                                    </select>
                                </div>
                            {/if}

                            <!-- Username -->
                            <div class="onl-form-group">
                                <label for="user_name" style="display:block; margin-bottom:8px; color:var(--text-secondary); font-size:14px;">
                                    {sugar_translate module="Users" label="LBL_USER_NAME"}
                                </label>
                                <input type="text" class="onl-form-control"
                                       placeholder="Enter your username"
                                       required autofocus
                                       tabindex="1"
                                       id="user_name"
                                       name="user_name"
                                       value='{$LOGIN_USER_NAME}'
                                       autocomplete="username">
                            </div>

                            <!-- Password -->
                            <div class="onl-form-group">
                                <label for="username_password" style="display:block; margin-bottom:8px; color:var(--text-secondary); font-size:14px;">
                                    {sugar_translate module="Users" label="LBL_PASSWORD"}
                                </label>
                                <input type="password" class="onl-form-control"
                                       placeholder="Enter your password"
                                       tabindex="2"
                                       id="username_password"
                                       name="username_password"
                                       value='{$LOGIN_PASSWORD}'
                                       autocomplete="current-password">
                            </div>

                            <!-- Submit Button -->
                            <button type="submit" class="onl-submit-btn" tabindex="3" name="Login">
                                {sugar_translate module="Users" label="LBL_LOGIN_BUTTON_LABEL"}
                            </button>

                            <!-- Forgot Password Link -->
                            {if $DISPLAY_FORGOT_PASSWORD_FEATURE neq '' && $DISPLAY_FORGOT_PASSWORD_FEATURE neq 'none'}
                            <div style="text-align: center; margin-top: 20px;">
                                <a href='javascript:void(0)'
                                   onclick='toggleDisplay("forgot_password_dialog")'
                                   style="color: var(--primary-gold); text-decoration: none; font-size: 14px;">
                                    {sugar_translate module="Users" label="LBL_LOGIN_FORGOT_PASSWORD"}
                                </a>
                            </div>
                            {/if}
                        </form>

                        <!-- Forgot Password Form -->
                        <form class="form-signin passform" role="form" action="index.php" method="post" name="fp_form" id="fp_form" autocomplete="off">
                            <div id="forgot_password_dialog" style="display:none; margin-top: 30px;">
                                <h3 style="text-align: center; color: var(--text-primary); margin-bottom: 20px;">
                                    {sugar_translate module="Users" label="LBL_LOGIN_FORGOT_PASSWORD"}
                                </h3>
                                <div id="generate_success" class='error' style="display:inline;"></div>

                                <div class="onl-form-group">
                                    <label for="fp_user_name" style="display:block; margin-bottom:8px; color:var(--text-secondary); font-size:14px;">
                                        {sugar_translate module="Users" label="LBL_USER_NAME"}
                                    </label>
                                    <input type="text" class="onl-form-control"
                                           id="fp_user_name"
                                           name="fp_user_name"
                                           value='{$LOGIN_USER_NAME}'
                                           placeholder="Enter your username"
                                           autocomplete="username">
                                </div>

                                <div class="onl-form-group">
                                    <label for="fp_user_mail" style="display:block; margin-bottom:8px; color:var(--text-secondary); font-size:14px;">
                                        {sugar_translate module="Users" label="LBL_EMAIL"}
                                    </label>
                                    <input type="email" class="onl-form-control"
                                           id="fp_user_mail"
                                           name="fp_user_mail"
                                           value=''
                                           placeholder="Enter your email"
                                           autocomplete="email">
                                </div>

                                {$CAPTCHA}
                                <div id='wait_pwd_generation'></div>
                                <button type="button"
                                        class="onl-submit-btn"
                                        onclick="validateAndSubmit(); return document.getElementById('cant_login').value == ''"
                                        id="generate_pwd_button"
                                        name="fp_login"
                                        style="margin-top: 10px;">
                                    {sugar_translate module="Users" label="LBL_LOGIN_SUBMIT"}
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- ==========================================================================
             www.onl Footer
             ========================================================================== -->
        <footer class="onl-footer">
            <div class="onl-footer-content">
                <!-- Logo Section -->
                <div class="onl-footer-line">
                    <div class="onl-footer-logo-wrapper">
                        <a href="https://www.onl" target="_blank">
                            <img src="/images/wwwonl-logo-dark-default.svg" alt="www.onl" class="onl-footer-logo-img logo-dark">
                            <img src="/images/wwwonl-logo-light-default.svg" alt="www.onl" class="onl-footer-logo-img logo-light">
                        </a>
                    </div>
                </div>

                <!-- Links -->
                <div class="onl-footer-line onl-footer-links">
                    <a href="https://www.onl/tld-types/" target="_blank" class="onl-footer-link">TLD Types</a>
                    <a href="https://www.onl/calculator/" target="_blank" class="onl-footer-link">Calculator</a>
                    <a href="https://www.onl/contact/" target="_blank" class="onl-footer-link">Contact</a>
                    <a href="https://www.onl/legal/" target="_blank" class="onl-footer-link">Legal</a>
                    <a href="https://www.onl/agent/" target="_blank" class="onl-footer-link">Agent Portal</a>
                </div>

                <!-- Powered By -->
                <div class="onl-footer-line">
                    <p class="onl-powered-by">
                        Powered by <a href="https://unregistry.com" target="_blank" rel="noopener" class="powered-by-u">Unregistry</a>
                    </p>
                </div>

                <!-- Copyright -->
                <div class="onl-footer-line onl-copyright">
                    <p>
                        &copy; <span id="copyright-year">2026</span>
                        <a href="https://www.onl">World Wide Web Online</a> - All rights reserved.
                    </p>
                </div>
            </div>
        </footer>
    </div>

    <!-- ==========================================================================
         Mobile Menu
         ========================================================================== -->
    <div class="onl-mobile-overlay"></div>

    <div class="onl-mobile-menu">
        <div class="onl-mobile-menu-content">
            <a href="https://www.onl/tld-types/" target="_blank" class="onl-mobile-link">TLD Types</a>
            <a href="https://www.onl/calculator/" target="_blank" class="onl-mobile-link">Calculator</a>
            <a href="https://www.onl/contact/" target="_blank" class="onl-mobile-link">Contact</a>
            <a href="https://www.onl/apply/" target="_blank" class="onl-mobile-link">Start</a>

            <!-- Mobile Theme Toggle -->
            <button class="onl-theme-toggle-mobile" aria-label="Toggle theme" style="margin-top: 20px;">
                <svg class="onl-theme-icon onl-sun-icon" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <circle cx="12" cy="12" r="5"></circle>
                    <line x1="12" y1="1" x2="12" y2="3"></line>
                    <line x1="12" y1="21" x2="12" y2="23"></line>
                    <line x1="4.22" y1="4.22" x2="5.64" y2="5.64"></line>
                    <line x1="18.36" y1="18.36" x2="19.78" y2="19.78"></line>
                    <line x1="1" y1="12" x2="3" y2="12"></line>
                    <line x1="21" y1="12" x2="23" y2="12"></line>
                    <line x1="4.22" y1="19.78" x2="5.64" y2="18.36"></line>
                    <line x1="18.36" y1="5.64" x2="19.78" y2="4.22"></line>
                </svg>
                <svg class="onl-theme-icon onl-moon-icon" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="display: none;">
                    <path d="M21 12.79A9 9 0 1 1 11.21 3 7 7 0 0 0 21 12.79z"></path>
                </svg>
            </button>
        </div>
    </div>
</div>

<!-- ==========================================================================
     JavaScript - Load after DOM and replace page content
     ========================================================================== -->
<script src="/agent/dashboard/custom/js/login-theme-toggle.js"></script>
<script src="/agent/dashboard/custom/js/login-navigation.js"></script>

<script>
(function() {
    'use strict';

    // Wait for DOM to be ready
    function initLoginPage() {
        // Hide all original content
        var originalElements = document.querySelectorAll('.p_login > *, body > div:not(.onl-login-wrapper)');
        for (var i = 0; i < originalElements.length; i++) {
            originalElements[i].style.display = 'none';
        }

        // Show www.onl login wrapper
        var wrapper = document.querySelector('.onl-login-wrapper');
        if (wrapper) {
            wrapper.style.display = 'block';
            document.body.style.backgroundColor = getComputedStyle(document.documentElement).getPropertyValue('--bg-primary');
        }

        // Initialize theme
        var savedTheme = localStorage.getItem('theme') || 'light';
        document.body.setAttribute('data-theme', savedTheme);
    }

    // Run when DOM is ready
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', initLoginPage);
    } else {
        initLoginPage();
    }
})();
</script>

<script>
{literal}
function validateAndSubmit() {
    var form = document.getElementById('fp_form');
    if (form) {
        form.submit();
    }
}

function toggleDisplay(id) {
    var element = document.getElementById(id);
    if (element) {
        if (element.style.display === 'none') {
            element.style.display = 'block';
        } else {
            element.style.display = 'none';
        }
    }
}

function switchLanguage(lang) {
    var url = window.location.href;
    var separator = url.indexOf('?') !== -1 ? '&' : '?';
    window.location.href = url + separator + 'login_language=' + lang;
}
{/literal}
</script>
