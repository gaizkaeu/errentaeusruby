import { Fragment } from "react";
import { User } from "@nextui-org/react";
import { IUser } from "../../storage/types";
import { useTranslation } from "react-i18next";

export const UserAvatar = (props: {
  user: IUser;
  size: "xs" | "sm" | "md";
}) => {
  const { user } = props;
  return (
    <Fragment>
      <User
        text={user.first_name}
        name={user.first_name}
        description={props.size == "md" ? user.last_name : undefined}
        size={props.size}
      />
    </Fragment>
  );
};

export const NoUserAvatar = () => {
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
