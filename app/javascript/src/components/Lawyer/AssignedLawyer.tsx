import React from "react";
import { Card, Text } from "@nextui-org/react";
import { IUser } from "../../storage/authSlice";
import LawyerAvatar from ".";

const AssignedLawyer = (props: { lawyer: IUser }) => {
    return (
        <Card>
            <Card.Body>
                <Text b>Tu asesor fiscal</Text>
                <LawyerAvatar lawyer={props.lawyer} />
            </Card.Body>
        </Card>
    )
}

export default AssignedLawyer;