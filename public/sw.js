
self.addEventListener('install', (_event) => {
    // console.log('sw.js: Service worker has been installed.', event);
  });
  
  self.addEventListener('activate', (_event) => {
    // console.log('sw.js: Service worker has been activated.', event);
  });
  
  self.addEventListener('fetch', (_event) => {
    // console.log('sw.js: Service worker is fetching', event);
  });

  self.addEventListener("push", (event) => {
    let title = (event.data && event.data.text()) || "Yay a message";
    let body = "We have received a push message";
    let tag = "push-simple-demo-notification-tag";
  
    self.registration.showNotification(title, { body, tag })
  });