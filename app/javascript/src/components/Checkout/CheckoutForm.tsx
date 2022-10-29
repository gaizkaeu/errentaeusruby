import { Button, Card, Spacer, Text } from "@nextui-org/react"
import {
    PaymentElement,
    useStripe,
    useElements
  } from "@stripe/react-stripe-js";
import { useEffect, useState } from "react";
import { useLocation } from "react-router-dom";
import CheckAnimated from "../Icons/CheckAnimated";

const CheckoutForm = () => {
    const stripe = useStripe();
    const elements = useElements();
    const loc = useLocation();

    const [message, setMessage] = useState(null);
    const [isLoading, setIsLoading] = useState(false);

    useEffect(() => {
      if (!stripe) {
        return;
      }
  
      const clientSecret = new URLSearchParams(window.location.search).get(
        "payment_intent_client_secret"
      );
  
      if (!clientSecret) {
        return;
      }
  
      stripe.retrievePaymentIntent(clientSecret).then(({ paymentIntent }) => {
        switch (paymentIntent.status) {
          case "succeeded":
            setMessage("Payment succeeded!");
            break;
          case "processing":
            setMessage("Your payment is processing.");
            break;
          case "requires_payment_method":
            setMessage("Your payment was not successful, please try again.");
            break;
          default:
            setMessage("Something went wrong.");
            break;
        }
      });
    }, [stripe]);
  
    const handleSubmit = async (e) => {
      e.preventDefault();
  
      if (!stripe || !elements) {
        // Stripe.js has not yet loaded.
        // Make sure to disable form submission until Stripe.js has loaded.
        return;
      }
  
      setIsLoading(true);
  
      const { error } = await stripe.confirmPayment({
        elements,
        confirmParams: {
          // Make sure to change this to your payment completion page
          return_url: `https://errentaeusreact.test${loc.pathname}`
        },
      });
  
      // This point will only be reached if there is an immediate error when
      // confirming the payment. Otherwise, your customer will be redirected to
      // your `return_url`. For some payment methods like iDEAL, your customer will
      // be redirected to an intermediate site first to authorize the payment, then
      // redirected to the `return_url`.
      if (error.type === "card_error" || error.type === "validation_error") {
        setMessage(error.message);
      } else {
        setMessage("An unexpected error occurred.");
      }
  
      setIsLoading(false);
    };
    return (
        <div>
            {message !== "Payment succeeded!" ? (
            <form id="payment-form" onSubmit={handleSubmit}>
                <PaymentElement id="payment-element" />
                <br/>
                <Button disabled={isLoading || !stripe || !elements} type="submit" id="submit" color="primary">
                    <span id="button-text">
                    {isLoading ? <div className="spinner" id="spinner"></div> : "Pagar ahora"}
                    </span>
                </Button>
                {message && <div id="payment-message">{message}</div>}
            </form>
            ) : (
              <CheckAnimated/>
            )}
        </div>
    )
}

export default CheckoutForm;