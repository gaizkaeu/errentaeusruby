import React, { Suspense } from 'react'
import { Provider } from 'react-redux'
import { BrowserRouter, Routes, Route, Navigate } from 'react-router-dom'
import { useAuth } from './storage/hooks'
import { store } from './storage/store'
import { Text } from '@nextui-org/react'
const NewTaxIncome = React.lazy(() => import('./components/TaxIncome/NewTaxIncome'));
const ShowTaxIncome = React.lazy(() => import('./components/TaxIncome/ShowTaxIncome'));
const MenuTaxIncome = React.lazy(() => import('./components/TaxIncome/MenuTaxIncome'));
const TaxIncomePage = React.lazy(() => import('./pages/TaxIncomePage'));
const HomePage = React.lazy(() => import('./pages/Home'));
const EstimationPage = React.lazy(() => import('./pages/EstimationPage'));
const CalculatorPage = React.lazy(() => import('./pages/CalculatorPage'));
const AuthenticationPage = React.lazy(() => import('./pages/AuthenticationPage'));
const App = React.lazy(() => import('./App'));

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
            <Route index element={<HomePage />} />
            <Route path="/calculator" element={<CalculatorPage />} />
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
              <Route index element={<MenuTaxIncome/>}></Route>
              <Route path="new" element={<NewTaxIncome/>}></Route>
              <Route path=":id" element={<ShowTaxIncome/>}></Route>
            </Route>
          </Route>
        </Routes>
      </BrowserRouter>
    </Provider>
  )
}

export default AppRoutes
