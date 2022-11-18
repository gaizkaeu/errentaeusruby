import { FormikHelpers } from "formik";
import toast from "react-hot-toast";
import { useTranslation } from "react-i18next";
import { useLoginAccountMutation, useLogOutMutation } from "../storage/api";
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

  const logoutHandle = async () => {
    const toastNotification = toast.loading(t("authentication.loggingOut"));
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
    formikHelpers: FormikHelpers<any>,
    onSuccess: () => void
  ) => {
    const toastNotification = toast.loading(t("authentication.loggingIn"));

    signIn(values)
      .unwrap()
      .then(
        () => {
          toast.success(t("authentication.loggedIn"), {
            id: toastNotification,
          });
          onSuccess();
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
  };
};
