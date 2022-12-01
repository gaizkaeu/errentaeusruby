import { Outlet } from "react-router-dom";
import { NextUIProvider } from "@nextui-org/react";

import Navigation from "./components/Navigation/Navigation";
import { useDarkMode } from "usehooks-ts";
import { Suspense, useEffect } from "react";
import { Toaster } from "react-hot-toast";
import axios from "axios";
import Footer from "./components/Footer";
import Loader from "./components/Loader";

import i18next from "i18next";
import { darkTheme, lightTheme } from "./theme";
import { useGetCurrentAccountQuery } from "./storage/api";
import { useAuth } from "./hooks/authHook";

const ConfirmationBanner = React.lazy(
  () => import("./components/Authentication/ConfirmationBanner")
);

const App = () => {
  const darkMode = useDarkMode();
  useGetCurrentAccountQuery();
  const auth = useAuth();

  useEffect(() => {
    const token = document
      .querySelector('meta[name="csrf-token"]')!
      .getAttribute("content");
    axios.defaults.headers.common["X-CSRF-Token"] = token!;
    axios.defaults.headers.common["Accept"] = "application/json";
    axios.defaults.headers.common["X-Requested-With"] = "XMLHttpRequest";
  }, []);

  i18next.on("languageChanged", (lng) => {
    document.documentElement.setAttribute("lang", lng);
  });

  return (
    <NextUIProvider theme={darkMode.isDarkMode ? darkTheme : lightTheme}>
      <Toaster />
      <Navigation />
      <div className="min-h-screen">
        <Suspense fallback={<Loader />}>
          {auth.status.loggedIn && !auth.currentUser?.confirmed && (
            <ConfirmationBanner />
          )}
          <Outlet />
        </Suspense>
      </div>
      <Footer />
    </NextUIProvider>
  );
};

export default App;
