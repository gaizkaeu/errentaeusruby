import { Outlet } from 'react-router-dom'
import { createTheme, NextUIProvider } from '@nextui-org/react'

import Navigation from './components/Navigation/Navigation'
import { useDarkMode } from 'usehooks-ts'
import { Provider } from 'react-redux'
import React, { useEffect } from 'react'
import { useAppDispatch } from './storage/hooks'
import { loggedIn, signIn } from './storage/authSlice'

const lightTheme = createTheme({
  type: 'light',
})

const darkTheme = createTheme({
  type: 'dark',
})

const App = () => {
  const darkMode = useDarkMode()
  const dispatch = useAppDispatch()

  useEffect(() => {
    dispatch(loggedIn())
  }, [])

  return (
    <NextUIProvider theme={darkMode.isDarkMode ? darkTheme : lightTheme}>
      <div>
        <Navigation />
        <Outlet />
      </div>
    </NextUIProvider>
  )
}

export default App
