/* eslint-disable */
import ReactDOM from "react-dom/client";
import "./index.css";
import { register } from "register-service-worker";

import AppRoutes from "../../../client/routes";
import { BrowserRouter } from "react-router-dom";

register("/sw.js", {
  registrationOptions: { scope: "./" },
  ready(_registration: ServiceWorkerRegistration) {
    console.log("Service worker is active.");
  },
  registered(_registration: ServiceWorkerRegistration) {
    console.log("Service worker has been registered.");
  },
  cached(_registration: ServiceWorkerRegistration) {
    console.log("Content has been cached for offline use.");
  },
  updatefound(_registration: ServiceWorkerRegistration) {
    console.log("New content is downloading.");
  },
  updated(_registration: ServiceWorkerRegistration) {
    console.log("New content is available; please refresh.");
  },
  offline() {
    console.log(
      "No internet connection found. App is running in offline mode."
    );
  },
  error(error) {
    console.error("Error during service worker registration:", error);
  },
});

const root = ReactDOM.createRoot(
  document.getElementById("root") as HTMLElement
);

root.render(
  <React.StrictMode>
    <BrowserRouter>
      <AppRoutes />
    </BrowserRouter>
  </React.StrictMode>
);
