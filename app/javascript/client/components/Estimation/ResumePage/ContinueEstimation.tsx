import { Button, Text, Textarea } from "@nextui-org/react";
import { fromUnixTime, intervalToDuration } from "date-fns";
import { useLocation, useNavigate } from "react-router-dom";
import { firstStep } from "../../../storage/calculatorSlice";
import { useAppDispatch, useAppSelector } from "../../../storage/hooks";
import { Estimation } from "../../../storage/types";
import { RequiresAuthentication } from "../../Authentication/AuthComponent";
import { ArrowIcon } from "../../Icons/ArrowIcon";
import EstimationCard from "../EstimationCard";

export default function ContinueEstimation(props: { estimation: Estimation }) {
  const logged_in = useAppSelector((state) => state.authentication.logged_in);
  const dispatch = useAppDispatch();
  const location = useLocation();
  const nav = useNavigate();

  return (
    <div className="grid grid-cols-1 gap-y-8 place-content-center items-center">
      <EstimationCard estimation={props.estimation} deletable />
      {logged_in ? (
        <Button
          rounded
          bordered
          flat
          className="px-6 py-4 "
          color="success"
          size={"lg"}
          iconRight={<ArrowIcon />}
          onPress={() => {
            dispatch(firstStep());
            nav({
              pathname: "/mytaxincome/new",
              search: `?j=${props.estimation.token.data}`,
            });
          }}
          auto
        >
          ¡Todo listo! Continuar
        </Button>
      ) : (
        <div className="w-full">
          <Text className="text-center">
            Útilizamos las cuentas para poder <b>proteger tu información</b>.
            <br />
            <RequiresAuthentication
              nextPage="/mytaxincome/new"
              location={location}
            />
          </Text>
        </div>
      )}
    </div>
  );
}

export const SingleEstimation = (props: { estimation: Estimation }) => {
  return (
    <div className="grid grid-cols-1 gap-y-4">
      <div>
        <EstimationExpiry expDate={props.estimation.token.exp} />
        <Text h3>Compartir esta estimation</Text>
        <ShareEstimation />
        <Textarea
          fullWidth
          label="Firma de tu estimación"
          css={{ opacity: 0.7 }}
          readOnly
          initialValue={props.estimation.token.data}
        ></Textarea>
      </div>
    </div>
  );
};

const EstimationExpiry = (props: { expDate: string }) => {
  const reaming = intervalToDuration({
    start: new Date(),
    end: fromUnixTime(+props.expDate),
  });

  return (
    <>
      <Text b size="$xl">
        Válida durante
      </Text>
      <Text size="$lg">{reaming.days} días</Text>
    </>
  );
};

const ShareEstimation = () => (
  <div className="sharing-buttons flex flex-wrap">
    <a
      className="border-2 duration-200 ease inline-flex items-center mb-1 mr-1 transition py-3 px-5 rounded-full text-white border-indigo-600 bg-indigo-600 hover:bg-indigo-700 hover:border-indigo-700"
      target="_blank"
      rel="noopener noreferrer"
      href="https://wa.me/?text=Share%20estimation%20https%3A%2F%2Ferrenta.eus"
      aria-label="Share on Whatsapp"
      draggable="false"
    >
      <svg
        aria-hidden="true"
        fill="currentColor"
        xmlns="http://www.w3.org/2000/svg"
        viewBox="0 0 512 512"
        className="w-6 h-6"
      >
        <title>Whatsapp</title>
        <path d="M413 97A222 222 0 0 0 64 365L31 480l118-31a224 224 0 0 0 330-195c0-59-25-115-67-157zM256 439c-33 0-66-9-94-26l-7-4-70 18 19-68-4-7a185 185 0 0 1 287-229c34 36 56 82 55 131 1 102-84 185-186 185zm101-138c-5-3-33-17-38-18-5-2-9-3-12 2l-18 22c-3 4-6 4-12 2-32-17-54-30-75-66-6-10 5-10 16-31 2-4 1-7-1-10l-17-41c-4-10-9-9-12-9h-11c-4 0-9 1-15 7-5 5-19 19-19 46s20 54 23 57c2 4 39 60 94 84 36 15 49 17 67 14 11-2 33-14 37-27s5-24 4-26c-2-2-5-4-11-6z"></path>
      </svg>
      <span className="ml-2">Whatsapp</span>
    </a>
    <a
      className="border-2 duration-200 ease inline-flex items-center mb-1 mr-1 transition py-3 px-5 rounded-full text-white border-indigo-600 bg-indigo-600 hover:bg-indigo-700 hover:border-indigo-700"
      target="_blank"
      rel="noopener noreferrer"
      href="https://telegram.me/share/url?text=Share%20estimation&amp;url=https%3A%2F%2Ferrenta.eus"
      aria-label="Share on Telegram"
      draggable="false"
    >
      <svg
        aria-hidden="true"
        fill="currentColor"
        xmlns="http://www.w3.org/2000/svg"
        viewBox="0 0 512 512"
        className="w-6 h-6"
      >
        <title>Telegram</title>
        <path d="M256 8a248 248 0 1 0 0 496 248 248 0 0 0 0-496zm115 169c-4 39-20 134-28 178-4 19-10 25-17 25-14 2-25-9-39-18l-56-37c-24-17-8-25 6-40 3-4 67-61 68-67l-1-4-5-1q-4 1-105 70-15 10-27 9c-9 0-26-5-38-9-16-5-28-7-27-16q1-7 18-14l145-62c69-29 83-34 92-34 2 0 7 1 10 3l4 7a43 43 0 0 1 0 10z"></path>
      </svg>
      <span className="ml-2">Telegram</span>
    </a>
    <a
      className="border-2 duration-200 ease inline-flex items-center mb-1 mr-1 transition py-3 px-5 rounded-full text-white border-indigo-600 bg-indigo-600 hover:bg-indigo-700 hover:border-indigo-700"
      target="_blank"
      rel="noopener noreferrer"
      href="mailto:?subject=Share%20estimation&amp;body=https%3A%2F%2Ferrenta.eus"
      aria-label="Share by Email"
      draggable="false"
    >
      <svg
        aria-hidden="true"
        fill="currentColor"
        xmlns="http://www.w3.org/2000/svg"
        viewBox="0 0 512 512"
        className="w-6 h-6"
      >
        <title>Email</title>
        <path d="M464 64a48 48 0 0 1 29 86L275 314c-11 8-27 8-38 0L19 150a48 48 0 0 1 29-86h416zM218 339c22 17 54 17 76 0l218-163v208c0 35-29 64-64 64H64c-35 0-64-29-64-64V176l218 163z"></path>
      </svg>
      <span className="ml-2">Email</span>
    </a>
  </div>
);
