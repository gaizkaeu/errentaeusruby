import { Button, Text } from "@nextui-org/react";
import { ArrowIcon } from "../components/Icons/ArrowIcon";
import { useNavigate } from "react-router-dom";
import { Fragment } from "react";
import {
  BoltIcon,
  DevicePhoneMobileIcon,
  GlobeAltIcon,
  ScaleIcon,
} from "@heroicons/react/24/outline";

const HomePage = () => (
  <div className="isolate">
    <div className="absolute inset-x-0 top-[-10rem] -z-10 transform-gpu overflow-hidden blur-3xl sm:top-[-20rem]">
      <svg
        className="relative left-[calc(50%-11rem)] -z-10 h-[21.1875rem] max-w-none -translate-x-1/2 rotate-[30deg] sm:left-[calc(50%-30rem)] sm:h-[42.375rem]"
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
    <div className="relative px-6 lg:px-8">
      <div className="mx-auto max-w-3xl pt-20 pb-32 sm:pt-48 sm:pb-40">
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
              ERRENTA.EUS
            </Text>
            <Text className="mt-6 text-lg leading-8 text-gray-600 sm:text-center">
              Haz la declaración de la renta con una asesoria de{" "}
              <b>confianza</b>, sin <b>sorpresas</b> y con el mejor
              asesoramiento.
            </Text>
            <HeaderActions />
          </div>
        </div>
        <div className="absolute inset-x-0 top-[calc(100%-13rem)] -z-10 transform-gpu overflow-hidden blur-3xl sm:top-[calc(100%-30rem)]">
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
    <Example />
  </div>
);

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

const features = [
  {
    name: "Digital.",
    description:
      "La declaración de la renta en la palma de tu mano. No solo eso, sino que también, segura, rápida y personal.",
    icon: GlobeAltIcon,
  },
  {
    name: "Precio justo.",
    description:
      "Nuestra asesoria ofrece los precios más competitivos del sector, además de dar el mejor servicio.",
    icon: ScaleIcon,
  },
  {
    name: "Rápido.",
    description:
      "No solo por la velocidad en la comunicación con tu asesor/a, sino por la facilidad de aportar documentacion o realizar un pago.",
    icon: BoltIcon,
  },
  {
    name: "Seguro.",
    description:
      "Nos preocupamos por tu privacidad, por lo que te mostramos todo lo que guardamos sobre ti, y tienes la capacidad de eliminar lo que quieras.",
    icon: DevicePhoneMobileIcon,
  },
];

export function Example() {
  return (
    <div className="py-18 sm:py-24 lg:py-28">
      <div className="mx-auto max-w-7xl px-6 lg:px-8">
        <div className="sm:text-center">
          <h2 className="text-lg font-semibold leading-8 text-indigo-600">
            Lo mejor.
          </h2>
          <Text className="mt-2 text-3xl font-bold tracking-tight text-gray-900 sm:text-4xl">
            Porque errenta
          </Text>
          <Text className="mx-auto mt-6 max-w-2xl text-lg leading-8 text-gray-600">
            Disfruta de todas las nuevas características de esta plataforma,
            como si fuese tu asesoría de toda la vida.
          </Text>
        </div>

        <div className="mt-20 max-w-lg sm:mx-auto md:max-w-none">
          <div className="grid grid-cols-1 gap-y-16 md:grid-cols-2 md:gap-x-12 md:gap-y-16">
            {features.map((feature) => (
              <div
                key={feature.name}
                className="relative flex flex-col gap-6 sm:flex-row md:flex-col lg:flex-row"
              >
                <div className="flex h-12 w-12 items-center justify-center rounded-xl bg-indigo-500 text-white sm:shrink-0">
                  <feature.icon className="h-8 w-8" aria-hidden="true" />
                </div>
                <div className="sm:min-w-0 sm:flex-1">
                  <Text className="text-lg font-semibold leading-8 text-gray-900">
                    {feature.name}
                  </Text>
                  <Text className="mt-2 text-base leading-7 text-gray-600">
                    {feature.description}
                  </Text>
                </div>
              </div>
            ))}
          </div>
        </div>
      </div>
    </div>
  );
}

export default HomePage;
