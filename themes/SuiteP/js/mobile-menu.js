/**
 * Modern Right-Slide Navigation Menu for uCRM
 * Slides in from the right with smooth animation
 */

(function() {
    'use strict';

    // Create slide menu HTML
    function createSlideMenu() {
        if ($('.mobile-slide-menu').length === 0) {
            // Get the existing mobile menu
            var $existingMenu = $('.navbar-header .mobile_menu').clone();

            // Create slide menu container
            var $slideMenu = $('<div class="mobile-slide-menu">' +
                '<button class="mobile-menu-close">&times;</button>' +
                '<div class="mobile-menu-content"></div>' +
                '</div>');

            // Add menu to container
            $slideMenu.find('.mobile-menu-content').append($existingMenu);

            // Create overlay
            var $overlay = $('<div class="mobile-menu-overlay"></div>');

            // Add to page
            $('body').append($overlay).append($slideMenu);
        }
    }

    // Toggle menu
    function toggleMenu(e) {
        e.preventDefault();
        $('.mobile-slide-menu').toggleClass('active');
        $('.mobile-menu-overlay').toggleClass('active');
        $('body').toggleClass('mobile-menu-open');
    }

    // Close menu
    function closeMenu() {
        $('.mobile-slide-menu').removeClass('active');
        $('.mobile-menu-overlay').removeClass('active');
        $('body').removeClass('mobile-menu-open');
    }

    // Initialize
    $(document).ready(function() {
        createSlideMenu();

        // Toggle button click
        $(document).on('click', '.navbar-toggle[data-toggle="slide-menu"]', toggleMenu);

        // Close button click
        $(document).on('click', '.mobile-menu-close', closeMenu);

        // Overlay click
        $(document).on('click', '.mobile-menu-overlay', closeMenu);

        // ESC key to close
        $(document).on('keydown', function(e) {
            if (e.key === 'Escape' && $('.mobile-slide-menu').hasClass('active')) {
                closeMenu();
            }
        });
    });
})();
