import { StarIcon } from "@heroicons/react/24/outline";
import {
  Col,
  Container,
  Link,
  Row,
  Spacer,
  styled,
  Text,
} from "@nextui-org/react";
import { levitating } from "../../utils/animations";
import { FeatureItem } from "../Card-Grid/styles";
import { Title } from "../Primitives";

const StyledContainer = styled("div", {
  dflex: "center",
  position: "absolute",
  zIndex: "$max",
});

const ReviewsComponent = () => {
  return (
    <StyledContainer className="relative">
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
      <FeatureItem
        onClick={() => undefined}
        css={{
          position: "relative",
          cursor: "pointer",
          top: "-400px",
          left: "100px",
          px: "$8",
          mw: "120px",
          animation: `${levitating} 11s ease infinite`,
          backgroundColor: "$cardBackground",
          boxShadow: "$sm",
        }}
      >
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
            Elena
          </Text>
        </Row>
        <Row align="center" css={{ px: "$2", pt: "$4", pb: "$2" }}>
          <Text className="feature-description" css={{ color: "$accents8" }}>
            Atención profesional, personalizada y atenta. Muy satisfecha con
            servicios prestados y trato recibido. Ya tengo nueva asesora,
            totalmente recomendable.
          </Text>
        </Row>
      </FeatureItem>
      <FeatureItem
        onClick={() => undefined}
        css={{
          position: "relative",
          cursor: "pointer",
          top: "0px",
          left: "-100px",
          px: "$8",
          mw: "120px",
          animation: `${levitating} 8s ease infinite`,
          backgroundColor: "$cardBackground",
          boxShadow: "$sm",
        }}
      >
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
            Laura
          </Text>
        </Row>
        <Row align="center" css={{ px: "$2", pt: "$4", pb: "$2" }}>
          <Text className="feature-description" css={{ color: "$accents8" }}>
            Atención profesional, personalizada y atenta. Muy satisfecha con
            servicios prestados y trato recibido. Ya tengo nueva asesora,
            totalmente recomendable.
          </Text>
        </Row>
      </FeatureItem>
      <FeatureItem
        onClick={() => undefined}
        css={{
          position: "relative",
          cursor: "pointer",
          top: "-30px",
          left: "100px",
          px: "$8",
          mw: "120px",
          animation: `${levitating} 8s ease infinite`,
          backgroundColor: "$cardBackground",
          boxShadow: "$sm",
        }}
      >
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
            Laura
          </Text>
        </Row>
        <Row align="center" css={{ px: "$2", pt: "$4", pb: "$2" }}>
          <Text className="feature-description" css={{ color: "$accents8" }}>
            Atención profesional, personalizada y atenta. Muy satisfecha con
            servicios prestados y trato recibido. Ya tengo nueva asesora,
            totalmente recomendable.
          </Text>
        </Row>
      </FeatureItem>
    </StyledContainer>
  );
};

const Reviews = () => {
  return (
    <Container
      alignItems="center"
      className="overflow-hidden"
      as="section"
      css={{
        position: "relative",
        height: "calc(84vh - 76px)",
        "@xsMax": {
          height: "calc(100vh - 64px)",
        },
      }}
      display="flex"
      gap={0}
      justify="space-between"
      lg={true}
      wrap="nowrap"
    >
      <Row
        align="center"
        css={{
          zIndex: "$2",
          "@mdMax": {
            mt: "80px",
            p: "0 8px",
          },
          "@xsMax": {
            mt: "0px",
          },
        }}
        wrap="wrap"
      >
        <Col
          css={{
            position: "relative",
            zIndex: "$2",
            "@md": {
              width: "50%",
            },
            "@mdMax": {
              width: "100%",
            },
          }}
        >
          <Title>Nuestros clientes nos avalan</Title>
          <Link href="https://g.page/r/CbKDg4dig5GNEBM/review">
            ¡Danos tu opinión!{" "}
          </Link>
          <Spacer y={1.5} />
        </Col>
        <Col
          className="w-full h-full"
          css={{
            position: "relative",
            height: "100%",
          }}
          span={6}
        >
          <ReviewsComponent />
        </Col>
      </Row>
    </Container>
  );
};
export default Reviews;
