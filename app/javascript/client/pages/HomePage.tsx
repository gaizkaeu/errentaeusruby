import { Fragment } from "react";
import { Actions } from "../components/Home/Actions";
import BulletPoints from "../components/Home/BulletPoints";
import CollapsePoints from "../components/Home/CollapsePoints";
import Heading from "../components/Home/Heading";
import Reviews from "../components/Home/Reviews";
import { Step } from "../components/Home/Steps";

/* const push = () => {
  navigator.serviceWorker.ready.then((serviceWorkerRegistration) => {
    serviceWorkerRegistration.pushManager
      .getSubscription()
      .then((subscription) => {
        axios.post("api/v1/push", {
          message: "asd",
          subscription: subscription?.toJSON(),
        });
      });
  });
};
const subscribe = () => {
  navigator.serviceWorker.ready.then((serviceWorkerRegistration) => {
    serviceWorkerRegistration.pushManager.subscribe({
      userVisibleOnly: true,
      applicationServerKey: window.vapidPublicKey,
    });
  });
}; */

const HomePage = () => {
  return (
    <Fragment>
      <header>
        <Heading />
      </header>
      <main>
        <CollapsePoints />
        {/* <Button onPress={push}>prueba</Button>
        <Button onPress={subscribe}>suscribirse</Button> */}
        <Actions />
        <BulletPoints />
        <Reviews />
        <Step />
      </main>
    </Fragment>
  );
};

export default HomePage;
