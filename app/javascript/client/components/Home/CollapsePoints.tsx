import { StarIcon } from "@heroicons/react/24/outline";
import { Grid, Col, Collapse, Row, Text, Link } from "@nextui-org/react";
import { useState } from "react";
import { FeatureItem } from "../Card-Grid/styles";
import { Section, Subtitle, Title } from "../Primitives";

const items = [
  {
    id: "cercania",
    title: "Cercanía.",
    description:
      "La única asesoría en Vitoria-Gasteiz digitalizada, pero humana.",
  },
  {
    id: "privacidad",
    title: "Privacidad.",
    description:
      "Nunca ha sido tan fácil la privacidad. Solo tu abogad@ verá tus documentos, teniendo el control total.",
  },
  {
    id: "facilidad",
    title: "Facilidad.",
    description:
      "¿Qué es mas fácil que hacer tu declaración sin tener que perder tiempo consultando, sin mandar correos...?",
  },
];

const CollapsePoints = () => {
  const [activeItem, setActiveItem] = useState(items[0]);

  const handleChange = (value: number | undefined) => {
    if (value) setActiveItem(items[value - 1]);
  };

  return (
    <div className="isolate px-4 mx-auto max-w-7xl sm:px-6 lg:px-8 py-20 sm:py-24 lg:py-28">
      <Section css={{ position: "relative" }}>
        <div className="absolute inset-x-0 top-[-20rem] -z-10 transform-gpu overflow-hidden blur-3xl sm:top-[-20rem]">
          <svg
            className="relative left-[calc(50%-11rem)] h-[21.1875rem] max-w-none -translate-x-1/2 rotate-[30deg] sm:left-[calc(50%-30rem)] sm:h-[42.375rem]"
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
        <Row justify="flex-start">
          <Text className="text-4xl font-bold tracking-tight sm:text-center sm:text-6xl">
            ¿Qué nos
          </Text>
        </Row>
        <Row justify="flex-start">
          <Title color="violet">diferencia?</Title>
        </Row>
        <Subtitle>
          <Link
            css={{ d: "inline-flex" }}
            href="https://elizaasesores.com/"
            rel="noreferer noopener"
            target="_blank"
          >
            Eliza Asesores
          </Link>
          &nbsp;lleva más de 20 años ofreciendo servicios de alta calidad y
          personales. Hemos conseguido llevar el asesoramiento a otro nivel, a
          la palma de tu mano.
        </Subtitle>
        <Grid.Container gap={2}>
          <Grid
            css={{
              pl: 0,
              "@xsMax": {
                pr: "0",
              },
            }}
            sm={6}
            xs={12}
          >
            <Col>
              <Collapse.Group accordion onChange={handleChange}>
                {items.map(({ id, title, description }) => (
                  <Collapse
                    key={id}
                    className={activeItem.id === id ? "active" : ""}
                    css={{
                      br: "$lg",
                      border: "none",
                      p: "0 $lg",
                      margin: "$md 0",
                      "& .nextui-collapse-title": {
                        color: "$accents4",
                        fontSize: "1.7rem",
                        transition: "color 0.2s ease-in-out",
                      },
                      "&.active": {
                        bf: "saturate(180%) blur(14px)",
                        bg: "rgba(255, 255, 255, 0.05)",
                        boxShadow: "$md",
                      },
                      "&.active .nextui-collapse-view": {
                        pb: 0,
                      },
                      "&.active .nextui-collapse-title": {
                        color: "$text",
                      },
                      "&:hover": {
                        "&:not(.active) .nextui-collapse-title": {
                          color: "$accents7",
                        },
                      },
                    }}
                    expanded={id === items[0].id}
                    showArrow={false}
                    title={title}
                  >
                    <Text
                      css={{
                        fs: "1.4rem",
                        color: "$accents6",
                        "@xsMax": {
                          fs: "1rem",
                        },
                      }}
                    >
                      {description}
                    </Text>
                  </Collapse>
                ))}
              </Collapse.Group>
            </Col>
          </Grid>
          <Grid
            css={{
              pr: 0,
              mt: "$9",
              "@mdMax": {
                pl: "0",
              },
              "@xsMax": {
                mt: "$18",
              },
            }}
            sm={6}
            xs={12}
          >
            <Col
              css={{
                dflex: "center",
                fd: "column",
                ai: "flex-start",
                h: "100%",
                mt: "0%",
              }}
            >
              <FeatureItem onClick={() => undefined} className="h-full">
                <Row align="center">
                  <div className="icon-wrapper">
                    <StarIcon />
                  </div>
                  <Text
                    className="feature-title"
                    css={{
                      my: 0,
                      fontSize: "1.1rem",
                      fontWeight: "$semibold",
                      ml: "$4",
                    }}
                  >
                    {activeItem.title}
                  </Text>
                </Row>
                <Row align="center" css={{ px: "$2", pt: "$4", pb: "$2" }}>
                  <Text
                    className="feature-description"
                    css={{ color: "$accents8" }}
                  >
                    {activeItem.description}
                  </Text>
                </Row>
              </FeatureItem>
            </Col>
          </Grid>
        </Grid.Container>
      </Section>
    </div>
  );
};

export default CollapsePoints;
