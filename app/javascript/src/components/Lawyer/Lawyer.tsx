import { Fragment } from "react";
import { Button, Spacer, Tooltip, User } from "@nextui-org/react"
import { IUser } from "../../storage/types";
import { useTranslation } from "react-i18next";

const LawyerAvatar = (props: { lawyer: IUser, size: "xs" | "sm" | "md"}) => {
    const { lawyer } = props;
    return (
    <Tooltip placement="top" content={<LawyerHover lawyer={lawyer} />}>
        <User
            text={lawyer?.name}
            name={lawyer?.name}
            description={props.size == "md" ? lawyer?.surname : undefined}
            size={props.size}
        />
    </Tooltip>
    )
}

export const NoLawyerAvatar = () => {
    const { t, i18n } = useTranslation();

    return (
    <User
        className="mt-3"
        text={t('errors.unexpected')}
        name={t('lawyers.assignedLawyer')}
        description={t('errors.unexpected')}
/> )
}

const LawyerHover = (props: { lawyer: IUser }) => {
    const { t, i18n } = useTranslation();

    return (
        <Fragment>
            <Button>{t('lawyers.email')}</Button>
            <Spacer y={1}/>
            <Button>{t('lawyers.phone')}</Button>
        </Fragment>
    )
}

export default LawyerAvatar;