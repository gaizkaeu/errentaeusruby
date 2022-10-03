import { Outlet } from 'react-router-dom'
import { createTheme, NextUIProvider } from '@nextui-org/react'

import Navigation from './components/Navigation/Navigation'
import { useDarkMode } from 'usehooks-ts'
import { Suspense, useEffect } from 'react'
import { useAppDispatch } from './storage/hooks'
import { loggedIn } from './storage/authSlice'
import toast, { Toaster } from 'react-hot-toast'
import axios from 'axios'
import { rescueMyEstimation } from './storage/estimationSlice'
import Footer from './components/Footer'
import Loader from './components/Loader'

import './i18n';

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

    <NextUIProvider theme={darkMode.isDarkMode ? darkTheme : lightTheme}>
      <Toaster />
      <Navigation />
      <div className='min-h-screen'>
        <Suspense fallback={<Loader/>}>
          <Outlet/>
        </Suspense>
      </div>
      <Footer/>
    </NextUIProvider>
  )
}

export default App