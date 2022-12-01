import { Text } from "@nextui-org/react";
import { Link } from "react-router-dom";
import { Title } from "../Primitives";

export const Actions = () => {
  return (
    <section className="relative px-4 mx-auto max-w-7xl sm:px-6 lg:px-8 py-20 sm:py-24 lg:py-28">
      <div className="absolute right-10 top-0 blur-3xl transform-gpu overflow-hidden rotate-180">
        <svg
          className="relative -z-10 h-[21.1875rem] max-w-none -translate-x-1/2 sm:left-[calc(50%-30rem)] sm:h-[42.375rem]"
          xmlns="http://www.w3.org/2000/svg"
          version="1.1"
          viewBox="0 0 800 800"
          opacity="0.49"
        >
          <defs>
            <filter
              id="bbblurry-filter"
              x="-100%"
              y="-100%"
              width="400%"
              height="400%"
              filterUnits="objectBoundingBox"
              primitiveUnits="userSpaceOnUse"
              colorInterpolationFilters="sRGB"
            >
              <feGaussianBlur
                stdDeviation="40"
                x="0%"
                y="0%"
                width="100%"
                height="100%"
                in="SourceGraphic"
                edgeMode="none"
                result="blur"
              ></feGaussianBlur>
            </filter>
          </defs>
          <g filter="url(#bbblurry-filter)">
            <ellipse
              rx="164.5"
              ry="264.5"
              cx="259.52595847564226"
              cy="545.7212401385083"
              fill="hsla(287, 70%, 45%, 1)"
            ></ellipse>
            <ellipse
              rx="164.5"
              ry="264.5"
              cx="544.1617303818309"
              cy="200.29876357473006"
              fill="hsl(185, 100%, 57%)"
            ></ellipse>
          </g>
        </svg>
      </div>
      <div className="relative container">
        <Text className="text-4xl font-bold tracking-tight sm:text-6xl text-right">
          ¿Cómo
        </Text>
        <Title color="green" className="text-right">
          empezar?
        </Title>
        <ul className="grid lg:grid-cols-2 gap-10 text-gray-500">
          <li className="group w-full relative flex items-start xl:items-center rounded-3xl border border-transparent transform-gpu hover:scale-95 transition-transform ease-out duration-200 focus-within:border-purple-400 focus-within:ring focus-within:ring-blue-500">
            <img
              src="/ilu4.svg"
              className="w-20 h-20 lg:w-24 lg:h-24 xl:w-36 xl:h-36 object-cover rounded-3xl group-hover:opacity-50 transition-all"
              alt="A man writing code on a vintage desktop computer"
            />
            <div className="group-hover:opacity-50 transition-all pl-6 sm:px-6 xl:px-10">
              <Text h4 className="font-heading text-xl xl:text-2xl text-navy">
                Empezar a calcular.
              </Text>
              <p className="mt-2 text-base">
                Realiza el cálculo de tu presupuesto para presentar la
                declaración de la renta con nosotros.
              </p>
            </div>

            <svg
              role="img"
              className="hidden sm:block self-center flex-shrink-0 mr-4 text-violet-500 transform-gpu scale-50 -translate-x-12 opacity-0 group-hover:scale-100 group-hover:translate-x-0 group-hover:opacity-100 transition-all ease-out duration-300"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              strokeWidth="2"
              strokeLinecap="round"
              strokeLinejoin="round"
              width="30px"
            >
              <g>
                <line x1="5" y1="12" x2="19" y2="12"></line>
                <polyline points="12 5 19 12 12 19"></polyline>
              </g>
            </svg>
            <Link className="opacity-0 absolute inset-0" to="/calculator">
              Calcular
            </Link>
          </li>
          <li className="group w-full relative flex items-start xl:items-center rounded-3xl border border-transparent transform-gpu hover:scale-95 transition-transform ease-out duration-200 focus-within:border-purple-400 focus-within:ring focus-within:ring-blue-500">
            <img
              src="/ilu2.svg"
              className="w-20 h-20 lg:w-24 lg:h-24 xl:w-36 xl:h-36 object-cover rounded-3xl group-hover:opacity-50 transition-all"
              alt="A speedball in front of a computer interface"
            />
            <div className="group-hover:opacity-50 transition-all pl-6 sm:px-6 xl:px-10">
              <Text h4 className="font-heading text-xl xl:text-2xl text-navy">
                Pídenos una cita.
              </Text>
              <p className="mt-2 text-base">
                ¿Qué mejor que hablar con nosotros? Pregúntanos todas las dudas
                que tengas e intentaremos resolverlas lo mejor posible.
              </p>
            </div>

            <svg
              role="img"
              className="hidden sm:block self-center flex-shrink-0 mr-4 text-violet-500 transform-gpu scale-50 -translate-x-12 opacity-0 group-hover:scale-100 group-hover:translate-x-0 group-hover:opacity-100 transition-all ease-out duration-300"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              strokeWidth="2"
              strokeLinecap="round"
              width="30px"
              strokeLinejoin="round"
            >
              <g>
                <line x1="5" y1="12" x2="19" y2="12"></line>
                <polyline points="12 5 19 12 12 19"></polyline>
              </g>
            </svg>
            <a
              target="_blank"
              className="opacity-0 absolute inset-0"
              href="/docs/getting-started/remix/"
            >
              Read More
            </a>
          </li>
          <li className="group w-full relative flex items-start xl:items-center rounded-3xl border border-transparent transform-gpu hover:scale-95 transition-transform ease-out duration-200 focus-within:border-purple-400 focus-within:ring focus-within:ring-blue-500">
            <img
              src="/ilu3.svg"
              className="w-20 h-20 lg:w-24 lg:h-24 xl:w-36 xl:h-36 object-cover rounded-3xl group-hover:opacity-50 transition-all"
              alt="A hand holding scissors and cutting out paper for a scrapbook"
            />
            <div className="group-hover:opacity-50 transition-all pl-6 sm:px-6 xl:px-10">
              <Text h4 className="font-heading text-xl xl:text-2xl text-navy">
                Descubre quienes somos.
              </Text>
              <p className="mt-2 text-base">
                Visita la página web de Eliza Asesores, y descubre la mejor
                asesoría de Vitoria-Gasteiz.
              </p>
            </div>

            <svg
              role="img"
              className="hidden sm:block self-center flex-shrink-0 mr-4 text-violet-500 transform-gpu scale-50 -translate-x-12 opacity-0 group-hover:scale-100 group-hover:translate-x-0 group-hover:opacity-100 transition-all ease-out duration-300"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              strokeWidth="2"
              strokeLinecap="round"
              width="30px"
              strokeLinejoin="round"
            >
              <g>
                <line x1="5" y1="12" x2="19" y2="12"></line>
                <polyline points="12 5 19 12 12 19"></polyline>
              </g>
            </svg>
            <a
              target="_blank"
              className="opacity-0 absolute inset-0"
              href="/docs/getting-started/elixir/"
            >
              Read More
            </a>
          </li>
          <li className="group w-full relative flex items-start xl:items-center rounded-3xl border border-transparent transform-gpu hover:scale-95 transition-transform ease-out duration-200 focus-within:border-purple-400 focus-within:ring focus-within:ring-blue-500">
            <img
              src="/ilu1.svg"
              className="w-20 h-20 lg:w-24 lg:h-24 xl:w-36 xl:h-36 object-cover rounded-3xl group-hover:opacity-50 transition-all"
              alt="A smartphone flying through the air with an app on its screen"
            />
            <div className="group-hover:opacity-50 transition-all pl-6 sm:px-6 xl:px-10">
              <Text h4 className="font-heading text-xl xl:text-2xl text-navy">
                Contacta directamente con nosotros.
              </Text>
              <p className="mt-2 text-base">¡Te responderemos al instante!</p>
            </div>

            <svg
              role="img"
              className="hidden sm:block self-center flex-shrink-0 mr-4 text-violet-500 transform-gpu scale-50 -translate-x-12 opacity-0 group-hover:scale-100 group-hover:translate-x-0 group-hover:opacity-100 transition-all ease-out duration-300"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              strokeWidth="2"
              strokeLinecap="round"
              strokeLinejoin="round"
              width="30px"
            >
              <g>
                <line x1="5" y1="12" x2="19" y2="12"></line>
                <polyline points="12 5 19 12 12 19"></polyline>
              </g>
            </svg>
            <a
              target="_blank"
              className="opacity-0 absolute inset-0"
              href="/blog/new-turboku/"
            >
              Read More
            </a>
          </li>
        </ul>
      </div>
    </section>
  );
};
