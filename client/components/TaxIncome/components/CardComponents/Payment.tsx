import { Button, Card, Loading, Spacer, Text } from "@nextui-org/react";
import { TaxIncome } from "../../../../storage/types";
import { useEffect, useState, Fragment } from "react";
import axios from "axios";
import { Elements } from "@stripe/react-stripe-js";
import CheckoutForm from "../../../Checkout/CheckoutForm";
import { loadStripe } from "@stripe/stripe-js";
import { useDarkMode } from "usehooks-ts";
import CheckAnimated from "../../../Icons/CheckAnimated";
import { useNavigate } from "react-router-dom";
import { useGetPaymentDataOfTaxIncomeQuery } from "../../../../storage/api";
import { PaymentDetailsComponent } from "../../../Checkout/PaymentDetails";

const stripePromise = loadStripe(
  "pk_test_51LxvpDGrlIhNYf6eC8Bfb4jKtTzFRPBEkpNLHWRjq6sgMFtlb6bQ0dmuIEWANdwCkeV1laTQNAXWJjYEYmmen5me00SA8Wd4kJ"
);

const WaitingPayment = (props: { taxIncome: TaxIncome }) => {
  const [clientSecret, setClientSecret] = useState("");
  const darkMode = useDarkMode();

  useEffect(() => {
    axios
      .post<{ clientSecret: string }>(
        `/api/v1/tax_incomes/${props.taxIncome.id}/create_payment_intent`
      )
      .then((data) => {
        setClientSecret(data.data.clientSecret);
      });
  }, []);

  const appearance = {
    theme: darkMode.isDarkMode ? ("night" as const) : ("flat" as const),
  };

  const options = {
    clientSecret,
    appearance,
  };

  return (
    <div>
      <Card variant="flat">
        <Card.Body>
          <Text b size="$xl">
            Pasalera de pago.
          </Text>
          <Text>
            El precio que ha establecido tu abogado es de{" "}
            <Text b color="green">
              {props.taxIncome.price / 100.0} €
            </Text>
            .
          </Text>
        </Card.Body>
      </Card>
      <Spacer />
      {clientSecret ? (
        <Elements options={options} stripe={stripePromise}>
          <CheckoutForm />
        </Elements>
      ) : (
        <Text>Ha ocurrido un error.</Text>
      )}
    </div>
  );
};

export const PaymentCompleted = (props: { taxIncome: TaxIncome }) => {
  const nav = useNavigate();
  const { currentData, isError, isLoading } = useGetPaymentDataOfTaxIncomeQuery(
    props.taxIncome.id
  );
  return !isLoading ? (
    <div>
      {!isError ? (
        <Fragment>
          <Card variant="flat">
            <Card.Body>
              <Text b>Pago aceptado correctamente.</Text>
              <CheckAnimated />
              <Button
                onPress={() =>
                  nav(
                    `/mytaxincome/${props.taxIncome.id}/${props.taxIncome.state}`
                  )
                }
              >
                Continuar
              </Button>
            </Card.Body>
          </Card>
          <br />
          <Card.Divider />
          <br />
          <PaymentDetailsComponent paymentDetails={currentData!} />
        </Fragment>
      ) : (
        <Text>Error</Text>
      )}
    </div>
  ) : (
    <Loading />
  );
};

export default WaitingPayment;
