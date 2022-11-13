import { Fragment } from "react";
import { Text } from "@nextui-org/react";
import InputField from "../../FormFields/InputField";
import { useTranslation } from "react-i18next";

export default function Start(formField: {
  formField: {
    first_name: {
      name: string;
      label: string;
      requiredErrorMsg: string;
    };
  };
}) {
  const {
    formField: { first_name },
  } = formField;
  const { t } = useTranslation();

  return (
    <Fragment>
      <Text h3>{t("calculator.home.welcome")}</Text>
      <Text h4 weight={"normal"}>
        {t("calculator.home.header")}
      </Text>
      <InputField
        name={first_name.name}
        label={first_name.label}
        rounded
        bordered
        fullWidth
      ></InputField>
      <br />
      <br />
      <Text h5 className="underline">
        {t("calculator.privacy.header")}
      </Text>
      <Text h6 weight={"normal"}>
        {t("calculator.privacy.content")}
      </Text>
    </Fragment>
  );
}
