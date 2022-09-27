import { Outlet } from 'react-router-dom'
import { createTheme, NextUIProvider } from '@nextui-org/react'

import Navigation from './components/Navigation/Navigation'
import React, { useEffect } from 'react'
import { useAppDispatch } from './storage/hooks'
import { loggedIn } from './storage/authSlice'
import toast, { Toaster } from 'react-hot-toast'
import axios from 'axios'
import { rescueMyEstimation } from './storage/estimationSlice'
import Footer from './components/Footer'
import useDarkMode from 'use-dark-mode'

const lightTheme = createTheme({
  type: 'light',
})

const darkTheme = createTheme({
  type: 'dark',
})

const App = () => {
  const dispatch = useAppDispatch()
  const darkMode = useDarkMode(false);

  useEffect(() => {
    const token = document
      .querySelector('meta[name="csrf-token"]')!
      .getAttribute('content')
    axios.defaults.headers.common['X-CSRF-Token'] = token!
    axios.defaults.headers.common['Accept'] = 'application/json'
    axios.defaults.headers.common['X-Requested-With'] = 'XMLHttpRequest'
    dispatch(loggedIn())
    dispatch(rescueMyEstimation())
  }, [])

  return (
    <NextUIProvider theme={darkMode.value ? darkTheme : lightTheme}>
      <Toaster />
      <Navigation />
      <div className='min-h-screen'>
        <Outlet/>
      </div>
      <Footer/>
    </NextUIProvider>
  )
}

export default App
