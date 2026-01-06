/**
 * www.onl Login Page Navigation
 * Mobile menu and theme toggle functionality for the login page
 */

(function() {
    'use strict';

    // Wait for DOM to be ready
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', initLoginNavigation);
    } else {
        initLoginNavigation();
    }

    function initLoginNavigation() {
        // Select elements
        const navToggle = document.querySelector('.nav-toggle');
        const mobileMenu = document.querySelector('.mobile-menu');
        const mobileOverlay = document.querySelector('.mobile-menu-overlay');
        const mobileLinks = document.querySelectorAll('.mobile-link');
        const themeToggle = document.querySelector('.theme-toggle');

        // Mobile menu toggle functionality
        if (navToggle) {
            navToggle.addEventListener('click', function(e) {
                e.preventDefault();
                e.stopPropagation();
                toggleMobileMenu();
            });
        }

        // Theme toggle functionality
        if (themeToggle) {
            themeToggle.addEventListener('click', function(e) {
                e.preventDefault();
                toggleTheme();
            });
        }

        // Close mobile menu when clicking on links
        mobileLinks.forEach(function(link) {
            link.addEventListener('click', function() {
                closeMobileMenu();
            });
        });

        // Close mobile menu when clicking overlay
        if (mobileOverlay) {
            mobileOverlay.addEventListener('click', function() {
                closeMobileMenu();
            });
        }

        // Close menu on escape key
        document.addEventListener('keydown', function(e) {
            if (e.key === 'Escape' && mobileMenu && mobileMenu.classList.contains('active')) {
                closeMobileMenu();
            }
        });

        // Update copyright year
        const yearElements = document.querySelectorAll('#current-year');
        const currentYear = new Date().getFullYear();
        yearElements.forEach(function(el) {
            el.textContent = currentYear;
        });

        /**
         * Toggle mobile menu open/closed
         */
        function toggleMobileMenu() {
            if (!mobileMenu || !navToggle) return;

            const isActive = mobileMenu.classList.toggle('active');
            navToggle.classList.toggle('active', isActive);

            // Toggle overlay
            if (mobileOverlay) {
                if (isActive) {
                    mobileOverlay.style.display = 'block';
                } else {
                    mobileOverlay.style.display = 'none';
                }
            }

            // Animate hamburger menu
            const spans = navToggle.querySelectorAll('span');
            if (spans.length >= 3) {
                if (isActive) {
                    // Transform to X
                    spans[0].style.transform = 'rotate(45deg) translateY(8px)';
                    spans[1].style.opacity = '0';
                    spans[2].style.transform = 'rotate(-45deg) translateY(-8px)';
                } else {
                    // Reset to hamburger
                    spans[0].style.transform = 'none';
                    spans[1].style.opacity = '1';
                    spans[2].style.transform = 'none';
                }
            }

            // Prevent body scroll when menu is open
            document.body.style.overflow = isActive ? 'hidden' : '';
        }

        /**
         * Close mobile menu
         */
        function closeMobileMenu() {
            if (!mobileMenu || !navToggle) return;

            mobileMenu.classList.remove('active');
            navToggle.classList.remove('active');

            // Close overlay
            if (mobileOverlay) {
                mobileOverlay.style.display = 'none';
            }

            // Reset hamburger animation
            const spans = navToggle.querySelectorAll('span');
            if (spans.length >= 3) {
                spans[0].style.transform = 'none';
                spans[1].style.opacity = '1';
                spans[2].style.transform = 'none';
            }

            // Restore body scroll
            document.body.style.overflow = '';
        }

        /**
         * Toggle theme between light and dark
         */
        function toggleTheme() {
            const html = document.documentElement;
            const body = document.body;
            const currentTheme = html.getAttribute('data-theme') || 'light';
            const newTheme = currentTheme === 'light' ? 'dark' : 'light';

            // Update theme
            html.setAttribute('data-theme', newTheme);
            body.setAttribute('data-theme', newTheme);

            // Save to localStorage
            try {
                localStorage.setItem('theme', newTheme);
            } catch (e) {
                // localStorage not available
            }

            // Update theme icon visibility
            const sunIcon = themeToggle.querySelector('.sun-icon');
            const moonIcon = themeToggle.querySelector('.moon-icon');

            if (sunIcon && moonIcon) {
                if (newTheme === 'dark') {
                    sunIcon.style.display = 'none';
                    moonIcon.style.display = 'block';
                } else {
                    sunIcon.style.display = 'block';
                    moonIcon.style.display = 'none';
                }
            }
        }

        // Initialize theme from localStorage or system preference
        function initTheme() {
            const html = document.documentElement;
            const body = document.body;
            const themeToggle = document.querySelector('.theme-toggle');

            let savedTheme = 'light';

            // Check localStorage first
            try {
                savedTheme = localStorage.getItem('theme') || 'light';
            } catch (e) {
                // localStorage not available, use system preference
                if (window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches) {
                    savedTheme = 'dark';
                }
            }

            // Apply theme
            html.setAttribute('data-theme', savedTheme);
            body.setAttribute('data-theme', savedTheme);

            // Update theme icon visibility
            if (themeToggle) {
                const sunIcon = themeToggle.querySelector('.sun-icon');
                const moonIcon = themeToggle.querySelector('.moon-icon');

                if (sunIcon && moonIcon) {
                    if (savedTheme === 'dark') {
                        sunIcon.style.display = 'none';
                        moonIcon.style.display = 'block';
                    } else {
                        sunIcon.style.display = 'block';
                        moonIcon.style.display = 'none';
                    }
                }
            }
        }

        // Initialize theme on page load
        initTheme();
    }
})();
