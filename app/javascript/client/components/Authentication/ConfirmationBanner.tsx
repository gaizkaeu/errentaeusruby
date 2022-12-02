import {
  CheckBadgeIcon,
  ExclamationCircleIcon,
  XMarkIcon,
} from "@heroicons/react/24/outline";
import { Loading } from "@nextui-org/react";
import { useEffect, useState } from "react";
import { useAuth } from "../../hooks/authHook";
import { useRequestResendConfirmationMutation } from "../../storage/api";
import { Button } from "../../utils/GlobalStyles";

export default function ConfirmationBanner() {
  const [show, setShow] = useState(false);
  const auth = useAuth();
  const [resend, { isLoading, isSuccess, isError, error }] =
    useRequestResendConfirmationMutation();

  const dismiss = () => {
    const now = new Date().getTime();
    localStorage.setItem("confirmationBannerDimissedAt", JSON.stringify(now));
    setShow(false);
  };

  const resendButton = () => {
    const now = new Date().getTime();
    if (auth.currentUser?.id) {
      resend(auth.currentUser.id)
        .unwrap()
        .then(() => {
          localStorage.setItem("resendConfirmationSentAt", JSON.stringify(now));
        });
    }
  };

  useEffect(() => {
    if (show) return;
    const interval = setInterval(() => {
      const now = new Date().getTime();
      const dismiss = localStorage.getItem("confirmationBannerDimissedAt");
      if (!dismiss) setShow(true);

      if (dismiss && +dismiss < now - 5 * 60 * 1000) {
        setShow(true);
        localStorage.removeItem("confirmationBannerDimissedAt");
      }
    }, 2000);

    return () => clearInterval(interval);
  }, [show]);

  return (
    <div
      className={`${isError ? "bg-red-500" : "bg-indigo-600"} ${
        !show && "hidden"
      } z-50 animate-in slide-in-from-top`}
    >
      <div className="mx-auto max-w-7xl py-3 px-3 sm:px-6 lg:px-8">
        <div className="flex flex-wrap items-center justify-between">
          <div className="flex w-0 flex-1 items-center">
            <span className="flex rounded-lg bg-indigo-800 p-2">
              <ExclamationCircleIcon
                className="h-6 w-6 text-white"
                aria-hidden="true"
              />
            </span>
            {isError ? (
              <p className="ml-3 truncate font-medium text-white">
                <span className="md:hidden">Error</span>
                <span className="hidden md:inline">
                  {JSON.stringify(error.data)}
                </span>
              </p>
            ) : (
              <p className="ml-3 truncate font-medium text-white">
                <span className="md:hidden">Confirma tu correo.</span>
                <span className="hidden md:inline">
                  Confirmación de correo pendiente.
                </span>
              </p>
            )}
          </div>
          <div className="order-3 mt-2 w-full flex-shrink-0 sm:order-2 sm:mt-0 sm:w-auto">
            {!isLoading ? (
              !isSuccess ? (
                <a
                  onClick={resendButton}
                  className="flex items-center justify-center rounded-md border border-transparent bg-white px-4 py-2 text-sm font-medium text-indigo-600 shadow-sm hover:bg-indigo-50"
                >
                  Reenviar
                </a>
              ) : (
                <Button
                  auto
                  color="success"
                  icon={<CheckBadgeIcon width="30px" />}
                />
              )
            ) : (
              <Button
                disabled
                auto
                bordered
                color="primary"
                css={{ px: "$13" }}
              >
                <Loading color="currentColor" size="sm" />
              </Button>
            )}
          </div>
          <div className="order-2 flex-shrink-0 sm:order-3 sm:ml-3">
            <button
              type="button"
              onClick={dismiss}
              className="-mr-1 flex rounded-md p-2 hover:bg-indigo-500 focus:outline-none focus:ring-2 focus:ring-white sm:-mr-2"
            >
              <span className="sr-only">Dismiss</span>
              <XMarkIcon className="h-6 w-6 text-white" aria-hidden="true" />
            </button>
          </div>
        </div>
      </div>
    </div>
  );
}
