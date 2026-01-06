/**
 * www.onl Login Page Navigation
 * Mobile menu functionality for the login page
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
        const navToggle = document.querySelector('.onl-nav-toggle');
        const mobileMenu = document.querySelector('.onl-mobile-menu');
        const mobileOverlay = document.querySelector('.onl-mobile-overlay');
        const mobileLinks = document.querySelectorAll('.onl-mobile-link');

        // Mobile menu toggle functionality
        if (navToggle) {
            navToggle.addEventListener('click', function(e) {
                e.preventDefault();
                toggleMobileMenu();
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

        /**
         * Toggle mobile menu open/closed
         */
        function toggleMobileMenu() {
            if (!mobileMenu || !navToggle) return;

            const isActive = mobileMenu.classList.toggle('active');
            navToggle.classList.toggle('active', isActive);

            // Toggle overlay
            if (mobileOverlay) {
                mobileOverlay.classList.toggle('active', isActive);
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
                mobileOverlay.classList.remove('active');
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
    }
})();
