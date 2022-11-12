import { FormikHelpers } from "formik";
import toast from "react-hot-toast";
import { useTranslation } from "react-i18next";
import { logOut, signIn } from "../storage/authSlice";
import { useAppSelector, useAppDispatch } from "../storage/hooks";
import { SessionCreationData } from "../storage/types";

export const useAuth = () => {
  const authStatus = useAppSelector((state) => ({ loggedIn: state.authentication.logged_in, fetched: state.authentication.fetched }));
  const currentUser = useAppSelector((state) => state.authentication.user);
  const dispatch = useAppDispatch()
  const { t } = useTranslation();

  const logoutHandle = async () => {
    const toastNotification = toast.loading(t("authentication.loggingOut"))
    const action = await dispatch(logOut())

    if (logOut.fulfilled.match(action)) {
      toast.success(t("authentication.loggedOut"), {
        id: toastNotification,
      })
      location.reload()
    } else {
      toast.error(t("errors.unexpected"), {
        id: toastNotification,
      })
    }
  }
  const formLogIn = async (values: SessionCreationData, formikHelpers: FormikHelpers<any>, onSuccess: () => void) => {
    const toastNotification = toast.loading(t("authentication.loggingIn"))
    const action = await dispatch(
      signIn(values),
    )

    if (signIn.fulfilled.match(action)) {
      toast.success(t("authentication.loggedIn"), {
        id: toastNotification,
      })
      onSuccess();
    } else {
      if (action.payload) {
        formikHelpers.setFieldError('password', 'Error')
        formikHelpers.setFieldError('email', 'Error')
        toast.error('Error ' + action.payload.error, {
          id: toastNotification,
        })
      } else {
        toast.error(t("errors.unexpected"), {
          id: toastNotification,
        })
      }
    }
  }

  return {
    status: authStatus,
    currentUser: currentUser,
    actions: {
      logOut: logoutHandle,
      formLogIn: formLogIn
    }
  }
}
