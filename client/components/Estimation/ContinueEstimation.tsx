import { Button, Text } from "@nextui-org/react";
import { useLocation, useNavigate } from "react-router-dom";
import { firstStep } from "../../storage/calculatorSlice";
import { useAppDispatch, useAppSelector } from "../../storage/hooks";
import { RequiresAuthentication } from "../Authentication/AuthComponent";
import { ArrowIcon } from "../Icons/ArrowIcon";

export default function ContinueEstimation() {
  const logged_in = useAppSelector((state) => state.authentication.logged_in);
  const dispatch = useAppDispatch();
  const location = useLocation();
  const nav = useNavigate();

  return (
    <div className="flex place-content-center items-center">
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
            nav("/mytaxincome/new");
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
