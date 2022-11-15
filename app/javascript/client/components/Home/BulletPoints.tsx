import { Text } from "@nextui-org/react";
import {
  GlobeAltIcon,
  ScaleIcon,
  BoltIcon,
  LockClosedIcon,
} from "@heroicons/react/24/outline";
import { Box } from "../Primitives";

const BulletPoints = () => {
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
      icon: LockClosedIcon,
    },
  ];
  return (
    <div className="py-18 sm:py-24 lg:py-28">
      <div className="mx-auto max-w-7xl">
        <Box
          css={{
            position: "absolute",
            top: "-50%",
            left: "-10%",
            zIndex: "-$1",
            "@xsMax": {
              top: "-35%",
              left: "-90%",
            },
          }}
        >
          <img alt="theming background" src="/collapsepointsbg.svg" />
        </Box>
        <div className="sm:text-center">
          <Text className="mt-2 font-bold tracking-tight text-3xl sm:text-5xl">
            Lo mejor
          </Text>
          <Text color="#9750DD" className="text-lg font-semibold leading-8">
            de nuestros servicios.
          </Text>
          <Text className="mx-auto mt-6 max-w-2xl text-lg leading-8 text-gray-600">
            Disfruta de todas las nuevas características de esta plataforma,
            como si fuese tu asesoría de toda la vida.
          </Text>
        </div>

        <div className="mt-20 max-w-lg sm:mx-auto md:max-w-none">
          <div className="grid grid-cols-1 gap-y-12 md:grid-cols-2 md:gap-x-12 md:gap-y-16">
            {features.map((feature) => (
              <div
                key={feature.name}
                className="relative flex flex-col gap-4 sm:flex-row md:flex-col lg:flex-row"
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
};

export default BulletPoints;
