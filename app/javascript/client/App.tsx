import { Outlet } from "react-router-dom";
import { NextUIProvider, Text } from "@nextui-org/react";

import Navigation from "./components/Navigation/Navigation";
import { useDarkMode } from "usehooks-ts";
import { Suspense, useEffect } from "react";
import { Toaster } from "react-hot-toast";
import axios from "axios";
import Footer from "./components/Footer";
import Loader from "./components/Loader";

import "./i18n";
import i18next from "i18next";
import { darkTheme, lightTheme } from "./theme";
import { useGetCurrentAccountQuery } from "./storage/api";
import { useAuth } from "./hooks/authHook";
import ConfirmationBanner from "./components/Authentication/ConfirmationBanner";

const Banner = () => {
  return (
    <div id="banner" className="flex justify-center w-full px-4 py-3 ">
      <div className="items-center md:flex">
        <Text className="text-sm font-mediumd md:my-0">
          <span className="bg-blue-100 text-blue-800 text-xs font-semibold mr-2 px-2.5 py-0.5 rounded hidden md:inline">
            ¡Importante!
          </span>
          Entorno de desarrollo
          <a
            href="https://elizaasesores.com"
            className="inline-flex items-center ml-2 text-sm font-medium text-blue-600 md:ml-2 dark:text-blue-500 hover:underline"
          >
            Eliza Asesores
            <svg
              className="w-4 h-4 ml-1 text-blue-600 dark:text-blue-500"
              fill="currentColor"
              viewBox="0 0 20 20"
              xmlns="http://www.w3.org/2000/svg"
            >
              <path
                fillRule="evenodd"
                d="M10.293 3.293a1 1 0 011.414 0l6 6a1 1 0 010 1.414l-6 6a1 1 0 01-1.414-1.414L14.586 11H3a1 1 0 110-2h11.586l-4.293-4.293a1 1 0 010-1.414z"
                clipRule="evenodd"
              ></path>
            </svg>
          </a>
        </Text>
      </div>
    </div>
  );
};

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
      <Banner />
      <Navigation />
      {auth.status.loggedIn && !auth.currentUser?.confirmed && (
        <ConfirmationBanner />
      )}
      <Suspense fallback={<Loader />}>
        <Outlet />
      </Suspense>
      <Footer />
    </NextUIProvider>
  );
};

export default App;
