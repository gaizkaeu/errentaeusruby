import {
  CredentialResponse,
  GoogleLogin,
  googleLogout,
  GoogleOAuthProvider,
} from "@react-oauth/google";
import { FormikHelpers } from "formik";
import toast from "react-hot-toast";
import { useTranslation } from "react-i18next";
import {
  useGoogleOAuthOneTapCallBackMutation,
  useLoginAccountMutation,
  useLogOutMutation,
} from "../storage/api";
import { useAppSelector } from "../storage/hooks";
import { SessionCreationData } from "../storage/types";

export const useAuth = () => {
  const authStatus = useAppSelector((state) => ({
    loggedIn: state.authentication.logged_in,
    fetched: state.authentication.fetched,
  }));
  const currentUser = useAppSelector((state) => state.authentication.user);
  const { t } = useTranslation();
  const [signOut] = useLogOutMutation();
  const [signIn] = useLoginAccountMutation();
  const [googleoAuthCallback] = useGoogleOAuthOneTapCallBackMutation();

  const oneTapSuccess = (res: CredentialResponse) => {
    const toastLogin = toast.loading("Iniciando sesión con google");
    if (res.credential)
      googleoAuthCallback(res.credential)
        .unwrap()
        .then(() => {
          toast.success("¡Hola!", { id: toastLogin });
        })
        .catch(() => {
          toast.error("Error", { id: toastLogin });
        });
  };

  const GoogleLoginComponent = () => (
    <GoogleOAuthProvider clientId="321891045066-2it03nhng83jm5b40dha8iac15mpej4s.apps.googleusercontent.com">
      <div className="w-fit">
        <GoogleLogin
          useOneTap
          theme="filled_black"
          size="large"
          shape="pill"
          auto_select
          onSuccess={oneTapSuccess}
          onError={() => {
            console.log("Login Failed");
          }}
        />
      </div>
    </GoogleOAuthProvider>
  );

  const logoutHandle = async () => {
    const toastNotification = toast.loading(t("authentication.loggingOut"));
    googleLogout();
    signOut()
      .unwrap()
      .then(
        () => {
          toast.success(t("authentication.loggedOut"), {
            id: toastNotification,
          });
          location.reload();
        },
        () => {
          toast.error(t("errors.unexpected"), {
            id: toastNotification,
          });
        }
      );
  };
  const formLogIn = async (
    values: SessionCreationData,
    formikHelpers: FormikHelpers<SessionCreationData>
  ) => {
    const toastNotification = toast.loading(t("authentication.loggingIn"));

    signIn(values)
      .unwrap()
      .then(
        () => {
          toast.success(t("authentication.loggedIn"), {
            id: toastNotification,
          });
        },
        (err) => {
          formikHelpers.setFieldError("password", "Error");
          formikHelpers.setFieldError("email", "Error");
          toast.error("Error " + err, {
            id: toastNotification,
          });
        }
      );
  };

  return {
    status: authStatus,
    currentUser: currentUser,
    actions: {
      logOut: logoutHandle,
      formLogIn: formLogIn,
    },
    components: {
      google: GoogleLoginComponent,
    },
  };
};
