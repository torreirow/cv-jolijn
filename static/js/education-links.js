// Make education items clickable and link to /experience/
document.addEventListener('DOMContentLoaded', function() {
  // Find all education items by looking for the degree titles
  const educationCards = document.querySelectorAll('.group.h-full.flex.flex-col');

  educationCards.forEach(function(card) {
    // Check if this card contains education content (has a degree title)
    const degreeTitle = card.querySelector('.text-xl.font-bold');
    if (degreeTitle) {
      // Make the card clickable
      card.style.cursor = 'pointer';

      // Add click handler to navigate to /experience/#education
      card.addEventListener('click', function() {
        window.location.href = '/experience/#education';
      });

      // Add aria-label for accessibility
      card.setAttribute('role', 'link');
      card.setAttribute('aria-label', 'View full education details: ' + degreeTitle.textContent.trim());
    }
  });

  // When on experience page, check for #education hash and scroll to Education section
  if (window.location.pathname === '/experience/' || window.location.pathname === '/experience') {
    function scrollToEducation() {
      if (window.location.hash === '#education') {
        // Find the Education heading
        const educationHeading = Array.from(document.querySelectorAll('h2')).find(h =>
          h.textContent.trim() === 'Education'
        );
        if (educationHeading) {
          // Scroll with offset for header
          const offset = 80;
          const elementPosition = educationHeading.getBoundingClientRect().top;
          const offsetPosition = elementPosition + window.pageYOffset - offset;

          window.scrollTo({
            top: offsetPosition,
            behavior: 'smooth'
          });
        }
      }
    }

    // Scroll on page load
    scrollToEducation();

    // Also listen for hash changes
    window.addEventListener('hashchange', scrollToEducation);
  }
});
