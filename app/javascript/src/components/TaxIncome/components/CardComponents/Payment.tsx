import { Card, Loading, Spacer, Text } from "@nextui-org/react"
import { TaxIncome } from "../../../../storage/types";
import { useEffect, useState } from "react";
import axios from "axios";
import { Elements } from "@stripe/react-stripe-js";
import CheckoutForm from "../../../Checkout/CheckoutForm";
import { loadStripe } from "@stripe/stripe-js";
import { useDarkMode } from "usehooks-ts";

const stripePromise = loadStripe("pk_test_51LxvpDGrlIhNYf6eC8Bfb4jKtTzFRPBEkpNLHWRjq6sgMFtlb6bQ0dmuIEWANdwCkeV1laTQNAXWJjYEYmmen5me00SA8Wd4kJ");


const WaitingPayment = (props: { taxIncome: TaxIncome }) => {

    const [clientSecret, setClientSecret] = useState("");
    const darkMode = useDarkMode();

    useEffect(() => {
        axios.post<{ clientSecret: string }>(`/api/v1/tax_incomes/${props.taxIncome.id}/create_payment_intent`).then((data) => {
            setClientSecret(data.data.clientSecret)
        })
    }, [])


    const appearance = {
        theme: darkMode.isDarkMode ? 'night' as const : 'flat' as const
    };

    const options = {
        clientSecret,
        appearance
    };

    return clientSecret ? (
        <div>
            <Card variant="flat">
                <Card.Body>
                    <Text b size="$xl">Pasalera de pago.</Text>
                    <Text>El precio que ha establecido tu abogado es de <Text b color="green">{props.taxIncome.price} €</Text>.</Text>
                </Card.Body>
            </Card>
            <Spacer/>
            <Elements options={options} stripe={stripePromise}>
                <CheckoutForm />
            </Elements>
        </div>
    ) : <Loading/>

}

export default WaitingPayment;