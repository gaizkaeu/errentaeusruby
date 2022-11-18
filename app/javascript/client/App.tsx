import { Outlet } from "react-router-dom";
import { NextUIProvider } from "@nextui-org/react";

import Navigation from "./components/Navigation/Navigation";
import { useDarkMode } from "usehooks-ts";
import { Suspense, useEffect } from "react";
import { useAppDispatch } from "./storage/hooks";
import { Toaster } from "react-hot-toast";
import axios from "axios";
import { rescueMyEstimation } from "./storage/estimationSlice";
import Footer from "./components/Footer";
import Loader from "./components/Loader";

import "./i18n";
import i18next from "i18next";
import { darkTheme, lightTheme } from "./theme";
import { GoogleOAuthProvider } from "@react-oauth/google";
import { useGetCurrentAccountQuery } from "./storage/api";

const App = () => {
  const darkMode = useDarkMode();
  const dispatch = useAppDispatch();
  useGetCurrentAccountQuery();

  useEffect(() => {
    const token = document
      .querySelector('meta[name="csrf-token"]')!
      .getAttribute("content");
    axios.defaults.headers.common["X-CSRF-Token"] = token!;
    axios.defaults.headers.common["Accept"] = "application/json";
    axios.defaults.headers.common["X-Requested-With"] = "XMLHttpRequest";
    dispatch(rescueMyEstimation());
  }, []);

  i18next.on("languageChanged", (lng) => {
    document.documentElement.setAttribute("lang", lng);
  });

  return (
    <GoogleOAuthProvider clientId="321891045066-2it03nhng83jm5b40dha8iac15mpej4s.apps.googleusercontent.com">
      <NextUIProvider theme={darkMode.isDarkMode ? darkTheme : lightTheme}>
        <Toaster />
        <Navigation />
        <div className="min-h-screen">
          <Suspense fallback={<Loader />}>
            <Outlet />
          </Suspense>
        </div>
        <Footer />
      </NextUIProvider>
    </GoogleOAuthProvider>
  );
};

export default App;
