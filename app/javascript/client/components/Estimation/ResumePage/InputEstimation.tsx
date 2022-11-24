import { Text, Textarea } from "@nextui-org/react";

export const InputEstimation = () => {
  return (
    <>
      <div>
        <Text h2>Parece que no tenemos ninguna estimación...</Text>
        <Textarea label="¿Te han compartido algo?" fullWidth></Textarea>
      </div>
    </>
  );
};
