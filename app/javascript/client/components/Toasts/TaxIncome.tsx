import { CheckIcon } from "@heroicons/react/24/outline";
import { Toast, toast } from "react-hot-toast";
import { useTranslation } from "react-i18next";

export const DeletedSuccessfully = (props: { t: Toast }) => {
  const { t } = useTranslation();
  return (
    <div
      className={`${
        props.t.visible ? "animate-enter" : "animate-leave"
      } max-w-md w-full bg-white shadow-lg rounded-lg pointer-events-auto flex ring-1 ring-black ring-opacity-5`}
    >
      <div className="flex-1 w-0 p-4">
        <div className="flex items-center">
          <div className="flex-shrink-0 pt-0.5 text-black">
            <CheckIcon height="20px" />
          </div>
          <div className="ml-3 flex-1">
            <p className="text-sm font-medium text-gray-900">
              {t("taxincome.toasts.title")}
            </p>
            <p className="mt-1 text-sm text-gray-500">
              {t("taxincome.toasts.actions.deleteSuccess")}
            </p>
          </div>
        </div>
      </div>
      <div className="flex border-l border-gray-200">
        <button
          onClick={() => toast.dismiss(props.t.id)}
          className="w-full border border-transparent rounded-none rounded-r-lg p-4 flex items-center justify-center text-sm font-medium text-indigo-600 hover:text-indigo-500 focus:outline-none focus:ring-2 focus:ring-indigo-500"
        >
          {t("toasts.close")}
        </button>
      </div>
    </div>
  );
};
