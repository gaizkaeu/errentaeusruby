import { Fragment } from "react";
import { Text } from "@nextui-org/react";
import SignIn from "./SignIn";
import SignUp from "./SignUp";
import { Link, Location } from "react-router-dom";
import CheckAnimated from "../Icons/CheckAnimated";
import { useAuth } from "../../hooks/authHook";
import { CredentialResponse, GoogleLogin } from "@react-oauth/google";
import { useGoogleOAuthOneTapCallBackMutation } from "../../storage/api";

export const RequiresAuthentication = (props: {
  nextPage: string;
  location: Location;
}) => {
  const [googleoAuthCallback] = useGoogleOAuthOneTapCallBackMutation();

  const oneTapSuccess = (res: CredentialResponse) => {
    if (res.credential) googleoAuthCallback(res.credential);
  };

  return (
    <div>
      <Text>Es necesario tener una cuenta para continuar</Text>
      <Text>
        <Link
          to="/auth/sign_in"
          state={{ background: props.location, nextPage: props.nextPage }}
        >
          Iniciar sesión
        </Link>{" "}
        o{" "}
        <Link
          to="/auth/sign_up"
          state={{ background: props.location, nextPage: props.nextPage }}
        >
          Registrarme
        </Link>
      </Text>
      <GoogleLogin
        useOneTap
        auto_select
        onSuccess={oneTapSuccess}
        onError={() => {
          console.log("Login Failed");
        }}
      />
    </div>
  );
};

const AuthComponent = (props: { onAuth: () => void; method: boolean }) => {
  const { status } = useAuth();

  return (
    <Fragment>
      {status.loggedIn ? (
        <CheckAnimated />
      ) : (
        <div className="w-full grid-cols-1 items-center align-center">
          <Text b size="md">
            {props.method ? "Iniciar sesión" : "Registro"}
          </Text>
          {props.method ? (
            <SignIn loginSuccess={props.onAuth} />
          ) : (
            <SignUp loginSuccess={props.onAuth} />
          )}
        </div>
      )}
    </Fragment>
  );
};
export default AuthComponent;
