import { Fragment } from "react";
import { Button, Text } from "@nextui-org/react";
import { useEffect } from "react";
import { useNavigate } from "react-router-dom";
import { firstStep } from "../../../storage/calculatorSlice";
import { useAppDispatch, useAppSelector } from "../../../storage/hooks";
import CheckAnimated from "../../Icons/CheckAnimated";

const Finish = () => {
  const error = useAppSelector((state) => {
    return state.estimations;
  });

  const dispatch = useAppDispatch();

  const navigation = useNavigate();

  useEffect(() => {
    setTimeout(() => {
      navigation({
        pathname: "/estimation",
        search: `&j=${error.estimation?.token.data}`,
      });
      dispatch(firstStep());
    }, 2000);
  });

  return (
    <Fragment>
      {status === "failed" && error ? (
        <Fragment>
          <Text h3>Ha ocurrido un error</Text>
          <Text h4 color="red">
            {error.error}
          </Text>
          <Button
            rounded
            bordered
            flat
            color="warning"
            size={"md"}
            auto
            onPress={() => dispatch(firstStep())}
          >
            Volver a intentarlo
          </Button>
        </Fragment>
      ) : (
        <Fragment>
          <CheckAnimated />
        </Fragment>
      )}
    </Fragment>
  );
};

export default Finish;
