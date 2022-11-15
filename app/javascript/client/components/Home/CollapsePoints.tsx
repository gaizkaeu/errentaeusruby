import { StarIcon } from "@heroicons/react/24/outline";
import { Grid, Col, Collapse, Row, Text, Link } from "@nextui-org/react";
import { useState } from "react";
import { FeatureItem } from "../Card-Grid/styles";
import { Box, Section, Subtitle, Title } from "../Primitives";

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
    <div className="py-20 sm:py-24 lg:py-28">
      <Section css={{ position: "relative" }}>
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
                mt: "-10%",
              }}
            >
              <FeatureItem onClick={() => undefined}>
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
