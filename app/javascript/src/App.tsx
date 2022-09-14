import { Outlet } from "react-router-dom";
import { createTheme, NextUIProvider } from "@nextui-org/react"

import {store} from './storage/store'

import Navigation from './components/Navigation/Navigation'
import { useDarkMode } from "usehooks-ts";
import { Provider } from "react-redux";
import React from "react";


const lightTheme = createTheme({
  type: 'light',
})

const darkTheme = createTheme({
  type: 'dark',
})


const App = () => {
  const darkMode = useDarkMode();

  return (
    <Provider store={store}>
        <NextUIProvider theme={darkMode.isDarkMode ? darkTheme : lightTheme}>
          <div>
            <Navigation/>
            <Outlet/>
          </div>
        </NextUIProvider>
    </Provider>
  )
}

export default App;