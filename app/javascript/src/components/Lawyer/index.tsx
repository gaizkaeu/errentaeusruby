import React from "react";
import { Button, Grid, Spacer, Tooltip, User } from "@nextui-org/react"
import { IUser } from "../../storage/authSlice"

const LawyerAvatar = (props: { lawyer: IUser }) => {
    const { lawyer } = props;
    return (
    <Tooltip placement="top" content={<LawyerCard lawyer={lawyer} />}>
        <User
            className="mt-3"
            text={lawyer?.name}
            name={lawyer?.name}
            description={lawyer?.surname}
        />
    </Tooltip>
    )
}

const LawyerCard = (props: { lawyer: IUser }) => {
    return (
        <React.Fragment>
            <Button>Email</Button>
            <Spacer y={1}/>
            <Button>Teléfono</Button>
        </React.Fragment>
    )
}

export default LawyerAvatar;