import { Badge, Text } from "@nextui-org/react";
import { PaymentDetails } from "../../storage/types";

export const PaymentDetailsComponent = (props: {
  paymentDetails: PaymentDetails;
}) => {
  const { paymentDetails } = props;
  return (
    <div>
      <Text h3>Detalles del pago</Text>
      <div className="flex flex-wrap text-center">
        <div className="flex-grow">
          <Text b>Tarjeta</Text>
          <Text>···· {paymentDetails.card.last4}</Text>
        </div>
        <div className="flex-grow">
          <Text b>Estado</Text>
          <br />
          {paymentDetails.status === "succeeded" &&
            !paymentDetails.card.refunded && (
              <Badge color="success" variant="flat">
                Correcto
              </Badge>
            )}
          {paymentDetails.card.refunded && (
            <Badge color="primary" variant="flat">
              Devuelto
            </Badge>
          )}
        </div>
        <div className="flex-grow">
          <Text b>Factura</Text>
          <br />
          <a href={paymentDetails.receipt_url}>Ver factura</a>
        </div>
        <div className="flex-grow">
          <Text b>Cantidad</Text>
          <Text>{paymentDetails.amount / 100.0} €</Text>
        </div>
      </div>
    </div>
  );
};
