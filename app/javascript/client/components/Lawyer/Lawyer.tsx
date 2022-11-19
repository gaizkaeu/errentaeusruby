import { Fragment } from "react";
import { User } from "@nextui-org/react";
import { IUser } from "../../storage/types";
import { useTranslation } from "react-i18next";

const LawyerAvatar = (props: { lawyer: IUser; size: "xs" | "sm" | "md" }) => {
  const { lawyer } = props;
  return (
    <Fragment>
      <User
        text={lawyer.first_name}
        name={lawyer.first_name}
        description={props.size == "md" ? lawyer.last_name : undefined}
        size={props.size}
      />
    </Fragment>
  );
};

export const NoLawyerAvatar = () => {
  const { t } = useTranslation();

  return (
    <User
      className="mt-3"
      text={t("errors.unexpected")}
      name={t("lawyers.assignedLawyer")}
      description={t("errors.unexpected")}
    />
  );
};

/* TODO:
const LawyerHover = () => {
  const { t } = useTranslation();

  return (
    <Fragment>
      <Button>{t("lawyers.email")}</Button>
      <Spacer y={1} />
      <Button>{t("lawyers.phone")}</Button>
    </Fragment>
  );
}; */

export default LawyerAvatar;
