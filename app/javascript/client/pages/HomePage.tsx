import { Fragment } from "react";
import { Actions } from "../components/Home/Actions";
import BulletPoints from "../components/Home/BulletPoints";
import CollapsePoints from "../components/Home/CollapsePoints";
import Heading from "../components/Home/Heading";
import Reviews from "../components/Home/Reviews";
import { Step } from "../components/Home/Steps";

// const topFeatures = [
//   {
//     title: "Themeable",
//     description:
//       "Provides a simple way to customize default themes, you can change the colors, fonts, breakpoints and everything you need.",
//     icon: <MoonIcon />,
//   },
//   {
//     title: "Fast",
//     description:
//       "Avoids unnecessary styles props at runtime, making it more performant than other UI libraries.",
//     icon: <MoonIcon />,
//   },
//   {
//     title: "Light & Dark UI",
//     description:
//       "Automatic dark mode recognition, NextUI automatically changes the theme when detects HTML theme prop changes.",
//     icon: <MoonIcon />,
//   },
//   {
//     title: "Unique DX",
//     description:
//       "NextUI is fully-typed to minimize the learning curve, and provide the best possible developer experience.",
//     icon: <MoonIcon />,
//   },
// ];

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
        {/*         <FeaturesGrid features={topFeatures} /> */}
        <Reviews />
        <Step />
      </main>
    </Fragment>
  );
};

export default HomePage;
