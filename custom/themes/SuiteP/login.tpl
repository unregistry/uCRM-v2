{*
/**
 * www.onl Agent Dashboard Login Page
 * Full www.onl website integration with SuiteCRM login form
 */}
{literal}
<script type='text/javascript'>
    var LBL_LOGIN_SUBMIT = '{/literal}{sugar_translate module="Users" label="LBL_LOGIN_SUBMIT"}{literal}';
    var LBL_REQUEST_SUBMIT = '{/literal}{sugar_translate module="Users" label="LBL_REQUEST_SUBMIT"}{literal}';
    var LBL_SHOWOPTIONS = '{/literal}{sugar_translate module="Users" label="LBL_SHOWOPTIONS"}{literal}';
    var LBL_HIDEOPTIONS = '{/literal}{sugar_translate module="Users" label="LBL_HIDEOPTIONS"}{literal}';
{/literal}
</script>

<!-- www.onl CSS -->
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">
<link rel="stylesheet" href="/css/style.css?v=20250101-5">

<!-- ==========================================================================
     www.onl Navigation Bar
     ========================================================================== -->
<nav class="navbar">
    <div class="nav-container">
        <div class="nav-brand">
            <a href="/">
                <img src="/images/wwwonl-logo-dark-default.svg" alt="www.onl" class="logo logo-dark">
                <img src="/images/wwwonl-logo-light-default.svg" alt="www.onl" class="logo logo-light">
            </a>
        </div>
        <div class="nav-menu">
            <a href="/tld-types/" class="nav-link">TLD Types</a>
            <a href="/calculator/" class="nav-link">Calculator</a>
            <a href="/contact/" class="nav-link">Contact</a>
            <a href="/apply/" class="nav-link">Start</a>
            <button class="theme-toggle" aria-label="Toggle theme">
                <svg class="theme-icon sun-icon" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
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
                <svg class="theme-icon moon-icon" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" style="display: none;">
                    <path d="M21 12.79A9 9 0 1 1 11.21 3 7 7 0 0 0 21 12.79z"></path>
                </svg>
            </button>
        </div>
        <button class="nav-toggle" aria-label="Toggle menu">
            <span></span>
            <span></span>
            <span></span>
        </button>
    </div>
</nav>

<!-- Mobile Menu -->
<div class="mobile-menu-overlay"></div>
<div class="mobile-menu">
    <div class="mobile-menu-content">
        <a href="/tld-types/" class="mobile-link">TLD Types</a>
        <a href="/calculator/" class="mobile-link">Calculator</a>
        <a href="/contact/" class="mobile-link">Contact</a>
        <a href="/apply/" class="mobile-link">Start</a>
    </div>
</div>

<!-- ==========================================================================
     Login Container
     ========================================================================== -->
