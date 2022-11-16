import { Fragment } from "react";
import BulletPoints from "../components/Home/BulletPoints";
import CollapsePoints, { CollapsePointsText } from "../components/Home/CollapsePoints";
import Heading from "../components/Home/Heading";

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
      <main className="px-4 mx-auto max-w-7xl sm:px-6 lg:px-8">
        <BulletPoints />
        <CollapsePoints />
        {/*         <FeaturesGrid features={topFeatures} /> */}
      </main>
    </Fragment>
  );
};

export default HomePage;
