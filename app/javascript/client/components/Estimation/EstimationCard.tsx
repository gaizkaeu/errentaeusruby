import { Button, Card, Text } from "@nextui-org/react";
import { useNavigate } from "react-router-dom";
import {
  useGetEstimationByIdQuery,
  useGetEstimationByTokenQuery,
} from "../../storage/api";
import { Estimation } from "../../storage/types";
import { ArrowIcon } from "../Icons/ArrowIcon";

export const EstimationFromJWTWrapper = (props: {
  token: string | undefined;
  deleteEstimation?: () => void;
  [x: string]: unknown;
}) => {
  const { data, isLoading, isError } = useGetEstimationByTokenQuery(
    props.token ?? "",
    { skip: props.token ? false : true }
  );

  return isLoading ? (
    <EstimationCardSkeleton />
  ) : !isError ? (
    <EstimationCard
      delete={props.deleteEstimation}
      estimation={data}
      {...props}
    />
  ) : (
    <EstimationErrorCard />
  );
};

export const EstimationWrapper = (props: {
  estimationId: string;
  [x: string]: unknown;
}) => {
  const { data, isLoading } = useGetEstimationByIdQuery(props.estimationId);
  return isLoading ? (
    <EstimationCardSkeleton />
  ) : (
    <EstimationCard estimation={data!} {...props} />
  );
};

const EstimationCard = (props: {
  estimation: Estimation | undefined;
  deletable?: boolean;
  delete?: () => void;
}) => {
  const { estimation, deletable } = props;
  return (
    <Card variant="flat" role="dialog">
      {estimation ? (
        <Card.Body>
          <Text size="$xl">
            Tu estimación de{" "}
            <span className="text-green-600 font-bold">
              {estimation.price} €.
            </span>
          </Text>
          <Text size="$sm">
            Nota: Esta información será visible para nuestros asesores
          </Text>
          <div className="w-full">
            {deletable && (
              <Button
                rounded
                bordered
                flat
                size="lg"
                auto
                color="error"
                onPress={props.delete}
              >
                Eliminar
              </Button>
            )}
          </div>
        </Card.Body>
      ) : (
        <NoEstimationCard />
      )}
    </Card>
  );
};

export const EstimationErrorCard = () => {
  const navigate = useNavigate();
  return (
    <Card variant="flat" role="dialog">
      <Card.Body>
        <Text b>Error al cargar tu estimación.</Text>
        <Text>
          Esto puede ocurrir porque tu estimación haya caducado o se haya
          estropeado el enlace.
        </Text>
        <Button
          rounded
          color="error"
          className="mt-3"
          size={"lg"}
          onPress={() => navigate("/contact")}
          iconRight={<ArrowIcon />}
        >
          Contacta con nosotros
        </Button>
      </Card.Body>
    </Card>
  );
};

export const NoEstimationCard = () => {
  const navigate = useNavigate();
  return (
    <Card variant="flat" role="dialog">
      <Card.Body>
        <Text b>No tenemos ninguna estimación.</Text>
        <Text>
          Utilizamos las estimaciones para hacer las cosas más sencillas y
          claras.
        </Text>
        <Button
          rounded
          className="mt-3"
          size={"lg"}
          auto
          onPress={() => navigate("/calculator")}
          iconRight={<ArrowIcon />}
        >
          Calcula tu precio
        </Button>
      </Card.Body>
    </Card>
  );
};

export const EstimationCardSkeleton = () => {
  return (
    <Card variant="flat" role="dialog">
      <Card.Body>
        <Text b>Estimación</Text>
        <div className="flex justify-between gap-5 mt-3 items-center animate-pulse">
          <div>
            <div className="h-2.5 bg-gray-300 rounded-full w-72 mb-2.5"></div>
            <div className="w-42 h-2 bg-gray-200 rounded-full "></div>
            <div className="w-42 h-2 bg-gray-200 rounded-full "></div>
          </div>
          <div className="h-2.5 bg-gray-300 rounded-full w-16"></div>
        </div>
        <div className="flex gap-5 mt-5 items-center animate-pulse">
          <div className="h-8 bg-gray-300 rounded-xl w-24"></div>
          <div className="h-8 bg-gray-300 rounded-xl w-24"></div>
        </div>
      </Card.Body>
    </Card>
  );
};

export default EstimationCard;
