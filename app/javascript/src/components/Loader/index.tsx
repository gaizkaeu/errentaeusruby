import { Text } from "@nextui-org/react";
import "./index.css";
export default function Loader() {
  return (
    <div className="loader">
      <div className="load-text">
        <div className="loaded-text">
          <Text
            className="text-5xl font-bold text-black"
            css={{
              textGradient: "45deg, $yellow600 -20%, $red600 100%",
            }}
          >
            E
          </Text>
        </div>
        <div className="loading-text">
          <Text
            className="text-5xl font-bold text-black"
            css={{
              textGradient: "45deg, $yellow600 -20%, $red600 100%",
            }}
          >
            RRENTA.eus
          </Text>
        </div>
      </div>
    </div>
  );
}
