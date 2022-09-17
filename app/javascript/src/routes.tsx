import React from 'react'
import { Provider } from 'react-redux'
import { BrowserRouter, Routes, Route } from 'react-router-dom'
import App from './App'
import SignIn from './components/Authentication/SignIn'
import SignUp from './components/Authentication/SignUp'
import AuthenticationPage from './pages/AuthenticationPage'
import Calculator from './pages/CalculatorPage'
import EstimationPage from './pages/EstimationPage'
import Home from './pages/Home'
import {store} from './storage/store'

const AppRoutes = () => {
  return (
    <Provider store={store}>
      <BrowserRouter>
        <Routes>
          <Route path="/" element={<App />}>
            <Route index element={<Home />} />
            <Route path="/calculator" element={<Calculator />} />
            <Route path="/estimation" element={<EstimationPage />} />
            <Route path="/auth" element={<AuthenticationPage />}>
              <Route path="/auth/sign_up" element={<SignUp />} />
              <Route path="/auth/sign_in" element={<SignIn />} />
            </Route>
          </Route>
        </Routes>
      </BrowserRouter>
    </Provider>
  )
}

export default AppRoutes
