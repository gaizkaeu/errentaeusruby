import React, { useEffect } from 'react'
import { Provider } from 'react-redux'
import { BrowserRouter, Routes, Route, Navigate } from 'react-router-dom'
import App from './App'
import AuthenticationPage from './pages/AuthenticationPage'
import Calculator from './pages/CalculatorPage'
import EstimationPage from './pages/EstimationPage'
import Home from './pages/Home'
import TaxIncomePage from './pages/TaxIncomePage'
import { useAuth } from './storage/hooks'
import { store } from './storage/store'
import { Text } from '@nextui-org/react'
import NewTaxIncome from './components/TaxIncome/NewTaxIncome'

const PrivateRoute = (props: { children: JSX.Element }) => {
  const [auth, fetched] = useAuth();

  return fetched ? (auth ? props.children : <Navigate to="/auth/sign_in" />) : <Text>Loading...</Text>
}

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
              <Route path=":action" element={<AuthenticationPage/>}/>
            </Route>
            <Route
              path="/mytaxincome"
              element={
                <PrivateRoute>
                  <TaxIncomePage />
                </PrivateRoute>
              }
            >
              <Route path="new" element={<NewTaxIncome/>}></Route>
            </Route>
          </Route>
        </Routes>
      </BrowserRouter>
    </Provider>
  )
}

export default AppRoutes
