import { Button, Text } from "@nextui-org/react";
import { Fragment } from "react";
import { useNavigate } from "react-router-dom";
import { ErrentaUnderlined } from "../../utils/GlobalStyles";
import { ArrowIcon } from "../Icons/ArrowIcon";

const Heading = () => {
  return (
    <div className="relative isolate">
      <div className="invisible lg:visible absolute top-25 inset-x-0 -z-50">
        <img
          className="invisible lg:visible relative left-[calc(50%-8rem)] -z-10 h-[21.1875rem] max-w-none -translate-x-1/2 rotate-[30deg] sm:left-[calc(50%-34rem)] sm:h-[42.375rem]"
          alt="App image tax income appointment"
          src="/iphone-landing.webp"
          width="340px"
        ></img>
      </div>
      <div className="absolute inset-x-0 top-[-10rem] transform-gpu overflow-hidden blur-3xl sm:top-[-20rem] -z-50">
        <svg
          className="relative left-[calc(50%-11rem)] h-[21.1875rem] max-w-none -translate-x-1/2 rotate-[30deg] sm:left-[calc(50%-30rem)] sm:h-[42.375rem] -z-50"
          viewBox="0 0 1155 678"
          fill="none"
          xmlns="http://www.w3.org/2000/svg"
        >
          <path
            fill="url(#45de2b6b-92d5-4d68-a6a0-9b9b2abad533)"
            fillOpacity=".3"
            d="M317.219 518.975L203.852 678 0 438.341l317.219 80.634 204.172-286.402c1.307 132.337 45.083 346.658 209.733 145.248C936.936 126.058 882.053-94.234 1031.02 41.331c119.18 108.451 130.68 295.337 121.53 375.223L855 299l21.173 362.054-558.954-142.079z"
          />
          <defs>
            <linearGradient
              id="45de2b6b-92d5-4d68-a6a0-9b9b2abad533"
              x1="1155.49"
              x2="-78.208"
              y1=".177"
              y2="474.645"
              gradientUnits="userSpaceOnUse"
            >
              <stop stopColor="#9089FC" />
              <stop offset={1} stopColor="#FF80B5" />
            </linearGradient>
          </defs>
        </svg>
      </div>
      <div className="px-4 mx-auto max-w-7xl sm:px-6 lg:px-8">
        <div className="relative mx-auto max-w-3xl pt-20 pb-32 sm:pt-48 sm:pb-40">
          <div>
            <div className="mb-8 flex sm:justify-center">
              <div className="relative overflow-hidden rounded-full py-1.5 px-4 text-sm leading-6 ring-1 ring-indigo-600 hover:ring-indigo-400">
                <Text color="gray">
                  ¿Cómo funciona?.{" "}
                  <a href="#" className="font-semibold text-indigo-600">
                    <span className="absolute inset-0" aria-hidden="true" />
                    Más información <span aria-hidden="true">&rarr;</span>
                  </a>
                </Text>
              </div>
            </div>
            <div>
              <Text
                h1
                className="text-4xl font-bold tracking-tight sm:text-center sm:text-6xl"
              >
                <ErrentaUnderlined />
                <Text
                  weight="light"
                  size="md"
                  className="text-left inline-block ml-3"
                >
                  by Eliza Asesores
                </Text>
              </Text>
              <Text className="mt-6 text-lg leading-8 text-gray-600 sm:text-center">
                Haz la declaración de la renta con una asesoria de{" "}
                <b>confianza</b>, sin <b>sorpresas</b> y con el mejor
                asesoramiento.
              </Text>
              <HeaderActions />
            </div>
          </div>
          <div className="absolute inset-x-0 z-10 bottom-[-6rem] visible lg:hidden">
            <img
              alt="App image tax income appointment"
              width="307px"
              height="203px"
              className="relative -z-10 mx-auto"
              src="/iphone-landing-mobile.webp"
            ></img>
          </div>
          <div className="absolute inset-x-0 top-[calc(100%-13rem)] transform-gpu overflow-hidden blur-3xl sm:top-[calc(100%-30rem)] -z-10">
            <svg
              className="relative left-[calc(50%+3rem)] h-[21.1875rem] max-w-none -translate-x-1/2 sm:left-[calc(50%+36rem)] sm:h-[42.375rem]"
              viewBox="0 0 1155 678"
              fill="none"
              xmlns="http://www.w3.org/2000/svg"
            >
              <path
                fill="url(#ecb5b0c9-546c-4772-8c71-4d3f06d544bc)"
                fillOpacity=".3"
                d="M317.219 518.975L203.852 678 0 438.341l317.219 80.634 204.172-286.402c1.307 132.337 45.083 346.658 209.733 145.248C936.936 126.058 882.053-94.234 1031.02 41.331c119.18 108.451 130.68 295.337 121.53 375.223L855 299l21.173 362.054-558.954-142.079z"
              />
              <defs>
                <linearGradient
                  id="ecb5b0c9-546c-4772-8c71-4d3f06d544bc"
                  x1="1155.49"
                  x2="-78.208"
                  y1=".177"
                  y2="474.645"
                  gradientUnits="userSpaceOnUse"
                >
                  <stop stopColor="#9089FC" />
                  <stop offset={1} stopColor="#FF80B5" />
                </linearGradient>
              </defs>
            </svg>
          </div>
        </div>
      </div>
    </div>
  );
};

const HeaderActions = () => {
  const navigate = useNavigate();
  return (
    <Fragment>
      <div className="mt-8 flex gap-x-4 gap-y-3 sm:justify-center flex-wrap">
        <Button
          rounded
          color="gradient"
          auto
          onPress={() => navigate("/calculator")}
          iconRight={<ArrowIcon />}
        >
          Calculadora
        </Button>
        <Button
          rounded
          color="warning"
          auto
          onPress={() => navigate("/mytaxincome")}
        >
          Mi declaración
        </Button>
      </div>
    </Fragment>
  );
};

export default Heading;
