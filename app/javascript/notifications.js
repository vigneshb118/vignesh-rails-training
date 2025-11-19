// Close notification function
function closeNotification(notification) {
  if (!notification || notification.classList.contains('notification-hiding')) {
    return; // Already closing or invalid
  }
  
  notification.classList.add('notification-hiding');
  
  // Remove from DOM after animation completes
  setTimeout(() => {
    if (notification && notification.parentNode) {
      notification.remove();
    }
  }, 300); // Match animation duration
}

// Auto-close notifications after 3 seconds
function autoCloseNotification(notification) {
  if (!notification) return;
  
  // Mark as processed to avoid duplicate timers
  if (notification.hasAttribute('data-auto-closed')) {
    return;
  }
  
  notification.setAttribute('data-auto-closed', 'true');
  
  // Auto-close after 3 seconds
  setTimeout(() => {
    if (notification && notification.parentNode) {
      closeNotification(notification);
    }
  }, 3000);
}

// Initialize all notifications on the page
function initializeNotifications() {
  const notifications = document.querySelectorAll('#notifications .notification:not([data-auto-closed])');
  notifications.forEach(notification => {
    autoCloseNotification(notification);
  });
}

// Setup event delegation for close buttons (works with dynamically added content)
// Attach to document so it works even if container is replaced
let closeButtonSetup = false;

function setupCloseButtons() {
  // Only set up once - document-level listener works for all notifications
  if (closeButtonSetup) return;
  closeButtonSetup = true;
  
  // Use document-level delegation so it works even if container is replaced by Turbo
  document.addEventListener('click', function(e) {
    // Only handle clicks within the notifications container
    const notificationsContainer = document.getElementById('notifications');
    if (!notificationsContainer || !notificationsContainer.contains(e.target)) {
      return;
    }
    
    // Check if the click is on or inside a close button
    const closeButton = e.target.closest('.notification-close');
    if (closeButton) {
      e.preventDefault();
      e.stopPropagation();
      const notification = closeButton.closest('.notification');
      if (notification) {
        closeNotification(notification);
      }
    }
  }, true); // Use capture phase to catch events early
}

// Use MutationObserver to catch any dynamically added notifications
let observer = null;

function setupObserver() {
  const notificationsContainer = document.getElementById('notifications');
  if (!notificationsContainer) return;
  
  if (observer) {
    observer.disconnect();
  }
  
  observer = new MutationObserver(function(mutations) {
    mutations.forEach(function(mutation) {
      mutation.addedNodes.forEach(function(node) {
        if (node.nodeType === 1) { // Element node
          // Check if the added node is a notification
          if (node.classList && node.classList.contains('notification')) {
            autoCloseNotification(node);
          }
          // Also check for notifications within the added node
          const childNotifications = node.querySelectorAll && node.querySelectorAll('.notification:not([data-auto-closed])');
          if (childNotifications && childNotifications.length > 0) {
            childNotifications.forEach(notification => {
              autoCloseNotification(notification);
            });
          }
        }
      });
    });
  });

  observer.observe(notificationsContainer, {
    childList: true,
    subtree: true
  });
}

// Initialize everything when DOM is ready
function init() {
  setupCloseButtons();
  setupObserver();
  initializeNotifications();
}

// Listen for DOMContentLoaded
document.addEventListener('DOMContentLoaded', init);

// Listen for turbo:load (full page loads)
document.addEventListener('turbo:load', init);

// Listen for turbo:after-stream-render to catch notifications added via Turbo Streams
document.addEventListener('turbo:after-stream-render', function(event) {
  // Use a small delay to ensure the DOM is updated
  setTimeout(() => {
    initializeNotifications();
  }, 50);
});

