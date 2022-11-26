import { Fragment } from "react";
import { Text } from "@nextui-org/react";
import SignIn from "./SignIn";
import SignUp from "./SignUp";
import { Link } from "react-router-dom";
import CheckAnimated from "../Icons/CheckAnimated";
import { useAuth } from "../../hooks/authHook";

export const RequiresAuthentication = (props: {
  nextPage: string;
  children: JSX.Element;
}) => {
  const { status, components } = useAuth();

  return status.loggedIn ? (
    props.children
  ) : (
    <div className="grid grid-cols-1 place-items-center">
      <Text>Es necesario tener una cuenta para continuar</Text>
      <Text>
        <Link to="/auth/sign_in" state={{ nextPage: location.pathname }}>
          Iniciar sesión
        </Link>{" "}
        o{" "}
        <Link to="/auth/sign_up" state={{ nextPage: location.pathname }}>
          Registrarme
        </Link>
      </Text>
      {components.google()}
    </div>
  );
};

const AuthComponent = (props: { method: boolean }) => {
  const { status } = useAuth();

  return (
    <Fragment>
      {status.loggedIn ? (
        <CheckAnimated />
      ) : (
        <div className="w-full grid-cols-1 items-center align-center">
          {props.method ? <SignIn /> : <SignUp />}
        </div>
      )}
    </Fragment>
  );
};
export default AuthComponent;
