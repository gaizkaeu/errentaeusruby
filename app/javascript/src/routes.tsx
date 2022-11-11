import { Provider } from "react-redux";
import { Routes, Route, Navigate, useLocation } from "react-router-dom";
import { store } from "./storage/store";
import { Text } from "@nextui-org/react";
import { Suspense } from "react";
import { useAuth } from "./hooks/authHook";
const ShowDocumentHistory = React.lazy(
  () => import("./components/Document/modals/DocumentHistoryModal")
);
const EstimationEditModal = React.lazy(
  () => import("./components/Estimation/modals/EstimationEditModal")
);
const AuthModal = React.lazy(
  () => import("./components/Authentication/modals/AuthModal")
);
const NewTaxIncome = React.lazy(
  () => import("./components/TaxIncome/NewTaxIncome")
);
const ShowTaxIncome = React.lazy(
  () => import("./components/TaxIncome/ShowTaxIncome")
);
const MenuTaxIncome = React.lazy(
  () => import("./components/TaxIncome/MenuTaxIncome")
);
const TaxIncomePage = React.lazy(() => import("./pages/TaxIncomePage"));
const EditAppointment = React.lazy(
  () => import("./components/Appointment/modals/EditAppointment")
);
const HomePage = React.lazy(() => import("./pages/HomePage"));
const EstimationPage = React.lazy(() => import("./pages/EstimationPage"));
const CalculatorPage = React.lazy(() => import("./pages/CalculatorPage"));
const App = React.lazy(() => import("./App"));

const PrivateRoute = (props: { children: JSX.Element }) => {
  const { status } = useAuth();
  const location = useLocation();

  return status.fetched ? (
    status.loggedIn ? (
      props.children
    ) : (
      <Navigate
        to="/auth/sign_in"
        replace
        state={{ nextPage: location.pathname }}
      />
    )
  ) : (
    <Text>Loading...</Text>
  );
};

const AppRoutes = () => {
  const location = useLocation();
  const background = location.state && location.state.background;

  return (
    <Provider store={store}>
      <Routes location={background || location}>
        <Route path="/" element={<App />}>
          <Route index element={<HomePage />} />
          <Route path="/calculator" element={<CalculatorPage />} />
          <Route path="/estimation" element={<EstimationPage />} />
          <Route
            path="auth/sign_up"
            element={
              <Suspense>
                <AuthModal method={false} />
              </Suspense>
            }
          />
          <Route
            path="auth/sign_in"
            element={
              <Suspense>
                <AuthModal method={true} />
              </Suspense>
            }
          />
          <Route
            path="/mytaxincome"
            element={
              <PrivateRoute>
                <TaxIncomePage />
              </PrivateRoute>
            }
          >
            <Route index element={<MenuTaxIncome />}></Route>
            <Route path="new" element={<NewTaxIncome />}></Route>
            <Route path=":tax_income_id/" element={<ShowTaxIncome />} />
            <Route path=":tax_income_id/:page" element={<ShowTaxIncome />} />
          </Route>
          <Route path="/appointment/:appointment_id">
            <Route
              path="edit"
              element={
                <Suspense>
                  <EditAppointment />
                </Suspense>
              }
            />
          </Route>
          <Route path="/estimation/:estimation_id">
            <Route
              path="edit"
              element={
                <Suspense>
                  <EstimationEditModal />
                </Suspense>
              }
            />
          </Route>
          <Route path="/documents/:document_id">
            <Route
              path="history"
              element={
                <Suspense>
                  <ShowDocumentHistory />
                </Suspense>
              }
            />
          </Route>
        </Route>
      </Routes>
      {background && (
        <Routes>
          <Route
            path="auth/sign_up"
            element={
              <Suspense>
                <AuthModal method={false} />
              </Suspense>
            }
          />
          <Route
            path="auth/sign_in"
            element={
              <Suspense>
                <AuthModal method={true} />
              </Suspense>
            }
          />
          <Route path="/appointment/:appointment_id">
            <Route
              path="edit"
              element={
                <Suspense>
                  <EditAppointment />
                </Suspense>
              }
            />
          </Route>
          <Route path="/estimation/:estimation_id">
            <Route
              path="edit"
              element={
                <Suspense>
                  <EstimationEditModal />
                </Suspense>
              }
            />
          </Route>
          <Route path="/documents/:document_id">
            <Route
              path="history"
              element={
                <Suspense>
                  <ShowDocumentHistory />
                </Suspense>
              }
            />
          </Route>
        </Routes>
      )}
    </Provider>
  );
};

export default AppRoutes;
