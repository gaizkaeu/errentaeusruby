import React from 'react'
import { Provider } from 'react-redux'
import { BrowserRouter, Routes, Route } from 'react-router-dom'
import App from './App'
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
          </Route>
        </Routes>
      </BrowserRouter>
    </Provider>
  )
}

export default AppRoutes
