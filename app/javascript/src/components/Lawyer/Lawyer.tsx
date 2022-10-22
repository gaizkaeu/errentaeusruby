import { Fragment } from "react";
import { Button, Spacer, Tooltip, User } from "@nextui-org/react"
import { IUser } from "../../storage/types";

const LawyerAvatar = (props: { lawyer: IUser }) => {
    const { lawyer } = props;
    return (
    <Tooltip placement="top" content={<LawyerHover lawyer={lawyer} />}>
        <User
            className="mt-3"
            text={lawyer?.name}
            name={lawyer?.name}
            description={lawyer?.surname}
        />
    </Tooltip>
    )
}

export const NoLawyerAvatar = () => {

    return (
    <User
        className="mt-3"
        text="Ha ocurrido un error"
        name="Tu abogado"
        description="Ha ocurrido un error"
/> )
}

const LawyerHover = (props: { lawyer: IUser }) => {
    return (
        <Fragment>
            <Button>Email</Button>
            <Spacer y={1}/>
            <Button>Teléfono</Button>
        </Fragment>
    )
}

export default LawyerAvatar;