<div class="p_login">
    {* Hide SuiteCRM branding - CSS handles this *}

    <div class="p_login_middle">
        <div style="max-width: 450px; margin: 60px auto; padding: 40px; background: rgba(255,255,255,0.95); border-radius: 16px; box-shadow: 0 20px 60px rgba(0,0,0,0.3);">

            {if $LOGIN_ERROR_MESSAGE}
                <p align='center' class='error'>{$LOGIN_ERROR_MESSAGE}</p>
            {/if}

            <div id="loginform">
                <h2 style="text-align: center; margin-bottom: 30px; color: #cc9933;">Agent Portal Login</h2>

                <form class="form-signin" role="form" action="index.php" method="post" name="DetailView" id="form"
                      onsubmit="return document.getElementById('cant_login').value == ''" autocomplete="off">

                    <span class="error" id="browser_warning" style="display:none">
                        {sugar_translate label="WARN_BROWSER_VERSION_WARNING"}
                    </span>
                    <span class="error" id="ie_compatibility_mode_warning" style="display:none">
                        {sugar_translate label="WARN_BROWSER_IE_COMPATIBILITY_MODE_WARNING"}
                    </span>

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
                        <div style="margin-bottom: 15px;">
                            <label style="display: block; margin-bottom: 5px; color: #666;">
                                {sugar_translate module="Users" label="LBL_LANGUAGE"}:
                            </label>
                            <select name='login_language' class="form-control" style="width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 6px;" onchange="switchLanguage(this.value)">{$SELECT_LANGUAGE}</select>
                        </div>
                    {/if}

                    <div style="margin-bottom: 15px;">
                        <input type="text" class="form-control"
                               placeholder="{sugar_translate module="Users" label="LBL_USER_NAME"}" required autofocus
                               tabindex="1" id="user_name" name="user_name" value='{$LOGIN_USER_NAME}' autocomplete="off"
                               style="width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 6px;">
                    </div>

                    <div style="margin-bottom: 15px;">
                        <input type="password" class="form-control"
                               placeholder="{sugar_translate module="Users" label="LBL_PASSWORD"}" tabindex="2"
                               id="username_password" name="username_password" value='{$LOGIN_PASSWORD}' autocomplete="off"
                               style="width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 6px;">
                    </div>

                    <button type="submit" class="btn btn-primary"
                            title="{sugar_translate module="Users" label="LBL_LOGIN_BUTTON_TITLE"}" tabindex="3" name="Login"
                            value="{sugar_translate module="Users" label="LBL_LOGIN_BUTTON_LABEL"}"
                            style="width: 100%; padding: 12px; background: linear-gradient(135deg, #997226, #cc9933); border: none; border-radius: 6px; color: white; font-weight: 600; cursor: pointer;">
                        {sugar_translate module="Users" label="LBL_LOGIN_BUTTON_LABEL"}
                    </button>

                    {if $DISPLAY_FORGOT_PASSWORD_FEATURE neq '' && $DISPLAY_FORGOT_PASSWORD_FEATURE neq 'none'}
                    <div style="text-align: center; margin-top: 15px;">
                        <a href='javascript:void(0)' onclick='toggleDisplay("forgot_password_dialog")'
                           style="color: #997226; text-decoration: none;">
                            {sugar_translate module="Users" label="LBL_LOGIN_FORGOT_PASSWORD"}
                        </a>
                    </div>
                    {/if}
                </form>

                <form class="form-signin passform" role="form" action="index.php" method="post" name="fp_form" id="fp_form" autocomplete="off">
                    <div id="forgot_password_dialog" style="display:none">
                        <input type="hidden" name="entryPoint" value="GeneratePassword">
                        <div id="generate_success" class='error' style="display:inline;"></div>
                        <h3 style="text-align: center; margin-bottom: 15px;">{sugar_translate module="Users" label="LBL_LOGIN_FORGOT_PASSWORD"}</h3>
                        <div style="margin-bottom: 15px;">
                            <input type="text" class="form-control" id="fp_user_name" name="fp_user_name"
                                   value='{$LOGIN_USER_NAME}'
                                   placeholder="{sugar_translate module="Users" label="LBL_USER_NAME"}" autocomplete="off"
                                   style="width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 6px;">
                        </div>
                        <div style="margin-bottom: 15px;">
                            <input type="text" class="form-control" id="fp_user_mail" name="fp_user_mail" value=''
                                   placeholder="{sugar_translate module="Users" label="LBL_EMAIL"}" autocomplete="off"
                                   style="width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 6px;">
                        </div>
                        {$CAPTCHA}
                        <div id='wait_pwd_generation'></div>
                        <button type="button" class="btn btn-primary"
                                onclick="validateAndSubmit(); return document.getElementById('cant_login').value == ''"
                                id="generate_pwd_button" name="fp_login"
                                style="width: 100%; padding: 12px; background: linear-gradient(135deg, #997226, #cc9933); border: none; border-radius: 6px; color: white; font-weight: 600; cursor: pointer;">
                            {sugar_translate module="Users" label="LBL_LOGIN_SUBMIT"}
                        </button>
                    </div>
                </form>

            </div>
        </div>
    </div>

    <div class="p_login_bottom" style="display: none;">
        {* Hidden by CSS - using www.onl footer instead *}
    </div>
</div>

<!-- ==========================================================================
     www.onl Footer
     ========================================================================== -->
<footer class="footer">
    <div class="container">
        <div class="footer-content-new">
            <div class="footer-line footer-logo-section">
                <a href="/">
                    <img src="/images/wwwonl-logo-dark-default.svg" alt="www.onl" class="footer-logo-img logo-dark">
                    <img src="/images/wwwonl-logo-light-default.svg" alt="www.onl" class="footer-logo-img logo-light">
                </a>
            </div>
            <div class="footer-line footer-links">
                <a href="/tld-types/" class="footer-link">TLD Types</a>
                <span class="footer-separator">•</span>
                <a href="/calculator/" class="footer-link">Calculator</a>
                <span class="footer-separator">•</span>
                <a href="/contact/" class="footer-link">Contact</a>
                <span class="footer-separator">•</span>
                <a href="/legal/" class="footer-link">Legal</a>
                <span class="footer-separator">•</span>
                <a href="/agent/dashboard/" class="footer-link">Agent Portal</a>
            </div>
            <div class="footer-line footer-powered-by-line">
                Powered by <a href="https://unregistry.com" class="powered-by-unregistry">Unregistry</a>
            </div>
            <div class="footer-line footer-copyright">
                <span class="footer-copyright">
                    &copy; <span id="current-year"></span> <a href="/">World Wide Web Online</a>. All rights reserved.
                </span>
            </div>
        </div>
    </div>
</footer>

<!-- www.onl JavaScript - main.js removed (incompatible with login page) -->
<script src="/agent/dashboard/custom/js/login-navigation.js"></script>

{literal}
<style>
/* Hide SuiteCRM branding on login page */
.p_login_top { display: none !important; }
.p_login_bottom { display: none !important; }
.p_login { background: transparent !important; }
</style>
{/literal}
