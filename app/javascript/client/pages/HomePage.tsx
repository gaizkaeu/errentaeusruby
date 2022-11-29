import { Fragment } from "react";
import { Actions } from "../components/Home/Actions";
import BulletPoints from "../components/Home/BulletPoints";
import CollapsePoints from "../components/Home/CollapsePoints";
import Heading from "../components/Home/Heading";
import Reviews from "../components/Home/Reviews";
import { Step } from "../components/Home/Steps";

const HomePage = () => {
  return (
    <Fragment>
      <header>
        <Heading />
      </header>
      <main>
        <CollapsePoints />
        <Actions />
        <BulletPoints />
        <Reviews />
        <Step />
      </main>
    </Fragment>
  );
};

export default HomePage;
