// Auto-close notifications after 3 seconds
function autoCloseNotification(notification) {
  // Mark as processed to avoid duplicate timers
  if (notification.hasAttribute('data-auto-closed')) {
    return;
  }
  
  notification.setAttribute('data-auto-closed', 'true');
  
  // Auto-close after 3 seconds
  setTimeout(() => {
    notification.classList.add('notification-hiding');
    
    // Remove from DOM after animation completes
    setTimeout(() => {
      notification.remove();
    }, 300); // Match animation duration
  }, 3000);
}

// Initialize notifications on page load
function initializeNotifications() {
  const notifications = document.querySelectorAll('.notification:not([data-auto-closed])');
  notifications.forEach(notification => {
    autoCloseNotification(notification);
  });
}

// Listen for DOMContentLoaded
document.addEventListener('DOMContentLoaded', initializeNotifications);

// Listen for turbo:load (full page loads)
document.addEventListener('turbo:load', initializeNotifications);

// Listen for turbo:after-stream-render to catch notifications added via Turbo Streams
document.addEventListener('turbo:after-stream-render', function(event) {
  // Use a small delay to ensure the DOM is updated
  setTimeout(() => {
    initializeNotifications();
  }, 10);
});

// Use MutationObserver as a fallback to catch any dynamically added notifications
let observer = null;

function setupObserver() {
  if (observer) {
    observer.disconnect();
  }
  
  observer = new MutationObserver(function(mutations) {
    mutations.forEach(function(mutation) {
      mutation.addedNodes.forEach(function(node) {
        if (node.nodeType === 1) { // Element node
          if (node.classList && node.classList.contains('notification')) {
            autoCloseNotification(node);
          }
          // Also check children
          const childNotifications = node.querySelectorAll && node.querySelectorAll('.notification:not([data-auto-closed])');
          if (childNotifications) {
            childNotifications.forEach(notification => {
              autoCloseNotification(notification);
            });
          }
        }
      });
    });
  });

  const notificationsContainer = document.getElementById('notifications');
  if (notificationsContainer) {
    observer.observe(notificationsContainer, {
      childList: true,
      subtree: true
    });
  }
}

// Start observing the notifications container
document.addEventListener('DOMContentLoaded', setupObserver);

// Also observe on turbo:load
document.addEventListener('turbo:load', setupObserver);

