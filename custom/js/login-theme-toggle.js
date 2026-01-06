/**
 * Theme Toggle JavaScript
 * Handles theme switching between Day and Night modes
 *
 * @author www.onl
 * @version 1.0
 */

(function() {
    'use strict';

    const CONFIG = {
        apiEndpoint: 'index.php?entryPoint=themeToggle',
        buttonId: 'onl-theme-toggle-btn',
        themes: { light: 'Day', dark: 'Night' }
    };

    class ThemeToggle {
        constructor() {
            this.currentTheme = null;
            this.isLoading = false;
            this.button = null;
        }

        init() {
            if (document.readyState === 'loading') {
                document.addEventListener('DOMContentLoaded', () => this.setup());
            } else {
                this.setup();
            }
        }

        setup() {
            this.detectCurrentTheme();
            this.createButton();
            this.updateButtonIcon();
            this.button.addEventListener('click', (e) => {
                e.preventDefault();
                this.toggleTheme();
            });
        }

        detectCurrentTheme() {
            // Check body class or data attribute
            const bodyTheme = document.body.getAttribute('data-subtheme');
            if (bodyTheme && (bodyTheme === 'Day' || bodyTheme === 'Night')) {
                this.currentTheme = bodyTheme;
            } else {
                // Default to Day (light mode)
                this.currentTheme = 'Day';
            }
        }

        updateButtonIcon() {
            const sunIcon = this.button.querySelector('.sun-icon');
            const moonIcon = this.button.querySelector('.moon-icon');

            if (this.currentTheme === 'Night') {
                sunIcon.style.display = 'none';
                moonIcon.style.display = 'block';
            } else {
                sunIcon.style.display = 'block';
                moonIcon.style.display = 'none';
            }
        }

        createButton() {
            const footer = document.querySelector('.onl-footer') || document.querySelector('footer');
            if (!footer) return;

            const container = document.createElement('div');
            container.className = 'onl-theme-toggle-container';

            const button = document.createElement('button');
            button.id = CONFIG.buttonId;
            button.className = 'onl-theme-toggle-btn';
            button.type = 'button';
            button.setAttribute('aria-label', 'Toggle theme');
            button.innerHTML = `
                <svg class="sun-icon" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
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
                <svg class="moon-icon" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" style="display: none;">
                    <path d="M21 12.79A9 9 0 1 1 11.21 3 7 7 0 0 0 21 12.79z"></path>
                </svg>
            `;

            container.appendChild(button);
            const copyrightDiv = footer.querySelector('.footer-copyright');
            if (copyrightDiv && copyrightDiv.parentNode) {
                copyrightDiv.parentNode.insertBefore(container, copyrightDiv);
            } else {
                footer.appendChild(container);
            }
            this.button = button;
        }

        toggleTheme() {
            if (this.isLoading) return;
            this.isLoading = true;
            this.button.classList.add('loading');

            // Toggle to opposite theme
            const newTheme = this.currentTheme === 'Day' ? 'Night' : 'Day';

            const formData = new FormData();
            formData.append('theme', newTheme);

            fetch(CONFIG.apiEndpoint, {
                method: 'POST',
                body: formData,
                credentials: 'same-origin'
            })
            .then(r => r.json())
            .then(data => {
                if (data.success) {
                    window.location.reload();
                } else {
                    alert('Failed: ' + (data.error || 'Unknown error'));
                    this.isLoading = false;
                    this.button.classList.remove('loading');
                }
            })
            .catch(err => {
                console.error(err);
                alert('Failed to toggle theme');
                this.isLoading = false;
                this.button.classList.remove('loading');
            });
        }
    }

    const themeToggle = new ThemeToggle();
    themeToggle.init();
})();
