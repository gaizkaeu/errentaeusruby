self.addEventListener('install', () => {
  // Skip over the "waiting" lifecycle state, to ensure that our
  // new service worker is activated immediately, even if there's
  // another tab open controlled by our older service worker code.
  self.skipWaiting();
});
  self.addEventListener('activate', (_event) => {
    // console.log('sw.js: Service worker has been activated.', event);
  });
  
  self.addEventListener('fetch', (_event) => {
    // console.log('sw.js: Service worker is fetching', event);
  });

  self.addEventListener("push", (event) => {
    let notification = JSON.parse(event.data.text())
    let title = notification.title || "Nueva notificación";
    let body = "Entra en tu cuenta para más información";
    let icon = "https://errenta.eus//android-chrome-192x192.png"
    let data = { url:notification.url };
    let actions = [{action: "open_url", title: "Ver"}];
  
    self.registration.showNotification(title, { body, icon, data: data, actions: actions })
  });

  self.addEventListener('notificationclick', function(event) {
    switch(event.action){
      case 'open_url':
      clients.openWindow(event.notification.data.url); //which we got from above
      break;
      case 'any_other_action':
      clients.openWindow("https://errenta.eus");
      break;
    }
  }
  , false);